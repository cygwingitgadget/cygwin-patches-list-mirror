Return-Path: <cygwin-patches-return-7535-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9304 invoked by alias); 3 Nov 2011 21:05:40 -0000
Received: (qmail 9286 invoked by uid 22791); 3 Nov 2011 21:05:38 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm13.access.bullet.mail.mud.yahoo.com (HELO nm13.access.bullet.mail.mud.yahoo.com) (66.94.237.214)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 03 Nov 2011 21:05:20 +0000
Received: from [66.94.237.192] by nm13.access.bullet.mail.mud.yahoo.com with NNFMP; 03 Nov 2011 21:05:20 -0000
Received: from [66.94.237.111] by tm3.access.bullet.mail.mud.yahoo.com with NNFMP; 03 Nov 2011 21:05:20 -0000
Received: from [127.0.0.1] by omp1016.access.mail.mud.yahoo.com with NNFMP; 03 Nov 2011 21:05:20 -0000
Received: (qmail 72880 invoked from network); 3 Nov 2011 21:05:20 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@98.110.183.46 with login)        by smtp102.vzn.mail.bf1.yahoo.com with SMTP; 03 Nov 2011 14:05:19 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 2CDA313C0D3	for <cygwin-patches@cygwin.com>; Thu,  3 Nov 2011 17:05:19 -0400 (EDT)
Date: Thu, 03 Nov 2011 21:05:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extend faq.using to discuss fork failures
Message-ID: <20111103210519.GA4294@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E570031.4080800@cs.utoronto.ca> <20110830090020.GE30452@calimero.vinschen.de> <4E5CE899.4030605@cs.utoronto.ca> <4EB2C2CD.1080400@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EB2C2CD.1080400@dronecode.org.uk>
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
X-SW-Source: 2011-q4/txt/msg00025.txt.bz2

On Thu, Nov 03, 2011 at 04:35:25PM +0000, Jon TURNEY wrote:
>On 30/08/2011 14:41, Ryan Johnson wrote:
>> That sounds reasonable, though I suspect we'd want want to keep the concluding
>> bits in the FAQ as well. Unfortunately, summertime free time has come to an
>> end so I don't know when I'll get to this next. Perhaps a good compromise for
>> now would be for you to post only the first FAQ question? That would at least
>> cut traffic to the cygwin ML a bit.
>
>I've updated Ryan's patch to hopefully address the comments made, polished the 
>language a bit in places, and split it into a patch for the FAQ which just 
>says how to fix problems and a patch for the UG which contains the technical 
>details.

>Index: doc/faq-using.xml
>===================================================================
>RCS file: /cvs/src/src/winsup/doc/faq-using.xml,v
>retrieving revision 1.35
>diff -u -p -r1.35 faq-using.xml
>--- doc/faq-using.xml	4 Aug 2011 18:25:41 -0000	1.35
>+++ doc/faq-using.xml	3 Nov 2011 16:26:56 -0000
>@@ -1099,7 +1099,7 @@ it.</para>
> IPv6 stack, see the <ulink url="http://www.microsoft.com/technet/network/ipv6/ipv6faq.mspx">Microsoft TechNet IPv6 FAQ article</ulink>
> </para></answer></qandaentry>
> 
>-<qandaentry id="faq.using.bloda">
>+<qandaentry id="faq.using.bloda" xreflabel="BLODA">
> <question><para>What applications have been found to interfere with Cygwin?</para></question>
> <answer>
> 
>@@ -1199,3 +1199,38 @@ such as virtual memory paging and file c
> </listitem>
> </itemizedlist></para>
> </answer></qandaentry>
>+
>+<qandaentry id='faq.using.fixing-fork-failures'>
>+  <question><para>How do I fix <literal>fork()</literal> failures?</para></question>
>+  <answer>
>+  <para>Unfortunately, Windows can be quite hostile to a

I would still prefer eschewing actively negative words like "hostile" and just
neutrally stating that Windows does not use a fork/exec model and does not offer
any easy way to implement fork.

I'd also like to see specific errors mentioned so that when people are searching for
a solution to the problem they will be able to find it in the FAQ.

cgf
