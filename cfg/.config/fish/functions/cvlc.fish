function cvlc --wraps='flatpak run --command=cvlc org.videolan.VLC' --description 'alias cvlc=flatpak run --command=cvlc org.videolan.VLC'
    flatpak run --command=cvlc org.videolan.VLC $argv
end
