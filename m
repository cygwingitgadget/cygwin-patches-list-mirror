Return-Path: <cygwin-patches-return-6311-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19513 invoked by alias); 19 Mar 2008 00:57:51 -0000
Received: (qmail 19500 invoked by uid 22791); 19 Mar 2008 00:57:49 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 19 Mar 2008 00:57:25 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JbmcN-00028L-0p 	for cygwin-patches@cygwin.com; Wed, 19 Mar 2008 00:57:23 +0000
Message-ID: <47E064F3.A98E112A@dessent.net>
Date: Wed, 19 Mar 2008 00:57:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] better stackdumps
References: <47E05D34.FCC2E30A@dessent.net> <47E05FBE.B57EF4A2@dessent.net> <Pine.GSO.4.63.0803182040020.8440@access1.cims.nyu.edu>
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
X-SW-Source: 2008-q1/txt/msg00085.txt.bz2

Igor Peshansky wrote:

> Would it make sense to force a newline before the function name and to
> display it with a small indent?  That way people who want the old-style
> stackdump could just feed the new one into "grep -v '^  '" or something...

Yes, that would be one way.  That actually reminds me of another issue
that I forgot to mention: glibc has a backtrace API that can be called
from user-code at any time, not just at faults.  At the moment we are
exporting something similar called cygwin_stackdump but we don't declare
it in any header.  Would it be worthwhile to try to match the glibc API
and export it under the same name/output format?

Brian
