From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sources.redhat.com
Subject: Re: Set argv[0] in the win32 style for non-Cygwin applications.
Date: Wed, 27 Sep 2000 09:48:00 -0000
Message-id: <20000927124720.E8818@cygnus.com>
References: <s1sog1chnr4.fsf@jaist.ac.jp> <20000925112318.A9745@cygnus.com> <s1sg0mmgduk.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00102.html

On Wed, Sep 27, 2000 at 10:32:19PM +0900, Kazuhiro Fujieda wrote:
>>>> On Mon, 25 Sep 2000 11:23:19 -0400
>>>> Chris Faylor <cgf@cygnus.com> said:
>
>> This is a good idea (and I think the code used to do this) but it should
>> probably just always force the first argument into Windows format.  A cygwin
>> app will always use the argv array and a non-cygwin app will always use the
>> argument list, so...
>
>I misunderstood how the iscygexec method works. I believed it
>should examine whether a file is a cygwin app. I expected too
>much of it without reading the code. It isn't so easy.

It could do that but I don't think there would be any gain since it would imply
a lot of disk I/O.

A file is currently considered to be a "cygwin executable" (iscygexec is
true) if it comes from a directory mounted with a "-X" option.  In this
case spawn_guts will only prepare a UNIX-style argv and environ list for
the execed process.  Otherwise it will produce both a Windows command
and environment list and a UNIX style.

cgf
