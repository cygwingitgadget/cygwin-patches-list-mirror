From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>, <cygwin-xfree@cygwin.com>
Subject: RE: [PATCH] Re: pthread -- Corinna?
Date: Mon, 16 Apr 2001 19:35:00 -0000
Message-id: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EEEB@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00080.html

Oh, I forget - check the changelog in 1999, I did look into this when I
did the code :]

Rob

> -----Original Message-----
> From: Robert Collins 
> Sent: Tuesday, April 17, 2001 12:26 PM
> To: cygwin-patches@cygwin.com; cygwin-xfree@cygwin.com
> Subject: RE: [PATCH] Re: pthread -- Corinna?
> 
> 
> > -----Original Message-----
> > From: Christopher Faylor [ mailto:cgf@redhat.com ]
> > Sent: Tuesday, April 17, 2001 12:25 PM
> > To: cygwin-patches@cygwin.com; cygwin-xfree@cygwin.com
> > Subject: Re: [PATCH] Re: pthread -- Corinna?
> > 
> > 
> > On Tue, Apr 17, 2001 at 07:48:00AM +1000, Robert Collins wrote:
> > >----- Original Message -----
> > >From: "Christopher Faylor" <cgf@redhat.com>
> > >To: <cygwin-xfree@cygwin.com>; <cygwin-patches@cygwin.com>
> > >Sent: Tuesday, April 17, 2001 1:20 AM
> > >Subject: Re: [PATCH] Re: pthread
> > >
> > >
> > >> On Mon, Apr 16, 2001 at 09:06:27PM +1000, Robert Collins wrote:
> > >> >Hi Suhaib,
> > >>>here are the two missing functions.  If you aren't setup 
> to compile
> > >>>cygwin1.dll let me know and I'll mail you mine.
> > >>
> > >>You seem to be adding a mutex that is supplanting the passwd_sem
> > >>variable.  Shouldn't passwd_sem be eliminated if you are 
> > adding this?
> > >
> > >No.  passwd_sem is not even a real semaphore.  It's simply 
> > used to stop
> > >security.cc looking calling getpwuid when fopen is called.  
> > Passwd_sem
> > >as a static variable has almost no overhead on access, a 
> > real semaphore
> > >or a trylock() on the mutex in security.cc will have a 
> > performance hit.
> > 
> > I'm not convinced that there aren't two diverse mechanisms trying to
> > accomplish the same thing here.  Since read_etc_passwd 
> should only be
> > called when "passwd_state == uninitialized" I assume that the 
> > intent of
> > this code is to avoid calling read_etc_passwd more than once.  This
> > is already handled by the "passwd_state == uninitialized" 
> test except
> > if there is an executed race (don't know if this is the 
> correct term).
> > 
> > I don't really understand what the passwd_sem code in security.cc is
> > trying to do.  It seems to short circuit get_id_from_sid in the case
> > where this function is called "simultaneously" from two 
> > different threads?
> > Or is this function somehow called recursively from getpwent?
> 
> I believe the recurse goes (witout function names - off top of head)
> fopen->check security->getpwuid->read_etc_password->fopen.
> 
> the problem is that 
> a) we can't change passwd_state from uninitialised until _after_ the
> read completes, or calls to getpwuid et al will think it's 
> been read and
> attempt a search.
> b) the recursive loop above will deadlock if it comes back into
> read_etc_password.
> 
> So we need a variable (not passwd_state) to indicate if we 
> are currently
> in the protected area of read_etc_passwd.
>  
> > If that is the case, then the "passwd_sem" variable could 
> be local to
> > security.cc, couldn't it?  As it is implemented now, it seems like
> > one thread calling getpwent could impact another thread that was
> > calling get_id_from_sid.
> 
> It needs to be set in read_etc_passwd because if two threads call
> 1 - getpwnam
> 2 - fopen(foo)
> 
> both calls may result in read_etc_passwd being called, but 
> only one will
> enter the mutex via fopen, the other will enter the mutex via
> read_etc_passwd. Instant deadlock.
> 
> Trylock isn't a solution because then the getpwnam and 
> related functions
> will return without actually having read the database.
> 
> The current code is thread safe because only one thread enters the
> protected code section, and that protected section sets the 
> sem variable
> so that fopen won't recurse back into read_etc_passwd. 
> 
> A true semaphore could be used, but as the current one is mutex
> protected there's no point in extra overhead.
> 
> Rob
>  
> > Corinna?
> > 
> > cgf
> > 
> 
