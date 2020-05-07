#!/usr/bin/python3

import yaml
import io
import chevron
import os
import sys

class Builder:
    def __init__(self):
        self.data_path = "build.yml"
        self.bake_tmpl_path = "utils/docker-bake.hcl.tmpl"
        self.bake_path = "build/docker-bake.hcl"
        self.skip_config = False
        self.data=self.get_data()
        self.create_dir_if_not_exist("build")

    def get_data(self):
        with io.open(self.data_path, 'r', encoding='utf-8') as f:
            return yaml.full_load(f)

    def build_bake(self):
        with open(self.bake_tmpl_path, 'r') as f:
            bake = chevron.render(f, self.data)

        with open(self.bake_path, 'w+') as f:
            f.write(str(bake))

    def build_dockerfile(self, arch_data):
        if_build = ".build" if self.data["STAGE"] else ""
        dockerfile_tmpl_path = f'Dockerfile{if_build}.tmpl'
        dockerfile_path = f'build/{arch_data["ARCH"]["name"]}/Dockerfile{if_build}'
        with open(dockerfile_tmpl_path, 'r') as f:
            dockerfile = chevron.render(f, arch_data)
        with open(dockerfile_path, 'w') as f:
            f.write(str(dockerfile))

    def create_dir_if_not_exist(self, arch_path):
        if not os.path.exists(arch_path):
            os.makedirs(arch_path)

    def build_dockerfiles(self):
        for arch in self.data['ARCH']:
            arch_path = 'build/' + arch['name']
            self.create_dir_if_not_exist(arch_path)
            arch_data = self.data.copy()
            arch_data['ARCH'] = arch
            self.build_dockerfile(arch_data)

    def config(self):
        if self.skip_config:
            return
        self.build_bake()
        self.build_dockerfiles()

    def docker(self):
        self.config()
        os.system(
          "docker buildx bake -f build/docker-bake.hcl"
          )

    def push_to_repo(self):
        repo = self.data["REPO"]
        if_build = "build-" if self.data["STAGE"] else ""
        for arch in self.data['ARCH']:
            if arch['enable']:
                tag = f'{if_build}{arch["tag"]}'
                tag_new = f'{if_build}{self.data["IMAGE_VERSION"]}-{arch["tag"]}'
                push_cmd = f'docker tag {repo}:{tag} lasery/{repo}:{tag_new}'
                os.system(push_cmd)
                push_cmd = f'docker push lasery/{repo}:{tag_new}'
                os.system(push_cmd)

    def tag_repo(self, version):
        repo = f'lasery/{self.data["REPO"]}'
        if_build = "build-" if self.data["STAGE"] else ""
        tag = f'{if_build}{version}'
        for arch in self.data['ARCH']:
            if arch['enable']:
                tag_new = f'{if_build}{self.data["IMAGE_VERSION"]}-{arch["tag"]}'
                push_cmd = f'docker manifest create -a {repo}:{tag}  {repo}:{tag_new}'
                os.system(push_cmd)
                push_cmd = f'docker manifest annotate {repo}:{tag}  {repo}:{tag_new} --arch {arch["arch"]}{" --variant " +  arch["variant"] if "variant" in arch else ""}'
                os.system(push_cmd)
        os.system(f'docker manifest push -p {repo}:{tag}')
        os.system(f'docker manifest inspect {repo}:{tag}')

    def push(self):
        version = self.data["IMAGE_VERSION"]
        self.docker()
        self.push_to_repo()
        self.tag_repo(version)

    def deploy(self):
        version = "latest"
        self.tag_repo(version)

if __name__ == '__main__':
    builder=Builder()
    sys.argv.pop(0)
    method = sys.argv.pop(0)
    if len(sys. argv) > 0 and sys.argv[0] == 'skip':
        builder.skip_config = True
    getattr(builder, method)()

# pytest utils/build.py -s
def test_config():
    builder=Builder()
    builder.config()
