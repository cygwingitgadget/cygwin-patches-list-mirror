From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <nhv@cape.com>, "'Jason Tishler'" <jason@tishler.net>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: fix cond_race... was RE: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Sun, 30 Sep 2001 07:40:00 -0000
Message-id: <006701c149be$0676afe0$01000001@lifelesswks>
References: <003201c149ab$0e16e020$a300a8c0@nhv>
X-SW-Source: 2001-q3/msg00243.html

----- Original Message -----
From: "Norman Vine" <nhv@cape.com>
To: "'Robert Collins'" <robert.collins@itdomain.com.au>; "'Jason
Tishler'" <jason@tishler.net>
Cc: <cygwin-patches@cygwin.com>
Sent: Sunday, September 30, 2001 10:25 PM
Subject: RE: fix cond_race... was RE: src/winsup/cygwin ChangeLog
thread.cc thread.h ...



> See attached

Inline is cool too :}.

please try an updated dll, I've checked in a potential fix now. If that
doesn't fix it, then..

in frame 3 (pthread_cond_wait.
can you do
print *(pthread_cond_t *) 0xa05e6fc (the value of the first parameter).

in frame 2,
print *cond
, or if cond doesn't look sensible,
print **pthread_cond_t *) <value of first parameter>


Rob
