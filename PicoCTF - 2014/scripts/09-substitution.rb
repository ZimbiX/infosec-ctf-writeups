#!/usr/bin/env ruby

# Unfinished

ciphertext = <<-EOS
ilk pzilguwvpiwgc jghk wn twilpaailkjgagungdilktwch

mgz ilwcf wo pc wycgupci nprpyk
pch mgzrk skkc ng opcm bapjkn
w yzknn wi ozni sk ng
szi niwaa w jpccgi nkk
wd ilk nprpyk gck wn ok
lgt jpc ilkuk sk ng ozjl ilpi mgz hgci fcgt
mgz hgci fcgt

mgz ilwcf mgz gtc tlpikrku apch mgz apch gc
ilk kpuil wn qzni p hkph ilwcy mgz jpc japwo
szi w fcgt krkum ugjf pch iukk pch jukpizuk
lpn p awdk lpn p nbwuwi lpn p cpok

mgz ilwcf ilk gcam bkgbak tlg puk bkgbak
puk ilk bkgbak tlg aggf pch ilwcf awfk mgz
szi wd mgz tpaf ilk dgginikbn gd p niupcyku
mgzaa akpuc ilwcyn mgz ckrku fckt mgz ckrku fckt

lprk mgz krku lkpuh ilk tgad jum ig ilk sazk jguc oggc
gu pnfkh ilk yuwccwcy sgsjpi tlm lk yuwcckh
jpc mgz nwcy twil paa ilk rgwjkn gd ilk ogzcipwcn
jpc mgz bpwci twil paa ilk jgagun gd ilk twch
jpc mgz bpwci twil paa ilk jgagun gd ilk twch

jgok uzc ilk lwhhkc bwck iupwan gd ilk dgukni
jgok ipnik ilk nzcntkki skuuwkn gd ilk kpuil
jgok ugaa wc paa ilk uwjlkn paa pugzch mgz
pch dgu gcjk ckrku tgchku tlpi ilkmuk tguil

ilk upwcniguo pch ilk uwrku puk om sugilkun
ilk lkugc pch ilk giiku puk om duwkchn
pch tk puk paa jgcckjikh ig kpjl gilku
wc p jwujak wc p lggb ilpi ckrku kchn

lgt lwyl twaa ilk nmjpoguk yugt
wd mgz jzi wi hgtc ilkc mgzaa ckrku fcgt
pch mgzaa ckrku lkpu ilk tgad jum ig ilk sazk jguc oggc

dgu tlkilku tk puk tlwik gu jgbbku nfwcckh
tk ckkh ig nwcy twil paa ilk rgwjkn gd ilk ogzcipwcn
tk ckkh ig bpwci twil paa ilk jgagun gd ilk twch

mgz jpc gtc ilk kpuil pch niwaa
paa mgzaa gtc wn kpuil zciwa
mgz jpc bpwci twil paa ilk jgagun gd ilk twch
EOS

num_letters = ciphertext.scan(/[a-z]/).count
freqs_count = {}
freqs_pct = {}
('a'..'z').each do |letter|
  count = ciphertext.count(letter)
  freqs_count[letter] = count
  freqs_pct[letter] = count / num_letters.to_f * 100
end

# freqs_pct.sort_by{|k,v| -v}



require 'pry'; binding.pry
puts 'a'