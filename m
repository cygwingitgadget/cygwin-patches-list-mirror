From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_console
Date: Wed, 28 Feb 2001 09:26:00 -0000
Message-id: <20010228182620.R8464@cygbert.vinschen.de>
References: <16286062992.20010216183758@logos-m.ru> <20010219214951.A23483@redhat.com> <7888578378.20010220130012@logos-m.ru> <17613156858.20010223151715@logos-m.ru> <20010226191432.E6209@redhat.com>
X-SW-Source: 2001-q1/msg00128.html

On Mon, Feb 26, 2001 at 07:14:32PM -0500, Christopher Faylor wrote:
> On Fri, Feb 23, 2001 at 03:17:15PM +0300, Egor Duda wrote:
> >i've   moved   console  state variables inside fhandler_console class.
> >this is a combined patch (with raw keyboard mode patch i sent sometime
> >ago). it adds 4 new rendition commands (\033[24;27;39;49m), compatible
> >with  linux console and already described in Chuck's terminfo file for
> >cygwin, and emulate "blink" attribute with bright background.
> 
> Wow, you've done a lot of work here.  It all looks fine.  Please check it
> in.
> 
> Thanks for your incredible effort.  It is much appreciated.  IMO, it makes
> things much more structured in the console code.

Egor,

your patch seems to have some problems on the local console window
at least on W2K.

When I open a console window with

tcsh, CYGWIN=tty: Only the first line is used at all. The background
                  color of the prompt is correct, behind the cursor
		  it's inverted.

bash, CYGWIN=tty: The first line is inverted, no cursor, no interaction.

tcsh, CYGWIN=notty: Crash, ia message box tells me that an instruction
                    at address x61061d48 points to 0x00000068.

bash, CYGWIN=notty: Same behaviour as tcsh with CYGWIN=tty, really!

When I revert the patch to fhandler_console.cc, everything is ok.

Corinna

> 
> cgf

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
