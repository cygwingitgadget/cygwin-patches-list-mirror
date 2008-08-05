Return-Path: <cygwin-patches-return-6349-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27901 invoked by alias); 5 Aug 2008 19:24:30 -0000
Received: (qmail 27890 invoked by uid 22791); 5 Aug 2008 19:24:30 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 05 Aug 2008 19:23:55 +0000
Received: from localhost.localdomain ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1KQS8P-0001Nk-4z 	for cygwin-patches@cygwin.com; Tue, 05 Aug 2008 19:23:53 +0000
Message-ID: <4898A8C7.28AB97ED@dessent.net>
Date: Tue, 05 Aug 2008 19:24:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix profiling
References: <4897E0E8.AB669CAC@dessent.net> <20080805143516.GA10807@ednor.casa.cgf.cx>
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
X-SW-Source: 2008-q3/txt/msg00012.txt.bz2

Christopher Faylor wrote:

> Please use your best judgement about the +r/=r thing given Dave's
> comments.

I think Dave's right, because when I compile with +r I get a "may be
used uninitialized" warning, so I'll just leave it as it is.

Both patches are now committed.  I wonder how long this was broken...

Brian
