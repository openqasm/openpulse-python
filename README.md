# OpenPulse Python Parser Reference Implementation

This project is a reference implementation of [OpenPulse](https://openqasm.com/language/openpulse.html).
Specifically, the parser passes the body of `cal` and `defcal` written in `OpenPulse`.
It reuses the classical types and statements from `openqasm3`.
## Developing openpulse

### Working with submodule

The `openpulse` repo depends on the antlr grammar in  
[OpenQASM](https://github.com/openqasm/openqasm) repo. It references OpenQASM as submodule.

To clone `openpulse`, run:

```
git clone --recurse-submodules https://github.com/openqasm/openpulse-python.git
```

If you forgot `--recurse-submodules` during initial cloning, you can run:

```
git submodule update --init --recursive
```

### Working with openpulse

To install dependencies, change to `source/openpulse` directory and run:

```
python -m pip install -r requirements.txt -r requirements-dev.txt
```

Now build the `openpulse` grammar. Change to the `source/grammar` directory and run:

```
antlr4 -lib ../../openqasm/source/grammar -o ../openpulse/openpulse/antlr -Dlanguage=Python3 -visitor openpulseLexer.g4 openpulseParser.g4
```

Finally, you can change to the `source/openpulse` directory and run:

```
pytest .
```
