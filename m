From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Fri, 28 Sep 2001 00:32:00 -0000
Message-id: <20010928033327.A2415@redhat.com>
References: <20010925114527.23687.qmail@sourceware.cygnus.com> <14472692346.20010927144858@logos-m.ru> <007b01c14743$2a0005b0$01000001@lifelesswks> <12280602580.20010927170049@logos-m.ru> <008301c1475e$afb0c4e0$01000001@lifelesswks> <20010927140440.B32577@redhat.com> <099067241.20010927220834@logos-m.ru> <20010928020326.A1798@redhat.com> <35145686916.20010928110534@logos-m.ru> <20010928032700.A2382@redhat.com>
X-SW-Source: 2001-q3/msg00225.html

On Fri, Sep 28, 2001 at 03:27:00AM -0400, Christopher Faylor wrote:
>On Fri, Sep 28, 2001 at 11:05:34AM +0400, egor duda wrote:
>>Hi!
>>
>>Friday, 28 September, 2001 Christopher Faylor cgf@redhat.com wrote:
>>
>>>>  320 12080627 [main] ssh 7436 peek_pipe: /dev/piper, saw EOF
>>>>  261 12080888 [main] ssh 7436 peek_pipe: saw eof on '/dev/piper'
>>>>  238 12081126 [main] ssh 7436 fhandler_pipe::ready_for_read: returning 1
>>
>>CF> As usual, I can't duplicate this problem.  I did see one oddity in some of the new
>>CF> code that I added.  I'll check in a patch for that shortly.
>>
>>Your last checkin fixed both cvs+ssh and testsuite's kill02 (it was
>>blocking on pipe read too) problems for me. Thanks!
>
>Phew.  I am now noticing a SEGV in zsh when it tries to run perl, though.
>
>Could that be due to pthread_mutex problems in passwd.cc and grp.cc?

To answer my own question: No.  It seems like it is related to CYGWIN=ntsec.
If I have this set, then zsh/fork/exec dies when starting perl, apparently in
malloc.  If I don't have CYGWIN=ntsec, then everything works ok.

I don't know why yet.

cgf
