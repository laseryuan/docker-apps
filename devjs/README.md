Usage
```
docker run -it -v "$(pwd)":/tmp/data -e HOME=/tmp --workdir=/tmp/data \
    -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -u "$(id -u)":"$(id -g)" \
    lasery/devcpp bash -l
```


## Reference
