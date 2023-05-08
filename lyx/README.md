## Build
```
docker build -t lasery/lyx .
docker push lasery/lyx

docker run \
  --name lyx \
  -it --rm \
  -v $PWD:/home/app/app \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY \
  lasery/lyx

docker exec -it lyx bash
```

## Update aux files
1. delete all the temp files
Stop the lyx docker OR
```
rm -r  /tmp/lyx_tmpdir.waleFDXHpSH1/lyx_tmp*
```

1. in lyx view vdi

1. copy aux files from tmp
```
ls -l /tmp/lyx_tmp*/lyx_tmp*
cp /tmp/lyx_tmpdir.*/lyx_tmpbuf0/*.aux ~/
```

1. in lyx view vdi
