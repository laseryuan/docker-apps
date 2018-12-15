Create volume
```
    docker volume create \
      --label keep \
      --driver local \
      --opt type=cifs \
      --opt o=username=username,file_mode=0777,dir_mode=0777 \
      --opt device=//192.168.1.100/seafile \
      seafile

docker run -it --rm -v seafile:/mnt busybox ls /mnt -l

docker volume rm seafile
```

Start server
```
docker run -d --name seafile \
  -e SEAFILE_SERVER_HOSTNAME=seafile.unsown.top \
  --label keep \
  --restart unless-stopped \
  -p 20081:80 \
  -e SEAFILE_ADMIN_EMAIL=me@example.com \
  -e SEAFILE_ADMIN_PASSWORD=password\
  -v seafile:/shared \
  seafileltd/seafile:latest

docker rm -f seafile

docker exec -it seafile /opt/seafile/seafile-server-latest/reset-admin.sh
  seafileltd/seafile:latest
```

Debug
```
sudo rm -r test/*

docker run --rm --name seafile \

      --opt o=username=username,file_mode=0777,dir_mode=0777 \
      --opt o=username=username,uid=1000,gid=1000 \
      --opt o=username=username \
```
