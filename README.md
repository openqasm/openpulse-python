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
antlr4 -o ../openpulse/openpulse/_antlr/_<major>_<minor> -Dlanguage=Python3 -visitor openpulseLexer.g4 openpulseParser.g4
```

Finally, you can change to the `source/openpulse` directory and run:

```
pytest .
```

## Deployment procedure

The deployment is primarily managed by a GitHub Actions pipeline, triggered by a tag of the form `v<version>`.
For example, for package version `0.4.0`, the tag should be `v0.4.0`.

To deploy:

1. create a PR that sets the version number of the package in `__init__.py` to what it should be.
2. once the PR has merged, tag the merge commit (for example, `git fetch origin; git tag -m "Python AST 0.4.0" v0.4.0 origin/main`).
3. push the tag to this repository (for example, `git push origin v0.4.0`).

At this point, the deployment pipeline will take over and deploy the package to PyPI.
You should be able to see the progress [in the Actions tab of this repository](https://github.com/openqasm/openpulse/actions/workflows/deploy-ast.yml).