Return-Path: <cygwin-patches-return-1632-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25236 invoked by alias); 28 Dec 2001 11:08:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25222 invoked from network); 28 Dec 2001 11:08:44 -0000
Message-ID: <069b01c18f90$0a195720$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	<cygwin-patches@sourceware.cygnus.com>
References: <NCBBIHCHBLCMLBLOBONKKEBICIAA.g.r.vansickle@worldnet.att.net>
Subject: Re: [PATCH] Setup.exe "other URL" functionality
Date: Fri, 09 Nov 2001 04:03:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 28 Dec 2001 11:08:43.0826 (UTC) FILETIME=[03677920:01C18F90]
X-SW-Source: 2001-q4/txt/msg00164.txt.bz2

Gary, can I ask that you do not bz2 your diffs, unless there is real
need for it?

It makes having a quick look at them much harder...

Rob
===
----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Sent: Friday, December 28, 2001 10:05 PM
Subject: [PATCH] Setup.exe "other URL" functionality


> Here's a patch that makes the "Other URL" functionality work.  I've
merged the
> IDD_SITE and IDD_OTHER_URL boxes into one, which seems more intuitive
(and yes,
> that list box is getting pretty stubby, it's on the proverbial plate).
>
> I also removed "test -f ./.bashrc && . ./.bashrc" from the generated
> /etc/profile.  Bash sources this automatically after it reads
/etc/profile, so
> all it was accomplishing with bash as your shell was to run .bashrc
twice, which
> I doubt was ever the intent, and I have to guess that users of other
shells
> don't really want to be running a ._bash_rc file.
>
> Note that I've attached two patches here.  The contents are the same,
but due to
> some wackiness in either "cvs diff" or indent (lemme make a WAG, sit
down for
> this one: CRLF probs? ;-)), the larger one (-pu'ed) ends up replacing
the entire
> contents of several files, while the smaller one (-pub'd) is rather
less
> agressive.
>
> Take your pick, it's Gair's Bimonthly 2-for-1 Sale!  Every diff must
go! ;-)
>
> --
> Gary R. Van Sickle
> Brewer.  Patriot.
>
