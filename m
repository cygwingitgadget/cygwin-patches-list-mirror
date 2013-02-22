Return-Path: <cygwin-patches-return-7829-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31217 invoked by alias); 22 Feb 2013 06:51:19 -0000
Received: (qmail 31203 invoked by uid 22791); 22 Feb 2013 06:51:18 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,TW_SF
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 22 Feb 2013 06:51:12 +0000
Received: from pool-173-76-49-193.bstnma.fios.verizon.net ([173.76.49.193] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1U8mTP-00094T-AF	for cygwin-patches@cygwin.com; Fri, 22 Feb 2013 06:51:11 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 91F4F880488	for <cygwin-patches@cygwin.com>; Fri, 22 Feb 2013 01:51:10 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/KvoKeE5ZiIq0sKnUmYfc7
Date: Fri, 22 Feb 2013 06:51:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Export <io.h> symbols with underscore
Message-ID: <20130222065110.GA7834@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130220151600.5983c15a@YAAKOV04> <20130221011432.GA2786@ednor.casa.cgf.cx> <20130221111545.GA24054@calimero.vinschen.de> <20130221194236.GA1163@ednor.casa.cgf.cx> <20130222001848.7049805a@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130222001848.7049805a@YAAKOV04>
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
X-SW-Source: 2013-q1/txt/msg00040.txt.bz2

On Fri, Feb 22, 2013 at 12:18:48AM -0600, Yaakov wrote:
>On Thu, 21 Feb 2013 14:42:36 -0500, Christopher Faylor wrote:
>> I wasn't fulling grokking the fact that Cygwin explicitly defined the
>> get_osfhandle without an underscore in io.h.  Sigh.  That's probably my
>> fault too.
>> 
>> But we definitely shouldn't be going back to adding "_" decorations.  I
>> have deleted a few of these and no one has complained.  I know that
>> isn't a scientific sampling but it's hard to believe that someone has
>> written code which actually goes out of its way to prepend an underscore
>> in front of a standard UNIX function name, especially since we do not,
>> AFAIK, define these functions in any header file.
>> 
>> So, I guess I don't understand why we need to add an underscore now
>> when we have gotten by with the incorrect declaration for get_osfhandle
>> all of these years.
>
>Because even if it caused a warning in C, the link still succeeded with
>the underscored symbol.

Ok.  I think we should also change io.h to only define _get_osfhandle on
both 64-bit and the trunk version of cygwin.  Ditto for _setmode.  And,
IMO, the access() declaration should be removed from io.h entirely.

cgf
