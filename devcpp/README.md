Usage
```
docker run -it -v "$(pwd)":/tmp/data -e HOME=/tmp --workdir=/tmp/data \
    -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -u "$(id -u)":"$(id -g)" \
    lasery/devcpp bash -l
```


Build
```
python3 ~/mbuild/utils/build.py docker
python3 ~/mbuild/utils/build.py deploy

```

## Reference
inspector-repl: https://news.ycombinator.com/item?id=16360738
reple: https://github.com/BenBrock/reple
https://github.com/tehrengruber/Defrustrator
https://stackoverflow.com/questions/72451424/is-it-possible-to-start-a-cling-repl-from-inside-lldb
replay code: https://news.ycombinator.com/item?id=27034588
