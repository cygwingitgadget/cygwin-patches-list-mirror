Return-Path: <cygwin-patches-return-6585-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1554 invoked by alias); 4 Aug 2009 13:46:18 -0000
Received: (qmail 1542 invoked by uid 22791); 4 Aug 2009 13:46:18 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f217.google.com (HELO mail-ew0-f217.google.com) (209.85.219.217)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 04 Aug 2009 13:46:10 +0000
Received: by ewy17 with SMTP id 17so3358996ewy.2         for <cygwin-patches@cygwin.com>; Tue, 04 Aug 2009 06:46:07 -0700 (PDT)
Received: by 10.210.19.7 with SMTP id 7mr6726429ebs.52.1249393567012;         Tue, 04 Aug 2009 06:46:07 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 28sm3127852eyg.50.2009.08.04.06.46.05         (version=SSLv3 cipher=RC4-MD5);         Tue, 04 Aug 2009 06:46:05 -0700 (PDT)
Message-ID: <4A783EBA.5070807@gmail.com>
Date: Tue, 04 Aug 2009 13:46:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: Dave Korn <dave.korn.cygwin@googlemail.com>
CC: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix order of dtors problem.
References: <4A71A45A.10409@gmail.com> <20090730135150.GA31765@ednor.casa.cgf.cx> <20090730141107.GJ18621@calimero.vinschen.de> <4A71C0CE.9040503@gmail.com>
In-Reply-To: <4A71C0CE.9040503@gmail.com>
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
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00039.txt.bz2

Dave Korn wrote:

>   That sounds like a fairly reasonable way of getting it some wider beta testing
> than I can do on my own.  I think it's likely to all be OK, so how about we
> change the plan to checking it in now and *reverting* it if any problems show up
> by the other side of the weekend?

  FTR: All the tests ran to completion with no unexpected or anomalous side-effects.

    cheers,
      DaveK
