# OverThe Wire - Krypton

Writeup by Brendan Weibrecht

# 1 -> 2

Caesar cipher

We have access to the encryption program, so just run plaintext through it to see what the corresponding substitution is. We can then use `tr` to undo the substitution on the ciphertext.

    krypton2@melinda:/games/krypton/krypton2$ irb
    irb(main):006:0> ('A'..'Z').to_a.join
    => "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    krypton2@melinda:/games/krypton/krypton2$ echo "ABCDEFGHIJKLMNOPQRSTUVWXYZ" > /tmp/ZimbiX_k2
    krypton2@melinda:/games/krypton/krypton2$ cd /tmp
    krypton2@melinda:/tmp$ mkdir ZimbiX_k2d
    krypton2@melinda:/tmp$ cd ZimbiX_k2d
    krypton2@melinda:/tmp/ZimbiX_k2d$ ln -s /games/krypton/krypton2/keyfile.dat keyfile.dat
    krypton2@melinda:/tmp/ZimbiX_k2d$ /games/krypton/krypton2/encrypt /tmp/ZimbiX_k2
    krypton2@melinda:/tmp/ZimbiX_k2d$ ll
    total 1104
    drwxrwxr-x    2 krypton2 krypton2    4096 May  7 08:18 ./
    drwxrwx-wt 2854 root     root     1118208 May  7 08:18 ../
    -rw-rw-r--    1 krypton3 krypton2      26 May  7 08:18 ciphertext
    lrwxrwxrwx    1 krypton2 krypton2      35 May  7 08:18 keyfile.dat -> /games/krypton/krypton2/keyfile.dat
    krypton2@melinda:/tmp/ZimbiX_k2d$ cat ciphertext
    MNOPQRSTUVWXYZABCDEFGHIJKLkrypton2@melinda:/tmp/ZimbiX_k2d$ cat /games/krypton/krypton2/krypton3 | tr MNOPQRSTUVWXYZABCDEFGHIJKL ABCDEFGHIJKLMNOPQRSTUVWXYZ
    CAESARISEASY

# 2 -> 3

Frequency analysis. I'm thinking this is a substitution cipher

Letter frequency:

    cat found* | grep -o . | sort | uniq -c | sort -r

Bigram frequency:

