#alias l="ls -fla"
alias l="exa -ghlba --git"
alias rspec='nocorrect rspec'
alias bundle='nocorrect bundle'
alias brewupdate="brew update; brew outdated; brew upgrade --all; brew cleanup"
alias eetools='nocorrect ./eetools'

# Customize to your needs...
export PATH=/usr/local/php5/bin:/Users/derek/bin:/usr/local/bin:/usr/local/sbin:/usr/local/git/bin:$PATH


WEB_DIR_HOME="${HOME}/Sites"

search-changelog()
{
	log=$(git log --reverse -S "$1" -- changelogs)

	if [[ ${log} =~ ^commit[[:space:]]([a-z0-9]{40}) ]]
	then
		hash=${match}
		repo=$(git config --get remote.origin.url)

		if [[ ${repo} =~ git@github\.com:(.*)\.git ]]
		then
			open "https://github.com/${match}/commit/${hash}"
		else
			echo ${hash}
		fi
	else
		echo "Could not find '$1'"
	fi
}

ht()
{
	cd ${WEB_DIR_HOME}

	# These two options do not natural sort - so capital letter directories
	# end up appearing above lowercase, regardless of first letter
	# `tree -di -L 1 --noreport`
	# `ls -d */`
	PS3="Where to, cap'n?: "
	select dir in `find . -maxdepth 1 -type d | sed 's/\.\///' | sed 's/^\.//' | sort -n`
	do
		if [[ "$dir" == '' ]]; then
			echo "Exiting."
			return
		fi
		break
	done

	cd $dir

	if [[ -d .git ]]; then
		git status
	fi
}

alias restart-fpm="nocorrect restart-fpm"

restart-fpm()
{
	if [ $# -ne 2 ]; then
		echo "usage: restart-fpm verstop verstart";echo;
		echo "    verstop    one of: 53 54 55 56 70";
		echo "    verstart   one of: 53 54 55 56 70"; echo;
		return
	fi

	echo "Stopping php-fpm $1..."
	launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php$1.plist
	echo "Starting php-fpm $2..."
	launchctl load -w   ~/Library/LaunchAgents/homebrew.mxcl.php$2.plist
	echo "php-fpm restarted"
}

alias sphp="nocorrect sphp"
sphp()
{
	if [ $# -ne 2 ]; then
		echo "usage: sphp from to";echo;
		echo "    from    one of: 53 54 55 56 70";
		echo "    to      one of: 53 54 55 56 70"; echo;
		return
	fi

	brew unlink php$1
	brew link php$2
	restart-fpm $1 $2
}

chrome-ellislab()
{
	/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --proxy-server=localhost:3128 2>&1 &
}

function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Some Phing stuff
PHP_COMMAND=/usr/local/Cellar/php56/5.6.9/bin
PHING_HOME=/usr/local/Cellar/php56/5.6.9/bin
PHP_CLASSPATH=${PHING_HOME}/classes
PATH=${PATH}:${PHING_HOME}

