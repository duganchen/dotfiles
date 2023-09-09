function ll --wraps='eza -l --icons' --wraps='eza -la --icons' --wraps='eza --icons --all --long' --description 'alias ll=eza --icons --all --long'
  eza --icons --all --long $argv; 
end
