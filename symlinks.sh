#!/usr/bin/zsh

# Check/fix symlinks from $HOME to dotfiles repository (i.e. current directory)

local -A links

# corresponding shell aliases and Vim commands
# are in zshenv and vimrc respectively.
links+=(.config/alacritty/alacritty.yml alacritty.yml)
links+=(.config/bspwm/bspwmrc bspwmrc)
links+=(.config/polybar/config polybar)
links+=(.screenrc screenrc)
links+=(.config/sxhkd/sxhkdrc sxhkdrc)
links+=(.tmux.conf tmux.conf)
links+=(.vim/vimrc vimrc)
links+=(.xinitrc xinitrc)
links+=(.Xmodmap Xmodmap)
links+=(.zshrc zshrc)
links+=(.zshenv zshenv)
links+=(.dircolors dircolors)
links+=(bin/emoji_menu.sh emoji/emoji_menu.sh)
links+=(.config/emoji/emoji.txt emoji/emoji.txt)
links+=(bin/run_alternatives.sh run_alternatives.sh)
links+=(bin/screenshot.sh screenshot.sh)
links+=(bin/dwmbar.sh dwmbar/dwmbar.sh)
links+=(bin/dwmbar_loop.sh dwmbar/dwmbar_loop.sh)

for link in ${(@k)links}; do
	real_src="$HOME/$link"
	target=$links[$link]
	desired_target="$PWD/$target"

	if [[ ! -e "$desired_target" ]]; then
		echo $'\u2753'" target does not exist: $desired_target"
		file "$desired_target"
		echo
		continue
	fi

	if [[ ! -e ${real_src:h} ]]; then
		if mkdir -p ${real_src:h}; then
			echo $'\u2705 \u2699'" FIXED DIR $real_src -> $desired_target"
		else
			echo $'\u274c'" FAILED TO FIX DIR $real_src -> $real_target"
			continue
		fi
	fi

	if [[ -e "$real_src" && ! -L "$real_src" ]]; then
		echo $'\u2753'" not a symlink: $real_src"
		file "$real_src"
		echo
		continue
	fi

	if ! real_target=$(readlink -f "$real_src"); then
		echo $'\u26a0'" failed to check: $real_src"
		file "$real_src"
		echo
		continue
	fi

	if [[ "$real_target" == "$desired_target" ]]; then
		echo $'\u2705'" OK $real_src -> $real_target"
	else
		if [[ -e "$real_src" ]]; then
			echo $'\u274c'" WON'T FIX SYMLINK $real_src -> $real_target"
		else
			if ln -s "$desired_target" "$real_src"; then
				echo $'\u2705 \u2699'" FIXED SYMLINK $real_src -> $desired_target"
			else
				echo $'\u274c'" FAILED TO FIX SYMLINK $real_src -> $real_target"
			fi
		fi
	fi 
done

