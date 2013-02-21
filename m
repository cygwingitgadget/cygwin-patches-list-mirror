Return-Path: <cygwin-patches-return-7823-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12680 invoked by alias); 21 Feb 2013 03:09:11 -0000
Received: (qmail 12669 invoked by uid 22791); 21 Feb 2013 03:09:10 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 21 Feb 2013 03:09:03 +0000
Received: from pool-173-76-49-193.bstnma.fios.verizon.net ([173.76.49.193] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1U8MWs-0000IX-IS	for cygwin-patches@cygwin.com; Thu, 21 Feb 2013 03:09:02 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 7B5708804BF	for <cygwin-patches@cygwin.com>; Wed, 20 Feb 2013 22:09:01 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18A5ObDTH/nySOAWbSIQJKz
Date: Thu, 21 Feb 2013 03:09:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Missing dllimport's in <error.h>
Message-ID: <20130221030901.GC2786@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130220203828.5216c525@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130220203828.5216c525@YAAKOV04>
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
X-SW-Source: 2013-q1/txt/msg00034.txt.bz2

On Wed, Feb 20, 2013 at 08:38:28PM -0600, Yaakov wrote:
>The attached patch for HEAD is required for compiling code which uses
><error.h> and -Wl,--disable-auto-import.
>
>
>Yaakov

>2013-02-20  Yaakov Selkowitz  <yselkowitz@...>
>
>	* include/error.h (error_message_count): Declare as dllimport.
>	(error_one_per_line): Ditto.
>	(error_print_progname): Ditto.

Looks right.  Please check in.

cgf
