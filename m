Return-Path: <cygwin-patches-return-5734-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22820 invoked by alias); 2 Feb 2006 17:30:29 -0000
Received: (qmail 22802 invoked by uid 22791); 2 Feb 2006 17:30:28 -0000
X-Spam-Check-By: sourceware.org
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 02 Feb 2006 17:30:27 +0000
Received: from rainbow ([192.168.1.165]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830); 	 Thu, 2 Feb 2006 17:30:23 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Cc: <gdb-patches@sourceware.org>
Subject: RE: [patch] fix spurious SIGSEGV faults under Cygwin
Date: Thu, 02 Feb 2006 17:30:00 -0000
Message-ID: <009001c6281e$5907ef60$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <43E23F92.37AF1CEA@dessent.net>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00043.txt.bz2

On 02 February 2006 17:21, Brian Dessent wrote:

> The main problem I see with this approach is the extra call to
> IsDebuggerPresent() every time a 'myfault' is created/destroyed, which
> potentially could be a lot.  I'm presuming this is a relatively cheap
> call so it wasn't something I worried too much about.  But then I didn't
> actually try to measure it.   
> 
> If it turns out that it's expensive, I was thinking that the inferior
> could maintain this information in some variable, and just communicate
> its location to gdb once at startup, then gdb could simply read that
> variable in the process' memory before deciding whether to handle the
> fault.

  ?????!

  I'm having a conceptual difficulty here: Under what circumstances would you expect there *not* to be a debugger attached to the
inferior to which the debugger is attached?  That's a bit zen, isn't it?

  Or IOW if a debugger is going to read a variable from its inferior that says if there's a debugger attached, well... it might as
well be #defined to 1 in the gdb source code, mightn't it?


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
