Return-Path: <cygwin-patches-return-2845-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27534 invoked by alias); 16 Aug 2002 23:09:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27520 invoked from network); 16 Aug 2002 23:09:19 -0000
Date: Fri, 16 Aug 2002 16:09:00 -0000
From: Pavel Tsekov <ptsekov@gmx.net>
Reply-To: Pavel Tsekov <ptsekov@gmx.net>
X-Priority: 3 (Normal)
Message-ID: <78138873329.20020817010844@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH suggestion] exceptions.cc, interrupt_setup ()
In-Reply-To: <119122398409.20020816203409@gmx.net>
References: <119122398409.20020816203409@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00293.txt.bz2

PT> The problem is triggered by the sigdelayed0() code which always
PT> restores the signal mask (exceptions.cc, line 1237) using

Sorry, I spread a misinformation. The above is not quite valid. Should
be:

The problem is triggered by the sigreturn() code which always
restores the signal mask (exceptions.cc, line 1191) using
sigsave.oldmask.

The text below is still valid though.

PT> sigsave.oldmask. The real problem is that the sigsave.oldmask field
PT> is never initialised when preparing to execute a signal handler.
PT> So imagine that someone set sigsave.oldmask to some value (sigsuspend() in this case),
PT> then you will always get this value as the signal mask after a signal handler is called.
