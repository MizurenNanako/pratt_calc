module AST : sig
  type t
end = struct
  module Op = struct
    type unary = Positive | Negative type binary = Add | Sub | Mul | Div | Pow
  end

  type t = BopExp of Op.binary * t * t | UopExp of Op.unary * t | Num of float
end
