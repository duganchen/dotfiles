function la --wraps=ls --wraps='exa --icons --all' --description 'alias la=exa --icons --all'
  exa --icons --all $argv; 
end
