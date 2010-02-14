Return-Path: <cygwin-patches-return-6962-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21265 invoked by alias); 14 Feb 2010 13:55:36 -0000
Received: (qmail 21255 invoked by uid 22791); 14 Feb 2010 13:55:36 -0000
X-SWARE-Spam-Status: No, hits=-2.3 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 14 Feb 2010 13:55:32 +0000
Received: from compute1.internal (compute1 [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 29271DF21A 	for <cygwin-patches@cygwin.com>; Sun, 14 Feb 2010 08:55:31 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Sun, 14 Feb 2010 08:55:31 -0500
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id BFA9597D3; 	Sun, 14 Feb 2010 08:55:30 -0500 (EST)
Message-ID: <4B7800C6.8010108@cwilson.fastmail.fm>
Date: Sun, 14 Feb 2010 13:55:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <20100213113509.GJ5683@calimero.vinschen.de>  <4B76C334.8080101@cwilson.fastmail.fm>  <20100213210122.GA20649@ednor.casa.cgf.cx> <20100214101834.GO5683@calimero.vinschen.de>
In-Reply-To: <20100214101834.GO5683@calimero.vinschen.de>
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
X-SW-Source: 2010-q1/txt/msg00078.txt.bz2

Corinna Vinschen wrote:
> On Feb 13 16:01, Christopher Faylor wrote:
>> On Sat, Feb 13, 2010 at 10:20:20AM -0500, Charles Wilson wrote:
>>> Corinna Vinschen wrote:
>>>> On Feb 13 01:43, Charles Wilson wrote:
>>>>> The attached patch(es) add XDR support to cygwin
>>>> Cool.
>> I didn't get Corinna's response in email and it isn't in the archive.
>> I assume that was unintentional?
> 
> Yes, sorry about that.  Apparently I hit the r button accidentally,
> rather than the l button(*).
> 
>> Also, follow-up question: Should this go into a different library
>> entirely?  Is it time to think about not just making cygwin1.dll the
>> monolithic one-stop-for-all-of-your-posix-api shared library?
> 
> Ideally libcygwin.a provides all the API which is expected in libc
> on other targets.
> 
> I don't know if that works, but it would be really cool if a single
> DLL import lib like libcygwin.a could export symbols from different
> DLLs.  That way we could create a cygxdr1.dll which contains the XDR
> functions, but which could be linked against by just the default linking
> against libcygwin.a.

Oh, it's certainly possible:

dlltool --identify /usr/lib/w32api/libvfw32.a
AVIFIL32.DLL
AVICAP32.DLL
MSVFW32.DLL

but I think it would be very hard to do that, IF the core implementation
code "lived" in newlib, rather than cygwin proper. So, this would almost
require that the core impl code be moved into winsup/cygwin -- and even
then, it requires additional complications for the build process and
mkimportlib. (Also, I'd have to export the 'set up the error reporting'
function, which I currently don't do).

I'm somewhat unenthusiastic about that.

> However, that would be link stage magic which has nothing to do with
> availability in source.  I have no problems with it being in newlib
> (though I doubt I had the idea in the first place).  This way other
> targets would get this OS-agnostic functionality as well.

Yes, that is my current thinking.

--
Chuck
