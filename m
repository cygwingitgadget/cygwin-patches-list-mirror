Return-Path: <cygwin-patches-return-5733-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14093 invoked by alias); 2 Feb 2006 17:21:32 -0000
Received: (qmail 14076 invoked by uid 22791); 2 Feb 2006 17:21:31 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 02 Feb 2006 17:21:28 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.60) 	(envelope-from <brian@dessent.net>) 	id 1F4i98-0008VH-4N; Thu, 02 Feb 2006 17:21:26 +0000
Message-ID: <43E23F92.37AF1CEA@dessent.net>
Date: Thu, 02 Feb 2006 17:21:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
CC: gdb-patches@sourceware.org
Subject: Re: [patch] fix spurious SIGSEGV faults under Cygwin
References: <43E1FA66.216E236C@dessent.net> <43E22C81.1C4600BA@dessent.net> <20060202170558.GD22365@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00042.txt.bz2

Christopher Faylor wrote:

> Thanks for the patch but I've been working on this too and, so far, I think
> it is possible to have a very minimal way of dealing with this problem.  I
> haven't had time to delve into it too deeply but I have been exploring this
> problem on and off for a couple of weeks.  If the situation at work calms
> down a little I may be able to finish up what I've been working on.
> 
> OTOH, if what I have is really not working then I'll take a look at what
> you've done.

Okay, no rush.  FWIW after noticing that strace was broken I tested a
version that used

 #define _CYGWIN_SIGNAL_STRING "cYgSiGw00f"
+#define _CYGWIN_FAULT_IGNORE_STRING "cYg0 faultig"
+#define _CYGWIN_FAULT_NOIGNORE_STRING "cYg0 nofaultig"

...which seems to fix the problem since the strtold() just picks up 0
after 'cYg' and strace ignores the rest.

The main problem I see with this approach is the extra call to
IsDebuggerPresent() every time a 'myfault' is created/destroyed, which
potentially could be a lot.  I'm presuming this is a relatively cheap
call so it wasn't something I worried too much about.  But then I didn't
actually try to measure it.

If it turns out that it's expensive, I was thinking that the inferior
could maintain this information in some variable, and just communicate
its location to gdb once at startup, then gdb could simply read that
variable in the process' memory before deciding whether to handle the
fault.  Or it could try to look at the SEH chain and see if a handler
residing in cygwin1.dll is setup to handle the fault, and if so just
silently pass it along.  But that seemed really complicated when there
already exists this mechanism for the process to communicate with the
debugger.

Brian
