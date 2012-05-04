Return-Path: <cygwin-patches-return-7659-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29400 invoked by alias); 4 May 2012 05:47:05 -0000
Received: (qmail 29389 invoked by uid 22791); 4 May 2012 05:47:03 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 04 May 2012 05:46:50 +0000
Received: from pool-98-110-183-154.bstnma.fios.verizon.net ([98.110.183.154] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1SQBLt-000CQJ-N8	for cygwin-patches@cygwin.com; Fri, 04 May 2012 05:46:49 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 1E92E13C0C0	for <cygwin-patches@cygwin.com>; Fri,  4 May 2012 01:46:49 -0400 (EDT)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+wlfACYm9NJwh+QL31agPR
Date: Fri, 04 May 2012 05:47:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: elf.h incomplete
Message-ID: <20120504054649.GA30831@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4FA281E3.4020008@samsung.com> <CA+sc5mnHw0CuSzaPiAV4ALQVEKs6_Nc20JrEvu-r121nZU3REg@mail.gmail.com> <4FA2870D.1030604@samsung.com> <4FA28961.2010407@cs.utoronto.ca> <4FA28F35.6060000@samsung.com> <4FA29070.1060300@gmail.com> <20120503152458.GB22355@ednor.casa.cgf.cx> <4FA300AB.3080306@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FA300AB.3080306@users.sourceforge.net>
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
X-SW-Source: 2012-q2/txt/msg00028.txt.bz2

On Thu, May 03, 2012 at 05:03:23PM -0500, Yaakov (Cygwin/X) wrote:
>On 2012-05-03 10:24, Christopher Faylor wrote:
>> Right.  I've noticed the incompleteness of elf.h from time to time too but
>> extending it would be tedious since you can't just cut/paste from a GPLv*
>> file.  Maybe one of the BSDs has something more complete these days?  We
>> could use one of those.
>
>This patch is a direct copy from FreeBSD HEAD.  I have NOT tested it, 
>though.

I think this really needs to be tested against something that uses it.

Anyone have an application that could exercise this?

cgf
