# Implementation of the denotational semantics of IMP- in OCaml

Example usage in `utop`:
`sem_c (Seq ((Assign ("x", Int 5)), (Cond ((Equal (Deref "x", Int 6)), (Assign ("y", Int 1)), (Assign ("y", Int 2)))))) [];;`

This is roughly equivalent to:
```
x := 5;
if x = 6 then y := 1 else y := 2
```

Note the difference in the definition of `state`, compared to the semantics.
