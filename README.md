# DotFiles

Create symlinks to the respecitve DotFiles and name them accordingly.<br>
The only exception is `.gitconfig` which has to be copied and adapted.

## vscodium
Symlink `product.json` and `settings.json` from `~/.config/VSCodium/`<br>
and from `~/.config/VSCodium/User/`, respectively.

Extensions:
```bash
$ codium --list-extensions | xargs -L 1 echo code --install-extension
code --install-extension fortran-lang.linter-gfortran
code --install-extension Gimly81.fortran
code --install-extension hansec.fortran-ls
code --install-extension jeanp413.open-remote-ssh
code --install-extension ms-python.isort
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension ms-toolsai.jupyter-keymap
code --install-extension ms-toolsai.jupyter-renderers
code --install-extension ms-toolsai.vscode-jupyter-cell-tags
code --install-extension ms-toolsai.vscode-jupyter-slideshow
code --install-extension ms-vscode.cpptools
code --install-extension timonwong.shellcheck
code --install-extension vscodevim.vim
```
Run each line to install the respective extension.
