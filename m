Return-Path: <cygwin-patches-return-7493-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19935 invoked by alias); 25 Aug 2011 19:33:39 -0000
Received: (qmail 19916 invoked by uid 22791); 25 Aug 2011 19:33:38 -0000
X-SWARE-Spam-Status: No, hits=-0.3 required=5.0	tests=AWL,BAYES_50,RCVD_IN_DNSWL_NONE,TW_YG,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm1-vm0.bullet.mail.sp2.yahoo.com (HELO nm1-vm0.bullet.mail.sp2.yahoo.com) (98.139.91.202)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 25 Aug 2011 19:33:24 +0000
Received: from [98.139.91.66] by nm1.bullet.mail.sp2.yahoo.com with NNFMP; 25 Aug 2011 19:33:24 -0000
Received: from [208.71.42.196] by tm6.bullet.mail.sp2.yahoo.com with NNFMP; 25 Aug 2011 19:33:24 -0000
Received: from [127.0.0.1] by smtp207.mail.gq1.yahoo.com with NNFMP; 25 Aug 2011 19:33:24 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@96.252.118.5 with login)        by smtp207.mail.gq1.yahoo.com with SMTP; 25 Aug 2011 12:33:18 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id BD52B42804D	for <cygwin-patches@cygwin.com>; Thu, 25 Aug 2011 15:33:17 -0400 (EDT)
Date: Thu, 25 Aug 2011 19:33:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Overflow cygthreads (those which use simplestub) don't set notify_detached event which may cause timer_delete to hung
Message-ID: <20110825193317.GA11398@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CALqHt2Da1+232daBQOVzsg8emudkpgJL+5tPF5rL4ZSSMT9qsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALqHt2Da1+232daBQOVzsg8emudkpgJL+5tPF5rL4ZSSMT9qsg@mail.gmail.com>
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
X-SW-Source: 2011-q3/txt/msg00069.txt.bz2

On Thu, Aug 25, 2011 at 08:06:08PM +0100, Rafal Zwierz wrote:
>* cygthread.cc (cygthread::simplestub): Notify that the thread has
>detached also in freerange thread case.

Looks good.  I'll check this in.  Thanks.

cgf
