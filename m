Return-Path: <cygwin-patches-return-7311-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4763 invoked by alias); 5 May 2011 20:07:34 -0000
Received: (qmail 4747 invoked by uid 22791); 5 May 2011 20:07:33 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm16-vm0.bullet.mail.sp2.yahoo.com (HELO nm16-vm0.bullet.mail.sp2.yahoo.com) (98.139.91.210)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 05 May 2011 20:07:18 +0000
Received: from [98.139.91.69] by nm16.bullet.mail.sp2.yahoo.com with NNFMP; 05 May 2011 20:07:18 -0000
Received: from [98.136.185.40] by tm9.bullet.mail.sp2.yahoo.com with NNFMP; 05 May 2011 20:07:18 -0000
Received: from [127.0.0.1] by smtp101.mail.gq1.yahoo.com with NNFMP; 05 May 2011 20:07:18 -0000
Received: from cgf.cx (cgf@108.49.31.43 with login)        by smtp101.mail.gq1.yahoo.com with SMTP; 05 May 2011 13:07:17 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id C60314A800A	for <cygwin-patches@cygwin.com>; Thu,  5 May 2011 16:07:16 -0400 (EDT)
Date: Thu, 05 May 2011 20:07:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] tcsetpgrp fails unexpectedly
Message-ID: <20110505200716.GB30765@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20110404171529.GA6155@ednor.casa.cgf.cx> <20110404192300.C2F931ED79B9@scythe.noid.net> <20110505171054.GE29608@ednor.casa.cgf.cx> <20110505172303.GH32085@calimero.vinschen.de> <20110505181924.GJ32085@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110505181924.GJ32085@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00077.txt.bz2

On Thu, May 05, 2011 at 08:19:24PM +0200, Corinna Vinschen wrote:
>On May  5 19:23, Corinna Vinschen wrote:
>> On May  5 13:10, Christopher Faylor wrote:
>> > On Mon, Apr 04, 2011 at 12:23:00PM -0700, Tor Perkins wrote:
>> > >
>> > >> Thanks for the patch and the report.  I'll take a look at this in detail
>> > >> in the next couple of days.  However, unfortunately, I think this is a
>> > >> large enough submission that it requires an assignment form.
>> > >
>> > >Thanks for looking into it!
>> > >
>> > >My assignment form is in the "snail".
>> > 
>> > Corinna, did you receive this?  Did I miss a notification?
>> 
>> Thanks for the reminder.  The notification was supposed to go directly
>> to you because I was on vacation at the time.  I'll check.
>
>Due to, let's say, "technical" problems I can't answer this question
>before Monday.  It seems the CA arrived and was signed, but somebody
>has to check.

Ok.  I'll put this in a cron job to send query email every hour until
it's resolved.

HTH.

cgf
