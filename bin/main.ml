open Ctypes
open Foreign
open Yojson.Basic

type font_def = { name : string; sizes : int list }
type single_font_def = { name : string; size : int }

let font_defs =
  let defs = [
    { name = "roboto-regular"; sizes = [16; 18; 20; 24; 28; 32; 36; 48] }
  ] in
  List.flatten (
    List.map (fun { name; sizes } ->
      List.map (fun size -> { name; size }) sizes
    ) defs
  )

(* Convert a single_font_def to JSON *)
let single_font_def_to_json { name; size } =
  `Assoc [("name", `String name); ("size", `Int size)]
let font_defs_to_json font_defs =
  `List (List.map single_font_def_to_json font_defs)

let font_defs_assoc_array = font_defs_to_json font_defs
let font_defs_json = pretty_to_string font_defs_assoc_array

let () = print_endline font_defs_json

let on_init_callback = (funptr (void @-> returning void))
let on_text_changed_callback = (funptr (int @-> string @-> returning void))
let on_combo_changed_callback = (funptr (int @-> int @-> returning void))
let on_numeric_value_changed_callback = (funptr (int @-> float @-> returning void))
let on_boolean_value_changed_callback = (funptr (int @-> bool @-> returning void))
let on_multiple_numeric_values_changed_callback = (funptr (int @-> ptr float @-> int @-> returning void))
let on_click_callback = (funptr (int @-> returning void))

let mylib = Dl.dlopen ~filename:"xframesshared.dll" ~flags:[Dl.RTLD_NOW]
let init =
  foreign ~from:mylib "init" 
                    (string @-> 
                      string @-> 
                        string @-> 
                          on_init_callback @-> 
                            on_text_changed_callback @->
                              on_combo_changed_callback @->
                                on_numeric_value_changed_callback @->
                                  on_boolean_value_changed_callback @->
                                    on_multiple_numeric_values_changed_callback @->
                                      on_click_callback @->
                                        returning void)

(* 

 *)

let on_init () = print_endline "Initialized!"
let on_text_changed id value = Printf.printf "Text changed for widget %d: %s\n" id value
let on_combo_changed id selected_index = Printf.printf "Combo changed for widget %d: %d\n" id selected_index
let on_numeric_value_changed id value = Printf.printf "Numeric value changed for widget %d: %f\n" id value
let on_boolean_value_changed id value = Printf.printf "Boolean value changed for widget %d: %b\n" id value
let on_multiple_numeric_values_changed some_id values_ptr num_values =
  let values =
    List.init num_values (fun i ->
      !@(values_ptr +@ i)
    )
  in
  Printf.printf "ID: %d, Values: [%s]\n"
    some_id
    (String.concat ", " (List.map string_of_float values))
let on_click id =
  Printf.printf "Clicked event received for widget: %d\n" id

let () =
  init 
    "./assets" 
    font_defs_json
    "{}"
    on_init 
    on_text_changed 
    on_combo_changed 
    on_numeric_value_changed
    on_boolean_value_changed
    on_multiple_numeric_values_changed
    on_click

let () =
  print_endline "Press enter to exit.";
  ignore (read_line ())