# Credit where credit is due / Preamble
#
# This borrows (steals?) heavily from https://bhelx.simst.im/articles/generating-bitcoin-keys-from-scratch-with-ruby/
#
# The bits and bobs that make this work come from that wonderful post, and from the bitcoin-ruby library by lian
# That library is located here https://github.com/lian/bitcoin-ruby
#
# If you find satoshi's treasure, or anyone else's with these scripts (and good luck, if I were to estimate the chances of that being 1 in 
#   10 zillion, the true chance would be super-much-more miniscule by many orders of magnitude than that. So your chances are ... smoll,)
# then be responsible/kind/just/based.
#
# These scripts are not-any-at-all-optimised, not guaranteed, and are here for fun. They were inspired by https://keys.lol and other things like that.
#
# Don't be lazy, don't be crazy, vote Kenny Powers.

require 'bitcoin'
require 'securerandom'
require 'digest'

def generate_key
  SecureRandom.hex(32)
end

# SHA-256 hash
def sha256(hex)
  Digest::SHA256.hexdigest([hex].pack("H*"))
end

# checksum is first 4 bytes of sha256-sha256 hexdigest.
def checksum(hex)
  sha256(sha256(hex))[0...8]
end

def int_to_base58(int_val, leading_zero_bytes=0)
  alpha = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
  base58_val, base = '', alpha.size
  while int_val > 0
    int_val, remainder = int_val.divmod(base)
    base58_val = alpha[remainder] + base58_val
  end
  base58_val
end

def encode_base58(hex)
  leading_zero_bytes = (hex.match(/^([0]+)/) ? $1 : '').size / 2
  ("1"*leading_zero_bytes) + int_to_base58( hex.to_i(16) )
end

PRIV_KEY_VERSION = '80'
def wif(hex)
  data = PRIV_KEY_VERSION + hex
  encode_base58(data + checksum(data))
end

current_wif = '5HpHagT65TZzG1PH3CSu63k8DbpvD8s5ip4nEB3kEsreAnchuDf'
current_address = Bitcoin::Key.from_base58(current_wif).addr
# satoshi address with ~64BTC '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa'
until (current_address == '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa') do
  File.open('/crackshmackin/data/f.addresses', 'a') do |f|
    f.puts("WIF: #{current_wif} | Address: #{current_address}")
  end
  abort("She cannot take any more of this, Captain!") if (File.size('/crackshmackin/data/f.addresses') > ENV["MAX_BYTES_F_ADDRESSES"].to_i)
  current_wif = wif(generate_key)
  current_address = Bitcoin::Key.from_base58(current_wif).addr
end
File.open('/crackshmackin/data/final.destination', 'a') do |f|
  f.puts("WIF: #{current_wif} | Address: #{current_address}")
end
