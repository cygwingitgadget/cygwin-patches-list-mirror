Return-Path: <cygwin-patches-return-1635-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13286 invoked by alias); 28 Dec 2001 12:22:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13272 invoked from network); 28 Dec 2001 12:22:51 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] Setup.exe "other URL" functionality
Date: Fri, 09 Nov 2001 04:31:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKGEBKCIAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <06d901c18f92$6209ef60$0200a8c0@lifelesswks>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-SW-Source: 2001-q4/txt/msg00167.txt.bz2

> Thanks. BTW: If you can identify what made that huge patch (my money is
> on indent 2.2.7 inserting ^M's)'s that would be handy.
>
> Rob

It's highly bizarre, but AFAICT it's not indent but rather something wrong with
"cvs diff".  Here's my investigation so far, I'm on all text mounts:

Experiment 1:
- mv my altered, indented "window.h" to "window.h.temp".  A hex editor shows it
to have the correct CRLF line endings (i.e. no extra CRs or something like
that).
- do a clean checkout of cvs's window.h.  The file on my system also shows
correct CRLF line ends.
- A "cvs diff" on the clean, just-checked-out source shows no differences.
- Do a "diff window.h window.h.temp" (not "cvs diff").  Shows only the actual
changes, not the entire file as being different.
- Replace the unaltered "window.h" with my "window.h.temp", and the "cvs
diff -pu" shows every line of the file to be different.
- Run "d2u" on my local "window.h", which is now the altered one.  "cvs
diff -pu" *still* shows every line to be different!  (so does a plain "cvs
diff", no -pu).

Experiment 2:
- Take a clean window.h, mv it to a new name, indent.
- Recheck out a clean window.h.
- Both show the same valid CRLF line endings.
- "cvs diff", every line is different.  "diff", nothing is different (even
though two lines are in fact indented differently - I thought you had to
"diff -b" to ignore WS changes?).

So I guess I'm out of WAGes now, unless cvs is tracking the file-moving and
claiming that a file with, say, the same contents but a different creation date
or something is completely different, regardless of contents.  But I don't think
that would explain the initial problem because I never moved any files.

--
Gary R. Van Sickle
Brewer.  Patriot.
