export LANG=en_US.UTF-8
ruby find_satoshi.rb &
sleep 1
ruby get_lucky.rb &
sleep 1
tmux new-session -d 'tail -f /crackshmackin/data/shucks.sux'
tmux split-window -v 'tail -f /crackshmackin/data/f.addresses'
tmux attach
