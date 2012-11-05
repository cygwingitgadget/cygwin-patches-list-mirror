Return-Path: <cygwin-patches-return-7769-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14940 invoked by alias); 5 Nov 2012 03:08:58 -0000
Received: (qmail 14898 invoked by uid 22791); 5 Nov 2012 03:08:55 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Nov 2012 03:08:45 +0000
Received: from pool-98-110-183-145.bstnma.fios.verizon.net ([98.110.183.145] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TVD3M-000CCM-HS	for cygwin-patches@cygwin.com; Mon, 05 Nov 2012 03:08:44 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 21CBA13C0C7	for <cygwin-patches@cygwin.com>; Sun,  4 Nov 2012 22:08:43 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+Ko7ukIHce5G9GdxrARGhG
Date: Mon, 05 Nov 2012 03:08:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] additional sys/termios.h defines
Message-ID: <20121105030843.GA2913@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1352083306.8040.10.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1352083306.8040.10.camel@YAAKOV04>
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
X-SW-Source: 2012-q4/txt/msg00046.txt.bz2

On Sun, Nov 04, 2012 at 08:41:46PM -0600, Yaakov (Cygwin/X) wrote:
>The attached patch adds a few defines to <sys/termios.h> to make it
>compatible with Linux and *BSD.
>
>2012-11-04  Yaakov Selkowitz  <yselkowitz@...>
>
>	* include/sys/termios.h (CBRK): Define as alias of CEOL.
>	(CREPRINT): Define as alias of CRPRNT.
>	(CDISCARD): Define as alias of CFLUSH.
>	(TTYDEF_*): Define.

Seems pretty straightforward.  Please check in.

Thanks.

cgf
