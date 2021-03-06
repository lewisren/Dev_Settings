#--------------------------------------------------------------------------------------------------------
# CUSTOM
#--------------------------------------------------------------------------------------------------------
export PATH="$PATH:$HOME/bin";

# User base's binary directory for Python 2.7
export PATH="$PATH:$HOME/Library/Python/2.7/bin";
# User base's binary directory for Python 3.6
export PATH="$PATH:$HOME/Library/Python/3.6/bin";
# VirtualEnv
export WORKON_HOME=~/Workspace/Envs
export VIRTUAL_ENV_DISABLE_PROMPT=1
source /usr/local/bin/virtualenvwrapper.sh
source /usr/local/opt/autoenv/activate.sh

export MAVEN_OPTS="-Xmx1024M"

j8 () {
	export JAVA_HOME=`/usr/libexec/java_home -v '1.8*'`;
  export CURRENT_JAVA_VERSION=8;
}
#Default to java 8
j8

# Import any ssh keys I might have.
ssh-add -D 2> /dev/null
ssh-add ~/.ssh/*.pem 2> /dev/null
ssh-add ~/.ssh/id_rsa


#--------------------------------------------------------------------------------------------------------
# PATH
#--------------------------------------------------------------------------------------------------------
# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
