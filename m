Return-Path: <cygwin-patches-return-2118-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14209 invoked by alias); 27 Apr 2002 13:33:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14195 invoked from network); 27 Apr 2002 13:33:19 -0000
Message-Id: <3.0.5.32.20020427093132.0080d100@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sat, 27 Apr 2002 06:33:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Workaround patch for MS CLOSE_WAIT bug
In-Reply-To: <3CBADAE5.92A542FE@ieee.org>
References: <3.0.5.32.20020414152944.007ec460@mail.attbi.com>
 <20020415141743.N29277@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00102.txt.bz2

Pierre A. Humblet wrote in
http://cygwin.com/ml/cygwin-patches/2002-q2/msg00039.html

>Weird behavior (details on request) can also be avoided by
>"closing on fork" the main sock after line (1) and deleting
>line (2).

This is an explanation for the record.
Systems: Win98 & WinME
Start a standalone sshd. From localhost or another machine launch
3 ssh sessions, in the order 1, 2, 3. Exit from #2 then from #1.
#3 is then reset unexpectedly.

Analysis: sshd has a daemon running and 3 forked workers. The workers
have a duplicated listen socket, which they closed, and an active i/o
socket. The daemon has an active listen socket. It doesn't matter if
the 3 accepted sockets are closed or not in the daemon, so this problem
is distinct from the MS CLOSE_WAIT bug.

Fix (arrived at experimentally): do not duplicate the listen socket
in the workers (they immediately close it anyway). It must be the case 
that cleaning up the duplicated sockets (improperly closed  by MS) when
the  subprocesses exit out of order exposes another MS bug.

It is serendipity that the "close on fork" approach developed for
the CLOSE_WAIT bug also takes care of this one.

The problem does not occur [more precisely, is hard to reproduce]
when the workers are exec'ed (e.g. inetd) because the duplicated
listen sockets exist only during the brief interval between the 
fork and the subsequent exec. 
The bug can be reproduced in other packages (e.g. qpopper) 
using forked workers. 

Pierre
 
