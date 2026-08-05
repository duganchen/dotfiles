function vlc --wraps='flatpak run org.videolan.VLC' --description 'alias vlc=flatpak run org.videolan.VLC'
    flatpak run org.videolan.VLC $argv
end
