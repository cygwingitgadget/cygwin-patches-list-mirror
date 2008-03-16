Return-Path: <cygwin-patches-return-6305-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25465 invoked by alias); 16 Mar 2008 15:42:13 -0000
Received: (qmail 25455 invoked by uid 22791); 16 Mar 2008 15:42:13 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 16 Mar 2008 15:41:55 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1Jauzi-00012u-3K 	for cygwin-patches@cygwin.com; Sun, 16 Mar 2008 15:41:54 +0000
Message-ID: <47DD3FC1.FAEDC06B@dessent.net>
Date: Sun, 16 Mar 2008 15:42:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] QueryDosDevice in handle_to_fn
References: <47DCF310.2E2CA04A@dessent.net> <20080316152213.GD29148@calimero.vinschen.de>
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
X-SW-Source: 2008-q1/txt/msg00079.txt.bz2

Corinna Vinschen wrote:

> len is a const value.  Checking len for being < 65536 is a constant
> expression which always results in qddlen being 65535 so the ?: is
> a noop, more or less.

Yeah, I realized that, and the compiler should optimize it away
completely.  I put it explicitly as a test in the source just for safety
so that if in the future somebody changes the definition of NT_MAX_PATH
or len for some reason and forgets to touch this part that things work
correctly without any overflows.

> Did you test if QueryDosDeviceW has the same problem as QueryDosDeviceA?
> If not, we should use that function.

No, but that's a good idea.  I'll check that and if it doesn't have this
quirk I'll see about moving to do the bulk of the function with WCHARs.

Brian
