From: egor duda <deo@logos-m.ru>
To: "Ronald Landheer" <info@rlsystems.net>
Cc: cygwin-patches@cygwin.com
Subject: Re: fhandlers codebase, magic dirs, etc.
Date: Sun, 30 Sep 2001 13:12:00 -0000
Message-id: <4292977955.20011001001000@logos-m.ru>
References: <NFBBLOMHALONCDMPGBLFCENKCCAA.info@rlsystems.net>
X-SW-Source: 2001-q3/msg00248.html

Hi!

Monday, 01 October, 2001 Ronald Landheer info@rlsystems.net wrote:

RL> NB: Just a small question: how does one go about debugging the Cygwin 
RL> DLL? I mean: ye can't have two of them at the same time, so I could just 
RL> put one aside in a gzip, but bugs in things like this might leave gdb 
RL> broken as well. I can brew up a whole bunch of testcases and see which 
RL> ones fail, but it would be nice to be able to step through the source.. 
RL> Is it possible?

you want to look at 'winsup/cygwin/how-to-debug-cygwin.txt' file in current
CVS sources.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
