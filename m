From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: Re: fix cond_race... was RE: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Fri, 28 Sep 2001 01:10:00 -0000
Message-id: <000701c147f5$44f52280$01000001@lifelesswks>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F1DA@itdomain002.itdomain.net.au> <20010928035840.A2535@redhat.com>
X-SW-Source: 2001-q3/msg00229.html

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Friday, September 28, 2001 5:58 PM
Subject: Re: fix cond_race... was RE: src/winsup/cygwin ChangeLog
thread.cc thread.h ...


> Rob,
> Why not just check them both in?

Well the previous one was incomplete in a technical sense, I just wanted
you folk to have something working.

As for this one, I will be checking it in, but I am running *very* late
to a dinner appointment... I mailed out from the office, and am typing
this from the house, on my way out.

> I don't know if anyone is familiar enough with the *threads.cc code
> to comment on your changes so if you have a fix that you think works,
> then why not just check it in?

I plan to. My internal quality control isn't passed yet - I have more
testing *I* want to do... These patches are still in "rough mode".

> Btw, I do have one minor nit:  I think that the spelling is
'verifiable'
> not 'verifyable'.

It's a class name :}. s&r can be done if needed :}.

Rob
