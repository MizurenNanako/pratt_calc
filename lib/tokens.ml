open Sexplib.Conv

module Num = struct
  type t = float [@@deriving sexp_of]

  let ( + ) = ( +. )
  let ( - ) = ( -. )
  let ( * ) = ( *. )
  let ( / ) = ( /. )
  let ( ^ ) = Float.pow
end

module Op = struct
  type t = Assign | Add | Sub | Mul | Div | Pow | Dot [@@deriving sexp_of]
end

type token =
  | Err of {lineno1: int; colno1: int; lineno2: int; colno2: int}
  | Num of float
  | Op of Op.t
  | Id of string
  | LP
  | RP
  | LB
  | RB
  | Eof
[@@deriving sexp_of]
