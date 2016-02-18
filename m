Return-Path: <cygwin-patches-return-8334-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40064 invoked by alias); 18 Feb 2016 12:44:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40054 invoked by uid 89); 18 Feb 2016 12:44:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, Hx-spam-relays-external:ESMTPA
X-HELO: out3-smtp.messagingengine.com
Received: from out3-smtp.messagingengine.com (HELO out3-smtp.messagingengine.com) (66.111.4.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 18 Feb 2016 12:44:02 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])	by mailout.nyi.internal (Postfix) with ESMTP id 2FA5D208D1	for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2016 07:44:00 -0500 (EST)
Received: from frontend1 ([10.202.2.160])  by compute6.internal (MEProxy); Thu, 18 Feb 2016 07:44:00 -0500
Received: from [192.168.1.102] (host86-141-131-217.range86-141.btcentralplus.com [86.141.131.217])	by mail.messagingengine.com (Postfix) with ESMTPA id B8150C0001A;	Thu, 18 Feb 2016 07:43:59 -0500 (EST)
Subject: Re: gprof profiling of multi-threaded Cygwin programs
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <56C404FF.502@maxrnd.com> <56C5A401.8060604@dronecode.org.uk> <Pine.BSF.4.63.1602180309170.49755@m0.truegem.net>
From: Jon Turney <jon.turney@dronecode.org.uk>
Cc: Mark Geisert <mark@maxrnd.com>
Message-ID: <56C5BC87.7070705@dronecode.org.uk>
Date: Thu, 18 Feb 2016 12:44:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <Pine.BSF.4.63.1602180309170.49755@m0.truegem.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2016-q1/txt/msg00040.txt.bz2

On 18/02/2016 11:29, Mark Geisert wrote:
>> A brief search tells me that apparently glibc supports the
>> (undocumented) GMON_OUT_PREFIX env var which enables a similar behaviour.
>
> Ah, I did not know about that.  It would be easy to implement.
>
> So I'm leaning towards choosing file name as GMON_OUT_PREFIX.exename.pid
> with GMON_OUT_PREFIX defaulting to "gmon.out" if unspecified.

I think if you are going to implement GMON_OUT_PREFIX, you should make 
the behaviour the same as glibc.

> Do you think the expanded name should be used in all cases, or only when
> there's a gmon.out already present?

I don't think you should be checking for an existing gmon.out file.  In 
the simple case where the program doesn't fork, it's expected that 
gmon.out will get overwritten.
