Return-Path: <cygwin-patches-return-7058-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7375 invoked by alias); 8 Aug 2010 16:33:53 -0000
Received: (qmail 7351 invoked by uid 22791); 8 Aug 2010 16:33:51 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-4.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.4)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sun, 08 Aug 2010 16:33:46 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 4470013C061	for <cygwin-patches@cygwin.com>; Sun,  8 Aug 2010 12:33:44 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 114BF2B352; Sun,  8 Aug 2010 12:33:44 -0400 (EDT)
Date: Sun, 08 Aug 2010 16:33:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] POSIX monotonic clock
Message-ID: <20100808163343.GA3637@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1280782148.6756.81.camel@YAAKOV04> <e9a284aade1fca8f1132eb866f4f7224@shell.sh.cvut.cz> <20100803140420.GA21733@ednor.casa.cgf.cx> <1281243978.1344.0.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1281243978.1344.0.camel@YAAKOV04>
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
X-SW-Source: 2010-q3/txt/msg00018.txt.bz2

On Sun, Aug 08, 2010 at 12:06:18AM -0500, Yaakov (Cygwin/X) wrote:
>On Tue, 2010-08-03 at 10:04 -0400, Christopher Faylor wrote:
>> On Tue, Aug 03, 2010 at 09:32:47AM +0200, V??clav Haisman wrote:
>> >This looks like you could get monotonic clock going backwards.
>> 
>> That's a good point.  We have that very problem here where I work.
>> However, Yaakov isn't adding anything new here so, if this is a problem,
>> it would be a long-standing one.
>> 
>> It sounds like it would be trivially solvable by setting the processor
>> affinity mask but I'm not sure what that would mean for performance.
>
>So should I hold off on my patch until this can be fixed?

Nah.  Go ahead.  Thanks.

cgf
