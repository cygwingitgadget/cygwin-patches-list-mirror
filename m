Return-Path: <cygwin-patches-return-1953-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5228 invoked by alias); 7 Mar 2002 00:53:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5192 invoked from network); 7 Mar 2002 00:53:26 -0000
Message-ID: <001101c1c572$ce00d830$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
References: <012301c1c570$8af537e0$0100a8c0@advent02> <20020307004423.GA24387@redhat.com>
Subject: Re: Patch for cd .../. bug
Date: Wed, 06 Mar 2002 17:19:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00310.txt.bz2

> >This patch fixes the bug that allows cd .../. to succeed.
>
> This isn't a bug.  It's how Windows works.
It breaks. Try it. You get dumped in a non-existent directory. Windows
ignores runs of dots. Unix treats them as non-existent files. At present
Cygwin has a mixture of both (treat last component as non-existent file,
ignore other components). IMO, this inconsistency is a bug. You shouldn't be
able to chdir() into an invalid directory (as you can at present). The path
is accepted by chdir() but the new posix path is rejected by other Cygwin
file routines so you are left in an inconsistent state.

Chris

