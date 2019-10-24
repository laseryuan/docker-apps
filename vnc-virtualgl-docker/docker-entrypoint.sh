#!/bin/bash
# vim: set noswapfile :

main() {
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1 # If the container was forced stopped
  case "$1" in
    fps)
shift
/opt/TurboVNC/bin/vncserver :1 -securitytypes None -viewonly
barrierc -d INFO --no-daemon -n mc-vnc "$@"
      ;;
    game)
/opt/TurboVNC/bin/vncserver :1 -securitytypes None
tail -f /dev/null
      ;;
# NoVNC proxy
    web)
/opt/websockify/run 5901 --cert=/self.pem --ssl-only --web=/opt/noVNC --wrap-mode=ignore -- vncserver :1 -securitytypes otp -otp
      ;;
    help)
      run-help
      ;;
    *)
      exec "$@"
      ;;
  esac
}

run-help() {
  cat /README.md
}

main "$@"
