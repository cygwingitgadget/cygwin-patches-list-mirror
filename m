Return-Path: <cygwin-patches-return-6346-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13662 invoked by alias); 5 Aug 2008 05:28:49 -0000
Received: (qmail 13651 invoked by uid 22791); 5 Aug 2008 05:28:48 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 05 Aug 2008 05:27:38 +0000
Received: from localhost.localdomain ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1KQF56-0007Q2-1y 	for cygwin-patches@cygwin.com; Tue, 05 Aug 2008 05:27:36 +0000
Message-ID: <4897E4C7.88A64A3C@dessent.net>
Date: Tue, 05 Aug 2008 05:28:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix profiling
References: <4897E0E8.AB669CAC@dessent.net>
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
X-SW-Source: 2008-q3/txt/msg00009.txt.bz2

Brian Dessent wrote:

> Since this code is lifted from the BSDs I did check that this change was
> made there as well, e.g.
> <http://www.openbsd.org/cgi-bin/cvsweb/src/sys/arch/i386/include/profile.h?rev=1.10&content-type=text/x-cvsweb-markup>.

Actually, I also missed that the above version uses +r instead of =r for
the second constraint.  I guess we should make that change too.

Brian
