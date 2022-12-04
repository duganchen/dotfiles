function tree --wraps='exa -tree' --wraps='exa -T' --description 'alias tree=exa -T'
  exa --icons -T $argv; 
end
