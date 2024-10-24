let run_lex_only () =
  let lexbuf = Sedlexing.Utf8.from_channel stdin in
  let rec loop () =
    let open Printf in
    let open Tokens in
    match Lexer.lex lexbuf with
    | Eof -> ()
    | Err (a, b) -> printf "\nerr: %d-%d" a b
    | k ->
        show_token k |> printf "%s;";
        loop ()
  in
  loop ();
  print_newline ()

let () = run_lex_only ()
