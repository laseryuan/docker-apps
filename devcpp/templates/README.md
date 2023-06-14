## Initialize project
```
init
```

## Settings
### Vim
let g:syntastic_cpp_include_dirs = [ 'include', 'include/eigen', '/usr/local/include/gsl', '/usr/lib/llvm-3.5/include' ]

## REPL
- cling
```
cling \
  -I ./include \
  -L /usr/lib

.L hello.cpp
hello()
.q
```

## build
```
clang++ -I ./include -std=c++11 hello.cpp -o bin/hello
bin/hello
```

- inspector
https://github.com/inspector-repl/inspector

prepare
```
ln -s /opt/cling/include/cling ./
ln -s /tmp/inspector/include ../
```

let program connect to repl (in another session)
```
inspector repl
```

prebuild & build
```
inspector prebuild test-inspector.cpp
clang++ -o test-proc $(inspector print-cflags) test-inspector.cpp
```

connect
```
./test-proc
```

## issue
inspector raise error when run "inspector repl" in the same directory as the
prebuild cpp file
