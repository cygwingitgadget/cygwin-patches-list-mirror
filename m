Return-Path: <cygwin-patches-return-5873-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2072 invoked by alias); 24 May 2006 03:43:52 -0000
Received: (qmail 2056 invoked by uid 22791); 24 May 2006 03:43:49 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-19.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 24 May 2006 03:43:44 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id E314213C01F; Tue, 23 May 2006 23:43:40 -0400 (EDT)
Date: Wed, 24 May 2006 03:43:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_base::readv
Message-ID: <20060524034340.GC14207@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ba40711f0605231728r3e349fd4m93b82a70ae058146@mail.gmail.com> <20060524010002.GB14893@trixie.casa.cgf.cx> <ba40711f0605231911q37040f58rfff1dd494f1b84a0@mail.gmail.com> <ba40711f0605231923x35b494b4q3e97f438b31b320f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba40711f0605231923x35b494b4q3e97f438b31b320f@mail.gmail.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00061.txt.bz2

On Tue, May 23, 2006 at 10:23:38PM -0400, Lev Bishop wrote:
>On 5/23/06, Lev Bishop wrote:
>
>>It does make sense. Try this version.
>
>Sorry, no. I'm stupid - ignore that version. There's not much point in
>doing assert(len>=0) given that len is unsigned, it's pretty much a
>given :-) How about just removing the assert()?
>
>So here's the 3rd attempt.
>
>2006-05-23  Lev Bishop  <lev.bishop+cygwin@gmail.com>
>
>	* fhandler.cc (readv): Deal with tot not precalculated.

>Index: fhandler.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
>retrieving revision 1.251
>diff -u -p -r1.251 fhandler.cc
>--- fhandler.cc	22 Mar 2006 16:42:44 -0000	1.251
>+++ fhandler.cc	24 May 2006 02:22:10 -0000
>@@ -966,8 +966,6 @@ fhandler_base::readv (const struct iovec
>       while (iovptr != iov);
>     }
> 
>-  assert (tot >= 0);
>-
>   if (!len)
>     return 0;
> 

I've checked this in but I changed the ChangeLog to:

2006-05-23  Lev Bishop  <lev.bishop+cygwin@gmail.com>

	* fhandler.cc (readv): Remove nonsensical assert.

Thanks.

cgf
