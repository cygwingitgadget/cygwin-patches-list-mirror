Return-Path: <cygwin-patches-return-6549-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1896 invoked by alias); 3 Jul 2009 15:17:58 -0000
Received: (qmail 1878 invoked by uid 22791); 3 Jul 2009 15:17:56 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-121.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.121)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Jul 2009 15:17:50 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 94A5F3B0008 	for <cygwin-patches@cygwin.com>; Fri,  3 Jul 2009 11:17:40 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 87C29CFB8E; Fri,  3 Jul 2009 11:17:40 -0400 (EDT)
Date: Fri, 03 Jul 2009 15:17:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: mkstemps
Message-ID: <20090703151740.GA26910@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A46A3AB.2060604@byu.net>  <20090628103249.GX30864@calimero.vinschen.de>  <4A4DFA3E.2010909@byu.net>  <4A4DFAE4.3090008@byu.net>  <20090703130134.GB12258@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090703130134.GB12258@calimero.vinschen.de>
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
X-SW-Source: 2009-q3/txt/msg00003.txt.bz2

On Fri, Jul 03, 2009 at 03:01:34PM +0200, Corinna Vinschen wrote:
>On Jul  3 06:34, Eric Blake wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>> 
>> According to Eric Blake on 7/3/2009 6:31 AM:
>> > With that vote of confidence, here's the patch (the changes to mktemp.cc,
>> > modulo a changed variable name, mirror newlib):
>> > 
>> > 2009-07-03  Eric Blake  <ebb9@byu.net>
>> > 
>> > 	Add fpurge, mkstemps.
>> > 	* cygwin.din (fpurge, mkstemps): New exports.
>> > 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
>> > 	* mktemp.cc (_gettemp): Add parameter.
>> > 	(mkstemps): New function.
>> > 	(mkstemp, mkdtemp, mktemp): Adjust clients.
>> 
>> Updated to avoid a compiler warning.
>
>Patch applied.

Is there some reason why we're not just using the newlib version of all
of these functions?  I have stared at the code in mktemp.cc and the only
thing I see that seems to be Cygwin specific is the arc4random function.
Is the security that this provides the only reason not to use newlib?

That is probably a good enough reason right there but I was just
wondering.

cgf
