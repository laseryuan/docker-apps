Usage
```
docker run -it -v "$(pwd)":/tmp/data -e HOME=/tmp --workdir=/tmp/data \
    -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -u "$(id -u)":"$(id -g)" \
    lasery/devpy bash -l
```


Build
```
python3 ~/mbuild/utils/build.py docker
python3 ~/mbuild/utils/build.py deploy

```

## issue

## Reference
https://sifranklin.wordpress.com/2017/08/21/pythons-equivalent-to-pry/
https://gist.github.com/mono0926/6326015
