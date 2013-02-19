Return-Path: <cygwin-patches-return-7813-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13322 invoked by alias); 19 Feb 2013 00:39:56 -0000
Received: (qmail 13223 invoked by uid 22791); 19 Feb 2013 00:39:55 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SARE_SUB_OBFU_Q1
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 19 Feb 2013 00:39:46 +0000
Received: from pool-173-76-49-193.bstnma.fios.verizon.net ([173.76.49.193] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1U7bFJ-0001fg-9t	for cygwin-patches@cygwin.com; Tue, 19 Feb 2013 00:39:45 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 6F3128804BC	for <cygwin-patches@cygwin.com>; Mon, 18 Feb 2013 19:39:44 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19GITuLWxZros97Nu4uwSHT
Date: Tue, 19 Feb 2013 00:39:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Qsort defects (in C-library)
Message-ID: <20130219003944.GC2682@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1361206282.74694.YahooMailNeo@web141004.mail.bf1.yahoo.com> <20130218210511.GA30648@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130218210511.GA30648@calimero.vinschen.de>
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
X-SW-Source: 2013-q1/txt/msg00024.txt.bz2

On Mon, Feb 18, 2013 at 10:05:11PM +0100, Corinna Vinschen wrote:
>On Feb 18 08:51, Dennis de Champeaux wrote:
>> 
>> 
>> // I hope this is the proper mailing list
>
>Unfortunately it's not.  Qsort is not implemented in Cygwin itself, but
>rather in newlib, the underlying C lib.  The right mailing list is
>newlib AT sourceware DOT org.
>It's also kind of good style not to send the entire code, but rather a
>context diff relative to current CVS.  For anonymous CVS access, see the
>"Download" link at http://sourceware.org/newlib/

i.e., "a patch" like the name cygwin-patches implies.

cgf
