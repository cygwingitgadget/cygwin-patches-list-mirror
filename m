Return-Path: <cygwin-patches-return-1580-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17576 invoked by alias); 12 Dec 2001 11:48:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17520 invoked from network); 12 Dec 2001 11:48:21 -0000
Message-ID: <04db01c18302$e66cae60$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Jan Nieuwenhuizen" <janneke@gnu.org>
Cc: <cygwin-patches@cygwin.com>
References: <m3bshtmxhb.fsf@appel.lilypond.org><878764062.20011128173421@nyckelpiga.de><m37ks9lgxi.fsf@appel.lilypond.org><4434079433.20011129221637@familiehaase.de><m3oflgy98n.fsf@appel.lilypond.org><9517228633.20011203135833@familiehaase.de><m3lmgkwgeu.fsf@appel.lilypond.org> <3C0D8535.D67735D1@ece.gatech.edu><m33d2pam3l.fsf@appel.lilypond.org><00d501c17d93$1936c990$0200a8c0@lifelesswks><m3zo4x7obb.fsf@appel.lilypond.org><m38zcdssxd.fsf@appel.lilypond.org><01a801c18036$3d447350$0200a8c0@lifelesswks><m3itbhqowz.fsf@appel.lilypond.org><027001c18040$c91651f0$0200a8c0@lifelesswks> <m3wuzth3l1.fsf@appel.lilypond.org>
Subject: Re: experimental texmf packages
Date: Sat, 03 Nov 2001 06:57:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 12 Dec 2001 11:48:19.0926 (UTC) FILETIME=[E50F8F60:01C18302]
X-SW-Source: 2001-q4/txt/msg00112.txt.bz2

----- Original Message -----
From: "Jan Nieuwenhuizen" <janneke@gnu.org>
> > Strange. C strings without \n should be a single line when output,
> > regardless of the in-source
> > formatting. I'll have look at this. (Not that I don't want to fix
the
> > bug, but I want to know the root cause.
>
> That's really simple, see patch.  Somenone added comma's between the
> PS1 definition lines (that maybe indent broke up).

I suspect that that is actually by design.Look at revision 1.2 of
desktop.cc and it has the same ,'s causing separate lines. I don't
really have an opinion on whats right here, but FWIW my prompt always
appears on one line - are you running textmode or tcsh or seomthing
non-default?

> > script.cc and script.h. Put the functions there, they can get
OOPified
> > later.
>
> Ok, done.  Next iteration below.  script.cc still has some cygpath
> calls, but I didn't know how this should be done wrt the windows exec
> call.

Thats ok. We can create a process abstraction later. I'm not too worried
about refactoring incrementally. This part looks ready.

> [From previous msg:]
> > Also postinstall.h won't compile if it's the only include used in a
> > translation unit. (ie include the _absolutely_ required headers to
parse
> > postinstall.h
>
> Hmm, altough it's now called script.h, I don't see the problem; it
> compiles fine here when it's the only header.

Well blow me down. Thats cool.

> Greetings,
> Jan.
>
> 2001-12-09  Jan Nieuwenhuizen  <janneke@gnu.org>
>
> * install.cc: Typo fix.

Please put all changes related to a single file in one place.
ie
 * install.cc:  Typo fix.
   (do_install): Run script...

> * Makefile.in (CFLAGS): Remove -Werror to allow build of w32api
> headers

This will not be accepted. if w32api is broken, revert it to an older
date (cd ../w32api && cvs update -D"foo" is great) or, if you have the
time, fix w32api and submit a patch.

> (realclean): more clean.

*.d is cleaned by the clean target. Why are you adding it here as well?

> * desktop.cc (etc_profile): Remove commas between lines (and thus
> line breaks) from PS1.

See above, I'm not for or against this - I just want to understand _why_
it is breaking for you, and not globally.

> * script.cc (run_script): Replace deprecated remove and move
> calls.
>
> * postinstall.cc (run_script_in_etc_postinstall): New function.
> (do_postinstall): Split off new funtion init_run_script ().
> (init_run_script):
> (run):
> (run_script): Move to script.cc.
>
> * script.h:
> * script.cc: New file.
>
> * Forward port cygwin-20010707.jcn3.patch.
>
> * package_meta.cc (uninstall): Run pre- and postremove scripts.
>
> * install.cc (do_install): Run script initialisation.

All Cool.


Rob
