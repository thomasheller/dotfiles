# dotfiles

Some personalized dotfiles.

I attempt to restore my setup from ~10 years ago and add some
improvements. While your mileage may vary, these files could inspire
you how [zsh](http://zsh.sourceforge.net/),
[vim](http://www.vim.org/), [tmux](https://tmux.github.io/) and
various other tools can be adjusted to suit your needs.

Note that using these dotfiles will install various other software on
your machine and change several settings. Please read and understand
the entire code before trying them.

## Notes

### In which order are Zsh config files loaded?

| No. | File          | Condition         |
| --- | ------------- | ----------------- |
| 1   | `~/.zshenv`   | always            |
| 2   | `~/.zprofile` | login shell       |
| 3   | `~/.zshrc`    | interactive shell |
| 4   | `~/.zlogin`   | login shell       |
|     | ...           | ...               |
|     | `~/.zlogout`  | login shell       |

