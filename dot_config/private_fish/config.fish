if status is-interactive
    # ~/.config/fish/config.fish

    set -U fish_greeting ""

    set -gx EDITOR nvim
    set -gx VISUAL nvim

    if command -q starship
        starship init fish | source
    end

    if command -q zoxide
        zoxide init --cmd cd fish | source
    end

    # Commands to run in interactive sessions can go here
end
