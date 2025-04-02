xclip -o -selection clipboard | grep -v -E "^[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}|<[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}>|^[[:space:]]*$" | uniq | tee /dev/tty | xclip -selection clipboard
