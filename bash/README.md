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

add following command to break the script
```
  debugger "$@"
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
