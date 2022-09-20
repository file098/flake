# My personal Nixos configuration

On live ISO

```bash
$ sudo su
nix-env -iA nixos.git
git clone <repo url> /mnt/<path>
nixos-install --flake .#<host>
reboot
# login
$ sudo rm -r /etc/nixos/configuration.nix
# move to build to desired location
```

## Flake Phylosophy

allora, i sistemi devono essere definiti nel flake, dove tutto condivide gli stessi moduli, e per ogni sistema si ha la possibilità di true/false i moduli
ho bisogno di una funzione custom che buildi le base del host ma che contenga già l'utente di default e il modulo del HM. HM deve essere usato come modulo del host in modo tale da aggiornare entrambi insieme, non dovendo dividere sistema e HM.

Non mi serve avere una cartella hosts dato che essi verrano definiti direttamente nel flake passando i parametri necesseri.

questa deve essere l'idea di base: https://github.com/jordanisaacs/dotfiles
per quando riguarda hm come modulo usare questo flake: https://github.com/kenranunderscore/dotfiles
