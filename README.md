# sysutil - system utilities to share among different computers

The purpose of this repository is to collect some utilities that are shared
among different computers. You are free to use my stuff in here but I don't take
liability for anything. There are the following utilities available:

- [Vim 8 Configuration](#vim-8)
- [Git Configuration](#git-config)
- [Bash Aliases](#bash-aliases)

## Vim 8 Configuration

This repository contains a [vimrc](vimrc) file that you can use to have the same
Vim experience than I have. Along with that, you can use my
[vim-cheat-sheet](doc/vim-cheat-sheet.txt) that is specific to my vimrc file.

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

#### Install vimrc

Installing the vimrc is very simple:

```
$ cd ~
$ git clone https://bitbucket.org/burrima/sysutil.git
$ cd sysutil
$ ./vim-setup.sh  # -> follow the instructions
```

The installation will ask you to overwrite the existing `~/.vimrc` file. If you
answer with yes, a backup called `~/.vimrc-backup` will be made before. So, it's
pretty safe to say yes. If you say no, then you have to manually source the
`sysutil/vimrc` file into your own vimrc config file (use `vimrc-user` as
inspiration).

The reason why the new installation process does not copy the vimrc directly to
your home drive is that it leaves you the possibility to add your own personal
(or computer specific) settings outside of version control (you are responsible
for your own changes by your own).

Note: If you are a work-mate of me, working with the BTAF framework, you have to
issue the following additional commands:
```
$ mkdir -p ~/.vim/pack/btaflint/start/btaflint/plugin/
$ ln -s /opt/btaflint.vim ~/.vim/pack/btaflint/start/btaflint/plugin/btaflint.vim
```
This will install a small local plugin as an extension to ALE. It is needed to
make the `btaflint` extra linting script active.

If you are brave, you may copy or link the file `vimrc-burrima` to `~/.vimrc`.

To update the vimrc after you have done the first installation, the following
steps are sufficient:
```
$ cd ~/sysutil
$ git pull
$ vim
:PackMaintain
```
It will keep your local `~/.vimrc` file untouched.

#### Install Powerline Fonts
The airline package for the status line can make use of so-called "Powerline
Fonts" for a more "modern" look. These fonts are patched, such that they contain
special symbols in the higher (usually unused) regions. The use of this feature
is optional and must be enabled explicitly in your local .vimrc file.

Most importantly, you have to install the fonts on the host that is actually
rendering the Vim screen. Normally, this is the PC where you work on (when
using Vim over SSH, fonts need to be installed on the client side).

To install them in Ubuntu 20.04, type:
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
code-refactoring is now possible in Vim through the Language Server Protocol.
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


### Vimrc revision history

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


### Personal Vim 8 Roadmap

There is still a lot more to explore about Vim. This is a collection of possible
next steps:

  * Collect experience with ALE and LSP and maybe look for better solutions if
    needed, e.g.:
      + find-references does not show code snippets
      + auto-completion is unnatural to use (<C-n> is a hard reach)
  * Code folding (already built-in to vim, see `:h folding`)
  * Explore possibilities of Git integration (vim-fugitive) - see
    <http://vimcasts.org/blog/2011/05/the-fugitive-series/>
  * Explore further text objects (e.g. "inner function") and how to define own
    ones when needed
  * More modern looking color scheme
  * Check out the abbreviation feature (:h abbreviations)

### Other Resources
  * Drew Neil's vimcasts and blog: <https://vimcasts.org>
  * <https://www.vimfromscratch.com>
  * Find free key mappings: <http://vimcasts.org/blog/2014/02/follow-my-leader/>


## Git Config

If you'd like to use my general git settings, then add the following line to
your personal `~/.gitconfig` file:

```
[include]
	path = sysutil/gitconfig
```


## Bash Aliases

If you want to use my Bash aliases, then do:

```
$ cd ~
$ ln -s sysutil/bash\_aliases .bash\_aliases
```
