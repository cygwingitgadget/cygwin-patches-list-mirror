From: Earnie Boyd <earnie_boyd@yahoo.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: MinGW Dvlpr <mingw-dvlpr@lists.sourceforge.net>
Subject: Re: [Fwd: w32api and gcc -pedantic]]
Date: Mon, 16 Apr 2001 06:25:00 -0000
Message-id: <3ADAF2AA.2AE1A652@yahoo.com>
X-SW-Source: 2001-q2/msg00073.html

Unless someone can give me a reasonable counter to Danny's reply below,
I'm not accepting this patch.

Earnie.

-------- Original Message --------
Subject: Re: [MinGW-dvlpr] [Fwd: w32api and gcc -pedantic]
Date: Sat, 14 Apr 2001 07:30:01 +1000 (EST)
From: Danny Smith <danny_r_smith_2001@yahoo.co.nz>
Reply-To: mingw-dvlpr@lists.sourceforge.net
To: mingw-dvlpr@lists.sourceforge.net


--- Earnie Boyd <earnie_boyd@yahoo.com> wrote: > What do others
(especially
Danny) on this list think of this patch?
> 
> Earnie.
> 
> -------- Original Message --------
> Subject: w32api and gcc -pedantic
> Date: Fri, 13 Apr 2001 23:10:57 +0400
> From: egor duda <deo@logos-m.ru>
> Reply-To: egor duda <cygwin-patches@cygwin.com>
> Organization: deo
> To: cygwin-patches@cygwin.com
> 
> Hi!
> 
>   w32api headers currently contain a number of anonymous structs and
> unions. So, gcc prints a bunch of warnings when invoked with -pedantic
> on program which #include <windows.h>. this patch is to avoid those
> warnings.
> 
> egor.            mailto:deo@logos-m.ru icq 5165414 fidonet 2:5020/496.19


My reading of C99 standard (section 6.7.2.1) is that nameless
unions/structures
are now part of standard.  The fix should go into GCC not the mingw
headers. 
GCC -pedantic -std=iso9899:199x should not raise warnings about unnamed
structures; GCC -pedantic -std=iso9899:199409 should.

I think the warnings should stay for now, since they are extensions to
the
currently supported standard.

Danny

_____________________________________________________________________________
http://movies.yahoo.com.au - Yahoo! Movies
- Now showing: Dude Where's My Car, The Wedding Planner, Traffic..

_______________________________________________
MinGW-dvlpr mailing list
MinGW-dvlpr@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/mingw-dvlpr

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

