## 

## Initialize project
```
init
vi Dockerfile
docker build -t myapp .
```

## Usage

### Normal script
```
import ipdb; ipdb.set_trace() # for inspecting code. type "q" to quit

from IPython import embed; embed(colors="neutral") # for REPL. "ctrl-d" to quit
```

### Test environment
pytest
```
pytest -s tests/sample.py # -s: for ipdb to break
pytest -k 'test_get_all_users' # specify test function name
```

behave
```
behave tests/features/tutorial.feature --no-capture
```

### Escaping
```
ctrl-z
pkill pytest
```

## Commnads (ipdb)
? for "help"
? s for "help for command s"
c for "continue to next breakpoint"
l for "some more context"
l 200,300 "show source code from line 200 to line 300"
s for "step into"
n for "step over"
r for "return"
