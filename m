Return-Path: <cygwin-patches-return-6296-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4508 invoked by alias); 15 Mar 2008 06:12:04 -0000
Received: (qmail 4497 invoked by uid 22791); 15 Mar 2008 06:12:03 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 15 Mar 2008 06:11:45 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JaPcN-00056W-NR 	for cygwin-patches@cygwin.com; Sat, 15 Mar 2008 06:11:43 +0000
Message-ID: <47DB689F.8FC91752@dessent.net>
Date: Sat, 15 Mar 2008 06:12:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] recognise when an exec()d process terminates due to 	  unhandled   exception
References: <47D9D8D3.17BC1E3B@dessent.net> <47D9E70D.ED6C84CB@dessent.net> <20080314141331.GB20808@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00070.txt.bz2

Christopher Faylor wrote:

> That was going to be my first observation, actually.  I'm still trying
> to digest the patch but it seems like it wouldn't work well with the
> fork retry code.

The patch doesn't change any behavior though: in current Cygwin if the
thing we're exec()ing returns a Win32 exit code of C0000135 (or
whatever) then we retry creating it 5 times.  With the patch, we still
retry starting it 5 times but after the last one fails we recognise the
situation and print a message.

Brian
