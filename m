From: Christopher Faylor <cgf@redhat.com>
To: cygwin-xfree@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: pthread
Date: Mon, 16 Apr 2001 08:20:00 -0000
Message-id: <20010416112045.D15438@redhat.com>
References: <7F2B9185F0196F44B59990759B91B1C23C35BA@ins-exch.inspirepharm.com> <00b701c0c665$49c99c80$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00076.html

On Mon, Apr 16, 2001 at 09:06:27PM +1000, Robert Collins wrote:
>Hi Suhaib,
>    here are the two missing functions. If you aren't setup to compile
>cygwin1.dll let me know and I'll mail you mine.

You seem to be adding a mutex that is supplanting the passwd_sem variable.
Shouldn't passwd_sem be eliminated if you are adding this?

cgf
>===
>Mon Apr 16 21:02:00 2001  Robert Collins <rbtcollins@hotmail.com>
>
> * cygwin.din: Export New functions.
> * passwd.cc (read_etc_passwd): Make race safe.
> (getpwuid_r): New function.
> (getpwnam_r): New function.
>
>===
