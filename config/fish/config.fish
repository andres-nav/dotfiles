set fish_greeting

fish_config theme choose "dracula"

direnv hook fish | source

fzf_configure_bindings --directory=\cd 

if status is-interactive
    # Commands to run in interactive sessions can go here
end
