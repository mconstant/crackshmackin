FROM ruby:slim

RUN apt-get update && apt-get install build-essential curl tmux -y

# max size of f.addresses file in bytes, e.g. 20000000 would make it max out at ~20Mb
ENV MAX_BYTES_F_ADDRESSES=20000000
# max size of shucks.sux file in bytes, e.g. 10000000 would make it max out at ~10Mb
ENV MAX_BYTES_SHUCKS_FILE=10000000
# discord hook
ENV CRACKSHMACKIN_DISCORD_HOOK=""

RUN gem install bundler

WORKDIR /crackshmackin
COPY Gemfile .
RUN bundle install
COPY find_satoshi.rb .
COPY get_lucky.rb .
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

RUN mkdir -p /crackshmackin/data
RUN touch /crackshmackin/data/f.addresses
RUN touch /crackshmackin/data/final.destination
RUN touch /crackshmackin/data/fyeah.bux
RUN touch /crackshmackin/data/shucks.sux

ENTRYPOINT "./entrypoint.sh"
