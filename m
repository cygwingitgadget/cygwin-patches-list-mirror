Return-Path: <cygwin-patches-return-3036-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30947 invoked by alias); 24 Sep 2002 07:27:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30929 invoked from network); 24 Sep 2002 07:27:53 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Tue, 24 Sep 2002 00:27:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Reset threadcount after fork
In-Reply-To: <1032816802.8314.15.camel@lifelesswks>
Message-ID: <Pine.WNT.4.44.0209240922210.277-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00484.txt.bz2



On Mon, 23 Sep 2002, Robert Collins wrote:

> On Mon, 2002-09-23 at 22:36, Thomas Pfaff wrote:
> >
> > 2002-09-23  Thomas Pfaff  <tpfaff@gmx.net>
> >
> > 	* thread.cc (MTinterface::fixup_after_fork): Reset threadcount to
> > 	1 after fork.
>
> Why do we need this? MTinterface::Init is also called after fork, and
> sets threadcount to 1.

Ignore it.

This patch is part of an update to MTinterface that should fix some fork
related issues, especially when fork is called from a thread other than
the mainthread.

Thomas
