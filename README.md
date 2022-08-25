# OpenPulse Python Parser Reference Implementation

This project is a reference implementation of [OpenPulse](https://openqasm.com/language/openpulse.html).
Specifically, the parser passes the body of `cal` and `defcal` written in `OpenPulse`.
It reuses the classical types and statements from `openqasm3`.
## Developing openpulse

### Working with submodule

The `openpulse` package depends on the `openqasm3` package. This repo references the 
[OpenQASM](https://github.com/openqasm/openqasm) repo as submodule.

To clone `openpulse`, run:

```
git clone --recurse-submodules https://github.com/openqasm/openpulse-python.git
```

If you forgot `--recurse-submodules` during initial cloning, you can run:

```
git submodule update --init --recursive
```

### Build and install openqasm3

We assume that you have already installed `Antlr4` tools following `openqasm/source/openqasm/README.md`
and set up an Python virtual environment for this project. 

You will need to build and install `openqasm3` first. Change to the `openqasm/source/grammar` 
directory and run:

```
antlr4 -o ../openqasm/openqasm3/antlr -Dlanguage=Python3 -visitor qasm3Lexer.g4 qasm3Parser.g4
```

Then change to the `openqasm/source/openqasm` directory and run:

```
python -mpip install -r requirements.txt -r requirements-dev.txt
python -mpip install -e ".[all]"
```

### Working with openpulse

Now build the `openpulse` grammar. Change to the `source/grammar` directory and run:

```
antlr4 -lib ../../openqasm/source/grammar -o ../openpulse/openpulse/antlr -Dlanguage=Python3 -visitor openpulseLexer.g4 openpulseParser.g4
```

Finally, you can change to the `source/openpulse` directory and run:

```
pytest .
```
