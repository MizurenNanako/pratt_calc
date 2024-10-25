module S = Sedlexing
module T = Tokens

(** defines integer lexeme *)
let integer = [%sedlex.regexp? Plus '0' .. '9']

(** defines postfix lexeme *)
let indicator = [%sedlex.regexp? Chars "pPeE"]

let sign = [%sedlex.regexp? Chars "+-"]
let postfix = [%sedlex.regexp? indicator, sign, integer]

(** defines decimal lexeme *)
let decimal = [%sedlex.regexp? ".", Opt integer]

(** defines full floating number lexeme *)
let real = [%sedlex.regexp? integer, Opt decimal, Opt postfix]

(** defines words lexeme *)
let alpha = [%sedlex.regexp? 'A' .. 'Z' | 'a' .. 'z']

(** lex *)
let rec lex lexbuf =
  match%sedlex lexbuf with
    | Chars " \n\t" -> lex lexbuf
    | "+" -> T.(Op Add)
    | "-" -> T.(Op Sub)
    | "*" -> T.(Op Mul)
    | "/" -> T.(Op Div)
    | "^" -> T.(Op Pow)
    | "(" -> T.LP
    | ")" -> T.RP
    | "[" -> T.LB
    | "]" -> T.RB
    | "." -> T.(Op Dot)
    | real ->
      let v =
        S.lexeme lexbuf |> Array.to_seq |> Seq.map Uchar.to_char |> String.of_seq
        |> float_of_string
      in
        T.(Num v)
    | alpha, Star (alpha | '0' .. '9') -> T.Id (S.Utf8.lexeme lexbuf)
    | eof -> T.Eof
    | _ ->
      let a, b = S.lexing_positions lexbuf in
        T.(
          Err
            { lineno1= a.Lexing.pos_lnum;
              colno1= a.Lexing.pos_cnum;
              lineno2= b.Lexing.pos_lnum;
              colno2= b.Lexing.pos_cnum
            }
        )
