From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: CYGWIN=codepage:oem read() patch
Date: Wed, 03 Jan 2001 06:46:00 -0000
Message-id: <20010103094557.A32356@redhat.com>
References: <200101020118.CAA12604@post.webmailer.de> <1944110760.20010103104846@logos-m.ru>
X-SW-Source: 2001-q1/msg00001.html

On Wed, Jan 03, 2001 at 10:48:46AM +0300, Egor Duda wrote:
>Hi!
>
>Tuesday, 02 January, 2001 lw@computerwuerfel.de lw@computerwuerfel.de wrote:
>
>lcd> The display is ok now, but when you getchar() resp. read() special characters
>lcd> from the console, you get false results.
>
>lcd> In winsup/cygwin/fhandler_console.cc, function fhandler_console::read,
>every character >> 127 is translated to ansi codepage.
>
>hmm. this is strange, but my patch did contain the following
>
>( http://cygwin.com/ml/cygwin-patches/2000-q4/msg00025/oem-cp-support.diff )

Sorry about that.  I guess this is probably a consequence of two people working
on the same section of code.  I've checked in a fix.

cgf

>***************
>*** 222,226 ****
>          /* Need this check since US code page seems to have a bug when
>             converting a CTRL-U. */
>!         if ((unsigned char)ich > 0x7f)
>            OemToCharBuff (tmp + 1, tmp + 1, 1);
>          if (!(input_rec.Event.KeyEvent.dwControlKeyState & LEFT_ALT_PRESSED))
>--- 222,226 ----
>          /* Need this check since US code page seems to have a bug when
>             converting a CTRL-U. */
>!         if ((unsigned char)ich > 0x7f && current_codepage == ansi_cp)
>            OemToCharBuff (tmp + 1, tmp + 1, 1);
>          if (!(input_rec.Event.KeyEvent.dwControlKeyState & LEFT_ALT_PRESSED))
>
>
>perhaps something gone wrong when applying this patch?
>
>Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
>

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
