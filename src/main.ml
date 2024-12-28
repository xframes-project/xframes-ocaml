open Ctypes
open Foreign

(* Define the callback types *)
let on_init_callback : (unit -> unit) typ = funptr void
let on_text_changed_callback : (string -> unit) typ = funptr (string @-> returning void)
let on_combo_changed_callback : (int -> unit) typ = funptr (int @-> returning void)
let on_numeric_value_changed_callback : (float -> unit) typ = funptr (float @-> returning void)
let on_boolean_value_changed_callback : (bool -> unit) typ = funptr (bool @-> returning void)
let on_multiple_numeric_values_changed_callback : (float list -> unit) typ = funptr (ptr void @-> returning void)
let on_click_callback : (unit -> unit) typ = funptr void

(* Declare the external C function *)
external init : string -> string -> string ->
                  (unit -> unit) -> (* onInit *)
                  (string -> unit) -> (* onTextChanged *)
                  (int -> unit) -> (* onComboChanged *)
                  (float -> unit) -> (* onNumericValueChanged *)
                  (bool -> unit) -> (* onBooleanValueChanged *)
                  (float list -> unit) -> (* onMultipleNumericValuesChanged *)
                  (unit -> unit) -> (* onClick *)
                  unit = "init"

let on_init () = print_endline "Initialized!"
let on_text_changed text = Printf.printf "Text changed: %s\n" text
let on_combo_changed num = Printf.printf "Combo changed: %d\n" num
let on_numeric_value_changed num = Printf.printf "Numeric value changed: %f\n" num
let on_boolean_value_changed flag = Printf.printf "Boolean value changed: %b\n" flag
let on_multiple_numeric_values_changed nums = 
  Printf.printf "Multiple numeric values changed: %s\n" (String.concat ", " (List.map string_of_float nums))
let on_click () = print_endline "Clicked!"

let () =
  init "assets" "fonts" "styles"
    on_init
    on_text_changed
    on_combo_changed
    on_numeric_value_changed
    on_boolean_value_changed
    on_multiple_numeric_values_changed
    on_click
