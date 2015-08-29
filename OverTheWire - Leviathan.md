# Leviathan

By Brendan Weibrecht

## 0

	grep password /home/leviathan0/.backup/bookmarks.html

	<DT><A HREF="http://leviathan.labs.overthewire.org/passwordus.html | This will be fixed later, the password for leviathan1 is rioGegei8m" ADD_DATE="1155384634" LAST_CHARSET="ISO-8859-1" ID="rdf:#$2wIU71">password to leviathan1</A>

	rioGegei8m

## 1

We are given a `check` binary that asks for a password. It has a setuid of leviathan2, so while executing it, that will be our effective user. Disassembling and decompiling it doesn't reveal an easy way to see the password. A way around this is to debug the binary and modify the string comparison test result.

	$ gdb check
	(gdb) b main
	(gdb) run
	(gdb) disas

These lines seem interesting:

	0x080485ae <+129>:	call   0x80483b0 <strcmp@plt>
	0x080485b3 <+134>:	test   %eax,%eax
	0x080485b5 <+136>:	jne    0x80485c5 <main+152>

It appears that if we modify `%eax` at `+134`, we can change which part of the program it branches to next, i.e. not perform the jump.

`jne` will perform the jump if the zero flag (ZF) is 0.
`test` performs an AND operation, and if the result is 0, ZF is set to 1; otherwise it's set to 0.

So, if we break at `0x080485b3`, and set `%eax` to 0, the 0 result of `test` will mean that ZF is set, and hence `jne` will not jump.

	(gdb) b *0x080485b3
	(gdb) c
	(gdb) disas
	(gdb) set $eax=0
	(gdb) c

Ta da! We are presented with a shell =)

Goddamn it, this doesn't execute it as leviathan2, so we can't read the passord file at `/etc/leviathan_pass/leviathan2`

---

Looking up the answer >_>

Running:

	$ ltrace ./check

and giving it a password of `asd` shows a string comparison of that with `sex`.

	__libc_start_main(0x804852d, 1, 0xffffd7a4, 0x80485f0 <unfinished ...>
	printf("password: ")                                           = 10
	getchar(0x8048680, 47, 0x804a000, 0x8048642password: asd
	)                   = 97
	getchar(0x8048680, 47, 0x804a000, 0x8048642)                   = 115
	getchar(0x8048680, 47, 0x804a000, 0x8048642)                   = 100
	strcmp("asd", "sex")                                           = -1
	puts("Wrong password, Good Bye ..."Wrong password, Good Bye ...
	)                           = 29
	+++ exited (status 0) +++

Let's try `sex` as the password...

	strcmp("sex", "sex")                                           = 0
	system("/bin/sh"$ 

Lol, it worked.

	leviathan1@melinda:~$ ./check 
	password: sex
	$ whoami
	leviathan2
	$ cat /etc/leviathan_pass/leviathan2

ougahZi8Ta

## 2

Having used IDA, I can't see a way to do it... Looking up the answer >_>

Printing a normal file:

	$ mkdir /tmp/zimbix_lev2; cd /tmp/zimbix_lev2
	$ touch b
	$ ltrace ~/printfile b
	access("b", 4)                                                 = 0
	snprintf("/bin/cat b", 511, "/bin/cat %s", "b")                = 10
	system("/bin/cat b")

Printing the password file:

	$ ltrace ~/printfile /etc/leviathan_pass/leviathan3
	access("/etc/leviathan_pass/leviathan3", 4)                    = -1
	puts("You cant have that file...")

So it has to pass the `access` check first, before it calls `cat`.

The reason it doesn't work is explained in the manual for `access` at http://linux.about.com/library/cmd/blcmdl2_access.htm:

> The check is done with the process's *real* uid and gid, rather than with the effective ids as is done when actually attempting an operation. This is to allow set-UID programs to easily determine the invoking user's authority.

The call to `cat` will treat a space as a separator between files. The `access` call does not, given the full path is passed as a string directly.

If we have files `a`, `b`, and `a b`, cat will use the first two, and `access` the last one. Therefore, if we make each file it will work fine. We can use a symbollic link for a file that will be read by `cat`.

	$ touch 'a b'
	$ ln -s /etc/leviathan_pass/leviathan3 a
	$ ~/printfile 'a b'

Ahdiemoo1j

## 3

Wow, this is very similar to level 2.

	$ ltrace ./level3 
	__libc_start_main(0x80485fe, 1, 0xffffd7a4, 0x80486d0 <unfinished ...>
	strcmp("h0no33", "kakaka")                                     = -1
	printf("Enter the password> ")                                 = 20
	fgets(Enter the password> sdf
	"sdf\n", 256, 0xf7fcac20)                                = 0xffffd59c
	strcmp("sdf\n", "snlprintf\n")                                 = -1
	puts("bzzzzzzzzap. WRONG"bzzzzzzzzap. WRONG
	)                                     = 19
	+++ exited (status 0) +++

`strcmp("sdf\n", "snlprintf\n")` Indicates the password is `snlprintf`. Lol, it works.

vuH0coox6m

## 4

`.trash/bin` appears to output the password in binary:

	01010100 01101001 01110100 01101000 00110100 01100011 01101111 01101011 01100101 01101001 00001010

Checking ltrace:

	$ ltrace .trash/bin
	__libc_start_main(0x80484cd, 1, 0xffffd7a4, 0x80485c0 <unfinished ...>
	fopen("/etc/leviathan_pass/leviathan5", "r")                   = 0
	+++ exited (status 255) +++

Using a binary to ASCII converter:

Tith4cokei

## 5

Default output:

	Cannot find /tmp/file.log

Touching the file prevents the error, but deletes the file after running.

	ln -s /etc/leviathan_pass/leviathan6 /tmp/file.log

UgaoFee4li

## 6

