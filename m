Return-Path: <cygwin-patches-return-1595-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28593 invoked by alias); 16 Dec 2001 16:26:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28579 invoked from network); 16 Dec 2001 16:26:44 -0000
X-Draft-From: ("nnmh:indoos.cygwin-patches" 24)
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf packages]
References: <m3bshtmxhb.fsf@appel.lilypond.org>
	<878764062.20011128173421@nyckelpiga.de>
	<m37ks9lgxi.fsf@appel.lilypond.org>
	<4434079433.20011129221637@familiehaase.de>
	<m3oflgy98n.fsf@appel.lilypond.org>
	<9517228633.20011203135833@familiehaase.de>
	<m3lmgkwgeu.fsf@appel.lilypond.org> <3C0D8535.D67735D1@ece.gatech.edu>
	<m33d2pam3l.fsf@appel.lilypond.org>
	<00d501c17d93$1936c990$0200a8c0@lifelesswks>
	<m3zo4x7obb.fsf@appel.lilypond.org>
	<m38zcdssxd.fsf@appel.lilypond.org>
	<01a801c18036$3d447350$0200a8c0@lifelesswks>
	<m3itbhqowz.fsf@appel.lilypond.org>
	<027001c18040$c91651f0$0200a8c0@lifelesswks>
	<m3wuzth3l1.fsf@appel.lilypond.org>
	<04db01c18302$e66cae60$0200a8c0@lifelesswks>
	<m3667ax540.fsf@appel.lilypond.org>
	<105201c18604$ea001670$0200a8c0@lifelesswks>
Organization: Jan at Appel
From: Jan Nieuwenhuizen <janneke@gnu.org>
Date: Tue, 06 Nov 2001 05:42:00 -0000
In-Reply-To: <105201c18604$ea001670$0200a8c0@lifelesswks> ("Robert Collins"'s message of "Sun, 16 Dec 2001 18:40:19 +1100")
Message-ID: <m366779lms.fsf@appel.lilypond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2001-q4/txt/msg00127.txt.bz2

"Robert Collins" <robert.collins@itdomain.com.au> writes:

> > Ok.  I like having just a one-line prompt.
> 
> See my other emails. Lets leave this to the side, it's orthogonal to the
> remove script work you've done.

Yes, fine.

> Right. Well setup compiled before w32api got broken. I've said it twice
> now: revert your w32api (which is what's broken) and setup will build
> cleanly.

Yes, I understand your view/wishes and will comply.  I was just
explaining why I did this.

> > * install.cc (do_install): Run script initialisation.  Typo fix.
> 
> This is still wrong :}.

Ok, noted, thanks.

> I'm accepting this patch as is given your disclaimer above so don't
> worry about another round circuit.
> 
> I'll apply it within the next 24 hours.

Thanks, all very well.

Greetings,
Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
