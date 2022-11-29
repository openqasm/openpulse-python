/***** ANTLRv4  grammar for OpenPulse. *****/
// This grammar is OpenPulse extension for QOpenQASM3.0
// We introduce several new types for OpenPulse.
// We override several nodes in qasm3 to consume the new types.
// The OpenPulse grammar can be used inside cal or defcal blocks.

parser grammar openpulseParser;
import qasm3Parser;

options {
    tokenVocab = openpulseLexer;
}

calibrationBlock: openpulseStatement*;

openpulseStatement:
    // Statements can be used in the cal or defcal body
    aliasDeclarationStatement
    | assignmentStatement
    | barrierStatement
    | boxStatement
    | breakStatement
    | classicalDeclarationStatement
    | constDeclarationStatement
    | continueStatement
    | defStatement
    | delayStatement
    | endStatement
    | expressionStatement
    | externStatement
    | forStatement
    | gateCallStatement
    | ifStatement
    | includeStatement
    | ioDeclarationStatement
    | quantumDeclarationStatement
    | resetStatement
    | returnStatement
    | whileStatement
    ;

waveformLiteral: LBRACKET expression (COMMA expression)* COMMA? RBRACKET;

/** In the following we extend existing OpenQASM nodes. Need to refresh whenever OpenQASM is updated. **/
// We extend the scalarType with WAVEFORM, PORT and FRAME
scalarType:
    BIT designator?
    | INT designator?
    | UINT designator?
    | FLOAT designator?
    | ANGLE designator?
    | BOOL
    | DURATION
    | STRETCH
    | COMPLEX LBRACKET scalarType RBRACKET
    | WAVEFORM
    | PORT
    | FRAME
    ;

expression:
    LPAREN expression RPAREN                                  # parenthesisExpression
    | expression indexOperator                                # indexExpression
    | <assoc=right> expression op=DOUBLE_ASTERISK expression  # powerExpression
    | op=(TILDE | EXCLAMATION_POINT | MINUS) expression       # unaryExpression
    | expression op=(ASTERISK | SLASH | PERCENT) expression   # multiplicativeExpression
    | expression op=(PLUS | MINUS) expression                 # additiveExpression
    | expression op=BitshiftOperator expression               # bitshiftExpression
    | expression op=ComparisonOperator expression             # comparisonExpression
    | expression op=EqualityOperator expression               # equalityExpression
    | expression op=AMPERSAND expression                      # bitwiseAndExpression
    | expression op=CARET expression                          # bitwiseXorExpression
    | expression op=PIPE expression                           # bitwiseOrExpression
    | expression op=DOUBLE_AMPERSAND expression               # logicalAndExpression
    | expression op=DOUBLE_PIPE expression                    # logicalOrExpression
    | (scalarType | arrayType) LPAREN expression RPAREN       # castExpression
    | DURATIONOF LPAREN scope RPAREN                          # durationofExpression
    | Identifier LPAREN expressionList? RPAREN                # callExpression
    | (
        Identifier
        | BinaryIntegerLiteral
        | OctalIntegerLiteral
        | DecimalIntegerLiteral
        | HexIntegerLiteral
        | FloatLiteral
        | ImaginaryLiteral
        | BooleanLiteral
        | BitstringLiteral
        | TimingLiteral
        | HardwareQubit
	| waveformLiteral
      )                                                       # literalExpression
;
