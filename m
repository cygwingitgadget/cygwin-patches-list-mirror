From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: tzname
Date: Tue, 27 Mar 2001 07:47:00 -0000
Message-id: <20010327104754.E6177@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF02E2B2@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q1/msg00255.html

On Tue, Mar 27, 2001 at 04:07:17PM +1000, Robert Collins wrote:
> http://www.opengroup.org/onlinepubs/7908799/xsh/tzset.html
>specifies tzname, not _tzname. Also attached is a little test program
>written from the specs.

Um.  I hate to keep harping on this but there are a two things wrong with
this patch.

1) It is a newlib patch, so should go to the newlib group.

2) The ChangeLog is incorrect.  ChangeLogs have an established format.  This
   is not it:

>2001-03-21  Robert Collins  <rbtcollins@hotmail.com>
>  
>        http://www.opengroup.org/onlinepubs/7908799/xsh/tzset.html
>        specifies tzname, not _tzname. Define tzname to _tzname if it is not defined.

This is:

2001-03-21  Robert Collins  <rbtcollins@hotmail.com>

	* libc/include/time.h: Define tzname to _tzname for POSIX compliance.

cgf
