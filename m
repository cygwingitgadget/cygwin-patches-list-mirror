Return-Path: <cygwin-patches-return-6582-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20117 invoked by alias); 30 Jul 2009 15:35:42 -0000
Received: (qmail 20093 invoked by uid 22791); 30 Jul 2009 15:35:37 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_72,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f217.google.com (HELO mail-ew0-f217.google.com) (209.85.219.217)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 30 Jul 2009 15:35:28 +0000
Received: by ewy17 with SMTP id 17so391007ewy.2         for <cygwin-patches@cygwin.com>; Thu, 30 Jul 2009 08:35:25 -0700 (PDT)
Received: by 10.210.81.3 with SMTP id e3mr1643805ebb.12.1248968125514;         Thu, 30 Jul 2009 08:35:25 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 10sm1342560eyd.32.2009.07.30.08.35.24         (version=SSLv3 cipher=RC4-MD5);         Thu, 30 Jul 2009 08:35:25 -0700 (PDT)
Message-ID: <4A71C0CE.9040503@gmail.com>
Date: Thu, 30 Jul 2009 15:35:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix order of dtors problem.
References: <4A71A45A.10409@gmail.com> <20090730135150.GA31765@ednor.casa.cgf.cx> <20090730141107.GJ18621@calimero.vinschen.de>
In-Reply-To: <20090730141107.GJ18621@calimero.vinschen.de>
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
X-SW-Source: 2009-q3/txt/msg00036.txt.bz2

Corinna Vinschen wrote:
> On Jul 30 09:51, Christopher Faylor wrote:
>> On Thu, Jul 30, 2009 at 02:47:06PM +0100, Dave Korn wrote:
>>>  This is the patch I'm currently testing (so far, uneventfully).  I thought I'd
>>> send it here for posterity just in case I get squashed by a falling hippo or
>>> anything over the weekend.
>>>
>>> winsup/cygwin/ChangeLog:
>>>
>>> 	* globals.cc (enum exit_states::ES_GLOBAL_DTORS): Delete.
>>> 	* dcrt0.cc (__main): Schedule dll_global_dtors to run
>>> 	atexit before global dtors.
>>> 	(do_exit): Delete test for ES_GLOBAL_DTORS and call to
>>> 	dll_global_dtors.
>> FWIW, this looks fine.
> 
> I could simply check it in and create -53 from there...
> 

  That sounds like a fairly reasonable way of getting it some wider beta testing
than I can do on my own.  I think it's likely to all be OK, so how about we
change the plan to checking it in now and *reverting* it if any problems show up
by the other side of the weekend?

    cheers,
      DaveK
