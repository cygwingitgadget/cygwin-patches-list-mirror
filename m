From: Christopher Faylor <cgf@redhat.com>
To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: pthreads works, sorta - got it
Date: Wed, 27 Jun 2001 19:20:00 -0000
Message-id: <20010627222105.A29564@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F09E@itdomain002.itdomain.net.au> <20010627012932.I19058@redhat.com> <20010627013502.K19058@redhat.com> <008201c0ff0d$8fe3c2a0$806410ac@local> <009701c0ff0e$4d796400$806410ac@local> <00e501c0ff14$6ad8dd40$806410ac@local>
X-SW-Source: 2001-q2/msg00361.html

On Thu, Jun 28, 2001 at 12:21:11AM +1000, Robert Collins wrote:
>Got the bug... attached is a correct patch that doesn't break anything
>AFAICT.
>
>GCC was optimising the variable access when the macro
>check_null_empty-path_errno was used, and accessing the memory area _before_
>the readcheck! The overhead of a proper function should be lower than that
>of VirtualQueryHowever, so I've made it a function. It could have the guts
>of check_null_empty_path copied into it for speed, but that's optional IMO.
>
>Wed Jun 27 23:30:00 2001  Robert Collins <rbtcollins@hotmail.com>
>
>	* path.h (check_null_empty_path_errno): Convert to a function
>	prototype.
>	* path.cc (check_null_empty_path_errno): New function.
>	(check_null_empty_path): Change from VirtualQuery to IsBadWritePtr.
>	* resource.cc (getrlimit): Ditto.
>	(setrlimit): Ditto.
>	* thread.cc (check_valid_pointer): Ditto.

Thanks for the patch.  I took it a step further.  I renamed the _path
stuff to _str for consistency, and created some
check_null_invalid_struct* functions.

It has been checked in.

cgf
