Return-Path: <cygwin-patches-return-7576-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8971 invoked by alias); 30 Dec 2011 17:58:21 -0000
Received: (qmail 8961 invoked by uid 22791); 30 Dec 2011 17:58:20 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 30 Dec 2011 17:58:06 +0000
Received: from pool-173-76-50-112.bstnma.fios.verizon.net ([173.76.50.112] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1RggiU-000FaJ-3B	for cygwin-patches@cygwin.com; Fri, 30 Dec 2011 17:58:06 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 4715113C0CD	for <cygwin-patches@cygwin.com>; Fri, 30 Dec 2011 12:58:05 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+oH13MHg0Q9SKYEQ4YXgvf
Date: Fri, 30 Dec 2011 17:58:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add getpt(3)
Message-ID: <20111230175805.GA20555@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1325227497.5512.18.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1325227497.5512.18.camel@YAAKOV04>
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
X-SW-Source: 2011-q4/txt/msg00066.txt.bz2

On Fri, Dec 30, 2011 at 12:44:57AM -0600, Yaakov (Cygwin/X) wrote:
>getpt(3) is a GNU extension which predates posix_openpt(3):
>
>http://www.kernel.org/doc/man-pages/online/pages/man3/getpt.3.html
>
>The code itself is quite simple, but let me preempt some questions:
>
>1) Yes, portable code should use posix_openpt(3).  Unfortunately not all
>code is written with portability in mind.
>
>2) A macro is insufficient as it will not be discovered by an Autoconf
>AC_CHECK_FUNC or CMake CHECK_FUNCTION_EXISTS test (which is exactly how
>I came across this issue in the first place).
>
>Patches for winsup/cygwin and winsup/doc attached.

>2011-12-30  Yaakov Selkowitz  <yselkowitz@...>
>
>	* cygwin.din (getpt): Export.
>	* posix.sgml (std-gnu): Add getpt.
>	* tty.cc (getpt): New function.
>	* include/cygwin/stdlib.h [!__STRICT_ANSI__] (getpt): Declare.
>	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Looks good.  Please commit.

Thanks.

cgf
