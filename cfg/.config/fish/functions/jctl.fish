function jctl --wraps='journalctl -p 3 -xb' --description 'alias jctl journalctl -p 3 -xb'
    journalctl -p 3 -xb $argv
end
