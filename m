From: egor duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: case-sensitiveness of environment
Date: Tue, 17 Apr 2001 00:20:00 -0000
Message-id: <133228248153.20010417111911@logos-m.ru>
References: <27138147024.20010416101728@logos-m.ru>
X-SW-Source: 2001-q2/msg00093.html

Hi!

Monday, 16 April, 2001 egor duda deo@logos-m.ru wrote:

ed>   if cygwin environment contains both 'Path' and 'PATH', creating
ed> windows environment from it causes crash due to reallocating memory
ed> object which is externally referenced. this patch fixes that.

ed> i feel that we need a bit more tweaking with environment to deal with
ed> it case-insensitiveness under win32.

hmm, it looks like there's a little we can do here besides just fixing
a crash. as long as application can manipulate environment directly
via 'environ' variable, cygwin1.dll can't guarantee that we won't have
both 'Path' and 'PATH' in the environment.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

