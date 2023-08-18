# DotFiles

Create symlinks to the respecitve DotFiles and name them accordingly.<br>
The only exception is `.gitconfig` which has to be copied and adapted.

## vscodium
Symlink `product.json` and `settings.json` from `~/.config/VSCodium/`<br>
and from `~/.config/VSCodium/User/`, respectively.

Extensions:
```bash
$ codium --list-extensions | xargs -L 1 echo codium --install-extension
codium --install-extension fortran-lang.linter-gfortran
codium --install-extension Gimly81.fortran
codium --install-extension hansec.fortran-ls
codium --install-extension jeanp413.open-remote-ssh
codium --install-extension ms-azuretools.vscode-docker
codium --install-extension ms-python.isort
codium --install-extension ms-python.python
codium --install-extension ms-python.vscode-pylance
codium --install-extension ms-toolsai.jupyter
codium --install-extension ms-toolsai.jupyter-keymap
codium --install-extension ms-toolsai.jupyter-renderers
codium --install-extension ms-toolsai.vscode-jupyter-cell-tags
codium --install-extension ms-toolsai.vscode-jupyter-slideshow
codium --install-extension ms-vscode.cpptools
codium --install-extension njpwerner.autodocstring
codium --install-extension tht13.python
codium --install-extension timonwong.shellcheck
codium --install-extension vscodevim.vim
```
Run each line to install the respective extension.<br>
For the fortran extensions install
```bash
pip3 install --user --upgrade fortls fortran-language-server
```
Using `VSCodium` instead of `VSCode`, `pylance` needs to be limited to version `2023.6.40`.
