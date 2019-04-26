parser grammar copybook_parser;

options { tokenVocab=copybook_lexer; }

// main rule
main:
    item+
    EOF;

// literals
literal:
    STRINGLITERAL | numericLiteral | booleanLiteral | specialValues
    ;

numericLiteral:
    NUMERICLITERAL | ZERO | integerLiteral
    ;

integerLiteral:
    INTEGERLITERAL | NINES | LEVEL_ROOT | LEVEL_REGULAR | LEVEL_NUMBER_66 | LEVEL_NUMBER_77 | LEVEL_NUMBER_88
    ;

booleanLiteral
   : TRUE | FALSE
   ;

identifier:
      IDENTIFIER | THRU_OR_THROUGH | A_S | P_S | X_S | S
    | SINGLE_QUOTED_IDENTIFIER // is this valid?
    ;

thru:
    THRU_OR_THROUGH
    ;

// values
values:
    (VALUE IS? | VALUES ARE?)? valuesFromTo (COMMACHAR? valuesFromTo)*
    ;

valuesFromTo:
    valuesFrom valuesTo?
    ;

valuesFrom:
    literal
    ;

valuesTo:
    thru literal
    ;

specialValues:
    ALL literal | HIGH_VALUE | HIGH_VALUES | LOW_VALUE | LOW_VALUES | NULL | NULLS | QUOTE | QUOTES | SPACE | SPACES | ZERO | ZEROS | ZEROES
    ;

// occurs
sorts:
    (ASCENDING | DESCENDING) KEY? IS? identifier;

occurs_to:
    TO integerLiteral
    ;

occurs:
    OCCURS integerLiteral occurs_to? TIMES? (DEPENDING ON? identifier)? sorts? (INDEXED BY? identifier)?
    ;

// redefines
redefines:
    REDEFINES identifier
    ;

// renames
renames:
    RENAMES identifier (thru identifier)?
    ;

// storage
usage:
    (USAGE IS?)?
    (
      COMPUTATIONAL_1 | COMPUTATIONAL_2 | COMPUTATIONAL_3 | COMPUTATIONAL_4 | COMPUTATIONAL_5 | COMPUTATIONAL
    | COMP_1 | COMP_2 | COMP_3 | COMP_4 | COMP_5 | COMP
    | DISPLAY
    | BINARY
    | PACKED_DECIMAL
    )
    ;

separate_sign:
    SIGN IS (LEADING | TRAILING) SEPARATE? CHARACTER?
    ;

justified:
    (JUSTIFIED | JUST) RIGHT?
    ;

term:
    TERMINAL
    ;

sign_precision_9:
      NINES
    | SIGN_PRECISION_9
    ;

alpha_x:
      X_S
    | LENGTH_TYPE_X
    ;

alpha_a:
      X_S
    | LENGTH_TYPE_X
    ;

pictureLiteral:
    PICTURE | PIC
    ;

pic:
    pictureLiteral
    (
      alpha_x
    | alpha_a
    | (
        sign_precision_9 usage?
      | usage? sign_precision_9
      )
    )
    ;

section:
      LEVEL_ROOT
    | LEVEL_REGULAR
    ;

skipLiteral:
    SKIP1 | SKIP2 | SKIP3
    ;

item:
      COMMENT
    | term
    | section
      identifier
      (justified | occurs | pic | redefines | usage | values | separate_sign)*
      (BLANK WHEN? ZERO)?
      term
    | LEVEL_NUMBER_66 identifier renames term
    | LEVEL_NUMBER_88 identifier values term
    | skipLiteral
    ;


