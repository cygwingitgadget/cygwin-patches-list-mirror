Return-Path: <cygwin-patches-return-7678-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3513 invoked by alias); 11 Jun 2012 21:28:07 -0000
Received: (qmail 3503 invoked by uid 22791); 11 Jun 2012 21:28:06 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 11 Jun 2012 21:27:53 +0000
Received: from pool-108-49-31-224.bstnma.fios.verizon.net ([108.49.31.224] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1SeC9Q-0006QR-AN	for cygwin-patches@cygwin.com; Mon, 11 Jun 2012 21:27:52 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 7D3F013C0C1	for <cygwin-patches@cygwin.com>; Mon, 11 Jun 2012 17:27:51 -0400 (EDT)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19jKsiQunmYE/Zz0+5hEaIo
Date: Mon, 11 Jun 2012 21:28:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] regex: fix for kernel cross-compile
Message-ID: <20120611212751.GA10333@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4FD65BFC.1060900@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FD65BFC.1060900@users.sourceforge.net>
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
X-SW-Source: 2012-q2/txt/msg00047.txt.bz2

On Mon, Jun 11, 2012 at 03:58:36PM -0500, Yaakov (Cygwin/X) wrote:
>The attached patch fixes the issue I reported previously:
>
>http://cygwin.com/ml/cygwin/2012-06/msg00161.html
>
>According to POSIX[1], a '|' following '(' produces undefined results. 
>However, glibc and PCRE both allow the regex in question, so there is 
>basis for omitting this error.  I believe this is the last issue which 
>needs to be fixed within Cygwin to allow cross-compiling the Linux kernel.

Looks ok.  Please check in.

Thanks.

cgf
