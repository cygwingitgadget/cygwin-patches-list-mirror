From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fileutils-4.0-3
Date: Sun, 17 Jun 2001 07:43:00 -0000
Message-id: <20010617104337.B3159@redhat.com>
References: <Pine.GSO.4.21.0106122003330.3791-100000@devmail.dev.tivoli.com> <20010613105845.D1144@cygbert.vinschen.de> <12812308989.20010613152159@logos-m.ru> <20010613153123.K1144@cygbert.vinschen.de> <4385449600.20010614114100@logos-m.ru> <20010614170757.A1144@cygbert.vinschen.de> <20258602010.20010617153433@logos-m.ru>
X-SW-Source: 2001-q2/msg00316.html

On Sun, Jun 17, 2001 at 03:34:33PM +0400, egor duda wrote:
>CV> The patch is fine, IMO.
>
>unfortunately, when file resides on a remote share,
>CreateFile (fname,0,...,OPEN_EXISTING,...) returns valid handle even
>if file doesn't exist! i've seen this on nt4, share is nt4 too. just
>try to 'touch //server/share/non-exiting-file' -- it prints "file
>doesn't exist" instead of creating it.
>
>this patch is supposed to work around it. Can anybody test it in
>w9x/w2k/samba environments?

It actually worked fine with Samba before, at least in my setup.

It still works fine after this patch and the behavior that you mention
above is rectified when accessing shares between two Windows systems.

Ok to check in?

cgf
