Return-Path: <cygwin-patches-return-6091-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7073 invoked by alias); 18 May 2007 21:16:28 -0000
Received: (qmail 7063 invoked by uid 22791); 18 May 2007 21:16:27 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-68.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 18 May 2007 21:16:26 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 64D5C2B353; Fri, 18 May 2007 17:16:24 -0400 (EDT)
Date: Fri, 18 May 2007 21:16:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Segfault on unaligned lseek() on /dev/sdX (was: [ITP] 	ddrescue  1.3)
Message-ID: <20070518211624.GA11191@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <464DF837.6020304@t-online.de> <20070518194526.GA3586@ednor.casa.cgf.cx> <464E0B4D.8020602@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <464E0B4D.8020602@t-online.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00037.txt.bz2

On Fri, May 18, 2007 at 10:23:41PM +0200, Christian Franke wrote:
>Christopher Faylor wrote:
>>On Fri, May 18, 2007 at 09:02:15PM +0200, Christian Franke wrote:
>>  
>>>...
>>>
>>>
>>>    
>>
>>It seems like this could be done without the heavyweight use of malloc,
>>like use an automatic array of length 512 + 4 and calculate an aligned
>>address from that.
>
>Sorry, no. "unaligned seek" does not refer to memory here.

Why not just use 2048 or some larger number as the buffer size then?

cgf
