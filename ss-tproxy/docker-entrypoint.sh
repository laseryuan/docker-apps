#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    ipt2socks)
shift
run-ipt2socks "$@"
      ;;
    sstproxy)
shift
run-sstproxy
      ;;
    help)
cat /README.md
      ;;
    *)
      exec "$@"
      ;;
  esac
}

run-sstproxy() {
  ss-tproxy-config

  # setup handlers
  trap 'usr_handler' SIGUSR1
  trap 'term_handler' SIGTERM

  echo "Starting ss-tproxy ..."
  ss-tproxy start ${SSTP_CONFIG}

  # wait indefinetely
  echo wait indefinetely
  tail -f /dev/null & wait
  echo ending ...
}

ss-tproxy-config-valid() {
  if test $# -eq 2
  then
      socks_ip=$1
      socks_port=$2
  else
      echo "No proxy URL defined. Using default."
      exit 125
  fi
}

ss-tproxy-config() {
  # ss-tproxy-config-valid

  [ -z "${HOST_ADDRESS}" ] && { echo "Need to defaine HOST_ADDRESS !"; return 1; } || host_address="${HOST_ADDRESS}"

  [[ "${DEBUG}" == "true" ]] && ipt2socks_verbose='-v' || ipt2socks_verbose=""
  [[ "${DEBUG}" == "true" ]] && log_debug='on' || log_debug="off"

  [ -z "${USE_REDSOCKS}" ] && use_redsocks='true' || use_redsocks="false"
  [ -z "${SOCKS_IP}" ] && socks_ip='127.0.0.1' || socks_ip="${SOCKS_IP}"
  [ -z "${SOCKS_PORT}" ] && socks_port='1080' || socks_port="${SOCKS_PORT}"


  echo "Creating ss-tproxy configuration file ..."
  sed \
    -e "s|\${host_address}|${host_address}|" \
    -e "s|\${DEBUG}|${if_debug}|" \
      /etc/ss-tproxy/tmpl/ss-tproxy.conf.tmpl > /etc/ss-tproxy/ss-tproxy.conf.tmp

  if [[ "${use_redsocks}" == "true" ]]; then
    echo "Creating redsocks.conf file using: ${socks_ip}:${socks_port}..."
    sed \
      -e "s|\${ip}|${socks_ip}|" \
      -e "s|\${port}|${socks_port}|" \
      -e "s|\${log_debug}|${log_debug}|" \
        /etc/ss-tproxy/tmpl/redsocks.conf.tmpl > /etc/ss-tproxy/redsocks.conf

    cat /etc/ss-tproxy/redsocks.conf

    echo "Use redsocks startup script ..."
    sed \
      -e "s|\${proxy_startcmd}|start_redsocks2|" \
      -e "s|\${proxy_stopcmd}|kill -9 \$(pidof redsocks2)|" \
        /etc/ss-tproxy/ss-tproxy.conf.tmp > /etc/ss-tproxy/ss-tproxy.conf

    cat /etc/ss-tproxy/tmpl/start_redsocks2.tmpl >> /etc/ss-tproxy/ss-tproxy.conf
  else
    sed \
      -e "s|\${proxy_startcmd}|start_ipt2socks|" \
      -e "s|\${proxy_stopcmd}|kill -9 \$(pidof ipt2socks)|" \
        /etc/ss-tproxy/ss-tproxy.conf.tmp > /etc/ss-tproxy/ss-tproxy.conf

    echo "Use ipt2socks startup script using ${socks_ip}:${socks_port}..."
    sed \
      -e "s|\${socks_ip}|${socks_ip}|" \
      -e "s|\${socks_port}|${socks_port}|" \
      -e "s|\${verbose}|${ipt2socks_verbose}|" \
        /etc/ss-tproxy/tmpl/start_ipt2socks.tmpl >> /etc/ss-tproxy/ss-tproxy.conf
  fi

  cat /etc/ss-tproxy/ss-tproxy.conf
}

run-ipt2socks() {
  if test $# -eq 2
  then
      proxy_ip=$1
      proxy_port=$2
  else
      echo "No proxy URL defined. Using default."
      exit 125
  fi

  echo "Activating iptables rules..."
  /usr/local/bin/redsocks-fw.sh start

  pid=0

  # setup handlers
  trap 'kill ${!}; usr_handler' SIGUSR1
  trap 'kill ${!}; term_handler' SIGTERM

  echo "Starting ipt2socks using proxy ${proxy_ip}:${proxy_port}..."
  ipt2socks -R -s ${proxy_ip} -p ${proxy_port} &
  pid="$!"

  # wait indefinetely
  while true
  do
      tail -f /dev/null & wait ${!}
  done
}

# SIGTERM-handler
term_handler() {
  echo "Term signal catched. Shutdown ss-tproxy ..."
  ss-tproxy stop
  iptables-save | grep -v SSTP | iptables-restore
  exit 143; # 128 + 15 -- SIGTERM
}

main "$@"
