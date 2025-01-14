# xframes-ocaml

## Instructions

### Install opam

#### Debian Trixie

I followed the instructions https://opam.ocaml.org/doc/Install.html and ran the shell opam installer without any issues.

#### Windows

I strongly recommend installing [opam](https://opam.ocaml.org/) through [scoop](https://scoop.sh/).

`scoop install opam`

### Install ocaml

- `opam init`
- `opam switch create 4.14.0`

### Install dune

`opam install dune`

### Running the application

Install the dependencies first

- `opam install yojson`
- `opam install ctypes`
- `opam install ctypes-foreign`

`dune exec`

## Screenshots

Windows 11

![image](https://github.com/user-attachments/assets/da0d2f3b-43c9-4448-a079-4cf4db95e101)

Debian Trixie

![Screenshot From 2025-01-14 19-42-12](https://github.com/user-attachments/assets/9cb87ed5-f9e6-4065-aded-3c4cb6cbb61c)

