Return-Path: <cygwin-patches-return-7606-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9509 invoked by alias); 24 Feb 2012 20:31:29 -0000
Received: (qmail 9499 invoked by uid 22791); 24 Feb 2012 20:31:29 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 24 Feb 2012 20:31:13 +0000
Received: from pool-173-76-50-112.bstnma.fios.verizon.net ([173.76.50.112] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1S11nM-000Oa0-Ki	for cygwin-patches@cygwin.com; Fri, 24 Feb 2012 20:31:12 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id DE33313C002	for <cygwin-patches@cygwin.com>; Fri, 24 Feb 2012 15:31:11 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+2Q+aVzQ1IirncAEXvTxRc
Date: Fri, 24 Feb 2012 20:31:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add pldd(1)
Message-ID: <20120224203111.GB19740@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1330072720.7808.10.camel@YAAKOV04> <20120224094707.GB20683@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120224094707.GB20683@calimero.vinschen.de>
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
X-SW-Source: 2012-q1/txt/msg00029.txt.bz2

On Fri, Feb 24, 2012 at 10:47:07AM +0100, Corinna Vinschen wrote:
>On Feb 24 02:38, Yaakov (Cygwin/X) wrote:
>> The pldd(1) command apparently originates from Solaris and was added to
>> glibc-2.15[1].  Patches and new file attached.
>
>Looks good, works fine.  Please apply.

It's not entirely fine.  Minor nits:

- The comment says "pldd.cc" but it's pldd.c.

- There was no ChangeLog entry announcing its checkin.

cgf
