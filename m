From: Christopher Faylor <cgf@redhat.com>
To: Cygwin-Patches@Cygwin.Com
Cc: danny_r_smith_2001@yahoo.co.nz
Subject: Re: [Fwd: Fwd: _ANONYMOUS_STRUCT]
Date: Tue, 04 Sep 2001 08:09:00 -0000
Message-id: <20010904110936.D5758@redhat.com>
References: <3B94E80B.C0E046EB@yahoo.com>
X-SW-Source: 2001-q3/msg00101.html

On Tue, Sep 04, 2001 at 10:41:15AM -0400, Earnie Boyd wrote:
>FYI, you cannot include the individual w32api headers.  You must include
>windows.h to set up the necessary dependencies.  This is a MS
>requirement.

I'm not sure I understand what is being said here.

_ANONYMOUS_STRUCT is defined in windows.h.  It is not defined to a non-zero
value, though.  So, what was the previous code:

#if _ANONYMOUS_STRUCT || defined __cplusplus

attempting?  It seems to me that it never would have been activated for C
programs.  That is the problem I was seeing and that is what I was trying
to fix.

I don't remember why this is conditional anyway.  Is this just to accomodate
older compilers?

cgf

>Earnie.
>From: Danny Smith <danny_r_smith_2001@yahoo.co.nz>
>To: earnie_boyd@yahoo.com
>Subject: Fwd: _ANONYMOUS_STRUCT
>Date: Sun, 2 Sep 2001 11:46:18 +1000 (EST)
>
>Earnie, this bounced.  You may want to FWD to cygwin-patches.
>
>
> --- Danny Smith <danny_r_smith_2001@yahoo.co.nz> wrote: > Date: Sun, 2
>Sep 2001 11:35:57 +1000 (EST)
>> From: Danny Smith <danny_r_smith_2001@yahoo.co.nz>
>> Subject: _ANONYMOUS_STRUCT
>> To: cygwin-patches <cygwin-patches@cygwin.com>
>> 
>>  
>>  
>> > Sat Sep  1 10:40:37 2001  Christopher Faylor <cgf@cygnus.com>
>> >
>> > 	* include/winnt.h: Use defined(_ANONYMOUS_STRUCT) to determine if
>> > 	anonymous structs are available rather than just testing
>> preprocessor
>> >	variable directly.
>> 
>> 
>> 
>> This doesn't work.  _ANONYMOUS_STRUCT is _always_ defined in
>> windows.h.
>> 
>> windows.h, line 78
>> #ifndef _ANONYMOUS_STRUCT
>> #define _ANONYMOUS_STRUCT
>> 
>
>Danny
>
> http://travel.yahoo.com.au - Yahoo! Travel
>- Got Itchy feet? Get inspired!


-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
