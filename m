Return-Path: <cygwin-patches-return-7264-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11302 invoked by alias); 4 Apr 2011 14:39:57 -0000
Received: (qmail 11276 invoked by uid 22791); 4 Apr 2011 14:39:56 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm7-vm0.bullet.mail.sp2.yahoo.com (HELO nm7-vm0.bullet.mail.sp2.yahoo.com) (98.139.91.192)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 04 Apr 2011 14:39:20 +0000
Received: from [98.139.91.69] by nm7.bullet.mail.sp2.yahoo.com with NNFMP; 04 Apr 2011 14:39:19 -0000
Received: from [98.136.185.47] by tm9.bullet.mail.sp2.yahoo.com with NNFMP; 04 Apr 2011 14:39:19 -0000
Received: from [127.0.0.1] by smtp108.mail.gq1.yahoo.com with NNFMP; 04 Apr 2011 14:39:19 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp108.mail.gq1.yahoo.com with SMTP; 04 Apr 2011 07:39:18 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id BF859428013	for <cygwin-patches@cygwin.com>; Mon,  4 Apr 2011 10:39:17 -0400 (EDT)
Date: Mon, 04 Apr 2011 14:39:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add an additional relocation attempt pass to load_after_fork()
Message-ID: <20110404143917.GA1140@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D7CDDC7.5060708@dronecode.org.uk> <20110313152111.GA7064@calimero.vinschen.de> <4D7E908B.4010004@dronecode.org.uk> <20110315075313.GA5722@calimero.vinschen.de> <20110315150412.GA18662@ednor.casa.cgf.cx> <20110315154609.GE4320@calimero.vinschen.de> <20110330211556.GE13484@calimero.vinschen.de> <20110330212951.GC28494@ednor.casa.cgf.cx> <4D99BCCE.60407@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D99BCCE.60407@dronecode.org.uk>
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
X-SW-Source: 2011-q2/txt/msg00030.txt.bz2

On Mon, Apr 04, 2011 at 01:42:54PM +0100, Jon TURNEY wrote:
>On 30/03/2011 22:29, Christopher Faylor wrote:
>> On Wed, Mar 30, 2011 at 11:15:56PM +0200, Corinna Vinschen wrote:
>>> Chris, are you going to take a look into this patch?
>> 
>> yep.
>
>Attached is an updated version of the patch which fixes the warning identified
>by Yaakov.
>
>I've also attached a slightly cleaned up version of the additional fork
>debugging output patch I was using.

>
>2011-03-12  Jon TURNEY  <jon.turney@dronecode.org.uk>
>
>	* dll_init.cc (reserve_at, release_at): New functions.
>	(load_after_fork): Make a 3rd pass at trying to load the DLL in
>	the right place.

Rather than add a new pass could we just add rename/enhance "reserve_upto" so
that it both reserves the block of memory up to the dll's preferred load address
and the block of memory erroneously occupied by the dll?  Or is the extra step
important?

If so, it seems like we're allocating and freeing the space up to the DLL more
than once.  I think we could avoid doing that.

As far as fork debugging is concerned, do you know about building cygwin with
--enable-debugging and then setting "CYGWIN_DEBUG=blah"?  That will force a
gdb to start whenever cygwin runs a program named "blah".  That's how I usually
debug projects like this.

--enable-debugging has some irritating races so you have to use it sparingly but
it's invaluable for figuring out problems in forked processes.

cgf
