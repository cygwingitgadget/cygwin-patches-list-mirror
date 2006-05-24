Return-Path: <cygwin-patches-return-5868-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21839 invoked by alias); 24 May 2006 01:00:07 -0000
Received: (qmail 21809 invoked by uid 22791); 24 May 2006 01:00:06 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-19.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 24 May 2006 01:00:04 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id C334513C01F; Tue, 23 May 2006 21:00:02 -0400 (EDT)
Date: Wed, 24 May 2006 01:00:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_base::readv
Message-ID: <20060524010002.GB14893@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ba40711f0605231728r3e349fd4m93b82a70ae058146@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba40711f0605231728r3e349fd4m93b82a70ae058146@mail.gmail.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00056.txt.bz2

On Tue, May 23, 2006 at 08:28:58PM -0400, Lev Bishop wrote:
>2006-05-23  Lev Bishop  <lev.bishop+cygwin@gmail.com>
>
>	* fhandler.cc (readv): Deal with tot not precalculated.

>Index: fhandler.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
>retrieving revision 1.251
>diff -u -p -r1.251 fhandler.cc
>--- fhandler.cc	22 Mar 2006 16:42:44 -0000	1.251
>+++ fhandler.cc	24 May 2006 00:24:46 -0000
>@@ -964,6 +964,7 @@ fhandler_base::readv (const struct iovec
> 	  len += iovptr->iov_len;
> 	}
>       while (iovptr != iov);
>+      tot = len;
>     }
> 
>   assert (tot >= 0);

At this point in the code, tot is only used in the subsequent assert.
If that is the rationale for this change wouldn't it make more sense to
just check len in the assert?

cgf
