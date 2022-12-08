"debugger" command avaible for bash script debugging

```
docker run -it lasery/bash bash -l
```

Use OS agnostic path in you bash script
```
#!/usr/bin/env bash
```

# Debug methods

##Method 1
use debugger
https://blog.jez.io/bash-debugger/

- add breaking point
```
debugger "$@"
```

- conditional break
```
local debug_control=0
[ $debug_control ] && debugger "$@"
```

- add test cases to script
- use mock method
```
test (){
  function ssh {
    echo "calling: ssh $@"
  }
  export -f ssh

  if [[ $(main me@host ) != "calling: ssh me@host" ]]; then
    echo "TEST FAILURE: ssh"
    exit 1
  fi
  echo test succeed!
}

if [[ "$1" = "test" ]]; then
  test "$@"
else
  main "$@"
fi
```

##Method 2
use return

target.sh
```
local MY_VAR

return

echo $MY_VAR
```
source target.sh
