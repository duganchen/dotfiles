function lt --wraps='exa --long --group-directories-first --sort size' --description 'alias lt=exa --long --group-directories-first --sort size'
  exa --icons --long --group-directories-first --sort size $argv; 
end
