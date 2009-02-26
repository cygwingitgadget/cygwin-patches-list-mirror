Return-Path: <cygwin-patches-return-6418-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 933 invoked by alias); 26 Feb 2009 16:15:16 -0000
Received: (qmail 916 invoked by uid 22791); 26 Feb 2009 16:15:13 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f167.google.com (HELO mail-fx0-f167.google.com) (209.85.220.167)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 26 Feb 2009 16:14:41 +0000
Received: by fxm11 with SMTP id 11so640040fxm.2         for <cygwin-patches@cygwin.com>; Thu, 26 Feb 2009 08:14:38 -0800 (PST)
Received: by 10.86.4.2 with SMTP id 2mr2598797fgd.64.1235664877963;         Thu, 26 Feb 2009 08:14:37 -0800 (PST)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id k5sm7397648nfd.71.2009.02.26.08.14.37         (version=SSLv3 cipher=RC4-MD5);         Thu, 26 Feb 2009 08:14:37 -0800 (PST)
Message-ID: <49A6C215.40407@gmail.com>
Date: Thu, 26 Feb 2009 16:15:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] gethostbyname2
References: <0KFO009T9G34ZQ6E@vms173009.mailsrvcs.net> <08f301c99827$095c9a20$4e0410ac@wirelessworld.airvananet.com>
In-Reply-To: <08f301c99827$095c9a20$4e0410ac@wirelessworld.airvananet.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00016.txt.bz2

Pierre A. Humblet wrote:

> I am still fighting one issue with Windows. On XP, when using the native
> gethostbyname I can resolve computers on my local net (through NetBIOS or
> such). But I can't get them with DnsQuery, except my own computer, despite
> what I think the doc says. Any insight?

  Are you running / not-running the "DNS Client" service?  What happens if you
do the opposite of however it is now?  (Or even just restart it, if already
running, sometimes it gets persistently confused).

    cheers,
      DaveK
