From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix cond_race... was RE: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Fri, 28 Sep 2001 00:57:00 -0000
Message-id: <20010928035840.A2535@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F1DA@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q3/msg00228.html

Rob,
Why not just check them both in?

I don't know if anyone is familiar enough with the *threads.cc code
to comment on your changes so if you have a fix that you think works,
then why not just check it in?

Btw, I do have one minor nit:  I think that the spelling is 'verifiable'
not 'verifyable'.

cgf
On Fri, Sep 28, 2001 at 06:01:41PM +1000, Robert Collins wrote:
>BTW: this patch is additiive to the earlier fix for the rentrancy
>problem with pthread_mutex_lock - apply them both.
>
>Rob
>
>> -----Original Message-----
>> From: Robert Collins 
>> Sent: Friday, September 28, 2001 5:48 PM
>> To: cygwin-patches@cygwin.com
>> Subject: fix cond_race... was RE: src/winsup/cygwin ChangeLog 
>> thread.cc
>> thread.h ...
>> 
>> 
>> Well this patch should make evreything good -  fixing the critical
>> section induced race.
>> 
>> Going out now, this is being sent in for feedback and testing. I will
>> craft changelog etc from home in about 6-12 hours.
>> 
>> Rob
>> 
>> > -----Original Message-----
>> > From: Christopher Faylor [ mailto:cgf@redhat.com ]
>> > Sent: Friday, September 28, 2001 5:27 PM
>> > To: cygwin-patches@cygwin.com
>> > Subject: Re: src/winsup/cygwin ChangeLog thread.cc thread.h ...
>> > 
>> > 
>> > On Fri, Sep 28, 2001 at 11:05:34AM +0400, egor duda wrote:
>> > >Hi!
>> > >
>> > >Friday, 28 September, 2001 Christopher Faylor cgf@redhat.com wrote:
>> > >
>> > >>>  320 12080627 [main] ssh 7436 peek_pipe: /dev/piper, saw EOF
>> > >>>  261 12080888 [main] ssh 7436 peek_pipe: saw eof on '/dev/piper'
>> > >>>  238 12081126 [main] ssh 7436 
>> > fhandler_pipe::ready_for_read: returning 1
>> > >
>> > >CF> As usual, I can't duplicate this problem.  I did see one 
>> > oddity in some of the new
>> > >CF> code that I added.  I'll check in a patch for that shortly.
>> > >
>> > >Your last checkin fixed both cvs+ssh and testsuite's kill02 (it was
>> > >blocking on pipe read too) problems for me. Thanks!
>> > 
>> > Phew.  I am now noticing a SEGV in zsh when it tries to run 
>> > perl, though.
>> > 
>> > Could that be due to pthread_mutex problems in passwd.cc and grp.cc?
>> > 
>> > cgf
>> > 
>> 

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
