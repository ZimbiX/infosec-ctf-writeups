## 1

We just need to convert hex to decimal

Google: the_number in decimal

## 2 - Caesar

Given the challenge name, it's a caesar cipher. The rotation is unknown, so I wrote a script to output the result of each possible rotation.

Results:

	sgdrdbqdsozrrogqzrdhrcnvbtjvhttbyymfyulbtplmoudjein
	thesecretpassphraseisdowcukwiuuczzngzvmcuqmnpvekfjo
	uiftfdsfuqbttqisbtfjtepxdvlxjvvdaaohawndvrnoqwflgkp
	vjgugetgvrcuurjtcugkufqyewmykwwebbpibxoewsoprxgmhlq
	wkhvhfuhwsdvvskudvhlvgrzfxnzlxxfccqjcypfxtpqsyhnimr
	xliwigvixtewwtlvewimwhsagyoamyygddrkdzqgyuqrtziojns
	ymjxjhwjyufxxumwfxjnxitbhzpbnzzheeslearhzvrsuajpkot
	znkykixkzvgyyvnxgykoyjuciaqcoaaifftmfbsiawstvbkqlpu
	aolzljylawhzzwoyhzlpzkvdjbrdpbbjggungctjbxtuwclrmqv
	bpmamkzmbxiaaxpziamqalwekcseqcckhhvohdukcyuvxdmsnrw
	cqnbnlancyjbbyqajbnrbmxfldtfrddliiwpievldzvwyentosx
	drocombodzkcczrbkcoscnygmeugseemjjxqjfwmeawxzfoupty
	espdpncpealddascldptdozhnfvhtffnkkyrkgxnfbxyagpvquz
	ftqeqodqfbmeebtdmequepaiogwiuggollzslhyogcyzbhqwrva
	gurfrpergcnffcuenfrvfqbjphxjvhhpmmatmizphdzacirxswb
	hvsgsqfshdoggdvfogswgrckqiykwiiqnnbunjaqieabdjsytxc
	iwthtrgtiephhewgphtxhsdlrjzlxjjroocvokbrjfbcektzuyd
	jxuiushujfqiifxhqiuyitemskamykksppdwplcskgcdfluavze
	kyvjvtivkgrjjgyirjvzjufntlbnzlltqqexqmdtlhdegmvbwaf
	lzwkwujwlhskkhzjskwakvgoumcoammurrfyrneumiefhnwcxbg
	maxlxvkxmitlliaktlxblwhpvndpbnnvssgzsofvnjfgioxdych
	nbymywlynjummjblumycmxiqwoeqcoowtthatpgwokghjpyezdi
	ocznzxmzokvnnkcmvnzdnyjrxpfrdppxuuibuqhxplhikqzfaej
	pdaoaynaplwooldnwoaeozksyqgseqqyvvjcvriyqmijlragbfk
	qebpbzobqmxppmeoxpbfpaltzrhtfrrzwwkdwsjzrnjkmsbhcgl

Line 2 is:

	thesecretpassphraseisdowcukwiuuczzngzvmcuqmnpvekfjo

So the flag is:

	dowcukwiuuczzngzvmcuqmnpvekfjo

## 03 - web explotation - no comment

The page source reveals:

	<!-- In case you forget, the password for this site is: flag_64e04604c2125342bb50cd0fa704af7b9220eaf7 -->

So the flag is:

	flag_64e04604c2125342bb50cd0fa704af7b9220eaf7

## 04 - miscellaneous - common vulnerability exercise

Browsing 2014 CVE Details for Firefox:

http://www.cvedetails.com/vulnerability-list/vendor_id-452/product_id-3264/year-2014/opov-1/Mozilla-Firefox.html

Searching the page for 'audio' highlights several of the vulnerabilities. CVE-2014-1542 mentions the Speex resampler, which sounds like a speech system.

So the flag is:

	CVE-2014-1542

## 05 - cryptography 20 - the valley of fear

Given we are provided a section of a book, and that the format of the numbers provided looks familiar, I'm guessing that it's a book cipher - the three numbers direct you a word by indicating the number of the paragraph, line, and word.

Itching to code, I wrote a script to decode it for me.

The plaintext is:

	the flag is Ceremonial plates

So the flag is:

	Ceremonial plates

## 06 - web explotation 30 - internet inspection

Inspecting the DOM shows a table with the flag:

	flag_8f08c799f425583c063c8c4c9704b3d6a95240c2

## 07 - miscellaneous 30 - RoboPhoto

Search with the image on Google Images to find the book name.

So the flag is:

	The Positronic Man

## 08 - forensics 40 - grep is still your friend

	$ cat /problems/grepfriend/keys | grep daedaluscorp.txt.enc                  
	daedaluscorp.txt.enc       b2bee8664b754d0c85c4c0303134bca6

So the flag is:

	b2bee8664b754d0c85c4c0303134bca6

## 09 - cryptology 50 - substitution

Capitals for ciphertext, lowercase for plaintext.

Ciphertext:

	ILK PZILGUWVPIWGC JGHK WN TWILPAAILKJGAGUNGDILKTWCH

	MGZ ILWCF WO PC WYCGUPCI NPRPYK
	PCH MGZRK SKKC NG OPCM BAPJKN
	W YZKNN WI OZNI SK NG
	SZI NIWAA W JPCCGI NKK
	WD ILK NPRPYK GCK WN OK
	LGT JPC ILKUK SK NG OZJL ILPI MGZ HGCI FCGT
	MGZ HGCI FCGT

	MGZ ILWCF MGZ GTC TLPIKRKU APCH MGZ APCH GC
	ILK KPUIL WN QZNI P HKPH ILWCY MGZ JPC JAPWO
	SZI W FCGT KRKUM UGJF PCH IUKK PCH JUKPIZUK
	LPN P AWDK LPN P NBWUWI LPN P CPOK

	MGZ ILWCF ILK GCAM BKGBAK TLG PUK BKGBAK
	PUK ILK BKGBAK TLG AGGF PCH ILWCF AWFK MGZ
	SZI WD MGZ TPAF ILK DGGINIKBN GD P NIUPCYKU
	MGZAA AKPUC ILWCYN MGZ CKRKU FCKT MGZ CKRKU FCKT

	LPRK MGZ KRKU LKPUH ILK TGAD JUM IG ILK SAZK JGUC OGGC
	GU PNFKH ILK YUWCCWCY SGSJPI TLM LK YUWCCKH
	JPC MGZ NWCY TWIL PAA ILK RGWJKN GD ILK OGZCIPWCN
	JPC MGZ BPWCI TWIL PAA ILK JGAGUN GD ILK TWCH
	JPC MGZ BPWCI TWIL PAA ILK JGAGUN GD ILK TWCH

	JGOK UZC ILK LWHHKC BWCK IUPWAN GD ILK DGUKNI
	JGOK IPNIK ILK NZCNTKKI SKUUWKN GD ILK KPUIL
	JGOK UGAA WC PAA ILK UWJLKN PAA PUGZCH MGZ
	PCH DGU GCJK CKRKU TGCHKU TLPI ILKMUK TGUIL

	ILK UPWCNIGUO PCH ILK UWRKU PUK OM SUGILKUN
	ILK LKUGC PCH ILK GIIKU PUK OM DUWKCHN
	PCH TK PUK PAA JGCCKJIKH IG KPJL GILKU
	WC P JWUJAK WC P LGGB ILPI CKRKU KCHN

	LGT LWYL TWAA ILK NMJPOGUK YUGT
	WD MGZ JZI WI HGTC ILKC MGZAA CKRKU FCGT
	PCH MGZAA CKRKU LKPU ILK TGAD JUM IG ILK SAZK JGUC OGGC

	DGU TLKILKU TK PUK TLWIK GU JGBBKU NFWCCKH
	TK CKKH IG NWCY TWIL PAA ILK RGWJKN GD ILK OGZCIPWCN
	TK CKKH IG BPWCI TWIL PAA ILK JGAGUN GD ILK TWCH

	MGZ JPC GTC ILK KPUIL PCH NIWAA
	PAA MGZAA GTC WN KPUIL ZCIWA
	MGZ JPC BPWCI TWIL PAA ILK JGAGUN GD ILK TWCH

Using a frequency analysis tool:

http://www.richkni.co.uk/php/crypta/freq.php

We can see the following letter frequencies:

	K   151
	G   120
	I   111
	C   103
	P   89
	L   87
	U   73
	W   71
	A   63
	N   50
	T   43
	Z   43
	J   39
	H   36
	M   35
	D   21
	O   18
	B   17
	F   16
	R   16
	Y   14
	S   12
	Q   1
	V   1
	E   0
	X   0

This should be compared to the English letter frequencies listed on Wikipedia:

https://en.wikipedia.org/wiki/Letter_frequency

	e   12.702%
	t   9.056%
	a   8.167%
	o   7.507%
	i   6.966%
	n   6.749%
	s   6.327%
	h   6.094%
	r   5.987%
	d   4.253%
	l   4.025%
	c   2.782%
	u   2.758%
	m   2.406%
	w   2.361%
	f   2.228%
	g   2.015%
	y   1.974%
	p   1.929%
	b   1.492%
	v   0.978%
	k   0.772%
	j   0.153%
	x   0.150%
	q   0.095%
	z   0.074%

Combining these lists gives:

	K   e
	G   t
	I   a
	C   o
	P   i
	L   n
	U   s
	W   h
	A   r
	N   d
	T   l
	Z   c
	J   u
	H   m
	M   w
	D   f
	O   g
	B   y
	F   p
	R   b
	Y   v
	S   k
	Q   j
	V   x
	E   q
	X   z

which shows suggestions on what to try replacing first.

I was unsure of the accuracy of the above mapping given that many phrases in the lyrics are repeated, which I thought might skew the frequency analysis results.

After a few false starts, here are the steps I took - checking over the text after each to ensure no non-standard words had been introduced:

- Replace the most common letter, `K-e`
- Assuming the first line starts with `the`, and generally noting the frequency of the word `ILe`, sub `L-h` and `I-t`
- From `theUe`, I first tried `U-s`, but the rest of the text didn't look right, so I then tried `U-r` instead
- From `Thether`, sub `T-w`, revealing several occurences of `we`
- From `hGw`, sub `G-o`
- From `wWth` and `W`, sub `W-i`
- From `ePrth` and `P`, sub `P-a`
- From `eaJh other`, sub `J-c`
- From `with aAA the coAorN oD the`, sub `A-l`, `N-s`, and `D-f`
- From `Serries`, sub `S-b`
- From `bZt still i`, sub `Z-u`
- From `i Yuess it`, sub `Y-g`
- From `Oust be`, sub `O-m`
- From `i caCCot see`, sub `C-n`
- From `Mou can`, sub `M-y`
- From `anH for once`, sub `H-d`
- From `neRer`, sub `R-v`
- From `thinF`, sub `F-k`
- From `BeoBle`, sub `B-p`

Here is my replacement order:

	K-e
	L-h
	I-t
	U-r
	T-w
	G-o
	W-i
	P-a
	J-c
	A-l
	N-s
	D-f
	S-b
	Z-u
	Y-g
	O-m
	C-n
	M-y
	H-d
	R-v
	F-k
	B-p

Resulting in this almost completely deciphered text:

	the authoriVation code is withallthecolorsofthewind

	you think im an ignorant savage
	and youve been so many places
	i guess it must be so
	but still i cannot see
	if the savage one is me
	how can there be so much that you dont know
	you dont know

	you think you own whatever land you land on
	the earth is Qust a dead thing you can claim
	but i know every rock and tree and creature
	has a life has a spirit has a name

	you think the only people who are people
	are the people who look and think like you
	but if you walk the footsteps of a stranger
	youll learn things you never knew you never knew

	have you ever heard the wolf cry to the blue corn moon
	or asked the grinning bobcat why he grinned
	can you sing with all the voices of the mountains
	can you paint with all the colors of the wind
	can you paint with all the colors of the wind

	come run the hidden pine trails of the forest
	come taste the sunsweet berries of the earth
	come roll in all the riches all around you
	and for once never wonder what theyre worth

	the rainstorm and the river are my brothers
	the heron and the otter are my friends
	and we are all connected to each other
	in a circle in a hoop that never ends

	how high will the sycamore grow
	if you cut it down then youll never know
	and youll never hear the wolf cry to the blue corn moon

	for whether we are white or copper skinned
	we need to sing with all the voices of the mountains
	we need to paint with all the colors of the wind

	you can own the earth and still
	all youll own is earth until
	you can paint with all the colors of the wind

So the flag is:

	withallthecolorsofthewind

## 10 - web exploitation 40 - javascrypt

The page source shows a global variable `key`. Evaluating this in the Chrome console, shows the flag:

	flag_5151

## 11 - forensics 30 - pickle jar

Extract pickle.jar as a zip.

There's a file in there called `pickle.p` with contents:

	S'YOUSTOLETHEPICKLES'
	p0
	.

I decompiled `Jar.class` using JD-IntelliJ, but there was only basic output code in there.

The flag is:

	YOUSTOLETHEPICKLES

## 12 - binary explitation 40 - easy overflow

Open the shell and run

	nc vuln2014.picoctf.com 50000

> Your number is 1824832. Can you make it negative by adding a positive integer?

Responding `yes` shows:

> I'm unable to parse your number. It might be too large (the largest java int is 2147483647), or just not a number.

Well that gives us the answer. Respond `2147483647`, and it gives us the flag:

> Congratulations! The sum is -2138015749. Here is the flag: That_was_easssy!

Flag:

	That_was_easssy

## 13 - reverse engineering 60 - basic asm

