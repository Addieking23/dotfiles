# Git
abbr -a g git
abbr -a gs git status
abbr -a ga git add
abbr -a gc git commit
abbr -a gp git push
abbr -a gl git pull
abbr -a gd git diff
abbr -a gco git checkout
abbr -a gb git branch

# Navigation
abbr -a .. cd ..
abbr -a ... cd ../..
abbr -a .... cd ../../..

abbr -a h history

# Modern replacements (if installed)
if command -q eza
    abbr -a ls "eza --oneline --group-directories-first"
    abbr -a la "eza -lbhHigUmuSa"
    abbr -a ll "eza -lah"
    abbr -a tree "eza --tree"
end

if command -q bat
    abbr -a cat bat
end

abbr -a nv nvim
abbr -a vi vim
abbr -a rename wezterm cli set-tab-title
abbr -a cl clear
abbr -a nk NVIM_APPNAME="kickstart_nvim" nvim
abbr -a vv NVIM_APPNAME="vanilla_vim" nvim
abbr -a cc "claude --dangerously-skip-permissions"
abbr -a gl "glow -p"
