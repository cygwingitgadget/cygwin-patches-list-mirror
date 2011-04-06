Return-Path: <cygwin-patches-return-7274-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25730 invoked by alias); 6 Apr 2011 13:57:53 -0000
Received: (qmail 25713 invoked by uid 22791); 6 Apr 2011 13:57:52 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm7-vm0.bullet.mail.sp2.yahoo.com (HELO nm7-vm0.bullet.mail.sp2.yahoo.com) (98.139.91.192)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 06 Apr 2011 13:57:46 +0000
Received: from [98.139.91.70] by nm7.bullet.mail.sp2.yahoo.com with NNFMP; 06 Apr 2011 13:57:46 -0000
Received: from [98.136.185.45] by tm10.bullet.mail.sp2.yahoo.com with NNFMP; 06 Apr 2011 13:57:46 -0000
Received: from [127.0.0.1] by smtp106.mail.gq1.yahoo.com with NNFMP; 06 Apr 2011 13:57:46 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp106.mail.gq1.yahoo.com with SMTP; 06 Apr 2011 06:57:45 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id C7521428013	for <cygwin-patches@cygwin.com>; Wed,  6 Apr 2011 09:57:44 -0400 (EDT)
Date: Wed, 06 Apr 2011 13:57:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add an additional relocation attempt pass to load_after_fork()
Message-ID: <20110406135744.GA4912@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20110315075313.GA5722@calimero.vinschen.de> <20110315150412.GA18662@ednor.casa.cgf.cx> <20110315154609.GE4320@calimero.vinschen.de> <20110330211556.GE13484@calimero.vinschen.de> <20110330212951.GC28494@ednor.casa.cgf.cx> <4D99BCCE.60407@dronecode.org.uk> <20110404143917.GA1140@ednor.casa.cgf.cx> <4D9B3D5F.4040306@dronecode.org.uk> <20110405162102.GA18669@ednor.casa.cgf.cx> <4D9C5482.10303@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D9C5482.10303@dronecode.org.uk>
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
X-SW-Source: 2011-q2/txt/msg00040.txt.bz2

On Wed, Apr 06, 2011 at 12:54:42PM +0100, Jon TURNEY wrote:
>On 05/04/2011 17:21, Christopher Faylor wrote:
>> On Tue, Apr 05, 2011 at 05:03:43PM +0100, Jon TURNEY wrote:
>>> On 04/04/2011 15:39, Christopher Faylor wrote:
>> I'm trying to imagine a scenario where it would screw up to just do the
>> reserve_upto + "reserve the low block" and I can't think of one.  It's
>> potentially a little more work, of course, but I think it may catch the
>> more common failing conditions so it shouldn't be too noticeable.
>> 
>>>> If so, it seems like we're allocating and freeing the space up to the DLL more
>>>> than once.  I think we could avoid doing that.
>>>
>>> For performance reasons, I think you are right.  Or do you mean there is a
>>> correctness issue with that?
>>>
>>> If you indicate your preferences I'll respin the patch.
>>>
>>> 1) Combine passes 2 and 3
>> 
>> I'd prefer this.  If we can get people test the snapshot maybe we an
>> figure out if a separate loop is useful.
>
>Updated patch attached.

>2011-04-06  Jon TURNEY  <jon.turney@dronecode.org.uk>
>
>	* dll_init.cc (reserve_at, release_at): New functions.
>	(load_after_fork): If the DLL was loaded higher than the required
>	address, assume that it loaded at it's base address and also reserve
>	memory there to force it to be relocated.

This looks good except for formatting nits involving spaces before/after
parentheses.  I've checked it in with those very minor changes.

Thanks very much for this patch.

cgf
