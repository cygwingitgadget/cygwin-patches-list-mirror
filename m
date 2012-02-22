Return-Path: <cygwin-patches-return-7598-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22269 invoked by alias); 22 Feb 2012 01:30:22 -0000
Received: (qmail 22251 invoked by uid 22791); 22 Feb 2012 01:30:22 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 22 Feb 2012 01:30:08 +0000
Received: from pool-173-76-50-112.bstnma.fios.verizon.net ([173.76.50.112] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1S0120-0007it-5F	for cygwin-patches@cygwin.com; Wed, 22 Feb 2012 01:30:08 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 9C0E713C002	for <cygwin-patches@cygwin.com>; Tue, 21 Feb 2012 20:30:07 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1999PMskxAxF7gtQLblUugC
Date: Wed, 22 Feb 2012 01:30:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add scandirat(3)
Message-ID: <20120222013007.GA29507@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1329864298.3540.2.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1329864298.3540.2.camel@YAAKOV04>
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
X-SW-Source: 2012-q1/txt/msg00021.txt.bz2

On Tue, Feb 21, 2012 at 04:44:58PM -0600, Yaakov (Cygwin/X) wrote:
>scandirat(3) was added in glibc-2.15[1] and has supposedly been proposed
>for addition to POSIX.1[2].  Patch attached.
>
>
>Yaakov
>
>[1] http://sourceware.org/git/?p=glibc.git;a=blob_plain;f=NEWS
>[2] http://article.gmane.org/gmane.linux.man/2419
>

>2012-02-??  Yaakov Selkowitz <yselkowitz@...>
>
>	* cygwin.din (scandirat): Export.
>	* posix.sgml (std-gnu): Add scandirat.
>	* syscalls.cc (scandirat): New function.
>	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
>	* include/sys/dirent.h (scandirat): Declare.

Looks good.  Please apply.

Thanks, as always.

cgf
