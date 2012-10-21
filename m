Return-Path: <cygwin-patches-return-7739-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3871 invoked by alias); 21 Oct 2012 17:11:01 -0000
Received: (qmail 3846 invoked by uid 22791); 21 Oct 2012 17:10:59 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 21 Oct 2012 17:10:54 +0000
Received: from pool-72-74-71-200.bstnma.fios.verizon.net ([72.74.71.200] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TPz38-000Np6-6V	for cygwin-patches@cygwin.com; Sun, 21 Oct 2012 17:10:54 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 47E7713C005	for <cygwin-patches@cygwin.com>; Sun, 21 Oct 2012 13:10:53 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/KYkUHMA9BdDSz1fglRpGc
Date: Sun, 21 Oct 2012 17:11:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121021171053.GA24725@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121017164440.GA12989@ednor.casa.cgf.cx> <20121017170514.GD10578@calimero.vinschen.de> <20121017193258.GA15271@ednor.casa.cgf.cx> <1350545597.3492.59.camel@YAAKOV04> <20121018083419.GC6221@calimero.vinschen.de> <1350580828.3492.73.camel@YAAKOV04> <20121019092135.GA22432@calimero.vinschen.de> <1350664438.3492.114.camel@YAAKOV04> <20121019184636.GZ25877@calimero.vinschen.de> <20121021113320.GA2469@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121021113320.GA2469@calimero.vinschen.de>
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
X-SW-Source: 2012-q4/txt/msg00016.txt.bz2

On Sun, Oct 21, 2012 at 01:33:20PM +0200, Corinna Vinschen wrote:
>On Oct 19 20:46, Corinna Vinschen wrote:
>>On Oct 19 11:33, Yaakov (Cygwin/X) wrote:
>>>On Fri, 2012-10-19 at 11:21 +0200, Corinna Vinschen wrote:
>>>>Other than that, I think it's good to go in after the 1.7.17 release.
>>>>I'll try to do the release at some point between now and Monday.
>>>
>>>I'll include those changes and post a new patch then.
>
>On second thought...  considering that w32api is now Mingw64 based, and
>considering that building Cygwin with this Mingw64 built w32api works
>fine...  what do you guys think about a "once and for all" approach?
>Is it really necessary to keep supporting a build against the old
>w32api?  What does that buy us apart from added complexity?  Doesn't
>that also mean we have to test our builds against both w32api versions
>as long as we support it?  I, for one, have no real interest to do so.

I had exactly the same thought.  I'm in favor of just doing the
switchover.

That said, is it time to ask the mingw.org stuff to relocate their
CVS repo?  I could tar up the affected CVS directories for them if
so.

cgf
