From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: Re: tzname
Date: Tue, 27 Mar 2001 13:39:00 -0000
Message-id: <002901c0b706$309b8840$0200a8c0@lifelesswks>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF02E2B2@itdomain002.itdomain.net.au> <20010327104754.E6177@redhat.com>
X-SW-Source: 2001-q1/msg00256.html

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Wednesday, March 28, 2001 1:47 AM
Subject: Re: tzname


> On Tue, Mar 27, 2001 at 04:07:17PM +1000, Robert Collins wrote:
> > http://www.opengroup.org/onlinepubs/7908799/xsh/tzset.html
> >specifies tzname, not _tzname. Also attached is a little test program
> >written from the specs.
>
> Um.  I hate to keep harping on this but there are a two things wrong
with
> this patch.

Please, keep harping as long as I give you music to harp to.

> 1) It is a newlib patch, so should go to the newlib group.

Yes. Corinna's already pointed this out :].

> 2) The ChangeLog is incorrect.  ChangeLogs have an established format.
This
>    is not it:
>
> >2001-03-21  Robert Collins  <rbtcollins@hotmail.com>
> >
> >        http://www.opengroup.org/onlinepubs/7908799/xsh/tzset.html
> >        specifies tzname, not _tzname. Define tzname to _tzname if it
is not defined.
>
> This is:
>
> 2001-03-21  Robert Collins  <rbtcollins@hotmail.com>
>
> * libc/include/time.h: Define tzname to _tzname for POSIX compliance.
>
> cgf
>
