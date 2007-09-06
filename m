Return-Path: <cygwin-patches-return-6140-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19212 invoked by alias); 6 Sep 2007 18:53:09 -0000
Received: (qmail 19202 invoked by uid 22791); 6 Sep 2007 18:53:08 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Sep 2007 18:53:04 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1ITMTO-0005Ys-NM 	for cygwin-patches@cygwin.com; Thu, 06 Sep 2007 18:53:02 +0000
Message-ID: <46E04C8E.DF3755CC@dessent.net>
Date: Thu, 06 Sep 2007 18:53:00 -0000
From: Brian Dessent <brian@dessent.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Fix multithreaded snprintf
References: <46E04739.F0B0D169@dessent.net> <20070906183325.GA19790@ednor.casa.cgf.cx>
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
X-SW-Source: 2007-q3/txt/msg00015.txt.bz2

Christopher Faylor wrote:

> Go ahead and check this in but could you add a comment indicating that
> this part of include/sys/stdio.h has to be kept in sync with newlib?

Done.

> Nice catch!

I wish I could say I caught this by inspection but it was only by single
stepping through python guts that it became apparent what was going on.

Brian
