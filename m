From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_console
Date: Mon, 26 Feb 2001 16:15:00 -0000
Message-id: <20010226191432.E6209@redhat.com>
References: <16286062992.20010216183758@logos-m.ru> <20010219214951.A23483@redhat.com> <7888578378.20010220130012@logos-m.ru> <17613156858.20010223151715@logos-m.ru>
X-SW-Source: 2001-q1/msg00118.html

On Fri, Feb 23, 2001 at 03:17:15PM +0300, Egor Duda wrote:
>i've   moved   console  state variables inside fhandler_console class.
>this is a combined patch (with raw keyboard mode patch i sent sometime
>ago). it adds 4 new rendition commands (\033[24;27;39;49m), compatible
>with  linux console and already described in Chuck's terminfo file for
>cygwin, and emulate "blink" attribute with bright background.

Wow, you've done a lot of work here.  It all looks fine.  Please check it
in.

Thanks for your incredible effort.  It is much appreciated.  IMO, it makes
things much more structured in the console code.

cgf
