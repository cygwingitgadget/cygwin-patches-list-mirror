Return-Path: <cygwin-patches-return-6025-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17888 invoked by alias); 3 Jan 2007 15:40:35 -0000
Received: (qmail 17877 invoked by uid 22791); 3 Jan 2007 15:40:34 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-54.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.54)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 03 Jan 2007 15:40:30 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 4B49713C042; Wed,  3 Jan 2007 10:40:28 -0500 (EST)
Date: Wed, 03 Jan 2007 15:40:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Increase st_blksize to 64k
Message-ID: <20070103154028.GB19858@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0701021158490.2464@PC1163-8460-XP.flightsafety.com> <20070102184551.GA18182@trixie.casa.cgf.cx> <Pine.CYG.4.58.0701021301510.2464@PC1163-8460-XP.flightsafety.com> <20070103121620.GB4106@calimero.vinschen.de> <459BADB3.7080705@byu.net> <20070103133557.GC4106@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103133557.GC4106@calimero.vinschen.de>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00006.txt.bz2

On Wed, Jan 03, 2007 at 02:35:57PM +0100, Corinna Vinschen wrote:
>On Jan  3 06:20, Eric Blake wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>> 
>> According to Corinna Vinschen on 1/3/2007 5:16 AM:
>> > 
>> > Setting st_blksize to 64K might be a good idea for disk I/O if the value
>> > is actually used by applications.  Do you have a specific example or a
>> > test result from a Cygwin application which shows the advantage of
>> > setting st_blksize to this value?  I assume there was some actual case
>> > which led you to make this change ;)
>> 
>> Did you read the original link?
>> http://sourceware.org/ml/cygwin/2006-12/msg00911.html
>
>Urgh, sorry, no.  I missed it even twice, once when scanning the Cygwin
>list to see what happened since Christmas, and once in Brian's mail
>starting this thread.
>
>So it appears to make much sense to set the blocksize to 64K.  The
>only question would be whether to use getpagesize() or a hard coded
>value.  It seems to me that the 64K allocation granularity and using
>64K as buffer size in disk I/O coincide so I tend to agree that it
>makes sort of sense to use getpagesize at this point.  What do you
>think, Chris?

I don't think getpagesize should be linked to this value.  The fact that
both are 64K seems to be a coincidence to me.  This wasn't mentioned in
the document that Brian mentioned was it?

If we specifically want to use 64K block sizes then I think we should
specifically say that rather than relying on some other unrelated mechanism
to return a 64K constant.

cgf
