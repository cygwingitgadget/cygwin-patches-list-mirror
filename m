Return-Path: <cygwin-patches-return-7272-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28308 invoked by alias); 5 Apr 2011 16:22:31 -0000
Received: (qmail 28292 invoked by uid 22791); 5 Apr 2011 16:22:28 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm2.bullet.mail.ne1.yahoo.com (HELO nm2.bullet.mail.ne1.yahoo.com) (98.138.90.65)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 05 Apr 2011 16:22:23 +0000
Received: from [98.138.90.50] by nm2.bullet.mail.ne1.yahoo.com with NNFMP; 05 Apr 2011 16:22:22 -0000
Received: from [98.138.84.34] by tm3.bullet.mail.ne1.yahoo.com with NNFMP; 05 Apr 2011 16:22:22 -0000
Received: from [127.0.0.1] by smtp102.mail.ne1.yahoo.com with NNFMP; 05 Apr 2011 16:22:22 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp102.mail.ne1.yahoo.com with SMTP; 05 Apr 2011 09:22:00 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 65293428013	for <cygwin-patches@cygwin.com>; Tue,  5 Apr 2011 12:21:02 -0400 (EDT)
Date: Tue, 05 Apr 2011 16:22:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add an additional relocation attempt pass to load_after_fork()
Message-ID: <20110405162102.GA18669@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20110313152111.GA7064@calimero.vinschen.de> <4D7E908B.4010004@dronecode.org.uk> <20110315075313.GA5722@calimero.vinschen.de> <20110315150412.GA18662@ednor.casa.cgf.cx> <20110315154609.GE4320@calimero.vinschen.de> <20110330211556.GE13484@calimero.vinschen.de> <20110330212951.GC28494@ednor.casa.cgf.cx> <4D99BCCE.60407@dronecode.org.uk> <20110404143917.GA1140@ednor.casa.cgf.cx> <4D9B3D5F.4040306@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D9B3D5F.4040306@dronecode.org.uk>
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
X-SW-Source: 2011-q2/txt/msg00038.txt.bz2

On Tue, Apr 05, 2011 at 05:03:43PM +0100, Jon TURNEY wrote:
>On 04/04/2011 15:39, Christopher Faylor wrote:
>> On Mon, Apr 04, 2011 at 01:42:54PM +0100, Jon TURNEY wrote:
>>> Attached is an updated version of the patch which fixes the warning identified
>>> by Yaakov.
>>>
>>> I've also attached a slightly cleaned up version of the additional fork
>>> debugging output patch I was using.
>> 
>>>
>>> 2011-03-12  Jon TURNEY  <jon.turney@dronecode.org.uk>
>>>
>>> 	* dll_init.cc (reserve_at, release_at): New functions.
>>> 	(load_after_fork): Make a 3rd pass at trying to load the DLL in
>>> 	the right place.
>> 
>> Rather than add a new pass could we just add rename/enhance "reserve_upto" so
>> that it both reserves the block of memory up to the dll's preferred load address
>> and the block of memory erroneously occupied by the dll?  Or is the extra step
>> important?
>
>I don't know if the 2nd and 3rd passes can be combined.
>
From observation, the behaviour of LoadLibraryEx() seems to be to load the DLL
>at it's base address if it can, otherwise the lowest available address.  If
>that's accurate then there doesn't seem to be any harm in combining them
>(as pass 3 will always succeed in successfully remapping the DLL if pass 2
>would have), but that's based on my limited observations on a single Windows
>version.
>
>I guess I'm just being conservative to avoid the possibility of a regression
>if there are circumstances I don't know about where pass 2 would succeed but
>pass 3 would fail.

I'm trying to imagine a scenario where it would screw up to just do the
reserve_upto + "reserve the low block" and I can't think of one.  It's
potentially a little more work, of course, but I think it may catch the
more common failing conditions so it shouldn't be too noticeable.

>> If so, it seems like we're allocating and freeing the space up to the DLL more
>> than once.  I think we could avoid doing that.
>
>For performance reasons, I think you are right.  Or do you mean there is a
>correctness issue with that?
>
>If you indicate your preferences I'll respin the patch.
>
>1) Combine passes 2 and 3

I'd prefer this.  If we can get people test the snapshot maybe we an
figure out if a separate loop is useful.

cgf
