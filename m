From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fileutils-4.0-3
Date: Thu, 14 Jun 2001 08:08:00 -0000
Message-id: <20010614170757.A1144@cygbert.vinschen.de>
References: <Pine.GSO.4.21.0106122003330.3791-100000@devmail.dev.tivoli.com> <20010613105845.D1144@cygbert.vinschen.de> <12812308989.20010613152159@logos-m.ru> <20010613153123.K1144@cygbert.vinschen.de> <4385449600.20010614114100@logos-m.ru>
X-SW-Source: 2001-q2/msg00303.html

On Thu, Jun 14, 2001 at 11:41:00AM +0400, egor duda wrote:
> Hi!
> 
> Wednesday, 13 June, 2001 Corinna Vinschen vinschen@redhat.com wrote:
> 
> >> Wednesday, 13 June, 2001 Corinna Vinschen cygwin@cygwin.com wrote:
> >> 
> >> CV> Typically it's the other way around. If a Win32 application opens
> >> CV> a file using the `CreateFile' call, it has exclusive access to the
> >> CV> file while it's opened. If the application want's to share the
> >> CV> file with other apps, it can do that by giving additional flags
> >> CV> to `CreateFile' (FILE_SHARE_READ, FILE_SHARE_WRITE). Cygwin's
> >> CV> open(2) call uses these flags by default.
> >> 
> >> well, CreateFile() accepts 0 as second argument, which is what we
> >> need-- just query information no matter if anyone opened file in
> >> DENYALL mode. i've just tested it on nt4.0 -- it works fine.
> >> 
> >> the only question is whether we should add new parameter to
> >> fhandler::open(), say 'int cygwin_flags', or define new flag in
> >> fcntl.h? for me, the first one looks preferable.
> 
> CV> Wow. I just read the MSDN entry of CreateFile and I must admit
> CV> that I always slipped over that sentence without reading it.
> CV> It seems obvious now. If that really works (as you state),
> CV> it would be the ultimate solution for `fstat'.
> 
> CV> I think you're right using some internal flag. It's not needed
> CV> to create a new fcntl flag.
> 
> patch attached. i was a bit confused to discover, however, that
> stat_worker works somehow without it. AFAICS from stat_worker code,
> if it cannot open file, it still tries to get as much information as
> it can, file size and times included. so, du works for me either with
> or without this patch.

The patch is fine, IMO.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
