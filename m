From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-developers@cygwin.com>
Cc: <cygwin-patches@cygwin.com>
Subject: RE: muto object.
Date: Sun, 16 Sep 2001 19:37:00 -0000
Message-id: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F17C@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q3/msg00154.html

I'll try finishing the email this time.

What I meant to say was, if this looks ok, it makes muto's a potential
replacement for critical sections on 95 for pthreads, which would be
very good speed wise.

Anyway, I'll draw up a change log and the rest if you want this
included.

Rob

> -----Original Message-----
> From: Robert Collins 
> Sent: Monday, September 17, 2001 12:23 PM
> To: cygwin-developers@cygwin.com
> Cc: cygwin-patches@cygwin.com
> Subject: muto object.
> 
> 
> Chris, 
>   This update to muto handles threads exiting spontaneously without
> releasing the muto properly. I think it fixes the FIXME you have in
> ::release, but as I can't see how release can check for other thread
> activity, it may not have fixed that.
> 
> The logic it uses is:
> if we fail to wait for the event,
> protect ourselves with recover
> check for the thread having died (should be fast - noop basically) and
> if it has aquire the muto anyway.
> 
> There was also a typo in the destructor that could be causing memory
> leaks within process.
> 
> Rob
> 
