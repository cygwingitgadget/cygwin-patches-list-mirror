From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>, <cygwin-xfree@cygwin.com>
Subject: RE: [PATCH] Re: pthread -- Corinna?
Date: Mon, 16 Apr 2001 22:05:00 -0000
Message-id: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EEF0@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00086.html

> -----Original Message-----
> From: Christopher Faylor [ mailto:cgf@redhat.com ]
> Sent: Tuesday, April 17, 2001 2:52 PM
> To: cygwin-patches@cygwin.com; cygwin-xfree@cygwin.com
> Subject: Re: [PATCH] Re: pthread -- Corinna?
> 
> 
> On Tue, Apr 17, 2001 at 02:03:19PM +1000, Robert Collins wrote:
> >I've remembered my key thought:
> >
> >fopen should only fail open when etc_passwd is being read. 
> >
> >We've got two thread issues here: 
> >1) a area that requires serialisation (reading the file into memory) 
> >2) a potential deadlock due to recursion
> >(read_etc->fopen->get_id->read_etc)
> 
> You probably know this, but, recurison won't cause the mutex to block
> since repeated calls to a mutex in the same thread don't block if the
> thread owns the mutex.  It will recurse, though, of course, 
> which is not
> right.

Yes. Which is why the passwd_sem was there initially.
 
> >I think we should address the two issues separately. They aren't the
> >same thing after all.
> 
> Ah right.  I forgot my own point.  This can be controlled by changing
> the state of passwd_state to something like "initializing".
> 
> Yes.  I don't see how it can possibly be the right behavior that one
> thread will call get_id_from_sid and get the right behavior 
> and another
> one will not.
> 
> You just can't use a static variable to guard against recursion in a a
> multi-threaded application.  You could use thread local storage for
> this though, I guess.

Yes. pthread_key's are your friend :].
 
> >> Hmm.  This would be a problem even if we were 
> >> attempting
> >> to detect recursion via a static variable.
> >
> >Get_id_from_sid should know whether the call is part of parsing
> >/etc/passwd. We don't want to serialise disk access or opens 
> in general,
> >so some thought is needed on this one.
> > 
>  
> >> Hmm, again.  We actually have *three* variables 
> controlling how this
> >> operates now, passwd_state, passwd_sem, and etc_passwd_mutex.  IMO,
> >> that's too many.
> >
> >Why don't we abstract out the read_etc_passwd into the 
> search function?
> >That will cleanup some of the state test issues. 
> >
> >That gives
> >passwd_state - whether the passwd file has been parsed
> >etc_passwd_mutex - serialises the parsing.
> >passwd_sem - allows get_id_from_sid to skip checking access on
> >/etc/passwd when parsing /etc/passwd.
> >
> >I think the correct solution is to get rid of passwd_sem 
> completely. Get
> >rid og get_id_from_sid's shortcut capability, and give the search
> >function the ability to do a manual  one off parse of the 
> file, without
> >storing the result, to satisfy any getpwnam requests while 
> /etc/passwd
> >is being parsed. 
> 
> I won't disagree with the thought of getting rid of passwd_sem since
> that is what I've been saying from the start.  I don't like the
> idea of allowing a one-off parse of /etc/passwd, though.

Why not? I'm suggesting that we actually get to check security on
/etc/passwd in calls to getpwnam. Or is that a bad thing?
 

Other than that, it looks good. I presume the cygheap-> changes are
related issues/general code tidyup?


Rob
