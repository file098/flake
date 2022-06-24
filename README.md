# My personal Nixos configuration

On live ISO

```bash
$ sudo su
# nix-env -iA nixos.git
# git clone <repo url> /mnt/<path>
# nixos-install --flake .#<host>
# reboot
/* login */
$ sudo rm -r /etc/nixos/configuration.nix
/* move to build to desired location */
```
