Return-Path: <cygwin-patches-return-2438-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12665 invoked by alias); 15 Jun 2002 12:07:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12646 invoked from network); 15 Jun 2002 12:07:45 -0000
X-WM-Posted-At: avacado.atomice.net; Sat, 15 Jun 02 13:11:05 +0100
Message-ID: <005b01c21465$b97a07f0$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
References: <003c01c213f3$2ed077f0$6132bc3e@BABEL> <005801c213f6$ab0e2a30$6132bc3e@BABEL> <20020615010600.GB5699@redhat.com>
Subject: Re: Mount interaction with /dev & /proc entries
Date: Sat, 15 Jun 2002 05:07:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00421.txt.bz2

> >Before anyone else gets there, I'll reply to my own message (what a
> >change).
> >
> >The patch I just sent for path.cc breaks (at least) find(1) on
> >/proc/registry -- it doesn't descend into it at all. Sorry.
> >
> >So I've got something wrong in my understanding of the cygwin/win32
> >stuff (which doesn't surprise me). It still seems that something like
> >this change should be made. One difference betwen /proc and /dev is
> >that the /dev fs doesn't contain any directories. I'll go look some
> >more.
>
> Conrad -- I wouldn't bother investigating this for now.
>
> I have been sitting on the beginnings of a rewrite for the mount stuff.
> I think that 1.3.12 (or whatever) should have some improvements in this
> regard.
>
> Thanks for pointing out the problem with /proc, though.  You're right that
> it should still be visible during a chroot.  I'm not too worried about
that
> for 1.3.11, though.
Well, when I was writing the /proc stuff, I wrote it on the premise there
was an imaginary proc filesystem mounted a /proc. This means if you chroot,
that filesystem won't be mounted at /proc anymore and hence it is correct
that /proc doesn't work. i.e. the path handling is done with mount points in
mind.
I would argue, as Chris F has suggested above, that this is best left for
the re-write of the mount stuff.

Regards
Chris

