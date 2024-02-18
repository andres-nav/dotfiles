set fish_greeting

fish_config theme choose "gruvbox"

if type -q direnv
  direnv hook fish | source
end

fzf_configure_bindings --directory=\cd 

alias lf "lfcd"

if status is-interactive
    # Commands to run in interactive sessions can go here
end
