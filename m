Return-Path: <cygwin-patches-return-1647-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9765 invoked by alias); 3 Jan 2002 09:26:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9740 invoked from network); 3 Jan 2002 09:26:51 -0000
Message-ID: <08d701c19438$cbf8bc80$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Jan Nieuwenhuizen" <janneke@gnu.org>,
	"Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
Cc: <cygwin-patches@cygwin.com>
References: <m3bshtmxhb.fsf@appel.lilypond.org><878764062.20011128173421@nyckelpiga.de><m37ks9lgxi.fsf@appel.lilypond.org><4434079433.20011129221637@familiehaase.de><m3oflgy98n.fsf@appel.lilypond.org><9517228633.20011203135833@familiehaase.de><m3lmgkwgeu.fsf@appel.lilypond.org> <3C0D8535.D67735D1@ece.gatech.edu><m33d2pam3l.fsf@appel.lilypond.org><00d501c17d93$1936c990$0200a8c0@lifelesswks><m3zo4x7obb.fsf@appel.lilypond.org><m38zcdssxd.fsf@appel.lilypond.org><01a801c18036$3d447350$0200a8c0@lifelesswks><m3itbhqowz.fsf@appel.lilypond.org><027001c18040$c91651f0$0200a8c0@lifelesswks><m3wuzth3l1.fsf@appel.lilypond.org><04db01c18302$e66cae60$0200a8c0@lifelesswks><m3667ax540.fsf@appel.lilypond.org><105201c18604$ea001670$0200a8c0@lifelesswks><m366779lms.fsf@appel.lilypond.org> <m3pu4s73f2.fsf@appel.lilypond.org>
Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf packages]
Date: Thu, 03 Jan 2002 01:26:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 03 Jan 2002 09:26:50.0342 (UTC) FILETIME=[C5F65860:01C19438]
X-SW-Source: 2002-q1/txt/msg00004.txt.bz2

Right.  I completley naffed my sandbox with Gary's work in it :[.

Gary... can I please have that missing bit of the changelog?

Jan, I'll get your patch in straight after I commit Gary's.

Rob
===
----- Original Message -----
From: "Jan Nieuwenhuizen" <janneke@gnu.org>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: <cygwin-patches@cygwin.com>
Sent: Thursday, January 03, 2002 10:12 AM
Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf
packages]


> Hi,
>
> There was a complaint about installing experimental texmf: if, after
> selecting texmf, you set an essential package for running postinstall
> to `remove' (in the case of texmf, remove sed, eg), there's no warning
> that the postinstall fails, and thus the installation was not
> completed.
>
> I wanted to look into this, and then found the remove scripts patch
> wasn't yet in cvs, nor did I see further discussion.  What happened?
>
> Greetings,
>
> Jan.
>
> > > I'm accepting this patch as is given your disclaimer above so
don't
> > > worry about another round circuit.
> > >
> > > I'll apply it within the next 24 hours.
> >
> > Thanks, all very well.
>
> --
> Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music
typesetter
> http://www.xs4all.nl/~jantien       | http://www.lilypond.org
>
>
