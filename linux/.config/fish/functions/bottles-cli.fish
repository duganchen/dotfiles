function bottles-cli --wraps='flatpak run --command=bottles-cli com.usebottles.bottles' --description 'alias bottles-cli=flatpak run --command=bottles-cli com.usebottles.bottles'
  flatpak run --command=bottles-cli com.usebottles.bottles $argv
        
end
