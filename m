Return-Path: <cygwin-patches-return-5731-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15743 invoked by alias); 2 Feb 2006 16:00:36 -0000
Received: (qmail 15729 invoked by uid 22791); 2 Feb 2006 16:00:32 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 02 Feb 2006 16:00:27 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.60) 	(envelope-from <brian@dessent.net>) 	id 1F4gsj-0008CM-RS; Thu, 02 Feb 2006 16:00:26 +0000
Message-ID: <43E22C81.1C4600BA@dessent.net>
Date: Thu, 02 Feb 2006 16:00:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com, gdb-patches@sourceware.org
Subject: Re: [patch] fix spurious SIGSEGV faults under Cygwin
References: <43E1FA66.216E236C@dessent.net>
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
X-SW-Source: 2006-q1/txt/msg00040.txt.bz2

Brian Dessent wrote:

>  #define _CYGWIN_SIGNAL_STRING "cYgSiGw00f"
> +#define _CYGWIN_FAULT_IGNORE_STRING "cYgfAuLtIg"
> +#define _CYGWIN_FAULT_NOIGNORE_STRING "cYgNofAuLtIg"

Sigh, this breaks strace under Cygwin, I should have tested more.  Sorry
about that.  Apparently strace expects anything starting with the 'cYg'
prefix to be followed by a hex number.  I thought that since
_CYGWIN_SIGNAL_STRING already existed and didn't follow that format it
was safe to add more, but that's not the case.

So, should I pick another prefix that's not 'cYg'?  Or instead use
something like "cYg0 ..." since strace seems to just ignore the string
if its value is 0?  Or something else?

Brian
