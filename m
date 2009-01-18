Return-Path: <cygwin-patches-return-6409-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29195 invoked by alias); 18 Jan 2009 21:58:07 -0000
Received: (qmail 29184 invoked by uid 22791); 18 Jan 2009 21:58:06 -0000
X-SWARE-Spam-Status: No, hits=-2.3 required=5.0 	tests=AWL,BAYES_00,KAM_MX,SPF_HELO_PASS,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (66.187.233.31)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Jan 2009 21:57:57 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254]) 	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n0ILvtnV009534; 	Sun, 18 Jan 2009 16:57:55 -0500
Received: from greed.delorie.com (vpn-12-122.rdu.redhat.com [10.11.12.122]) 	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n0ILvuAo012925; 	Sun, 18 Jan 2009 16:57:56 -0500
Received: from greed.delorie.com (greed.delorie.com [127.0.0.1] (may be forged)) 	by greed.delorie.com (8.14.3/8.14.3) with ESMTP id n0ILvrKQ020271; 	Sun, 18 Jan 2009 16:57:54 -0500
Received: (from dj@localhost) 	by greed.delorie.com (8.14.3/8.14.3/Submit) id n0ILvr72020268; 	Sun, 18 Jan 2009 16:57:53 -0500
Date: Sun, 18 Jan 2009 21:58:00 -0000
Message-Id: <200901182157.n0ILvr72020268@greed.delorie.com>
From: DJ Delorie <dj@redhat.com>
To: "Dave Korn" <dave.korn.cygwin@googlemail.com>
CC: gcc-patches@gcc.gnu.org, binutils@sourceware.org,         gdb-patches@sourceware.org, cygwin-patches@cygwin.com,         kirkshorts@googlemail.com
In-reply-to: <2ca21dcc0901181338l41a01dafm256938683877ce59@mail.gmail.com> 	(dave.korn.cygwin@googlemail.com)
Subject: Re: [PATCH/libiberty] Fix PR38903 Cygwin GCC bootstrap failure [was Re: Libiberty issue vs cygwin [was Re: This is a Cygwin failure yeah?]]
References: <2ca21dcc0901171652s44c72ca7teb1ca6041344e4a4@mail.gmail.com> 	 <200901181707.n0IH7AGJ013144@greed.delorie.com> <2ca21dcc0901181338l41a01dafm256938683877ce59@mail.gmail.com>
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00007.txt.bz2


>   Thanks, applied.  I'm feeling lazy: there's still an auto-merger
> that'll port it across to src/ for me, isn't there?

Semi-automatic.  If you don't merge it, I have a cron job that does
everything but the "cvs commit" (and writes a script to do that, too).
I see the email and run the generated script to commit the actual
changes.

So if you're not in a rush, yes, I'll merge it eventually.  The script
runs once an hour, but that doesn't mean I'm watching it every hour ;-)
