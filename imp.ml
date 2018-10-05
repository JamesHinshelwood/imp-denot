type loc = string

type a_exp =
  | Int of int
  | Deref of loc
  | Add of a_exp * a_exp

type b_exp =
  | True
  | False
  | Equal of a_exp * a_exp
  | Not of b_exp

type comm =
  | Skip
  | Assign of loc * a_exp
  | Seq of comm * comm
  | Cond of b_exp * comm * comm

type state = loc * int list

let rec sem_a a = match a with
  | Int n -> fun s -> n
  | Deref l -> fun s -> snd (List.find (fun (x, y) -> x = l) s)
  | Add (x, y) -> fun s -> (sem_a x) s + (sem_a y) s

let rec sem_b b = match b with
  | True -> fun s -> true
  | False -> fun s -> false
  | Equal (x, y) -> fun s -> ((sem_a x) s) = ((sem_a y) s)
  | Not x -> fun s -> not ((sem_b x) s)

let rec sem_c c = match c with
  | Skip -> fun s -> s
  | Assign (l, a) -> fun s -> (l, (sem_a a) s)::s
  | Seq (x, y) -> fun s -> (sem_c y) ((sem_c x) s)
  | Cond (b, x, y) -> fun s -> if (sem_b b) s then (sem_c x) s else (sem_c y) s
