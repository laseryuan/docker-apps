set -eux

apt-get update && apt-get -y upgrade

apt-get install -y \
  locales tzdata

apt-get install -y \
  language-pack-zh-hans-base \
  language-pack-zh-hans \
  language-pack-zh-hant-base \
  language-pack-zh-hant \

apt-get install -y \
  ttf-wqy-zenhei \
  ttf-wqy-microhei \
  xfonts-wqy fonts-arphic-uming

apt-get install -y \
  ibus-rime \
  librime-data-jyutping \
  librime-data-luna-pinyin

# confile locale
ln -sf /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime
locale-gen en_US.UTF-8 zh_CN zh_CN.UTF-8 zh_TW zh_TW.UTF-8 zh_HK zh_HK.UTF-8 zh_SG zh_SG.UTF-8

# config ibus-rime
mkdir -p /home/headless/.config/ibus/rime
cp rime/default.custom.yaml /home/headless/.config/ibus/rime/

apt-get autoclean -y
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
