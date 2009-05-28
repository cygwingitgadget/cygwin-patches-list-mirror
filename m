Return-Path: <cygwin-patches-return-6525-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9548 invoked by alias); 28 May 2009 07:02:01 -0000
Received: (qmail 8637 invoked by uid 22791); 28 May 2009 07:01:57 -0000
X-SWARE-Spam-Status: No, hits=-0.7 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_42
X-Spam-Check-By: sourceware.org
Received: from mail.sysgo.com (HELO mail.sysgo.com) (195.145.229.155)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 28 May 2009 07:01:52 +0000
Received: from donald.sysgo.com (unknown [172.20.1.30]) 	by mail.sysgo.com (Postfix) with ESMTP id 306BF7C6DF 	for <cygwin-patches@cygwin.com>; Thu, 28 May 2009 09:01:47 +0200 (CEST)
Received: from [172.22.55.10] (den.sysgo.com [172.22.55.10]) 	by donald.sysgo.com (Postfix) with ESMTP id 4AE6B2E4716 	for <cygwin-patches@cygwin.com>; Thu, 28 May 2009 09:01:47 +0200 (CEST)
Message-ID: <4A1E36F5.1050804@sysgo.com>
Date: Thu, 28 May 2009 07:02:00 -0000
From: David Engraf <david.engraf@sysgo.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: [1.5] ls -l on /cygdrive/d doesn't work
References: <4A1BC73F.5090300@sysgo.com> <20090527211441.GA11382@ednor.casa.cgf.cx>
In-Reply-To: <20090527211441.GA11382@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00067.txt.bz2



Christopher Faylor wrote:
> On Tue, May 26, 2009 at 12:41:03PM +0200, David Engraf wrote:
>> I have fixed the error in ntea.cc handling the return value of 
>> NTQueryEaFile. This patch is only needed for the 1.5 release. Maybe this 
>> error should be considered as critical due to uninitialized stack usage 
>> of the variable fea when the function returned an error.
>>
>>
>> 2009-05-26 David Engraf <david.engraf@sysgo.com>
>>
>> 	* ntea.cc (read_ea): Fix error handling and avoid using
>> 	uninitialized stack.
> 
> Thanks for the patch but this will have to be a known limitation of
> 1.5.x.  We don't plan on making any new releases before 1.7 is rolled
> out.
> 
> cgf

But this could be a security problem and as long as we don't have 
released the 1.7 we should continue fixing critical parts because most 
of the users are using the stable version.

- David
