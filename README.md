# OpenPulse Python Parser Reference Implementation

This project is a reference implementation of [OpenPulse](https://openqasm.com/language/openpulse.html).
Specifically, the parser passes the body of `cal` and `defcal` written in `OpenPulse`.
It reuses the classical types and statements from `openqasm3`.
## Developing openpulse

To install dependencies, change to `source/openpulse` directory and run:

```
python -m pip install -r requirements.txt -r requirements-dev.txt
```

To reuse classic statements/types, OpenPulse grammar imports OpenQASM grammar. When we update the
OpenPulse grammar, we also need to copy the latest OpenQASM grammar from 
https://github.com/openqasm/openqasm/tree/main/source/grammar into the `source/grammar` directory.

Now build the `openpulse` grammar. Change to the `source/grammar` directory and run:

```
antlr4 -o ../openpulse/openpulse/antlr -Dlanguage=Python3 -visitor openpulseLexer.g4 openpulseParser.g4
```

Finally, you can change to the `source/openpulse` directory and run:

```
pytest .
```
