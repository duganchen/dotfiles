function lt --wraps='eza --long --group-directories-first --sort size' --description 'alias lt=eza --long --group-directories-first --sort size'
  eza --icons --long --group-directories-first --sort size $argv; 
end
