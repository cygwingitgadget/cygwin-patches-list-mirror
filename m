From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: st_blocks incorrect for files larger than 2Gbytes
Date: Wed, 26 Jul 2000 10:58:00 -0000
Message-id: <20000726135822.J7599@cygnus.com>
References: <200007261344.JAA17559@envy.delorie.com> <14788.000726@logos-m.ru> <20000726135017.G7599@cygnus.com>
X-SW-Source: 2000-q3/msg00033.html

On Wed, Jul 26, 2000 at 01:50:17PM -0400, Chris Faylor wrote:
>On Wed, Jul 26, 2000 at 06:56:07PM +0400, Egor Duda wrote:
>>Wednesday, 26 July, 2000 DJ Delorie dj@delorie.com wrote:
>>
>>>>   buf->st_blocks = (buf->st_size + S_BLKSIZE-1) / S_BLKSIZE;
>>>>
>>>> which way is preferable?
>>
>>DD>Casting  buf->st_size  to (unsigned long) before doing the math is.
>>DD>off_t is signed, but negative sizes are meaningless.
>>
>>Wed Jul 26 14:32:38 2000  Egor Duda <deo@logos-m.ru>
>>
>>        * syscalls.cc: Make stat return correct st_blocks for files
>>          with size bigger than 2Gb and less than 4Gb

Btw, I applied this patch.

cgf
