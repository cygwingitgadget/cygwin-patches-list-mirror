Return-Path: <cygwin-patches-return-7676-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28438 invoked by alias); 10 Jun 2012 18:25:15 -0000
Received: (qmail 28428 invoked by uid 22791); 10 Jun 2012 18:25:14 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-01-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.71)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 10 Jun 2012 18:25:02 +0000
Received: from pool-98-110-186-36.bstnma.fios.verizon.net ([98.110.186.36] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1Sdmov-000ITW-B1	for cygwin-patches@cygwin.com; Sun, 10 Jun 2012 18:25:01 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 2A9FC13C0C1	for <cygwin-patches@cygwin.com>; Sun, 10 Jun 2012 14:25:01 -0400 (EDT)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18KgNmjkta91WZxaN9OxiI4
Date: Sun, 10 Jun 2012 18:25:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: elf.h incomplete
Message-ID: <20120610182501.GA32575@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CA+sc5mnHw0CuSzaPiAV4ALQVEKs6_Nc20JrEvu-r121nZU3REg@mail.gmail.com> <4FA2870D.1030604@samsung.com> <4FA28961.2010407@cs.utoronto.ca> <4FA28F35.6060000@samsung.com> <4FA29070.1060300@gmail.com> <20120503152458.GB22355@ednor.casa.cgf.cx> <4FA300AB.3080306@users.sourceforge.net> <4FCED256.7030305@users.sourceforge.net> <20120606035249.GA22752@ednor.casa.cgf.cx> <4FD4E519.7000508@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FD4E519.7000508@users.sourceforge.net>
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
X-SW-Source: 2012-q2/txt/msg00045.txt.bz2

On Sun, Jun 10, 2012 at 01:19:05PM -0500, Yaakov (Cygwin/X) wrote:
>On 2012-06-05 22:52, Christopher Faylor wrote:
>> Sounds like it is good enough to check in.  We can tweak it as needed.
>
>That didn't take long. :-)  I had been testing with 3.3.7; the attached 
>additional defines are needed for building the 3.4.y kernels.  These 
>defines are from LLVM (llvm/Support/ELF.h), which is under NCSA (variant 
>of 3-clause BSD).  (Many more defines are available there as well, if 
>needed.)

Looks good.  Please check in.

cgf
