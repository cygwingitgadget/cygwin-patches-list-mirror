From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: st_blocks incorrect for files larger than 2Gbytes
Date: Wed, 26 Jul 2000 10:51:00 -0000
Message-id: <20000726135017.G7599@cygnus.com>
References: <200007261344.JAA17559@envy.delorie.com> <14788.000726@logos-m.ru>
X-SW-Source: 2000-q3/msg00032.html

On Wed, Jul 26, 2000 at 06:56:07PM +0400, Egor Duda wrote:
>Wednesday, 26 July, 2000 DJ Delorie dj@delorie.com wrote:
>
>>>   buf->st_blocks = (buf->st_size + S_BLKSIZE-1) / S_BLKSIZE;
>>>
>>> which way is preferable?
>
>DD>Casting  buf->st_size  to (unsigned long) before doing the math is.
>DD>off_t is signed, but negative sizes are meaningless.
>
>Wed Jul 26 14:32:38 2000  Egor Duda <deo@logos-m.ru>
>
>        * syscalls.cc: Make stat return correct st_blocks for files
>          with size bigger than 2Gb and less than 4Gb
>DD> However, this topic belongs on the newlib list, not the cygwin list.
>
>i  see.  making stat to support files bigger than 4 gigs (maximum file
>size    in    win32  is 2^64) requires to make changes in newlib. i've
>cc'ed  my previous message to newlib mailing list. but for now i think
>it's ok to patch cygwin.

It sounds like we'd have to change the stat structure to accomplish this
so I'm not sure that we want to do this right now.

I guess we could do what some versions of UNIX do and set up a 'statx'
field with larger fields and then define that to 'stat' so that all
new programs use statx and older functions still use the old stat.

cgf
