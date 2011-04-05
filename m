Return-Path: <cygwin-patches-return-7271-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14295 invoked by alias); 5 Apr 2011 16:03:37 -0000
Received: (qmail 14283 invoked by uid 22791); 5 Apr 2011 16:03:36 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 05 Apr 2011 16:03:30 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.8]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 05 Apr 2011 17:03:27 +0100
Message-ID: <4D9B3D5F.4040306@dronecode.org.uk>
Date: Tue, 05 Apr 2011 16:03:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add an additional relocation attempt pass to load_after_fork()
References: <4D7CDDC7.5060708@dronecode.org.uk> <20110313152111.GA7064@calimero.vinschen.de> <4D7E908B.4010004@dronecode.org.uk> <20110315075313.GA5722@calimero.vinschen.de> <20110315150412.GA18662@ednor.casa.cgf.cx> <20110315154609.GE4320@calimero.vinschen.de> <20110330211556.GE13484@calimero.vinschen.de> <20110330212951.GC28494@ednor.casa.cgf.cx> <4D99BCCE.60407@dronecode.org.uk> <20110404143917.GA1140@ednor.casa.cgf.cx>
In-Reply-To: <20110404143917.GA1140@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00037.txt.bz2

On 04/04/2011 15:39, Christopher Faylor wrote:
> On Mon, Apr 04, 2011 at 01:42:54PM +0100, Jon TURNEY wrote:
>> Attached is an updated version of the patch which fixes the warning identified
>> by Yaakov.
>>
>> I've also attached a slightly cleaned up version of the additional fork
>> debugging output patch I was using.
> 
>>
>> 2011-03-12  Jon TURNEY  <jon.turney@dronecode.org.uk>
>>
>> 	* dll_init.cc (reserve_at, release_at): New functions.
>> 	(load_after_fork): Make a 3rd pass at trying to load the DLL in
>> 	the right place.
> 
> Rather than add a new pass could we just add rename/enhance "reserve_upto" so
> that it both reserves the block of memory up to the dll's preferred load address
> and the block of memory erroneously occupied by the dll?  Or is the extra step
> important?

I don't know if the 2nd and 3rd passes can be combined.

From observation, the behaviour of LoadLibraryEx() seems to be to load the DLL
at it's base address if it can, otherwise the lowest available address.  If
that's accurate then there doesn't seem to be any harm in combining them
(as pass 3 will always succeed in successfully remapping the DLL if pass 2
would have), but that's based on my limited observations on a single Windows
version.

I guess I'm just being conservative to avoid the possibility of a regression
if there are circumstances I don't know about where pass 2 would succeed but
pass 3 would fail.

> If so, it seems like we're allocating and freeing the space up to the DLL more
> than once.  I think we could avoid doing that.

For performance reasons, I think you are right.  Or do you mean there is a
correctness issue with that?

If you indicate your preferences I'll respin the patch.

0) As is
1) Combine passes 2 and 3
2) Keep passes 2 and 3 separate but carry the reserve_upto allocation over
between pass 2 to pass 3, rather than freeing and reallocating it.
3) Other
