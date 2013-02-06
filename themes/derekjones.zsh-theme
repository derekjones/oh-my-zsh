function cue {
	if [[ `vcprompt -f "%m"` != "" ]]; then #modified
		echo "%{$fg[red]%}↑%{$reset_color%}" && return	
	fi
 	echo "→" && return
}

function git_prompt {
	git branch >/dev/null 2>/dev/null && echo "`vcprompt -f "[%b]"` " && return
}

PROMPT='%F{87}%n %{$reset_color%}at %F{87}%m%f:%F{63}%~%f$(git_prompt_info) $(cue) %{$reset_color%}'
#PROMPT='%F{87}%n %{$reset_color%}at %F{87}%m%f:%F{63}%~%f %{$reset_color%}'

REPORTTIME=10 # Show elapsed time if command took more than X seconds

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}↑%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""