# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/danielreed/.zsh/completions:"* ]]; then export FPATH="/Users/danielreed/.zsh/completions:$FPATH"; fi
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export VOLTA_FEATURE_PNPM=0
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export GOOGLE_CLOUD_PROJECT="mindler-data-science"

ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  jump
  aws
)

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias config="code ~/.zshrc"
alias claudeconfig="code ~/.claude"
alias top='cd "$(git rev-parse --show-toplevel)"'

# creates a new branch with the end of a JIRA url
# gtk https://test.atlassian.net/browse/TREAT-481 -> gcb feat/TREAT-481
gtk() {
  local ticket_id=${1##*/}  # Extract the last part after the last '/'
  git checkout -b "feat/$ticket_id"
}

# inits the aws-cli with an mfa token from 1password
# aws-init "my.1password.com" "My AWS" "my-profile"
aws-init() {
  # Ensure we are logged in
  op signin --account ${1}

  # Get TOTP from 1Password
  # Replace "AWS MFA" with your 1Password item name
  MFA_CODE=$(op item get "${2}" --otp)

  # Check if we got the code
  if [ -z "$MFA_CODE" ]; then
    echo "Failed to get MFA code from 1Password"
    exit 1
  fi

  # Run acp with the MFA code
  acp ${3} "$MFA_CODE" 3600
}

alias gitinit='f() { git init && git add . && git commit -m "init" && git branch -M main && 
  git remote add origin $1 && git push -u origin main; }; f'

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# bun completions
[ -s "/Users/danielreed/.bun/_bun" ] && source "/Users/danielreed/.bun/_bun"
. "/Users/danielreed/.deno/env"
# Initialize zsh completions (added by deno install script)
autoload -Uz compinit
compinit
# pnpm
export PNPM_HOME="/Users/danielreed/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm endexport PATH="$HOME/bin:$PATH"
