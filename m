Return-Path: <cygwin-patches-return-1644-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25250 invoked by alias); 2 Jan 2002 08:13:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25236 invoked from network); 2 Jan 2002 08:13:37 -0000
Message-ID: <036901c19365$654f99a0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	<cygwin-patches@sourceware.cygnus.com>
References: <NCBBIHCHBLCMLBLOBONKMECJCIAA.g.r.vansickle@worldnet.att.net>
Subject: Re: [PATCH] Setup.exe "other URL" functionality
Date: Wed, 02 Jan 2002 00:13:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 02 Jan 2002 08:13:36.0182 (UTC) FILETIME=[606CFD60:01C19365]
X-SW-Source: 2002-q1/txt/msg00001.txt.bz2

----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
> Yep, it looks like that combined with me now using binary mounts will
work
> around this.  For reasons I don't quite understand though, I couldn't
simply do
> a "cvs diff", but had to move my file (now with LFs-only), do a "cvs
update" to
> re-get the cvs version (which also has LFs-only now), replace that
with the file
> I just moved, and *then* it works.  I have no idea what to make of
that.

You should be ok with text mounts now, I think this problem cropped up
due to the CRLF's in the repository. I'm checking in a new version asap.

I'd like to point something out to you:
==
- "\n%%% $Id: choose.cc,v 2.82 2002/01/01 12:32:36 rbcollins Exp $\n";
+ "\n%%% $Id: choose.cc,v 2.81 2001/12/23 12:13:28 rbcollins Exp $\n";
==

Is a sure sign that your repository is out of date. (That's one reason
those lines exist :]). Another is to put your ChangeLog into the
ChangeLog file - if it shows anything other than your changelog when you
create the diff, something has been checked in and raced with you.

I *think* I've got every change I committed eliminated from your patch,
but it adds an element of risk (backing out an important change) and
plain old time-consumption I'd rather avoid. Having said that your patch
is kinda important so I'm spending that time and updating your patch by
hand. (in this case you missed Chris's Makefile fix as well and your
patch backs it out :}.)

I'm sure you would have caught this with a visual review of the patch
(you don't recall changing io_stream.cc for instance do you :})... so
can I suggest that you do such reviews in future? (I often catch last
minute errors with such self-QA). Also in the line of visual reviews,
propsheet.cc is in the diff (non ^M issue) but not the ChangeLog. Please
send me the relevant 'bit' and I'll check the lot in (I have everything
in my sandbox... just ned this one missing bit).

Also, please get it the habit of
cvs -z3 update -Pd && cvs -z3 diff -up > foo.patch
to reduce the chances of diffing against an old sandbox from happening.

Another way to prevent this is to checkout with -D 'now' (or if that
barfs -D '1 minute ago') which will cause the sandbox to be diffed
against the version you checked out, not the HEAD tag.

> But there's a few more files that need this treatment (it looks like
they're
> still CRLF in the repository database):
.
> So almost but not quite every new file I sent you (or maybe that is
all of
> them).  And these were all CRLFs.

Fixed. (I noticed you'd patched that after... doh!)

> Attached is a diff (the patch to date, LF-only) that may or may not be
of use in
> fixing this.  The changes have *not* been run through indent (with the
exception
> of two headers) - I did finally notice the
>
> "void foo::bar()"
>
> vs.
>
> "void
> foo:bar()"

I've noticed 2.2.7 doing that. Ah well, as I've said elsewhere, I want
(beautifier foo) to be authoritative on code presentation, if it's doing
it wrong, then I'll just live with that until a) we fix it, b) we find a
better tool.

> issue you had mentioned, among others, and I have no explanation for
why I
> should see it and not you.  I have no .indent.pro, I'm on a binary
mount like I
> said, I'm using no options, and it's "GNU indent 2.2.7" as distributed
by
> Cygnus.  I have attempted to cleave to the GNU formatting as best as
my own
> sense of aesthetics and limited PITA IDE (VC6) allow, but I'm sure
there's
> plenty there that isn't RMS chapter and verse.

So in short, please run indent, and I'll abide by it's output.

> Also attached is my changelog for this patch to date in the hope that
this will
> put this patch to bed.


