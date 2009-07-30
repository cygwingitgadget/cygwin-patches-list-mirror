Return-Path: <cygwin-patches-return-6580-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20927 invoked by alias); 30 Jul 2009 13:52:12 -0000
Received: (qmail 20915 invoked by uid 22791); 30 Jul 2009 13:52:10 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-121.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.121)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 30 Jul 2009 13:52:01 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id E065F13C002 	for <cygwin-patches@cygwin.com>; Thu, 30 Jul 2009 09:51:50 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id A0DD32B35F; Thu, 30 Jul 2009 09:51:50 -0400 (EDT)
Date: Thu, 30 Jul 2009 13:52:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix order of dtors problem.
Message-ID: <20090730135150.GA31765@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A71A45A.10409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A71A45A.10409@gmail.com>
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
X-SW-Source: 2009-q3/txt/msg00034.txt.bz2

On Thu, Jul 30, 2009 at 02:47:06PM +0100, Dave Korn wrote:
>
>  This is the patch I'm currently testing (so far, uneventfully).  I thought I'd
>send it here for posterity just in case I get squashed by a falling hippo or
>anything over the weekend.
>
>winsup/cygwin/ChangeLog:
>
>	* globals.cc (enum exit_states::ES_GLOBAL_DTORS): Delete.
>	* dcrt0.cc (__main): Schedule dll_global_dtors to run
>	atexit before global dtors.
>	(do_exit): Delete test for ES_GLOBAL_DTORS and call to
>	dll_global_dtors.

FWIW, this looks fine.

cgf
