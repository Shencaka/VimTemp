# vim-templates

This plugin is used to create templates for vim/nvim

## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'Shencaka/vim-templates'
```
Then reload Vim and run :PlugInstall.

## Usage

To save current buffer as a template run:

```vim
:SaveTemp <template name>
```

To load an existing template run:

```vim
:VimTemp <template name>
```

To delete an existing template run:

```vim
:RmTemp <template name>
```

## Defaults

By default overwriting and deletion default answer (pressing enter) will result in NO, to change this add the following to your vimrc/init.vim:
```vim
"for overwriting:
let g:replacetemp_default = 'yes' "no by deault
"for deletion:
let g:rmtemp_default = 'yes' "no by default
```
