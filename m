From: Corinna Vinschen <vinschen@cygnus.com>
To: cygdev <cygwin-developers@sources.redhat.com>, cygpatch <cygwin-patches@sources.redhat.com>
Subject: [PATCH]: New implementation for /dev/[u]random
Date: Mon, 24 Jul 2000 04:43:00 -0000
Message-id: <397C2BE5.DA513A25@cygnus.com>
X-SW-Source: 2000-q3/msg00030.html

Hi all,

I have checked in a patch which changes the implementation
of /dev/random and /dev/urandom as follows:

- If initialization of the system crypto provider or retrieving
  the entropy source fails, reading from /dev/random fails as well.

- If that happens when using /dev/urandom, a pseudo random number
  generator (the same as used in DJGPP) is used as a fallback
  entropy source.

- In either case it's now possible to thrill the entropy source
  (system _and_ pseudo) by writing to the device.

The difference in handling /dev/random in contrast to /dev/urandom
is reasoned by it's purpose as a source for "very high quality 
randomness" as it's described in the Linux man page random(4)
while /dev/urandom is explicitly allowed to use a substitute.

For clearness: `sshd' uses /dev/urandom so it should work now under
any circumstances.

Corinna

-- 
Corinna Vinschen
Cygwin Developer
Cygnus Solutions, a Red Hat company
