Return-Path: <cygwin-patches-return-7793-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30170 invoked by alias); 11 Jan 2013 14:42:53 -0000
Received: (qmail 30038 invoked by uid 22791); 11 Jan 2013 14:42:51 -0000
X-SWARE-Spam-Status: No, hits=-1.5 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 11 Jan 2013 14:42:43 +0000
Received: from pool-98-110-183-21.bstnma.fios.verizon.net ([98.110.183.21] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1Ttfog-000Cmq-Ty	for cygwin-patches@cygwin.com; Fri, 11 Jan 2013 14:42:43 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id B6EFB88052F	for <cygwin-patches@cygwin.com>; Fri, 11 Jan 2013 09:42:41 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/ekQ7nDEGr0JwaNrML85ec
Date: Fri, 11 Jan 2013 14:42:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Console modes: cursor style
Message-ID: <20130111144241.GA3450@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <50EFCE3C.8030607@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50EFCE3C.8030607@towo.net>
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
X-SW-Source: 2013-q1/txt/msg00004.txt.bz2

On Fri, Jan 11, 2013 at 09:33:00AM +0100, Thomas Wolff wrote:
>The attached patch adds two escape control sequences to the Cygwin Console:
>
>  * Show/Hide Cursor (DECTCEM)
>  * Set cursor style (DECSCUSR): block vs. underline cursor, or
>    arbitrary size (as an extension, using values > 4)

Thanks for doing this Thomas.  I'm sure the cygwin list user will be
pleased.

cgf
