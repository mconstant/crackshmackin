God.watch do |w|
  w.name = "find_satoshi"
  w.start = "ruby /crackshmackin/find_satoshi.rb"
  w.keepalive
end

God.watch do |w|
  w.name = "get_lucky"
  w.start = "ruby /crackshmackin/get_lucky.rb"
  w.keepalive
end
