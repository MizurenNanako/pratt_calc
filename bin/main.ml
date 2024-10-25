module Sexp = Sexplib.Sexp
module Fmt = Format

let run_lex_only () =
  let lexbuf = Sedlexing.Utf8.from_channel stdin in
  let rec loop () =
    let open Tokens in
    let open Fmt in
    match Lexer.lex lexbuf with
    | Eof -> ()
    | Err _ as k -> sexp_of_token k |> Sexp.pp std_formatter
    | k ->
      sexp_of_token k |> Sexp.pp std_formatter;
      loop ()
  in
    loop (); Fmt.print_newline ()

let () = run_lex_only ()
