Return-Path: <cygwin-patches-return-7574-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32646 invoked by alias); 30 Dec 2011 06:44:19 -0000
Received: (qmail 32635 invoked by uid 22791); 30 Dec 2011 06:44:18 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 30 Dec 2011 06:44:04 +0000
Received: from pool-173-76-50-112.bstnma.fios.verizon.net ([173.76.50.112] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1RgWCB-000Mxi-Dr	for cygwin-patches@cygwin.com; Fri, 30 Dec 2011 06:44:03 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id B58EE13C0CD	for <cygwin-patches@cygwin.com>; Fri, 30 Dec 2011 01:44:02 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/FGH3IYxa/D3nlCAkPGhst
Date: Fri, 30 Dec 2011 06:44:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix cancellation points list
Message-ID: <20111230064402.GA8794@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1325226325.5512.7.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1325226325.5512.7.camel@YAAKOV04>
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
X-SW-Source: 2011-q4/txt/msg00064.txt.bz2

On Fri, Dec 30, 2011 at 12:25:25AM -0600, Yaakov (Cygwin/X) wrote:
>pthread_rwlock_timedrdlock and pthread_rwlock_timedwrlock aren't
>implemented yet.  Patch attached.
>
>
>Yaakov
>

>2011-12-30  Yaakov Selkowitz  <yselkowitz@...>
>
>	* thread.cc: Mark pthread_rwlock_timedrdlock and
>	pthread_rwlock_timedwrlock as not yet implemented in the list of
>	cancellation points.

Please apply.

Thanks.

cgf
