Return-Path: <cygwin-patches-return-1568-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2853 invoked by alias); 8 Dec 2001 22:18:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2822 invoked from network); 8 Dec 2001 22:18:14 -0000
Message-ID: <01a801c18036$3d447350$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Jan Nieuwenhuizen" <janneke@gnu.org>
Cc: <cygwin-apps@cygwin.com>,
	<cygwin-patches@cygwin.com>
References: <m3bshtmxhb.fsf@appel.lilypond.org><878764062.20011128173421@nyckelpiga.de><m37ks9lgxi.fsf@appel.lilypond.org><4434079433.20011129221637@familiehaase.de><m3oflgy98n.fsf@appel.lilypond.org><9517228633.20011203135833@familiehaase.de><m3lmgkwgeu.fsf@appel.lilypond.org> <3C0D8535.D67735D1@ece.gatech.edu><m33d2pam3l.fsf@appel.lilypond.org><00d501c17d93$1936c990$0200a8c0@lifelesswks><m3zo4x7obb.fsf@appel.lilypond.org> <m38zcdssxd.fsf@appel.lilypond.org>
Subject: Re: experimental texmf packages
Date: Fri, 02 Nov 2001 13:54:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 08 Dec 2001 22:18:12.0579 (UTC) FILETIME=[3995C330:01C18036]
X-SW-Source: 2001-q4/txt/msg00100.txt.bz2

Follow to cygwin-patches please.

Thanks for freshening this up. There's still a little more to do, but it
looks good nonetheless.

Rob

----- Original Message -----
From: "Jan Nieuwenhuizen" <janneke@gnu.org>
> Jan Nieuwenhuizen <janneke@gnu.org> writes:
>
> > > BTW: can you freshed up your postremove patch? I'd like that to be
> > > included in setup.
> >
> > Yes, will do.

Thank you. A few nits:

> cygwin-installer-20011208.ChangeLog
> 2001-12-08  Jan Nieuwenhuizen  <janneke@gnu.org>
>
> * Makefile.in (CFLAGS): Remove -Werror to allow build.

The Werror is in by design. If your patch won't build with it, I won't
accept you patch.

> (realclean): more clean.
>
> * configure.in (LIB_AC_PROG_CXX): Bugfix for CXXFLAGS override.

What's wrong with the current method?

> * desktop.cc (etc_profile): Remove line breaks and spaces from PS1.

The line is now > 80 chars, and indent will break it up again. Is there
some reason for this change?

> * Forward port cygwin-20010707.jcn3.patch.
>
> * postinstall.cc (do_postinstall): Split off:
> (init_run_script): New function.
> (run_script_in_etc_postinstall): New function.
>
> * package_meta.cc (try_run_script): New function.

This doesn't belong here. It's nothing to do with the package, but with
interfacing with the shell/scripts. Also (this one is minor/optional),
cygpath and _access are deprecated - foo = io_stream::open (concat
("cygfile://", dir, fname, 0), "rb") followed by run_script (foo) would
be the more OO approach here.

In the future I think we'll want a script or shell class to encapsulate
all of this.

> (uninstall): Run pre- and postremove scripts.


> * install.cc (do_install): Run script initialisation.

You're missing postinstall.h in your changelog.
Also postinstall.h won't compile if it's the only include used in a
translation unit. (ie include the _absolutely_ required headers to parse
postinstall.h

Thanks
