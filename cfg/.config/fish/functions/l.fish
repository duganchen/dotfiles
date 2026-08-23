function l --wraps=eza --wraps='eza --color=always --group-directories-first --icons' --description 'alias l eza --color=always --group-directories-first --icons'
    eza --color=auto --group-directories-first --icons=auto $argv
end
