Return-Path: <cygwin-patches-return-4618-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5379 invoked by alias); 22 Mar 2004 20:25:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5368 invoked from network); 22 Mar 2004 20:25:41 -0000
Message-ID: <024901c4104b$d266a370$640aa8c0@esp>
From: "Matt Hargett" <matt@use.net>
To: <Pierre.Humblet@ieee.org>,
	<cygwin-patches@cygwin.com>
References: <405EF9F4.A97FF863@phumblet.no-ip.org> <20040322185405.GA3266@redhat.com> <405F4530.F3188C94@phumblet.no-ip.org>
Subject: Re: [Patch]: Win95
Date: Mon, 22 Mar 2004 20:25:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q1/txt/msg00108.txt.bz2

> Can you believe that the address appears 5 times on the stack on Win95,
> twice on ME, once on NT4.0?
>
> Now that the method is stable (after 1.5.10 is released), couldn't we
store
> the offsets in wincap, keeping the adaptive method as a backup in the
> unknown case? Or are there many variations?

I can tell you from the perspective of writing shellcode and rootkits on
windows that assuming offsets will be the same is not a good idea if you are
going for something that is to be widely deployed. Not only can they vary
between service packs/patches, but also between language editions of the OS.
