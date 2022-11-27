function ll --wraps='exa -l --icons' --wraps='exa -la --icons' --wraps='exa --icons --all --long' --description 'alias ll=exa --icons --all --long'
  exa --icons --all --long $argv; 
end
