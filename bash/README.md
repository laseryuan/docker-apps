"debugger" command avaible for bash script debugging

```
docker run -it lasery/bash bash -l
bash /sample.sh test
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


##Method 2
use return

target.sh
```
local MY_VAR

return

echo $MY_VAR
```
source target.sh
