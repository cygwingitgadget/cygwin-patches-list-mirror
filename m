Return-Path: <cygwin-patches-return-1591-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24104 invoked by alias); 16 Dec 2001 06:43:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24090 invoked from network); 16 Dec 2001 06:43:43 -0000
Message-ID: <0f9101c185fd$05e09930$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
References: <m3zo4x7obb.fsf@appel.lilypond.org> <m38zcdssxd.fsf@appel.lilypond.org> <01a801c18036$3d447350$0200a8c0@lifelesswks> <m3itbhqowz.fsf@appel.lilypond.org> <027001c18040$c91651f0$0200a8c0@lifelesswks> <m3wuzth3l1.fsf@appel.lilypond.org> <04db01c18302$e66cae60$0200a8c0@lifelesswks> <m3667ax540.fsf@appel.lilypond.org> <20011213215355.GA20040@redhat.com> <3C19F354.1E85323C@yahoo.com> <20011214161713.P740@cygbert.vinschen.de>
Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf packages]
Date: Mon, 05 Nov 2001 06:41:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 16 Dec 2001 06:43:42.0095 (UTC) FILETIME=[0046E1F0:01C185FD]
X-SW-Source: 2001-q4/txt/msg00123.txt.bz2


===
----- Original Message -----
From: "Corinna Vinschen" <cygwin-patches@cygwin.com>


> Agree.  I'm still for giving a nice PS1 by default (aka not '$ ')
> but it should get simplified so that it works for all bourne shell
> clones.

Sure. I suggest that a package gets created, and that bash, ash et al
depend on it that has a default prompt, and any other miscellaneous
things. Setup.exe will not overwrite /etc/profile if it exists at the
end of the package extraction and postinstall execution, so simply
having a package with
"/etc/profile.default" and a postinstall script that copies
profile.default to profile IFF profile is missing is very easy and
doesn't require setup.exe changes.

> In general a question raises (again, perhaps?):  Shouldn't we provide
> a default /etc/csh.login file as well?  At least as part of the tcsh
> package?

Yes.

Rob
