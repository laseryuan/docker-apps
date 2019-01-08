Check version and components
```
docker run -it --rm google/cloud-sdk:latest gcloud version
docker run -it --rm google/cloud-sdk:228.0.0-alpine gcloud version
```

Config
```
docker run -it --name gcloud-config google/cloud-sdk gcloud auth login
```

Run gcloud
```
docker run --rm -ti \
  -v ~/.ssh:/root/.ssh \
  -v $SSH_AUTH_SOCK:/ssh-agent \
  -e SSH_AUTH_SOCK=/ssh-agent \
  --volumes-from gcloud-config \
  google/cloud-sdk \
  {gcloud command}
```

SSH cloud shell
```
  gcloud alpha cloud-shell ssh --ssh-flag="-A"
```

Interactive (can be slow)
```
  gcloud beta interactive
```
