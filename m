From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: Add some defines in winnt.h.
Date: Wed, 14 Jun 2000 13:36:00 -0000
Message-id: <20000614163549.A8265@cygnus.com>
References: <s1saegpq9xb.fsf@jaist.ac.jp>
X-SW-Source: 2000-q2/msg00100.html

Since Mumit isn't around, I've taken the liberty of approving this patch.
It looks fine to me.

This is conditional on Mumit's approval when he returns, of course.

cgf

On Wed, Jun 14, 2000 at 11:21:52AM +0900, Kazuhiro Fujieda wrote:
>ChangeLog:
>	winnt.h: Add some missing defines related to locale identifiers.
>	Translate values of LANG_* and SUBLANG_* into hexadecimal codes
>	so that I can easily check these values with my eyes.
>
>Index: winnt.h
>===================================================================
>RCS file: /cvs/src/src/winsup/w32api/include/winnt.h,v
>retrieving revision 1.6
>diff -u -p -r1.6 winnt.h
