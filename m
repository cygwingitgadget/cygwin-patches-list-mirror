Return-Path: <cygwin-patches-return-7592-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24485 invoked by alias); 24 Jan 2012 06:04:16 -0000
Received: (qmail 24473 invoked by uid 22791); 24 Jan 2012 06:04:14 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mho-01-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.71)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 24 Jan 2012 06:04:00 +0000
Received: from pool-173-76-50-112.bstnma.fios.verizon.net ([173.76.50.112] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1RpZU7-0000lY-Ul	for cygwin-patches@cygwin.com; Tue, 24 Jan 2012 06:03:59 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 460BA13C022	for <cygwin-patches@cygwin.com>; Tue, 24 Jan 2012 01:03:59 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18ZRiXywvqgohMYFBqaReTd
Date: Tue, 24 Jan 2012 06:04:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] ldd: support .oct and .so modules
Message-ID: <20120124060359.GA2304@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1327384403.5392.7.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1327384403.5392.7.camel@YAAKOV04>
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
X-SW-Source: 2012-q1/txt/msg00015.txt.bz2

On Mon, Jan 23, 2012 at 11:53:23PM -0600, Yaakov (Cygwin/X) wrote:
>Octave modules use the .oct extension, and several programs use .so for
>modules even on Cygwin (e.g. Apache2, Mesa, OpenSSL, Ruby).  Currently,
>running ldd(1) on any of these returns ENOEXEC.
>
>The attached patch fixes ldd to treat these as DLLs and show their
>runtime dependencies.
>
>
>Yaakov
>

>2012-01-??  Yaakov Selkowitz  <yselkowitz@...>
>
>	* ldd.cc (start_process): Handle .oct and .so as DLLs.

Looks good.  Please check in.

Thanks.

cgf
