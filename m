From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>, <cygwin-xfree@cygwin.com>
Subject: Re: [PATCH] Re: pthread -- Corinna?
Date: Tue, 17 Apr 2001 03:30:00 -0000
Message-id: <009d01c0c729$68fe0b80$0200a8c0@lifelesswks>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF79C0@itdomain002.itdomain.net.au> <20010417005137.A26463@redhat.com> <20010417122126.A12559@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00095.html

----- Original Message -----
From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
To: <cygwin-patches@cygwin.com>; <cygwin-xfree@cygwin.com>
Sent: Tuesday, April 17, 2001 8:21 PM
Subject: Re: [PATCH] Re: pthread -- Corinna?


> On Tue, Apr 17, 2001 at 12:51:37AM -0400, Christopher Faylor wrote:
> > On Tue, Apr 17, 2001 at 02:03:19PM +1000, Robert Collins wrote:
> > >I've remembered my key thought:
> > > [...]
> > You probably know this, but, [...]
> > >I think we should [...]
> > Ah right. [...]
> > >> >A true semaphore could [...]
> > >> Still not convinced.
> > >> [...]
> > >Nope, [...]
> > Yes.  [...]
> > >Get_id_from_sid should know [...]
> > >> Maybe [...]
> > >Ahh, [...]
> > passwd_state <= initializing
> >
> > >> Hmm, again.  [...]
> > >Why don't we [...]
> > I won't disagree [...]
> > Index: security.cc
> > ===================================================================
> > [...]
>
> Ok, I'm in the subject so I think I should say something here, too.
> You both have told so much, back and forth, that I'm not quite sure
> how to tie in. Anyway.
>
> Robert is right in that we have two different problems. In my own
> words:
>
> - n>1 threads could try to call read_etc_passwd() nearly
>   simultaneously. This is a problem which could be handled by a
>   mutex or a critical section handler, perhaps.
>
> - get_id_from_sid is called from open if and only if ntsec is ON.
>   That's a problem which is thread internal. Each single thread
>   would have the same problem and it's related to the usage of
>   `fopen' in read_etc_passwd() and read_etc_group(). `passwd_sem'
>   and `group_sem' are just gatekeeper to avoid the recursion.
>
>   Obviously, the usage of these variables isn't thread safe.
>   The joke here is that the kernel (urgh, Cygwin itself) doesn't
>   need ntsec. It should always be able to open /etc/passwd and
>   /etc/group.
>
>   So, the better way is probably to drop both ..._sem variables and
>   just switch off allow_ntsec in read_etc_...() before opening a
>   file and restoring the setting afterwards.
>
>   If that's done inside of the above mentioned mutex or critical
section
>   protected area in read_etc_...(), it's protected against changings
by
>   simultaneous threads, too.

is allow_ntsec thread-specific or process-specific or system specific?

- if it's thread-specific, then that will work.

- If it's process specific, then we need to have every io call that
tests allow_ntsec enter the same mutex (or critical section). That would
be a rather significant performance hit for multithreaded apps. (If they
don't enter the section, then user read & writes will not be tested
against nt_sec during the parsing period.

- If it's system specific then we need a cross-process mutex m and every
io call [...] That would make cygwin _very_ slow for parallel process
behaviour.

I agree that it's the best way, as long as we have allow_ntsec thread
specific. Introducing a cross-thread bottleneck on i/o would be bad idea
IMO.

Rob

> Corinna
>
