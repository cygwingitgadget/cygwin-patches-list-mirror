Return-Path: <cygwin-patches-return-7228-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25236 invoked by alias); 30 Mar 2011 19:25:19 -0000
Received: (qmail 25224 invoked by uid 22791); 30 Mar 2011 19:25:18 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_LOW,TW_CG
X-Spam-Check-By: sourceware.org
Received: from out3.smtp.messagingengine.com (HELO out3.smtp.messagingengine.com) (66.111.4.27)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 30 Mar 2011 19:25:12 +0000
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])	by gateway1.messagingengine.com (Postfix) with ESMTP id 6628220990	for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2011 15:25:11 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])  by compute2.internal (MEProxy); Wed, 30 Mar 2011 15:25:11 -0400
Received: from [158.147.71.25] (158-147-71-25.harris.com [158.147.71.25])	by mail.messagingengine.com (Postfix) with ESMTPSA id 28B29405760;	Wed, 30 Mar 2011 15:25:11 -0400 (EDT)
Message-ID: <4D938396.7060407@cwilson.fastmail.fm>
Date: Wed, 30 Mar 2011 19:25:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
Reply-To: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: patch for icmp.h
References: <4D93786B.9050304@bogomips.com>
In-Reply-To: <4D93786B.9050304@bogomips.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00083.txt.bz2

On 3/30/2011 2:37 PM, John Paul Morrison wrote:
> This patch adds missing icmp types and definitions needs for source
> compatibility, and it seems to work for raw icmp sockets.
> My only changes is renaming __USE_BSD which is used by Linux. It doesn't
> look like cygwin has an equivalent and didn't want to add a potentially
> conflicting #define. The other option would be removing the #ifdef
> completely.
...
> I understand that raw/icmp sockets may be undocumented in Windows;
> Cygwin and/or windows and/or the myping.c test program may be buggy etc.
> The test program was able to put a valid ICMP echo request on the wire
> with correct ip and icmp headers in the correct endianness , so at least
> some raw socket functions are working

Well, they will only work in general on XP32 and older, not XP64, Vista,
or newer -- as you need admin rights to muck with raw or icmp sockets on
those OSs.

It's interesting this comes up now. Recently there was another thread
concerning ICMP:
http://cygwin.com/ml/cygwin/2011-03/msg00449.html
Especially Corinna's reply:
> Still, if you think you can make use of the tool anyway, try to fetch
> the netinet/ip6.h and netinet/icmp6.h headers from FreeBSD.  Both

That advice works here, too: if you want to add stuff to cygwin, you're
better off using BSD sources instead of GPLed ones (see below).

There was also some talk concerning w32api support for icmp
functionality, which may (or may not) be relevant:
http://cygwin.com/ml/cygwin/2011-03/msg00472.html


> --- snap/usr/include/cygwin/icmp.h    2011-03-27 12:31:43.000000000 -0700
> +++ /usr/include/cygwin/icmp.h    2011-03-28 16:02:20.842491500 -0700
> @@ -1 +1,291 @@
>  /* icmp.h */
> +
> +
> +/* Copyright (C) 1991, 92, 93, 95, 96, 97, 99 Free Software Foundation,
> Inc.
> +   This file is part of the GNU C Library.

If you're trying to add something to cygwin, it has to be copyright
assignable to Red Hat or available under a non-copyleft license (like
BSD) -- because otherwise Red Hat can't add (a) release it commercially,
nor (b) add the section 10(?) "other open source licenses" exception.
Since this patch is directly copied from GNU C, to which you do not own
the rights, you can't then assign them to Red Hat.  So, this patch, in
this form, can't be accepted (if I'm wrong, I'm sure Corinna or cgf will
correct me -- but I don't think I am).

And in any case, you'll need to fill out a copyright assignment
yourself, for any contribution of this size.

--
Chuck

