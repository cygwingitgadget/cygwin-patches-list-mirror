Return-Path: <cygwin-patches-return-1569-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24404 invoked by alias); 8 Dec 2001 23:33:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24389 invoked from network); 8 Dec 2001 23:33:43 -0000
Message-ID: <027001c18040$c91651f0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Jan Nieuwenhuizen" <janneke@gnu.org>
Cc: <cygwin-patches@cygwin.com>
References: <m3bshtmxhb.fsf@appel.lilypond.org><878764062.20011128173421@nyckelpiga.de><m37ks9lgxi.fsf@appel.lilypond.org><4434079433.20011129221637@familiehaase.de><m3oflgy98n.fsf@appel.lilypond.org><9517228633.20011203135833@familiehaase.de><m3lmgkwgeu.fsf@appel.lilypond.org> <3C0D8535.D67735D1@ece.gatech.edu><m33d2pam3l.fsf@appel.lilypond.org><00d501c17d93$1936c990$0200a8c0@lifelesswks><m3zo4x7obb.fsf@appel.lilypond.org><m38zcdssxd.fsf@appel.lilypond.org><01a801c18036$3d447350$0200a8c0@lifelesswks> <m3itbhqowz.fsf@appel.lilypond.org>
Subject: Re: experimental texmf packages
Date: Fri, 02 Nov 2001 13:58:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 08 Dec 2001 23:33:42.0037 (UTC) FILETIME=[C55A3450:01C18040]
X-SW-Source: 2001-q4/txt/msg00101.txt.bz2

----- Original Message -----
From: "Jan Nieuwenhuizen" <janneke@gnu.org>


> > > * Makefile.in (CFLAGS): Remove -Werror to allow build.
> >
> > The Werror is in by design. If your patch won't build with it, I
won't
> > accept you patch.
>
> Ah, good.  But it was not for my patch!  The latest cvs setup.exe
> won't build without it, in my environment.  I get warnings (-> errors)
> like:
>

Ok, those look like updated w32api stuff that needs prototypes added. I
had to do that the first time I added -Werror as well. (Hint, Hint) It'd
be great if patches added to core things like w32api were checked with
all -Werror and all warnings on before being committed.

> > > * configure.in (LIB_AC_PROG_CXX): Bugfix for CXXFLAGS override.
> >
> > What's wrong with the current method?
>
> At some point, it feeds $(CXXFLAGS) to the shell, which complains that
> CXXFLAGS is not a command.

Doesn't for me. Can you find where? (Make should be doing the
replacement).

> > > * desktop.cc (etc_profile): Remove line breaks and spaces from
PS1.
> >
> > The line is now > 80 chars, and indent will break it up again. Is
there
> > some reason for this change?
>
> Ah, that's how this bug got in, probably.  You may not notice it
> because your /etc/profile won't be overwritten, or you have your own
> PS1, but the default prompt from unpatched install looks like this:
...

Strange. C strings without \n should be a single line when output,
regardless of the in-source
formatting. I'll have look at this. (Not that I don't want to fix the
bug, but I want to know the root cause.

> > > * package_meta.cc (try_run_script): New function.
> >
> > This doesn't belong here. It's nothing to do with the package, but
with
> > interfacing with the shell/scripts. Also (this one is
minor/optional),
> > cygpath and _access are deprecated - foo = io_stream::open (concat
> > ("cygfile://", dir, fname, 0), "rb") followed by run_script (foo)
would
> > be the more OO approach here.
> >
> > In the future I think we'll want a script or shell class to
encapsulate
> > all of this.
>
> Ok.  In short: I tried to update the patch with a minimal amount of
> extra/moved code.  The comments suggest that pkg managent is still in
> flux.  I can fix the file exists check, but where do you want the
> function to go?

pkg management is very much in flux. There is a lot to do :]. I'm simply
trying to make each step robust and self contained. Lets make a new
script.cc and script.h. Put the functions there, they can get OOPified
later.

> Btw: is someone working on conflicts: or more versatile requires:?  I
> may want to have a look at adding versioned and/or alternative
> requires.  It would be easiest to change the syntax to something like:
>

> It's a quite small patch, if the functionality is ok, I guess I/we can
> fix these details?

Please do. Conflicts is on the wishlist, but not actively being
developed right now.
The reason for that issue is that we need a pop-up screen, perferrably a
sublist from the chooser of _all_ the affected packages. (Consider a
conflict with ash, everything that depends on ash needs to be shown as
getting uninstalled). And that popup needs a
backout-without-altering-what-I-had option to allow folk to undo a
mistaken click easily. And that needs me to finish the rationalisation
and multi-instance work I'm doing on the package chooser.

You're welcome to submit a patch that parses the conflict list though.
Also needed is a Provides: clause (ash provides sh, bash provides sh,
tcsh provide sh).
Likewise, for now just adding the parsing capability is a good start.

Requires should also be able to require by version - ie
requires: foo
requires: foo > _opaque_-1
requires: foo = _opaque_-1
requires: foo >= _opaque_-1
should all be valid.

I don't think we need < in the requires clause. That is implemented by a
conflicts > clause.

Rob
