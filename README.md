# sysutil - system utilities to share among different computers

The purpose of this repository is to collect some utilities that are shared
among different computers. I use them to have consistent experience between
different hosts at work, but also at home. You are free to use this tools and
configuration files but I don't take any liability. The following utilities are
available:

- [Vim Configuration](#vim)
- [vscode-neovim Configuration](#vscode-neovim)
- [Git Configuration](#git-config)
- [Bash Aliases](#bash-aliases)
- [Remote Settings Sync](#remote-settings-sync)

## Vim

This repository contains a hierarchy of vimrc files. There are two main files
which import other "add-on"-files. The idea is to link either `vimrc-base` or
`vimrc-office-btaf` to the home folder as `~/.vimrc`. This can be done manually
or better with the script `vim-setup.sh`. This script ensures that the initial
package manger repository (https://github.com/k-takata/minpac) is cloned to the
vim plugin directory, then links the `vimrc-base` file and finally starts vim to
install the required plugins as specified in the linked vimrc file.

Along with the vimrc files there is the
[vim-cheat-sheet](doc/vim-cheat-sheet.txt) which is specific to my personal
vimrc files. It is a good reference to learn and re-learn all key-bindings in my
repertoire.

The file `vimrc-base` contains basic settings and all required plugins for my
personal projects. It is the minimum required for me. The file
`vimrc-office-btaf` additionally imports the add-ons emojis, sonarlint, btaflint
and copilot - overall just a bit more fun to work with. Emojis is a fun-plugin
that uses emojis to mark changed lines.  Sonarlint and btaflint are used for
static code analysis (btaflint is proprietary to my company). Both plugins
required corresponding tools to be installed on the host. Copilot is the
Microsoft AI integration. Also this needs to be properly set up (see
https://github.com/github/copilot.vim).

The vimrc files are designed to work with Vim version >= 8. They should be safe
for neovim as well, I used neovim for some time. Currently, I am more often
using [vscode-neovim](#vscode-neovim), especially at work. The reason for this
is that the modern AI tools are way better integrated. But I still use plain old
Vim often enough to properly maintain the config files in this repository.

### References

[1] Practical Vim, Edit Text at the Speed of Thought, Drew Neil, 2012

[2] Modern Vim, Craft Your Development Environment with Vim 8 and Neovim,
    Drew Neil, 2018

### Installation and setup

To make everything work, you need at least Vim version 8 (or Neovim).

#### Install Vim 8 and required dependencies

Installation of Vim 8 on Ubuntu 20.04:
```
$ sudo add-apt-repository ppa:jonathonf/vim
$ sudo apt update
$ sudo apt install vim
```

Along with that, you need to install the following packages (for Ubuntu 20.04):
```
$ sudo apt install git ripgrep ctags cscope
```
Note: For code navigation, auto-completion and refactoring, additionally some
Language Servers (LSP) are required (see below for more information).

There is a simple Vim walk-through tools for newbies. It guides you through the
very first steps:
```
$ vimtutor
```

If you are a work mate of me, you don't need to install anything, it is all
there on the test-automation hosts.

#### Install vimrc

Installing the vimrc is very simple:

```
$ cd ~
$ git clone https://github.com/burrima/sysutil
$ cd sysutil
$ ./vim-setup.sh  # -> follow the instructions
```

The installation will ask you to overwrite the existing `~/.vimrc` file. If you
answer with yes, a backup called `~/.vimrc-backup` will be made before. So, it's
pretty safe to say yes. If you say no, then you have to manually link the
desired vimrc file to `~/.vimrc`.

To update the vimrc after you have done the first installation, the following
steps are sufficient:
```
$ cd ~/sysutil
$ git pull
$ vim
:PackMaintain
```
This will update all vim packages as defined in the updated vimrc file.

#### Install Powerline Fonts
The airline package for the status line can make use of so-called "Powerline
Fonts" for a more "modern" look (and emojis). These fonts are patched, such that
they contain special symbols in the higher (usually unused) regions. The use of
this feature is optional and must be enabled explicitly in your local .vimrc
file.

Most importantly, you have to install the fonts on the host that is actually
rendering the Vim screen. Normally, this is the PC where you work on (when
using Vim over SSH, fonts need to be installed on the client side).

To install them in Ubuntu 24.04, type:
```
$ sudo apt install fonts-powerline
```

To tell Vim to use the fonts, add the following line to your local .vimrc file:
```
let g:airline_powerline_fonts = 1
```

#### Disable Caps-Lock key
When you accidentally press the Caps-Lock key, you will notice that Vim behaves
very badly. So badly, that you can easily mess up your document with just a few
key strokes. Luckily, there's always the undo key but it is still annoying.

Thus, Drew Neil recommends in [1] to disable the Caps-Lock key completely and
use it for something more useful (e.g. <Esc> or <Ctrl> if these are a stretch on
your keyboard). The mapping shall be done system-wide. Google by yourself, but
for Ubuntu 20.04, this is what I have done:

Add the following to the file `~/.Xmodmap`:
```
!! replace capslock by esc key:
clear lock
keycode 0x42 = Escape
```

Please note that disabling the Caps-Lock key system-wide will take you the
possibility to type capital Umlaut letters in other tools than Vim. If this is a
problem for you, then better don't disable the Caps-Lock key. In Vim, you can
use the Operator `gU` to capitalize.

#### Install Language Servers (LSP)

Code navigation (go-to-definition etc), as well as auto-completion and
code-refactoring is possible in Vim through the Language Server Protocol.
There is - at the time being - heavy activity ongoing on this topic. So, I
decided for a simple, easy to install and still flexible solution: The ALE
plugin comes already with support for Language Servers. It is maybe not the most
versatile solution, but it works quite nicely.

The Language Server for the corresponding programming language must be
pre-installed on the host where Vim is running (though, theoretically, it can go
through TCP sockets). See [https://langserver.org](https://langserver.org) and
[https://github.com/dense-analysis/ale](https://github.com/dense-analysis/ale)
for more information.

For python, I have issued the following commands:
```
$ pip3 install -U jedi
$ pip3 install -U jedi-language-server
```

The variable `g:ale_linters` must be extended with `jedils` - which is already
done in my vimrc.

For C++, I have used the following:
```
$ sudo apt install clangd
```

### Example config files for project specific settings

This repo contains two files that you can use in your project root directories,
or even project sub-directories to tell Vim certain settings that are project
specific.

`.editorconfig`: This file is acc. to a de-facto standard that also other
editors respect. Type ":help editorconfig" in Vim to see what settings are
available.

`.projections`: This file is used by the Vim projectionist plugin to define
variables that are loaded into vimrc when Vim is started. It is highly flexible
and currently used for code linting and fixing rules (type ":help projectionist"
in Vim).


### How to install further Vim packages

#### Packages from GitHub
In case you require further packages for Vim, it's easy to install. Packages
from github can be added the same way as the ones I am using. Add the following
entry to your `~/.vimrc` file:

```
call minpac#add('<github-user>/<github-repository>')
```

Then, restart Vim and type:
```
:PackUpdate
```

To uninstall a packet that was installed with PackUpdate, delete the entry from
your `~/.vimrc` and, restart Vim and type:
```
:PackClean
```

#### Packages from other sources
It is possible to install packages manually by cloning the git repo directly
into the `~/.vim/pack/<package-name>/start/` folder. The `<package-name>` in the
path doesn't matter to Vim - it just looks for all `start/` folders to find
packages.

Uninstalling is as easy as removing the path again.

### Other Resources
  * Drew Neil's vimcasts and blog: <https://vimcasts.org>
  * <https://www.vimfromscratch.com>
  * Find free key mappings: <http://vimcasts.org/blog/2014/02/follow-my-leader/>


## vscode-neovim

Yes, I started using VsCode at work - for the simple reason of better
integration of modern AI tools. There are plugins which work fine in plain Vim -
and I use them as well - but the experience in VsCode is better for the time
being.

In my case, VsCode is running on Windows 11. But of course, I need all the Vim
power under the hood. This is possible with the plugin
https://github.com/vscode-neovim/vscode-neovim - thanks to volunteers which
provide this great tool!

To make it work, you need to install the original neovim (nvim) from
https://neovim.io/. Neovim must run stand-alone on the Windows PC to make it
work. Due to restrictions, I had to unzip the provided archive into:
`C:/users/<user>/bin/`. Then, I had to provide the path to nvim.exe to the
vscode-neovim plugin (open settings in VsCode and search for neovim). See also
the instructions on https://github.com/vscode-neovim/vscode-neovim.

You also need Git to be installed on Windows. Git is used to manage the Vim
plugins. If you are a work-mate of me, then you have to order Git in the company
portal.

When everything is installed, neovim should already be working in VsCode. The
normal mode is handled by neovim while the insert mode is the normal VsCode
editor (as far as I understood the documentation).

Now, copy the file `vimrc-vscode-neovim`, re-named as `init.vim` into the
folder: `C:/users/<user>/AppData/Local/nvim/`. This will bring my known settings
to vscode-neovim.

But first, you have to clone https://github.com/k-takata/minpac into the nvim
plugins directory. See on the linked page how to do it. Then, run nvim from the
installed bin folder and type `:PackMaintain` followed by Enter. This will
install all required plugins.

If all went well, you are ready to use vscode-neovim the way I do. Remember that
you have always the [vim-cheat-sheet](doc/vim-cheat-sheet.txt) at hand if you
are lost or want to learn something new.


## Git Config

If you'd like to use my general git settings, then add the following line to
your personal `~/.gitconfig` file:

```
[include]
	path = sysutil/gitconfig
```

My gitconfig file defines to use vim as editor and vimdiff as default diff tool.
Furthermore, it defines some abbreviations and contains other useful settings.


## Bash Aliases

If you want to use my Bash aliases, then do:

```
$ cd ~
$ ln -s sysutil/bash\_aliases .bash\_aliases
```

My bash\_aliases ensure that 256 colors are used in terminal (I had issues on
SSH-reconnect with lost colors). It defines to use vi-emulated mode on the bash
shell, defines useful command abbreviations (alias) and defines some settings
for NVM (node version manager) - used to install nodejs which is required only
if you want to integrate Copilot into Vim.

 Last but not least, my bash\_aliases
import `~/.bash\_credentials` if exists. This can be used to define API keys as
variables to be used as command arguments. Please make sure that this file is
not readable by any other user (`chmod 600 ~/.bash\_credentials`).


## Remote Settings Sync

There are two scripts which I use to synchronize all required settings from one
hosts home-drive to another host: `sync-from-remote.sh` and
`setup-dependent-host.sh`. This allows me to have consistent setups on different
hosts at work. I only have to maintain one host and the others just copy all
required files.

Better would be a more sophisticated solution, e.g. with Active Directory and
cloud storage - but the solution is so simple that it just works (note: all
hosts are identical).

You may want to use those files for your own purpose, but I urge you to only do
so if you understand what is going on. I am not taking any responsibility for
lost or overwritten files. This is a fully personal feature and nothing robust.


## Revision History

#### Version 2.4.0
  * Lots of improvements
  * Add vscode-neovim
  * Add Remote Settings Sync
  * Re-work README.md

#### Version 2.3.0
Incremental update:
  * bash\_aliases: add further shortcuts: ls variants
  * vimrc cleanup/fixes:
    * disable inline-ale linting errors because it causes visual problems
    * remove "set nocompatible" which is contained in vim-sensible
    * set tagbar with to 70
    * improve git shortcuts
    * bring cutlass package to the main vimrc file
  * vimrc extensions:
    * add vimrc-sonarlint extension, imported in vimrc-burrima
    * add vimrc-btaflint (used in office), imported in vimrc-burrima
    * switch to gruvbox8 color scheme
  * gitconfig: extend with further commands
  * update vim cheat sheet

#### Version 2.2.0
Add support for Neovim (and other updates):
  * Let user choose default editor (vim or nvim) in bash_aliases
  * Add editor support for lynx in bash_aliases
  * Add cutlass plugin to vimrc-burrima to have better cut-paste experience
  * Fix `<Space>b` behavior
  * Use `gs` instead of `<Leader>*` to grep for word under cursor
  * Add `<Space>i` and `<Space>s` to jump to Implementation and do Symbol search
    with ALE
  * Remove default linters and fixers from vimrc to enable ALE plugin defaults
    (use projectionist plugin to specify project-specific ones)
  * Add further shortcuts to gitconfig
  * Update vim-cheat-sheet documentation
  * Update this README

#### Version 2.1.1
Minor bugfixes:
  * Remove unused mappings for taglist (fix clash of `<Space>t` with ALE plugin)
  * Fix buffer list navigation with `<C-j>` and `<C-k>`
  * Update vim-cheat-sheet documentation

#### Version 2.1.0
Some useful extensions:
  * add :PackMaintain command to clean and update plugins in one step
  * add plugin vim-repeat to make extra plugin commands repeatable
  * add python pep8 indentation plugin
  * rework and update Git integration
  * update documentation

#### Version 2.0.3
Fix vim-setup script for fresh installs.

#### Version 2.0.2
Stop vim-setup when user does not want to overwrite his vimrc file (just setup
the minimum needed). Small documentation fixes and cleanup.

#### Version 2.0.1
Minor improvement in the installation process. Use global btaflint script
instead of local one to make it independent of currently checked-out branch.

#### Version 2.0.0
Complete re-work of vimrc, doc and the installation process, after reading book
[2] and re-reading book [1]:

  * use of package manager and use of many useful packages
  * more modern look-and-feel (with git-integration, new status-line, etc.)
  * complete re-work of the [vim-cheat-sheet](doc/vim-cheat-sheet.txt)
  * complete re-work of the installation process (by using `vim-install.sh`)
  * shift of responsibility (user has to source my vimrc file into his/hers)
  * added short-cuts with the `<Space>` bar (note: use `<Space>b` instead of
    just `<Space>` to show the buffer list)
  * added other mappings that are helpful on the Swiss keyboard

#### Version 1.2.1
Add version label to vimrc and doc

#### Version 1.2.0
Add btaflint - a project specific linter that we use in our office.

#### Version 1.1.0
Use full path in backup and swap files to prevent file clashes on shared PCs.

#### Version 1.0.0
Initial version from 2014-2018, after reading the book [1].


