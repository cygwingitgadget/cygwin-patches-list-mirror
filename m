From: Earnie Boyd <earnie_boyd@yahoo.com>
To: CP List <Cygwin-Patches@Cygwin.Com>, MD List <MinGW-Dvlpr@SF.Net>
Subject: [Fwd: Fwd: _ANONYMOUS_STRUCT]
Date: Tue, 04 Sep 2001 07:41:00 -0000
Message-id: <3B94E80B.C0E046EB@yahoo.com>
X-SW-Source: 2001-q3/msg00100.html

FYI, you cannot include the individual w32api headers.  You must include
windows.h to set up the necessary dependencies.  This is a MS
requirement.

Earnie.


To : earnie_boyd at yahoo dot com
Subject : Fwd: _ANONYMOUS_STRUCT
From : Danny Smith <danny_r_smith_2001 at yahoo dot co dot nz>
Date : Sun, 2 Sep 2001 11:46:18 +1000 (EST)

Earnie, this bounced.  You may want to FWD to cygwin-patches.


 --- Danny Smith <danny_r_smith_2001@yahoo.co.nz> wrote: > Date: Sun, 2
Sep 2001 11:35:57 +1000 (EST)
> From: Danny Smith <danny_r_smith_2001@yahoo.co.nz>
> Subject: _ANONYMOUS_STRUCT
> To: cygwin-patches <cygwin-patches@cygwin.com>
> 
>  
>  
> > Sat Sep  1 10:40:37 2001  Christopher Faylor <cgf@cygnus.com>
> >
> > 	* include/winnt.h: Use defined(_ANONYMOUS_STRUCT) to determine if
> > 	anonymous structs are available rather than just testing
> preprocessor
> >	variable directly.
> 
> 
> 
> This doesn't work.  _ANONYMOUS_STRUCT is _always_ defined in
> windows.h.
> 
> windows.h, line 78
> #ifndef _ANONYMOUS_STRUCT
> #define _ANONYMOUS_STRUCT
> 

Danny

http://travel.yahoo.com.au - Yahoo! Travel
- Got Itchy feet? Get inspired!
