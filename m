Return-Path: <cygwin-patches-return-1481-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 30932 invoked by alias); 13 Nov 2001 02:20:57 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 30918 invoked from network); 13 Nov 2001 02:20:56 -0000
Message-ID: <001401c16bea$107a89f0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <bkeener@thesoftwaresource.com>,
	<cygwin-patches@cygwin.Com>
References: <OE65oDk9X2VFyBUMeEk0000ecac@hotmail.com> <01fe01c16916$a920a350$0200a8c0@lifelesswks> <3BEBC8F6.3B150BA3@yahoo.com> <021401c16976$7a591380$0200a8c0@lifelesswks> <3BEFCB8E.C0507FBD@yahoo.com> <02c901c16bca$1a7e5fa0$0200a8c0@lifelesswks> <20011112224913.GA25415@redhat.com> <VA.000009d3.0210da6e@thesoftwaresource.com>
Subject: Re: [Patch] setup.exe - no skip/keep option buggyness
Date: Fri, 05 Oct 2001 13:10:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 13 Nov 2001 02:28:23.0760 (UTC) FILETIME=[DE34B500:01C16BEA]
X-SW-Source: 2001-q4/txt/msg00013.txt.bz2

----- Original Message -----
From: "Brian Keener" <bkeener@thesoftwaresource.com>


>
> Just to throw my two cents worth in - I kind of like the keep/skip and
the spin
> control.  The keep/skip makes perfect sense to me - I have a package
listed in
> the installed column of choose and I select keep - I want to keep that
version
> installed.  I have nothing displayed in the installed column - I
select skip -
> I still want nothing installed, in my way of thinking.  I would not
select
> "keep" if I had nothing of that package installed anyways.  I am not
saying you
> should ever have both options, that is a definite no-no but one or the
other in
> the right cases makes seems right to me.  I would/could select "skip"
if I did
> have the package installed and it would make sense but I think if
something is
> installed then "keep" really makes better sense.  It is still all
semantics -
> ultimately behind the scenes they accomplish the same thing, but we do
need to
> think of the clarity for the novice.

Well, behind the scenes they are treated differently right now - one is
ACTION_foo, one is ACTION_SAME_foo.

As for labels, skip in both cases makes intuitive sense to me.
nothing installed - skip this package.
something installed - skip changing this package.

> As to the spin control, I like it - but everyone elses discontent with
it makes
> me ask - what do you envision in its place - I might like that better.

A drop-down box. Why?
two reasons.
1) spin controls are hard for non-mouse users to control. And there's
nothing for a screen reader to read out in terms of options, other than
spinning around.
2) I would love to be able to go straight to the version I want, and to
use keyboard controls completely within choose.cc...

Rob
