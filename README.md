# WIP

## Flake Phylosophy

<!-- allora, i sistemi devono essere definiti nel flake, dove tutto condivide gli stessi moduli, e per ogni sistema si ha la possibilità di true/false i moduli
ho bisogno di una funzione custom che buildi le base del host ma che contenga già l'utente di default e il modulo del HM.

Non mi serve avere una cartella hosts dato che essi verrano definiti direttamente nel flake passando i parametri necesseri.

questa deve essere l'idea di base: <https://github.com/jordanisaacs/dotfiles>
per quando riguarda hm come modulo usare questo flake: <https://github.com/kenranunderscore/dotfiles>
anche questo è un buon flake
<https://github.com/GlancingMind/flake-config> -->

All the system should share all the configs, the specific configs should be defined in the `machines` folder by enable/disable the module

Dir tree:

- machines: per system specific config (hardware, boot)
- modules
  - system: nixos managed modules
  - home: HM managed modules
- lib: custom functions such as mkSystem
- other: wallpapers
