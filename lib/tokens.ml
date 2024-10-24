module Num = struct
  type t = float [@@deriving show]

  let ( + ) = ( +. )
  let ( - ) = ( -. )
  let ( * ) = ( *. )
  let ( / ) = ( /. )
  let ( ^ ) = Float.pow
end

module Op = struct
  type t = Assign | Add | Sub | Mul | Div | Pow | Dot [@@deriving show]
end

type token =
  | Err of int * int
  | Num of float
  | Op of Op.t
  | Id of string
  | LP
  | RP
  | LB
  | RB
  | Eof
[@@deriving show]
