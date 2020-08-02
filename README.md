# dotfiles

Some personalized dotfiles.

## Motivation

> A woodsman was once asked, “What would you do if you had
> just five minutes to chop down a tree?” He answered, “I
> would spend the first two and a half minutes sharpening my
> axe.”

## Setup

```bash
git clone https://github.com/thomasheller/dotfiles
cd dotfiles
./symlinks.sh
```

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

