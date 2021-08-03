docker pull lasery/v2ray
docker tag lasery/v2ray v2ray:amd64

caddy help
caddy run --help
caddy validate --help
caddy run -config /etc/Caddyfile
caddy validate -config /etc/Caddyfile
cat /etc/Caddyfile
cat /docker-entrypoint.sh | grep server_run -A 4
vi /etc/Caddyfile
/docker-entrypoint.sh server
ls /etc/v2ray/tmpl/

docker exec -it v2ray-dev bash
apk add curl
docker logs v2ray-dev
tail -f /srv/caddy.log
cat /srv/index.html
ls -al /srv/

nc -zv localhost 2333
nc -zv 172.17.0.1 80
nc -zv 172.17.0.1 443

vi /etc/hosts
curl ifconfig.me
curl http://localhost
curl http://172.17.0.1
curl https://172.17.0.1
