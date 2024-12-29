open Ctypes
open Foreign
open Yojson.Basic







let darkestGrey = "#141f2c"
let darkerGrey = "#2a2e39"
let darkGrey = "#363b4a"
let lightGrey = "#5a5a5a"
let lighterGrey = "#7A818C"
let black = "#0A0B0D"
let white = "#fff"

type imgui_col =
  | Text
  | TextDisabled
  | WindowBg
  | ChildBg
  | PopupBg
  | Border
  | BorderShadow
  | FrameBg
  | FrameBgHovered
  | FrameBgActive
  | TitleBg
  | TitleBgActive
  | TitleBgCollapsed
  | MenuBarBg
  | ScrollbarBg
  | ScrollbarGrab
  | ScrollbarGrabHovered
  | ScrollbarGrabActive
  | CheckMark
  | SliderGrab
  | SliderGrabActive
  | Button
  | ButtonHovered
  | ButtonActive
  | Header
  | HeaderHovered
  | HeaderActive
  | Separator
  | SeparatorHovered
  | SeparatorActive
  | ResizeGrip
  | ResizeGripHovered
  | ResizeGripActive
  | Tab
  | TabHovered
  | TabActive
  | TabUnfocused
  | TabUnfocusedActive
  | PlotLines
  | PlotLinesHovered
  | PlotHistogram
  | PlotHistogramHovered
  | TableHeaderBg
  | TableBorderStrong
  | TableBorderLight
  | TableRowBg
  | TableRowBgAlt
  | TextSelectedBg
  | DragDropTarget
  | NavHighlight
  | NavWindowingHighlight
  | NavWindowingDimBg
  | ModalWindowDimBg

(* Define a function to convert an imgui_col to an integer *)
let int_of_imgui_col = function
  | Text -> 0
  | TextDisabled -> 1
  | WindowBg -> 2
  | ChildBg -> 3
  | PopupBg -> 4
  | Border -> 5
  | BorderShadow -> 6
  | FrameBg -> 7
  | FrameBgHovered -> 8
  | FrameBgActive -> 9
  | TitleBg -> 10
  | TitleBgActive -> 11
  | TitleBgCollapsed -> 12
  | MenuBarBg -> 13
  | ScrollbarBg -> 14
  | ScrollbarGrab -> 15
  | ScrollbarGrabHovered -> 16
  | ScrollbarGrabActive -> 17
  | CheckMark -> 18
  | SliderGrab -> 19
  | SliderGrabActive -> 20
  | Button -> 21
  | ButtonHovered -> 22
  | ButtonActive -> 23
  | Header -> 24
  | HeaderHovered -> 25
  | HeaderActive -> 26
  | Separator -> 27
  | SeparatorHovered -> 28
  | SeparatorActive -> 29
  | ResizeGrip -> 30
  | ResizeGripHovered -> 31
  | ResizeGripActive -> 32
  | Tab -> 33
  | TabHovered -> 34
  | TabActive -> 35
  | TabUnfocused -> 36
  | TabUnfocusedActive -> 37
  | PlotLines -> 38
  | PlotLinesHovered -> 39
  | PlotHistogram -> 40
  | PlotHistogramHovered -> 41
  | TableHeaderBg -> 42
  | TableBorderStrong -> 43
  | TableBorderLight -> 44
  | TableRowBg -> 45
  | TableRowBgAlt -> 46
  | TextSelectedBg -> 47
  | DragDropTarget -> 48
  | NavHighlight -> 49
  | NavWindowingHighlight -> 50
  | NavWindowingDimBg -> 51
  | ModalWindowDimBg -> 52

let theme2_colors = Hashtbl.create 50

let () =
  Hashtbl.add theme2_colors Text (white, 1.0);
  Hashtbl.add theme2_colors TextDisabled (lighterGrey, 1.0);
  Hashtbl.add theme2_colors WindowBg (black, 1.0);
  Hashtbl.add theme2_colors ChildBg (black, 1.0);
  Hashtbl.add theme2_colors PopupBg (white, 1.0);
  Hashtbl.add theme2_colors Border (lightGrey, 1.0);
  Hashtbl.add theme2_colors BorderShadow (darkestGrey, 1.0);
  Hashtbl.add theme2_colors FrameBg (black, 1.0);
  Hashtbl.add theme2_colors FrameBgHovered (darkerGrey, 1.0);
  Hashtbl.add theme2_colors FrameBgActive (lightGrey, 1.0);
  Hashtbl.add theme2_colors TitleBg (lightGrey, 1.0);
  Hashtbl.add theme2_colors TitleBgActive (darkerGrey, 1.0);
  Hashtbl.add theme2_colors TitleBgCollapsed (lightGrey, 1.0);
  Hashtbl.add theme2_colors MenuBarBg (lightGrey, 1.0);
  Hashtbl.add theme2_colors ScrollbarBg (darkerGrey, 1.0);
  Hashtbl.add theme2_colors ScrollbarGrab (darkerGrey, 1.0);
  Hashtbl.add theme2_colors ScrollbarGrabHovered (lightGrey, 1.0);
  Hashtbl.add theme2_colors ScrollbarGrabActive (darkestGrey, 1.0);
  Hashtbl.add theme2_colors CheckMark (darkestGrey, 1.0);
  Hashtbl.add theme2_colors SliderGrab (darkerGrey, 1.0);
  Hashtbl.add theme2_colors SliderGrabActive (lightGrey, 1.0);
  Hashtbl.add theme2_colors Button (black, 1.0);
  Hashtbl.add theme2_colors ButtonHovered (darkerGrey, 1.0);
  Hashtbl.add theme2_colors ButtonActive (black, 1.0);
  Hashtbl.add theme2_colors Header (black, 1.0);
  Hashtbl.add theme2_colors HeaderHovered (black, 1.0);
  Hashtbl.add theme2_colors HeaderActive (lightGrey, 1.0);
  Hashtbl.add theme2_colors Separator (darkestGrey, 1.0);
  Hashtbl.add theme2_colors SeparatorHovered (lightGrey, 1.0);
  Hashtbl.add theme2_colors SeparatorActive (lightGrey, 1.0);
  Hashtbl.add theme2_colors ResizeGrip (black, 1.0);
  Hashtbl.add theme2_colors ResizeGripHovered (lightGrey, 1.0);
  Hashtbl.add theme2_colors ResizeGripActive (darkerGrey, 1.0);
  Hashtbl.add theme2_colors Tab (black, 1.0);
  Hashtbl.add theme2_colors TabHovered (darkerGrey, 1.0);
  Hashtbl.add theme2_colors TabActive (lightGrey, 1.0);
  Hashtbl.add theme2_colors TabUnfocused (black, 1.0);
  Hashtbl.add theme2_colors TabUnfocusedActive (lightGrey, 1.0);
  Hashtbl.add theme2_colors PlotLines (darkerGrey, 1.0);
  Hashtbl.add theme2_colors PlotLinesHovered (lightGrey, 1.0);
  Hashtbl.add theme2_colors PlotHistogram (darkerGrey, 1.0);
  Hashtbl.add theme2_colors PlotHistogramHovered (lightGrey, 1.0);
  Hashtbl.add theme2_colors TableHeaderBg (black, 1.0);
  Hashtbl.add theme2_colors TableBorderStrong (lightGrey, 1.0);
  Hashtbl.add theme2_colors TableBorderLight (darkerGrey, 1.0);
  Hashtbl.add theme2_colors TableRowBg (darkGrey, 1.0);
  Hashtbl.add theme2_colors TableRowBgAlt (darkerGrey, 1.0);
  Hashtbl.add theme2_colors TextSelectedBg (darkerGrey, 1.0);
  Hashtbl.add theme2_colors DragDropTarget (darkerGrey, 1.0);
  Hashtbl.add theme2_colors NavHighlight (darkerGrey, 1.0);
  Hashtbl.add theme2_colors NavWindowingHighlight (darkerGrey, 1.0);
  Hashtbl.add theme2_colors NavWindowingDimBg (darkerGrey, 1.0);
  Hashtbl.add theme2_colors ModalWindowDimBg (darkerGrey, 1.0)

(* Convert the theme colors to a Yojson.Basic JSON format *)
let theme_to_json () =
  let json_assoc = Hashtbl.fold (fun col (color, alpha) acc ->
    let col_int = int_of_imgui_col col in
    (string_of_int col_int, `List [ `String color; `Float alpha ]) :: acc
  ) theme2_colors [] in
  `Assoc json_assoc

(* Convert the theme to a pretty-printed string *)
let theme_json = pretty_to_string (theme_to_json ())

(* Print the JSON *)
let () = print_endline theme_json













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

let on_init () = ()
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
    theme_json
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