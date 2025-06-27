# Turing machine implemented in AWK

Turing machine is implemented in file `TM.awk`. It is used like this:

```bash
awk -f TM.awk PROGRAM_NAME
```

## Program syntax

First line defines tape content. All characters can be used except space beacuse it is default record separator in AWK.
There should be only one record in first line.

Second line defines start state, end state, and initial head position. There should be excatly three records in the second line.

From third line onward control states are defined. Control states have following shape:

```text
CURRENT_STATE INPUT_CHARACTER NEXT_STATE HEAD_MOVEMENT CHARACTER_TO_WRITE
CURRENT_STATE INPUT_CHARACTER NEXT_STATE HEAD_MOVEMENT
```

So, control states should have 4 or 5 record per line.  
Head movemement can be left (L), right (R) or stay (N).
If no characters should be written, control with 4 states should be used.

## Special cases

Head can move outside of defined tape content (left of far left character and right of far right character). In those case,
NULL_CHARACTER is returned (defined in BEGIN section of AWK script). Default NULL_CHARACTER is `$` character. Only one movement
outside of tape content is allowd without writing to the tape.

## Examples

- Example1.txt - move outside of tape content on the left side
- Example2.txt - move outside of tape content on the right side
- Example3.txt - change letter `c` with letter `x`
