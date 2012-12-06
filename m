Return-Path: <cygwin-patches-return-7788-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16868 invoked by alias); 6 Dec 2012 06:21:18 -0000
Received: (qmail 16856 invoked by uid 22791); 6 Dec 2012 06:21:16 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 06 Dec 2012 06:21:12 +0000
Received: from pool-173-76-51-117.bstnma.fios.verizon.net ([173.76.51.117] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TgUpb-000JOF-Md	for cygwin-patches@cygwin.com; Thu, 06 Dec 2012 06:21:11 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 510C913C076	for <cygwin-patches@cygwin.com>; Thu,  6 Dec 2012 01:21:11 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/Dj+eutZOjrPqUfLZF977E
Date: Thu, 06 Dec 2012 06:21:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] waitpid(2) WAIT_* macros
Message-ID: <20121206062111.GB10173@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1354771229.6160.2.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1354771229.6160.2.camel@YAAKOV04>
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
X-SW-Source: 2012-q4/txt/msg00065.txt.bz2

On Wed, Dec 05, 2012 at 11:20:29PM -0600, Yaakov (Cygwin/X) wrote:
>WAIT_ANY and WAIT_MYPGRP are defined by glibc[1] as symbolic constants
>for special values in the first argument to waitpid(2).  Patch attached.
>
>[1]
>http://www.gnu.org/software/libc/manual/html_node/Process-Completion.html

>2012-12-05  Yaakov Selkowitz  <yselkowitz@...>
>
>	* include/cygwin/wait.h (WAIT_ANY): Define.
>	(WAIT_MYPGRP): Define.

Seems pretty straightforward.  Please apply.

Thanks.

cgf
