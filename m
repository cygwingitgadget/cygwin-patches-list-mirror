Return-Path: <cygwin-patches-return-6534-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29456 invoked by alias); 4 Jun 2009 01:30:42 -0000
Received: (qmail 29446 invoked by uid 22791); 4 Jun 2009 01:30:42 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-121.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.121)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 04 Jun 2009 01:30:35 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 1DE5513C0C3 	for <cygwin-patches@cygwin.com>; Wed,  3 Jun 2009 21:30:25 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id E9E06590CB3; Wed,  3 Jun 2009 21:30:24 -0400 (EDT)
Date: Thu, 04 Jun 2009 01:30:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Separate pthread fixes #1
Message-ID: <20090604013024.GA15999@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A27031C.7030800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A27031C.7030800@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00076.txt.bz2

On Thu, Jun 04, 2009 at 12:11:24AM +0100, Dave Korn wrote:
>
>  The attached patch separates out the uncontroversial change to the
>__cygwin_lock* functions.
>
>winsup/cygwin/ChangeLog
>
>	* thread.cc (__cygwin_lock_lock):  Delete racy optimisation.
>	(__cygwin_lock_unlock):  Likewise.
>
>  OK?

Yes.  Thanks.

FWIW, I have made this same change many times over the years but I was
always afraid of the performance hit so I've ended up reverting it.
Since you've demonstrated a real problem, performance concerns obviously
don't matter.

cgf
