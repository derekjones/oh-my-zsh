alias l="ls -fla"

# Customize to your needs...
export PATH=/Users/derek/bin:/usr/local/bin:/usr/local/git/bin:Users/derek/pear/bin:/Users/derek/Library/Haskell/bin:$PATH


WEB_DIR_HOME="${HOME}/Sites"

ht()
{
	cd ${WEB_DIR_HOME}

	# These two options do not natural sort - so capital letter directories
	# end up appearing above lowercase, regardless of first letter
	# `tree -di -L 1 --noreport`
	# `ls -d */`
	PS3="Where to, cap'n?: "
	select dir in `find . -maxdepth 1 -type d | sed 's/\.\///' | sed 's/^\.//'`
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


function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}



# Phing
#export PHP_COMMAND=/usr/bin/php
export PHP_COMMAND=/usr/local/php5/bin/php
export PHING_HOME=/usr/local/phing
export PHP_CLASSPATH=${PHING_HOME}/classes
export PATH=${PATH}:${PHING_HOME}/bin

# Python
export PATH=PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PYTHONPATH='/Users/derek/Library/Python/2.7/site-packages'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
