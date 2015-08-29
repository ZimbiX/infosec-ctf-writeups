#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'base64'
require 'uri'

class String
  def convert_cookie_to_hex spaces = true
    uri = self
    base64 = URI.unescape uri
    un_base64 = Base64.decode64 base64
    hex = un_base64.to_hex_string spaces
  end

  def hex_xor b_hex
    a = self.to_byte_string
    b = b_hex.to_byte_string
    a.xor! b
  end
end

binding.pry
puts "Finished!"