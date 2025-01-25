#!/usr/bin/env bash

STARSHIP_CONFIG="$HOME/.config/starship.toml"
FISH_CONFIG="$HOME/.config/fish/config.fish"

sudo apt-add-repository ppa:fish-shell/release-3

apt update && apt upgrade

apt install fish -y

chsh -s /usr/bin/fish

curl -sS https://starship.rs/install.sh | sh

bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)

mkdir -p "$HOME/.config/fish"

touch "$HOME/.config/fish/config.fish"

/bin/cat <<EOF >>"$FISH_CONFIG"
## Path
fish_add_path "" "/bin" "/bin" "/root/.scripts" "/usr/local/bin" "$HOME/.atuin/bin"

status is-login; and begin

  # Login shell initialisation


end

status is-interactive; and begin

  set fish_greeting

  ## Abbreviations
  # Aliases
  # alias eza 'eza '
  # alias la 'eza -a'
  # alias ll 'eza -l'
  # alias lla 'eza -la'
  # alias ls eza
  # alias lt 'eza --tree'


  ## Source
  # fzf --fish | source
  atuin init fish | source
  # zoxide init fish | source
  starship init fish | source
end
EOF

/bin/cat <<EOF >"$STARSHIP_CONFIG"
# Get editor completions based on the config schema
"\$schema" = 'https://starship.rs/config-schema.json'

# Fix bug on LXC
[container]
disabled = true
EOF

exec fish
