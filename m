Return-Path: <cygwin-patches-return-4622-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 562 invoked by alias); 23 Mar 2004 01:18:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 552 invoked from network); 23 Mar 2004 01:18:53 -0000
Message-ID: <011e01c41074$cb556ac0$e22b1145@esp>
From: "Matt Hargett" <matt@use.net>
To: "Nicholas Wourms" <nwourms@netscape.net>
Cc: <Pierre.Humblet@ieee.org>,
	<cygwin-patches@cygwin.com>
References: <405EF9F4.A97FF863@phumblet.no-ip.org> <20040322185405.GA3266@redhat.com> <405F4530.F3188C94@phumblet.no-ip.org> <024901c4104b$d266a370$640aa8c0@esp> <405F8F15.40409@netscape.net>
Subject: Re: [Patch]: Win95
Date: Tue, 23 Mar 2004 01:18:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q1/txt/msg00112.txt.bz2

> >>Can you believe that the address appears 5 times on the stack on Win95,
> >>twice on ME, once on NT4.0?
> >>
> >>Now that the method is stable (after 1.5.10 is released), couldn't we
> > store
> >
> >>the offsets in wincap, keeping the adaptive method as a backup in the
> >>unknown case? Or are there many variations?
> >
> > I can tell you from the perspective of writing shellcode and rootkits on
> > windows that assuming offsets will be the same is not a good idea if you
are
> > going for something that is to be widely deployed. Not only can they
vary
> > between service packs/patches, but also between language editions of the
OS.
> >
>
> What would you suggest doing instead?

Um, I would stick to the adaptive method that is currently being used. Maybe
the adaptive method could be sped up a bit, though? I'll see if I spot
anything obvious in the code tomorrow.
