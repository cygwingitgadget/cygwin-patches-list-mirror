Return-Path: <cygwin-patches-return-7595-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5433 invoked by alias); 12 Feb 2012 22:28:32 -0000
Received: (qmail 5417 invoked by uid 22791); 12 Feb 2012 22:28:31 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 12 Feb 2012 22:28:16 +0000
Received: from pool-173-76-50-112.bstnma.fios.verizon.net ([173.76.50.112] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1Rwhu3-0006JO-Ae	for cygwin-patches@cygwin.com; Sun, 12 Feb 2012 22:28:15 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 9223C13C002	for <cygwin-patches@cygwin.com>; Sun, 12 Feb 2012 17:28:14 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+tJJzx7LDF4tyQJbzoGQcG
Date: Sun, 12 Feb 2012 22:28:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread.h: include <time.h>
Message-ID: <20120212222814.GA11499@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1329084242.7872.10.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1329084242.7872.10.camel@YAAKOV04>
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
X-SW-Source: 2012-q1/txt/msg00018.txt.bz2

On Sun, Feb 12, 2012 at 04:04:02PM -0600, Yaakov (Cygwin/X) wrote:
>POSIX states:
>> Inclusion of the <pthread.h> header shall make symbols defined in the
>> headers <sched.h> and <time.h> visible.
>
>The reason being that some pthread functions take a clockid_t argument,
>and the CLOCK_* symbolic names are therein defined.
>
>Patch attached.

Looks good.  Please check in.

Thanks.

cgf
