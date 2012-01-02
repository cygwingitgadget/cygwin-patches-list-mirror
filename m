Return-Path: <cygwin-patches-return-7586-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31177 invoked by alias); 2 Jan 2012 18:12:02 -0000
Received: (qmail 31161 invoked by uid 22791); 2 Jan 2012 18:12:00 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 02 Jan 2012 18:11:44 +0000
Received: from pool-173-76-50-112.bstnma.fios.verizon.net ([173.76.50.112] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1RhmMJ-0008YV-Pk	for cygwin-patches@cygwin.com; Mon, 02 Jan 2012 18:11:43 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 2A0E513C022	for <cygwin-patches@cygwin.com>; Mon,  2 Jan 2012 13:11:43 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX180knSf72F2k4kCfsvr6U7v
Date: Mon, 02 Jan 2012 18:12:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add pthread_sigqueue(3)
Message-ID: <20120102181143.GC9433@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1325444340.6724.15.camel@YAAKOV04> <20120102175952.GB9433@ednor.casa.cgf.cx> <4F01F2D1.6000501@dancol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F01F2D1.6000501@dancol.org>
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
X-SW-Source: 2012-q1/txt/msg00009.txt.bz2

On Mon, Jan 02, 2012 at 10:09:21AM -0800, Daniel Colascione wrote:
>On 1/2/12 9:59 AM, Christopher Faylor wrote:
>> On Sun, Jan 01, 2012 at 12:59:00PM -0600, Yaakov (Cygwin/X) wrote:
>> I guess this can go in since I already "implemented" sigqueue but
>> SI_QUEUE isn't actually fully functional.  Cygwin doesn't queue signals
>> and I don't believe it handles the sigval union correctly.
>
>By the way: have you had a chance to track down the signal-related
>crash bug at http://sourceware.org/ml/cygwin/2010-04/msg00989.html ? I
>can still reproduce it.

This is not a bug-reporting mailing list.
