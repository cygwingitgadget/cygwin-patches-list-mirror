Return-Path: <cygwin-patches-return-7283-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18457 invoked by alias); 15 Apr 2011 03:42:56 -0000
Received: (qmail 18446 invoked by uid 22791); 15 Apr 2011 03:42:54 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,TW_GT,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm13-vm2.bullet.mail.ne1.yahoo.com (HELO nm13-vm2.bullet.mail.ne1.yahoo.com) (98.138.91.89)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Fri, 15 Apr 2011 03:42:48 +0000
Received: from [98.138.90.53] by nm13.bullet.mail.ne1.yahoo.com with NNFMP; 15 Apr 2011 03:42:47 -0000
Received: from [98.138.84.45] by tm6.bullet.mail.ne1.yahoo.com with NNFMP; 15 Apr 2011 03:42:47 -0000
Received: from [127.0.0.1] by smtp113.mail.ne1.yahoo.com with NNFMP; 15 Apr 2011 03:42:47 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp113.mail.ne1.yahoo.com with SMTP; 14 Apr 2011 20:42:46 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 15E664A801A	for <cygwin-patches@cygwin.com>; Thu, 14 Apr 2011 23:42:46 -0400 (EDT)
Date: Fri, 15 Apr 2011 03:42:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_getattr_np, pthread_setschedprio
Message-ID: <20110415034245.GA10924@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1302489035.4944.20.camel@YAAKOV04> <1302836432.5296.7.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1302836432.5296.7.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00049.txt.bz2

On Thu, Apr 14, 2011 at 10:00:32PM -0500, Yaakov (Cygwin/X) wrote:
>On Sun, 2011-04-10 at 21:30 -0500, Yaakov (Cygwin/X) wrote:
>> This patch adds two pthread functions which appear to be "low-hanging
>> fruit".
>> 
>> pthread_setschedprio(3) is a POSIX function[1][2] which changes the
>> scheduling priority for the given thread.  It is similar to
>> pthread_setschedparam(3) but does not change the scheduling policy and
>> doesn't require the priority to be wrapped in a struct.
>> 
>> pthread_getattr_np(3) is a GNU extension[3] which initializes the given
>> pthread_attr_t with the actual attributes of the given thread.  While
>> the example code does not have the pthread_attr_t pre-initialized by
>> pthread_attr_init(3), I have seen real world code where it is, so either
>> possibility is handled.
>
>After further analysis, I should work further on pthread_getattr_np() in
>conjunction with adding pthread_attr_getstack(), both of which I need
>for webkitgtk-1.3.13.  But it will be a couple of weeks before I'll have
>the time to get to that.
>
>So for now, lets just implement pthread_setschedprio(), which looks
>pretty straight-forward and is unrelated to the others.  Revised patch
>attached.

Looks ok.  Please check in.

Thanks.

cgf
