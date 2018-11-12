docker run -it --rm --name="chromium" \
  --net=host -e DISPLAY -v /home/pi/.Xauthority:/home/chrome/.Xauthority:ro \
  --privileged \
  -v /opt/vc:/opt/vc \
  -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
  -v /dev/shm:/dev/shm \
  lasery/chromium:armv6hf-18.11 \
  chromium-browser

# Development
cd ~/projects/docker-apps/chromium/

docker build -t lasery/chromium:armv6hf -f Dockerfile.armv6hf .

docker run -it --rm --name="chromium" \
  --net=host -e DISPLAY -v /home/pi/.Xauthority:/home/chrome/.Xauthority:ro \
  --privileged \
  -v /opt/vc:/opt/vc \
  -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
  -v /dev/shm:/dev/shm \
  lasery/chromium:armv6hf \
  chromium-browser

  bash

  -v /etc/fonts/ \

docker tag lasery/chromium:armv6hf lasery/chromium:armv6hf-18.11
docker push lasery/chromium:armv6hf-18.11
