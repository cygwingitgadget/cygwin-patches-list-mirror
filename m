Return-Path: <cygwin-patches-return-7190-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31547 invoked by alias); 10 Feb 2011 15:34:22 -0000
Received: (qmail 31310 invoked by uid 22791); 10 Feb 2011 15:34:22 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm22-vm0.bullet.mail.bf1.yahoo.com (HELO nm22-vm0.bullet.mail.bf1.yahoo.com) (98.139.212.126)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 10 Feb 2011 15:34:16 +0000
Received: from [98.139.212.150] by nm22.bullet.mail.bf1.yahoo.com with NNFMP; 10 Feb 2011 15:34:14 -0000
Received: from [98.139.213.13] by tm7.bullet.mail.bf1.yahoo.com with NNFMP; 10 Feb 2011 15:34:14 -0000
Received: from [127.0.0.1] by smtp113.mail.bf1.yahoo.com with NNFMP; 10 Feb 2011 15:34:14 -0000
Received: from cgf.cx (cgf@72.70.43.36 with login)        by smtp113.mail.bf1.yahoo.com with SMTP; 10 Feb 2011 07:34:14 -0800 PST
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 9255B13C0CA	for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2011 10:34:13 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 912EE2B352; Thu, 10 Feb 2011 10:34:13 -0500 (EST)
Date: Thu, 10 Feb 2011 15:34:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: provide __xpg_strerror_r
Message-ID: <20110210153413.GD26842@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D4DAD40.3060904@redhat.com> <20110205202806.GA11118@ednor.casa.cgf.cx> <4D4DB682.3070601@redhat.com> <20110206095423.GA19356@calimero.vinschen.de> <4D532F6B.5080104@redhat.com> <20110210021547.GA26395@ednor.casa.cgf.cx> <20110210095054.GA2305@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110210095054.GA2305@calimero.vinschen.de>
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
X-SW-Source: 2011-q1/txt/msg00045.txt.bz2

On Thu, Feb 10, 2011 at 10:50:54AM +0100, Corinna Vinschen wrote:
>On Feb  9 21:15, Christopher Faylor wrote:
>> On Wed, Feb 09, 2011 at 05:20:59PM -0700, Eric Blake wrote:
>> >+/* Newlib's <string.h> provides declarations for two strerror_r
>> >+   variants, according to preprocessor feature macros.  It does the
>> >+   right thing for GNU strerror_r, but its __xpg_strerror_r mishandles
>> >+   a case of EINVAL when coupled with our strerror() override.*/
>> > #if 0
>> 
>> Can't we get rid of this now?
>
>I agree.  We should simply implement strerror_r by ourselves, even if
>it's identical to newlib's strerror_r.  In the long run it's less
>puzzeling to have all the strerror variants in one place.

Whichever we do, we surely don't need an #if 0/#endif in the code.

cgf
