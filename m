Return-Path: <cygwin-patches-return-7074-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29370 invoked by alias); 1 Sep 2010 18:35:27 -0000
Received: (qmail 29357 invoked by uid 22791); 1 Sep 2010 18:35:26 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-186-126.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.186.126)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 01 Sep 2010 18:35:22 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id DD0F313C061	for <cygwin-patches@cygwin.com>; Wed,  1 Sep 2010 14:35:20 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id CF3DD2B354; Wed,  1 Sep 2010 14:35:20 -0400 (EDT)
Date: Wed, 01 Sep 2010 18:35:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Faster process initialization
Message-ID: <20100901183520.GB15157@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C7E9891.7070207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C7E9891.7070207@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00034.txt.bz2

On Wed, Sep 01, 2010 at 08:16:49PM +0200, Magnus Holmgren wrote:
>This patch speeds up process initialization on 64-bit systems. Maybe
>the comment "Initialize signal processing here ..." should be re-worded
>or removed completely.

Yes, the fact that the comment makes no sense when moved would be your
first clue that it should be deleted.

>The speed difference can be noticeable.
>"while (true); do date; done | uniq -c" manages more than 3 times more
>"date" executions per second on my system.

Although you participated in the thread, you apparently ignored this:

http://cygwin.com/ml/cygwin/2010-08/msg01000.html

So, patch thoughtfully rejected.

cgf
