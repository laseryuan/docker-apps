## Usage
```
mkdir myapp
cd myapp

docker run -it --rm \
    -v "$(pwd)":/tmp/app \
    -w /tmp/app \
    lasery/devjs bash -lc init
```

## Reference
