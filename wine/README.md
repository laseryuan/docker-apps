Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker run
  -e LC_ALL=zh_CN.UTF-8 \
  -e LANG=zh_CN.UTF-8 \
  -e LANGUAGE=en_US.UTF-8 \
  -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
  --name wine \
  lasery/wine
```
# Configure Wine
```
docker exec -it wine
WINEARCH=win64 WINEPREFIX=~/.wine64 winecfg
export LC_ALL=zh_TW.BIG5
export LANG=zh_TW.BIG5
```

# run
```
WINEPREFIX=~/.wine64 wine ~/.wine64/drive_c/Program\ Files\ \(x86\)/application.exe
```

## Build image
1. Create builder image
```
python3 ~/mbuild/utils/build.py docker
python3 ~/mbuild/utils/build.py push --only
python3 ~/mbuild/utils/build.py deploy --only
```
