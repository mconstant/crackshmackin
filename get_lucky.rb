File.readlines('/crackshmackin/data/f.addresses').each do |line|
  addr = line.split(" ").last
  puts "#{addr} Balance is:"
  balance = `curl -sS https://blockchain.info/q/addressbalance/#{addr}`
  puts balance
  if (balance == "0")
    File.open('/crackshmackin/data/shucks.sux','a') do |f|
      f.puts("drat, address #{addr} has a balance of #{balance}")
      abort("Enough Already.") if (File.size('/crackshmackin/data/shucks.sux') > ENV["MAX_BYTES_SHUCKS_FILE"].to_i)
    end
  else
    File.open('/crackshmackin/data/fyeah.bux','a') do |f|
      f.puts("address #{addr} has #{balance} satoshis in it. and the private key WIF for the Bitcoin Wallet is #{line.split(' ')[1]}")
    end
  end
  # The blockchain.info API does not want you to do more than 1 request per 10s. don't be "that guy" 
  sleep 10
end
