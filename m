From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Fri, 28 Sep 2001 00:05:00 -0000
Message-id: <35145686916.20010928110534@logos-m.ru>
References: <20010925114527.23687.qmail@sourceware.cygnus.com> <14472692346.20010927144858@logos-m.ru> <007b01c14743$2a0005b0$01000001@lifelesswks> <12280602580.20010927170049@logos-m.ru> <008301c1475e$afb0c4e0$01000001@lifelesswks> <20010927140440.B32577@redhat.com> <099067241.20010927220834@logos-m.ru> <20010928020326.A1798@redhat.com>
X-SW-Source: 2001-q3/msg00223.html

Hi!

Friday, 28 September, 2001 Christopher Faylor cgf@redhat.com wrote:

>>  320 12080627 [main] ssh 7436 peek_pipe: /dev/piper, saw EOF
>>  261 12080888 [main] ssh 7436 peek_pipe: saw eof on '/dev/piper'
>>  238 12081126 [main] ssh 7436 fhandler_pipe::ready_for_read: returning 1

CF> As usual, I can't duplicate this problem.  I did see one oddity in some of the new
CF> code that I added.  I'll check in a patch for that shortly.

Your last checkin fixed both cvs+ssh and testsuite's kill02 (it was
blocking on pipe read too) problems for me. Thanks!

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
