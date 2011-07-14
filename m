Return-Path: <cygwin-patches-return-7427-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23298 invoked by alias); 14 Jul 2011 16:51:20 -0000
Received: (qmail 23287 invoked by uid 22791); 14 Jul 2011 16:51:19 -0000
X-SWARE-Spam-Status: No, hits=-1.5 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,TW_EG,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm8.bullet.mail.sp2.yahoo.com (HELO nm8.bullet.mail.sp2.yahoo.com) (98.139.91.78)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 14 Jul 2011 16:50:39 +0000
Received: from [98.139.91.64] by nm8.bullet.mail.sp2.yahoo.com with NNFMP; 14 Jul 2011 16:50:39 -0000
Received: from [208.71.42.201] by tm4.bullet.mail.sp2.yahoo.com with NNFMP; 14 Jul 2011 16:50:39 -0000
Received: from [127.0.0.1] by smtp212.mail.gq1.yahoo.com with NNFMP; 14 Jul 2011 16:50:38 -0000
Received: from cgf.cx (cgf@108.49.32.184 with login)        by smtp212.mail.gq1.yahoo.com with SMTP; 14 Jul 2011 09:50:38 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 7531B13C002	for <cygwin-patches@cygwin.com>; Thu, 14 Jul 2011 12:50:37 -0400 (EDT)
Date: Thu, 14 Jul 2011 16:51:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix for sigsegv in gcc 4.6
Message-ID: <20110714165028.GA15854@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E1CA325.7090802@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E1CA325.7090802@gmail.com>
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
X-SW-Source: 2011-q3/txt/msg00003.txt.bz2

On Wed, Jul 13, 2011 at 04:40:21AM +0900, jojelino wrote:
>i think it's about 5 month between preceeding one.
>missing WINAPI(__stdcall) which should had been added for function 
>pointer type is now cause of SIGSEGV. hence it is added.
>this changes applies to winsup/cygwin/environ,autoload.cc 
>winsup/utils/mkpasswd,mkgroup.c,loadlib.h,cygpath.cc
>and in autoload.cc, ebp+4 maybe not frame pointer, but we can make sure 
>it replaces return address by using __builtin_frame_address.
>this change applies to winsup/cygwin/autoload.cc
>
>patch,changelog modified are attached as you can see.
>please review it.

Given the fact that you're changing a fundamental part of Cygwin, I'd
classify this change as nontrivial.  I think you need a copyright
assignment as per http://cygwin.com/contrib.html .

cgf
