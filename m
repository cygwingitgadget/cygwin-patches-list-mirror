Return-Path: <cygwin-patches-return-7054-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15528 invoked by alias); 3 Aug 2010 14:04:37 -0000
Received: (qmail 15516 invoked by uid 22791); 3 Aug 2010 14:04:35 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-4.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.4)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 03 Aug 2010 14:04:25 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 8EC6E13C061	for <cygwin-patches@cygwin.com>; Tue,  3 Aug 2010 10:04:20 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 7B9462B352; Tue,  3 Aug 2010 10:04:20 -0400 (EDT)
Date: Tue, 03 Aug 2010 14:04:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] POSIX monotonic clock
Message-ID: <20100803140420.GA21733@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1280782148.6756.81.camel@YAAKOV04> <e9a284aade1fca8f1132eb866f4f7224@shell.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9a284aade1fca8f1132eb866f4f7224@shell.sh.cvut.cz>
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
X-SW-Source: 2010-q3/txt/msg00014.txt.bz2

On Tue, Aug 03, 2010 at 09:32:47AM +0200, V??clav Haisman wrote:
>This looks like you could get monotonic clock going backwards.

That's a good point.  We have that very problem here where I work.
However, Yaakov isn't adding anything new here so, if this is a problem,
it would be a long-standing one.

It sounds like it would be trivially solvable by setting the processor
affinity mask but I'm not sure what that would mean for performance.

cgf
