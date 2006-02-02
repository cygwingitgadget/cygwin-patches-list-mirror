Return-Path: <cygwin-patches-return-5735-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 821 invoked by alias); 2 Feb 2006 17:42:02 -0000
Received: (qmail 802 invoked by uid 22791); 2 Feb 2006 17:42:01 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 02 Feb 2006 17:42:01 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.60) 	(envelope-from <brian@dessent.net>) 	id 1F4iT0-000095-RA; Thu, 02 Feb 2006 17:41:59 +0000
Message-ID: <43E24462.67E8F280@dessent.net>
Date: Thu, 02 Feb 2006 17:42:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
CC: gdb-patches@sourceware.org
Subject: Re: [patch] fix spurious SIGSEGV faults under Cygwin
References: <009001c6281e$5907ef60$a501a8c0@CAM.ARTIMI.COM>
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
X-SW-Source: 2006-q1/txt/msg00044.txt.bz2

Dave Korn wrote:

>   I'm having a conceptual difficulty here: Under what circumstances would you expect there *not* to be a debugger attached to the
> inferior to which the debugger is attached?  That's a bit zen, isn't it?

The code in question here runs many times in the normal course of any
Cygwin program -- debugger or no.  The idea behind guarding the call to
OutputDebugString() with "if (being_debugged())" was that the call to
IsDebuggerPresent() was cheaper than the call to OutputDebugString(),
and that a well-behaived, non-debug build of a binary should not
needlessly send tons and tons of nonsense to OutputDebugString unless
it's actually being debugged and there is something there to interpret
the nonsense.

Brian
