From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: storing symlink in extended attribute (on ntfs)
Date: Wed, 30 May 2001 22:27:00 -0000
Message-id: <20010531012740.A21788@redhat.com>
References: <1791875116.20010510172000@logos-m.ru> <12912395994.20010510201521@logos-m.ru> <20010511142639.A26920@redhat.com> <64168820861.20010512154228@logos-m.ru> <178350282529.20010514180653@logos-m.ru> <18289228183.20010524164714@logos-m.ru> <20010529214139.B14906@redhat.com> <13839205033.20010530104808@logos-m.ru> <20010530095435.C17603@redhat.com>
X-SW-Source: 2001-q2/msg00271.html

On Wed, May 30, 2001 at 09:54:35AM -0400, Christopher Faylor wrote:
>Ok.  I have some pending changes to path.cc that I would like to get in
>before you checkin your changes.  I am storing the DriveType and
>volume information in the path_conv class now.  I'll check this in
>as soon as I've had a chance to test it some more.

Ok.  These are checked in.  I made all sorts of changes to propate the
remoteness of the path from path_conv and then it turned out that I'd
misdiagnosed the problem I was fixing and I really didn't need it.

I left the setting in because I suspect that it will still be useful,
though.

So, go ahead and check your stuff in, Egor.

cgf
