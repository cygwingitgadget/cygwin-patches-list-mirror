Return-Path: <cygwin-patches-return-1614-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24462 invoked by alias); 20 Dec 2001 12:08:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24448 invoked from network); 20 Dec 2001 12:08:40 -0000
Message-ID: <01db01c1894e$fc9370a0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	<cygwin-patches@sourceware.cygnus.com>
References: <NCBBIHCHBLCMLBLOBONKIEAFCIAA.g.r.vansickle@worldnet.att.net>
Subject: Re: [PATCH] Update 2 - Setup.exe property sheet patch
Date: Thu, 08 Nov 2001 06:27:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 20 Dec 2001 12:08:38.0924 (UTC) FILETIME=[0EF1E4C0:01C1894F]
X-SW-Source: 2001-q4/txt/msg00146.txt.bz2

Last time around hopefully!

1) format your changelog with line wrap at 80 columns.
2) It's a changelog, so if you #if 0 and then remove a function during
your local testing, the final change is actually just a remove.
Likewise, chooser.[cc|h] should not be mentioned because it never exists
(from CVS's viewpoint).
3) You've _Still_ got blank lines in the log.
4) You've got multiple log entries - this is going in as a single
commit, so thats inappropriate (IMO, open to discussion).

In a nutshell: This is a Changelog from CVS 'NOW' to CVS 'after the
commit'.
The acid test I recommed you perform is to walk through the .diff with
the changelog
open beside you. Make sure all changes are listed, and you also get to
do a code walkthrough for free.

5) (Blame me) Remove the change to link against comctl32 - thats in CVS
now (I've checked in my working dir as I recently got stable again the
chooser). (Which, IMO is starting to 'get there'.)

It's not a historical set of notes that you've gone through in your
sandbox but rather an explanation of the desired effect of the change
getting committed.

Don't worry about sending updated source, I just need the ChangeLog and
it'll all get committed.

Rob

===
----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Sent: Thursday, December 20, 2001 5:19 PM
Subject: [PATCH] Update 2 - Setup.exe property sheet patch


> Changes as per your (Rob) last email, plus a few other improvements.
Diff, new
> files, and ChangeLog attached.
>
> --
> Gary R. Van Sickle
> Brewer.  Patriot.
>
