Return-Path: <cygwin-patches-return-7584-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27937 invoked by alias); 2 Jan 2012 18:00:12 -0000
Received: (qmail 27926 invoked by uid 22791); 2 Jan 2012 18:00:11 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 02 Jan 2012 17:59:53 +0000
Received: from pool-173-76-50-112.bstnma.fios.verizon.net ([173.76.50.112] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1RhmAq-000LMq-Fo	for cygwin-patches@cygwin.com; Mon, 02 Jan 2012 17:59:52 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 5BD7213C022	for <cygwin-patches@cygwin.com>; Mon,  2 Jan 2012 12:59:52 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+hhdlPpFvrCxkcG+h/w2X/
Date: Mon, 02 Jan 2012 18:00:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add pthread_sigqueue(3)
Message-ID: <20120102175952.GB9433@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1325444340.6724.15.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1325444340.6724.15.camel@YAAKOV04>
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
X-SW-Source: 2012-q1/txt/msg00007.txt.bz2

On Sun, Jan 01, 2012 at 12:59:00PM -0600, Yaakov (Cygwin/X) wrote:
>This patchset adds pthread_sigqueue(3), a GNU extension:
>
>http://www.kernel.org/doc/man-pages/online/pages/man3/pthread_sigqueue.3.html
>
>The implementation is based on the existing sigqueue(2) and
>pthread_kill(3) code.
>
>Patches for winsup/cygwin and winsup/doc attached.


>2012-01-??  Yaakov Selkowitz  <yselkowitz@...>
>
>	* cygwin.din (pthread_sigqueue): Export.
>	* posix.sgml (std-gnu): Add pthread_sigqueue.
>	* thread.cc (pthread_sigqueue): New function.
>	* include/thread.h (pthread_sigqueue): New function.
>	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

I guess this can go in since I already "implemented" sigqueue but
SI_QUEUE isn't actually fully functional.  Cygwin doesn't queue signals
and I don't believe it handles the sigval union correctly.

But, anyway, thanks for the patch.  Go ahead and check in.

cgf
