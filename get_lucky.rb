begin
  require 'petname'
  petname = PetName::Generator.new
  File.readlines('/crackshmackin/data/f.addresses').each do |line|
    addr = line.split(" ").last
    puts "#{addr} Balance is:"
    balance = `curl -sS https://blockchain.info/q/addressbalance/#{addr}`
    puts balance
    if balance == "0"
      File.open('/crackshmackin/data/shucks.sux', 'a') do |f|
        f.puts("drat, address #{addr} has a balance of #{balance}")
        if File.size('/crackshmackin/data/shucks.sux') > ENV["MAX_BYTES_SHUCKS_FILE"].to_i
          max_size_message = "Enough Already. shucks.sux file has hit its size limit of #{(ENV["MAX_BYTES_SHUCKS_FILE"].to_f / 1000000).to_i}MB."
          `curl -H "Content-Type: application/json" -d '{"username": "crackshmackin", "content": "#{petname}: #{max_size_message}"}' #{ENV["CRACKSHMACKIN_DISCORD_HOOK"]}` unless (ENV["CRACKSHMACKIN_DISCORD_HOOK"].empty?)
          puts(max_size_message)
          sign_off_message = "#{File.basename(__FILE__)} signing off"
          `curl -H "Content-Type: application/json" -d '{"username": "crackshmackin", "content": "#{petname}: #{sign_off_message}"}' #{ENV["CRACKSHMACKIN_DISCORD_HOOK"]}` unless (ENV["CRACKSHMACKIN_DISCORD_HOOK"].empty?)
          puts(sign_off_message)
          exit 0
        end
      end
    else
      File.open('/crackshmackin/data/fyeah.bux', 'a') do |f|
        `curl -H "Content-Type: application/json" -d '{"username": "crackshmackin", "content": "#{petname}: You found a private key (WIF) #{line.split(' ')[1]} for the address #{addr} with #{balance} satoshis in it."}' #{ENV["CRACKSHMACKIN_DISCORD_HOOK"]}` unless (ENV["CRACKSHMACKIN_DISCORD_HOOK"].empty?)
        f.puts("address #{addr} has #{balance} satoshis in it. and the private key WIF for the Bitcoin Wallet is #{line.split(' ')[1]}")
      end
    end
    # The blockchain.info API does not want you to do more than 1 request per 10s. don't be "that guy"
    sleep 10
  end
ensure
  `curl -H "Content-Type: application/json" -d '{"username": "crackshmackin", "content": "#{petname}: #{File.basename(__FILE__)}: crackshmackin shutting down"}' #{ENV["CRACKSHMACKIN_DISCORD_HOOK"]}` unless (ENV["CRACKSHMACKIN_DISCORD_HOOK"].empty?)
end
