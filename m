From: Christopher Faylor <cgf@redhat.com>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog autoload.cc autolo ...
Date: Thu, 03 May 2001 08:04:00 -0000
Message-id: <20010503110333.A4579@redhat.com>
References: <20010503093508.13491.qmail@sourceware.cygnus.com> <132246850181.20010503140017@logos-m.ru> <20010503130608.B24200@cygbert.vinschen.de> <20010503131328.C24200@cygbert.vinschen.de> <9258490099.20010503171417@logos-m.ru>
X-SW-Source: 2001-q2/msg00181.html

On Thu, May 03, 2001 at 05:14:17PM +0400, egor duda wrote:
>Hi!
>
>Thursday, 03 May, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:
>
>CV> Couldn't you use an instance of fhandler_dev_random?
>
>ok, here it goes.
>
>2001-05-03  Egor Duda  <deo@logos-m.ru>
>
>        * fhandler_socket.cc (set_connect_secret): Use /dev/random to
>        generate secret cookie.

What happens to the buf that you allocate here?  It looks like a memory
leak.

cgf
