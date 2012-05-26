Return-Path: <cygwin-patches-return-7664-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24235 invoked by alias); 26 May 2012 20:53:38 -0000
Received: (qmail 24225 invoked by uid 22791); 26 May 2012 20:53:37 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 26 May 2012 20:53:22 +0000
Received: from pool-98-110-186-36.bstnma.fios.verizon.net ([98.110.186.36] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1SYNzG-000ImC-5l	for cygwin-patches@cygwin.com; Sat, 26 May 2012 20:53:22 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 2BD5513C0C1	for <cygwin-patches@cygwin.com>; Sat, 26 May 2012 16:53:21 -0400 (EDT)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+2AgY4/c9JUBxB77OTqasV
Date: Sat, 26 May 2012 20:53:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ctrl-C and non-Cygwin programs
Message-ID: <20120526205321.GB9413@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4fbfd2bd.2a04440a.04d9.54ec@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fbfd2bd.2a04440a.04d9.54ec@mx.google.com>
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
X-SW-Source: 2012-q2/txt/msg00033.txt.bz2

On Fri, May 25, 2012 at 11:43:11AM -0700, Mark Lofdahl wrote:
>References: <4F73CF37.4020001@elfmimi.jp>
>
>On 28/03/2012 10:55 PM, Ein Terakawa wrote:
>
>>What it does actually is it generates CTRL_BREAK_EVENT with 
>>Windows Console API GenerateConsoleCtrlEvent on the arrival of SIGINT.
>>And to make this scheme to be functional it is required to specify
>>CREATE_NEW_PROCESS_GROUP when creating new non-Cygwin processes.
>
>
>Is there any way for me to get the old behavior? I rely heavily on the
>ability to press ctrl-c in my non-cygwin console app and have that app
>receive a CTRL_C_EVENT instead of a CTRL_BREAK_EVENT. Everything worked fine
>for me before this patch.
>
>>To my surprise there seem to be no way to generate CTRL_C_EVENT using API.
>
>It is possible to generate a CTRL_C_EVENT, if you pass 0 as the process
>group id, in which case the event is passed to all process that share the
>console. Don't know if that would work in this situation.
>http://msdn.microsoft.com/en-us/library/windows/desktop/ms683155.aspx

You're in the wrong mailing list.  You don't ask for stuff here, you provide
patches.  Please use the main Cygwin list.
