Return-Path: <cygwin-patches-return-7688-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30218 invoked by alias); 27 Jul 2012 15:00:19 -0000
Received: (qmail 30201 invoked by uid 22791); 27 Jul 2012 15:00:17 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,TW_YG
X-Spam-Check-By: sourceware.org
Received: from mho-01-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.71)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 27 Jul 2012 15:00:02 +0000
Received: from pool-173-76-45-230.bstnma.fios.verizon.net ([173.76.45.230] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1Sum1J-0001Aa-OI	for cygwin-patches@cygwin.com; Fri, 27 Jul 2012 15:00:01 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id C9B60429680	for <cygwin-patches@cygwin.com>; Fri, 27 Jul 2012 11:00:00 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/JwkwGpRt/M3P1ql+TNhvF
Date: Fri, 27 Jul 2012 15:00:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: New modes for cygpath that terminate path with null byte, nothing
Message-ID: <20120727150000.GA10003@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <50124C62.9080405@dancol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50124C62.9080405@dancol.org>
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
X-SW-Source: 2012-q3/txt/msg00009.txt.bz2

On Fri, Jul 27, 2012 at 01:08:02AM -0700, Daniel Colascione wrote:
>I wrote this patch because I often write this:
>
>$ cygpath -aw foo > /dev/clipboard
>
>Today, cygpath always appends a newline to the information in the
>clipboard, which is annoying when trying to paste into a program that
>interprets newlines specially. This patch implements two new options:
>-0/--null and -n/--no-newline. The former separates all paths output by
>cygpath with a null byte; the latter separates them with nothing at all.
>With -n, my example above works more smoothly and pastes don't include a
>newline.

You could trivially accomplish these tasks with the use of 'tr':

cygpath -aw foo | tr -d '\n' > /dev/clipboard
cygpath -aw foo | tr '\n' '\0' >/dev/clipboard

cgf
