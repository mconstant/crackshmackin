# crackshmackin 

So you want to bruteforce a Bitcoin Private Key.... mmmmmkay....

## Quickstart
```sh
docker run -v crackshmackin:/crackshmackin/data -it --rm xmconstantx/crackshmackin
```

alternately
```sh
git clone https://github.com/mconstant/crackshmackin.git && make out_like_a_bandit
```

## What Th'? 
![WTF](./816523389795434517.gif) 

`crackshmackin` is a naive, brute-force/dumb-luck/heart-o-gold/hail-mary attempt to help anyone discover that they are Satoshi.

Find one of Satoshi's treasures by attempting to stumble upon the private key of this known address of the Satoshin -- [1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa](https://www.blockchain.com/btc/address/1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa).

Once you have the WIF you can import into your wallet, Satoshi, and then maybe try to remember your password. 

The address at this moment in time holds 68.44938308 BTC, which is a sum that can buy at this time almost 11 lambo or an unspecified amount of "Bitcoin Pizza."

This repo was not written by Satoshi. But we were inspired by his ability to stay anonymous so we used his email address for the "Anon" commits.

## Demo

[![asciicast](https://asciinema.org/a/SQzhtgbPwIeJ4CZhFwbLRPURh.png)](https://asciinema.org/a/SQzhtgbPwIeJ4CZhFwbLRPURh)

## Prior Work / Inspiration

- https://keys.lol - Yo Dawg... I heard you like needles in haystacks, so I put your needles in haystacks in haystacks...
- https://bhelx.simst.im/articles/generating-bitcoin-keys-from-scratch-with-ruby/ - This code bit off this guys work a bit. So credit _him_... ok?

## What are my chances of scoring Satoshi's treasure (or anything at all)?

You really don't have any. This is just for fun.

Watch this: 

[![YouStandNoChance](https://img.youtube.com/vi/S9JGmA5_unY/0.jpg)](https://www.youtube.com/watch?v=S9JGmA5_unY)

And this:

[![NoReally](https://img.youtube.com/vi/lPqFTbGyq8I/0.jpg)](https://www.youtube.com/watch?v=lPqFTbGyq8I&t=1s)


## Appendix

### Using more disk

This brute loves to hog your disk! The default max size for `f.addresses`, the fun file where the script saves all the incorrect guess addresses and their corresponding private keys to, defaults to a max size of 20mb. But, if you are a [frustrated chia miner](https://www.reddit.com/r/chia/comments/n3948d/i_have_made_a_decision_to_stop_mining/) with extra 12TB harddrives, or something, you can set that file to be as big as you please. There is an environment variable 

`MAX_BYTES_F_ADDRESSES` 

for that.

e.g.:

```sh
docker run -v crackshmackin:/crackshmackin/data -e MAX_BYTES_F_ADDRESSES=200000000000 -it --rm xmconstantx/crackshmackin
```

would set this to ~200GB

There is another environment variable to set the default max size for the file `shucks.sux`, a file which stores all the addresses you have private keys for that turn out to have a zero balance (and what's that worth?). Use

`MAX_BYTES_SHUCKS_FILE`

for that.

e.g.:

```sh
docker run -v crackshmackin:/crackshmackin/data -e MAX_BYTES_SHUCKS_FILE=100000000 -it --rm xmconstantx/crackshmackin
```

would set this to ~100MB. This file grows much more slowly than the `f.addresses` file since it makes one line every 10 seconds or so due to API limitations when checking wallet balances.

### Discord hooks

Don't you want to know when you have hit paydirt?

![wen](./Capture.PNG)

Use a Discord hook!

e.g.:

```sh
docker run -v crackshmackin:/crackshmackin/data \
  -e MAX_BYTES_SHUCKS_FILE=100000000 \
  -e MAX_BYTES_F_ADDRESSES=200000000000 \
  -e CRACKSHMACKIN_DISCORD_HOOK=https://discord.com/api/webhooks/999999999999999999/oxdeadbeefoxdeadbeefoxdeadbeefoxdeadbeef \
  -it --rm xmconstantx/crackshmackin
```

Configure:

![ConfigureDiscordWebhook](https://user-images.githubusercontent.com/85532172/125997350-b2b39f38-0839-451d-80f4-53ff4ba71ac0.png)

Nerd out:

![DiscordWebhookInUse](https://user-images.githubusercontent.com/85532172/125997206-6316654f-6872-4819-81bd-1b5ec3df2425.png)

Example (simulated) of what a hit might look like:

![image](https://user-images.githubusercontent.com/85532172/126021240-d27692b9-39b7-4625-8100-6847257380fb.png)


## Donate

![Donate](https://banano.id/pay/signature.php?wallet=ban_3nmstjw9uzngtg56awhxrn1cy4qtiqpbjenxhszh3ntq5tpowpk1mfc6ynyj)
![image](https://user-images.githubusercontent.com/85532172/126001892-54d6ce1e-e708-4ef4-a979-31c2129032ea.png)
![image](https://user-images.githubusercontent.com/85532172/126003588-127795fb-66ef-4d61-8566-37ebc6625282.png)

## So you actually want to find a needle in a haystack

Provided you, I dunno, want a chance at actually finding something in this vast keyspace of mostly false turns and empty handedness, you might actually consider a strategy that reduces the keyspace to a manageable level.

If you want to actually find something, consider using a *real tool* to crack something *less secure*

I'm talking about the process of hack/cracking brainwallets, for great good.

Hack someone and then send them a friendly reminder to move their funds like this amazing and groovy guy here. He's used an actually efficient method to approach quickly searching the keyspace including fast-hashed (SHA256) 'brain-wallet' private key generation phrases. His smort usage of bloom filters and a reduced space differentiates his project and points towards something that differs from this repo, which is a *fun joke* for *fun people* and *clowns with redonkulous luck*.

Seriously don't ever use song lyrics and a SHA256 hashing algorithm to cook up your private key, or the Nazgul will find you:

[![RyanGotchu](https://www.youtube.com/watch?v=foil0hzl4Pg)](https://www.youtube.com/watch?v=foil0hzl4Pg)

[![Brainflayer](https://github.com/ryancdotorg/brainflayer)](https://github.com/ryancdotorg/brainflayer)



