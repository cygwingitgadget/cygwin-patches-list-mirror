From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>, <cygwin-xfree@cygwin.com>
Subject: RE: [PATCH] Re: pthread -- Corinna?
Date: Mon, 16 Apr 2001 21:10:00 -0000
Message-id: <EA18B9FA0FE4194AA2B4CDB91F73C0EF79C0@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00084.html

> -----Original Message-----
> From: Christopher Faylor [ mailto:cgf@redhat.com ]
> Sent: Tuesday, April 17, 2001 12:54 PM
> To: cygwin-patches@cygwin.com; cygwin-xfree@cygwin.com
> Subject: Re: [PATCH] Re: pthread -- Corinna?
> 
> 
I've remembered my key thought:

fopen should only fail open when etc_passwd is being read. 

We've got two thread issues here: 
1) a area that requires serialisation (reading the file into memory) 
2) a potential deadlock due to recursion
(read_etc->fopen->get_id->read_etc)

I think we should address the two issues separately. They aren't the
same thing after all.

For the deadlock, a semaphore is the traditional method - you check if
you can get it, and if not either wait a while or return an error.

For the serialised area, a mutex or critical section is best ( I intend
to make pthread implement process-local mutex's as critical sections for
performance in the near future).
 
> >The current code is thread safe because only one thread enters the
> >protected code section, and that protected section sets the 
> sem variable
> >so that fopen won't recurse back into read_etc_passwd. 
> 
> In my experience, whenever you try to use two mechanisms to control
> recursion or simultaneous access you are asking for trouble.

Sure. But we have two distinct things to guard against.
 
> >A true semaphore could be used, but as the current one is mutex
> >protected there's no point in extra overhead.
> 
> Still not convinced.
> 
> It still seems like there is potential for error if two threads call
> get_id_from_sid.  One may correctly read a UID via getpwuid, one will
> short-circuit.  

Nope, getpwuid blocks if read_etc_passwd is in progress. (Or does the
short-circuit mean "do not call getpwuid" ?).

This highlights another problem: within cygwin we should be using the _r
functions. If the implementation of getpwuid was ever changed, we could
be in trouble race wise.

> Hmm.  This would be a problem even if we were 
> attempting
> to detect recursion via a static variable.

Get_id_from_sid should know whether the call is part of parsing
/etc/passwd. We don't want to serialise disk access or opens in general,
so some thought is needed on this one.
 
> Maybe we need another passwd_state == 'initializing'.

Ahh, that gets kind of messy because then all the getpwnam checks will
need to be passwd_state == uninitialised || passwd_state ==
initializing.
 
> Hmm, again.  We actually have *three* variables controlling how this
> operates now, passwd_state, passwd_sem, and etc_passwd_mutex.  IMO,
> that's too many.

Why don't we abstract out the read_etc_passwd into the search function?
That will cleanup some of the state test issues. 

That gives
passwd_state - whether the passwd file has been parsed
etc_passwd_mutex - serialises the parsing.
passwd_sem - allows get_id_from_sid to skip checking access on
/etc/passwd when parsing /etc/passwd.

I think the correct solution is to get rid of passwd_sem completely. Get
rid og get_id_from_sid's shortcut capability, and give the search
function the ability to do a manual  one off parse of the file, without
storing the result, to satisfy any getpwnam requests while /etc/passwd
is being parsed. 

Rob
> cgf
> 
