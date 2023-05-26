set fish_greeting

fish_config theme choose "dracula"

direnv hook fish | source


if status is-interactive
    # Commands to run in interactive sessions can go here
end
