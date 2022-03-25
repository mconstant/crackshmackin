export LANG=en_US.UTF-8
ruby find_satoshi.rb &
sleep 1
ruby get_lucky.rb &
sleep 1
tail -f /crackshmackin/data/shucks.sux &
tail -f /crackshmackin/data/f.addresses &
