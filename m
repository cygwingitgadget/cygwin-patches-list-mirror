Return-Path: <cygwin-patches-return-1655-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20577 invoked by alias); 3 Jan 2002 12:14:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20563 invoked from network); 3 Jan 2002 12:14:41 -0000
X-Draft-From: ("nnmh:indoos" 6812)
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
	<m366779lms.fsf@appel.lilypond.org>
	<m3pu4s73f2.fsf@appel.lilypond.org>
	<097401c1944b$de1aa230$0200a8c0@lifelesswks>
Organization: Jan at Appel
From: Jan Nieuwenhuizen <janneke@gnu.org>
Date: Thu, 03 Jan 2002 04:14:00 -0000
In-Reply-To: <097401c1944b$de1aa230$0200a8c0@lifelesswks> ("Robert Collins"'s message of "Thu, 3 Jan 2002 22:43:29 +1100")
Message-ID: <m3ell7pr6b.fsf@appel.lilypond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q1/txt/msg00012.txt.bz2

"Robert Collins" <robert.collins@itdomain.com.au> writes:

> Right, this is now in CVS> Sorry about the muckup.

Ok, thanks, it's there.

How should errors in postinstall scripts be handled?  It is tempting
to replace

    postinstall.cc:
    find (cygpath ("/etc/postinstall", 0), run_script_in_etc_postinstall);

with something vaguely like

   for (size_t n = 1; n <= db.packages.number (); n++)
     if (try_run_script ("/etc/postinstall/", name))
       warning ("postinstall of %s failed"
                "please examine or rerun /etc/postinstall/%s.sh manually",
                name, name));

But, afaik, there's no need for a package's postinstall script to be
called '<pkg->name>.sh'?  Should/can we enforce something like this?

Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
