From: Christopher Faylor <cgf@redhat.com>
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Subject: Re: setlogmask() patch
Date: Mon, 22 Jan 2001 07:34:00 -0000
Message-id: <20010122103427.A30981@redhat.com>
References: <20010121225155.A1272@dothill.com>
X-SW-Source: 2001-q1/msg00036.html

Applied. Thanks.

cgf

On Sun, Jan 21, 2001 at 10:51:56PM -0500, Jason Tishler wrote:
>See attach for (trivial) patch and ChangeLog entry to add back
>setlogmask() to Cygwin.  Note that I followed the other syslog exports
>and exported setlogmask() as _setlogmask() too.  I don't know if this
>was correct.
>
>To apply the patch, use the following:
>
>    $ cd src/winsup/cygwin
>    $ # save attached patch to /tmp
>    $ patch </tmp/setlogmask.patch
