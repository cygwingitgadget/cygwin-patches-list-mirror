From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Change to fhandler_random.cc/wincrypt.h
Date: Sat, 27 May 2000 07:04:00 -0000
Message-id: <392FD5FB.EF3B0494@vinschen.de>
X-SW-Source: 2000-q2/msg00088.html

I have patched fhandler_random.cc to be able to deal with
user accounts which have not loaded their user registry hive.

The patch has required to add the missing CRYPT_MACHINE_KEYSET
define to wincrypt.h

Corinna
