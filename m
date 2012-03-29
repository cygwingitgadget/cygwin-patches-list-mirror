Return-Path: <cygwin-patches-return-7630-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25269 invoked by alias); 29 Mar 2012 14:45:40 -0000
Received: (qmail 25254 invoked by uid 22791); 29 Mar 2012 14:45:38 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 29 Mar 2012 14:45:23 +0000
Received: from pool-173-76-45-163.bstnma.fios.verizon.net ([173.76.45.163] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1SDGbL-000KH9-9N	for cygwin-patches@cygwin.com; Thu, 29 Mar 2012 14:45:23 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 709CC13C002	for <cygwin-patches@cygwin.com>; Thu, 29 Mar 2012 10:45:22 -0400 (EDT)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/Qe5flrV2ymtGFqQcarnBx
Date: Thu, 29 Mar 2012 14:45:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Compiler warnings when building latest cygwin cvs with gcc-4.6 (1/2)
Message-ID: <20120329144522.GD12164@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4F747373.5030605@cs.utoronto.ca> <4F7473FE.2020704@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F7473FE.2020704@cs.utoronto.ca>
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
X-SW-Source: 2012-q1/txt/msg00053.txt.bz2

On Thu, Mar 29, 2012 at 10:38:54AM -0400, Ryan Johnson wrote:
>On 29/03/2012 10:36 AM, Ryan Johnson wrote:
>> Patch 1: fix function attribute conflicts

Sorry, I appreciate the effort but I'd rather deal with these types of
issues when we have a newer version of gcc available.  If we don't have
that we can only take your word for it that things are fixed.  And, it
it is tedious to inspect each change individually to see if you've done
things the way I think they should be done or if there should be a more
global change.

I routinely sweep through the sources when we have a new version of gcc
available.  I'll do the same when we have a new version of gcc.

cgf
