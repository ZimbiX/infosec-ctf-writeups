#!/usr/bin/env ruby

ciphertext = 'rfcqcapcrnyqqnfpyqcgqbmuasiugssaxxlextkasoklntcidhm'

(1..25).each do |rot|
  puts ciphertext.chars.map { |char_a|
    alpha_i_a = char_a.upcase.ord - 65
    alpha_i_b = (alpha_i_a + rot) % 26
    char_b = (alpha_i_b + 65).chr.downcase
  }.join
end