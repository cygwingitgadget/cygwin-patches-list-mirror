From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: close-on-exec handles are left open by exec parent
Date: Sat, 04 Aug 2001 11:47:00 -0000
Message-id: <20010804144655.A3121@redhat.com>
References: <71194343130.20010802183838@logos-m.ru> <20010803113109.D26623@redhat.com> <34115428587.20010804205546@logos-m.ru> <47119421729.20010804220219@logos-m.ru>
X-SW-Source: 2001-q3/msg00050.html

On Sat, Aug 04, 2001 at 10:02:19PM +0400, egor duda wrote:
>Hi!
>
>Saturday, 04 August, 2001 egor duda deo@logos-m.ru wrote:
>
>ed> without synchronization i got all kinds of strange lockups and
>ed> crashes, which disappear when synchronization is added. i didn't
>ed> investigate those crashes, but they probably do need some closer
>ed> investigation. i'll try to look at them.
>
>well, i think i've found a reason for at least one of them. the fix
>looks almost obvious. ok to apply?

Hah!  Yes.  Please apply it.

cgf
