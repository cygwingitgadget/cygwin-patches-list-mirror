Return-Path: <cygwin-patches-return-8609-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 129100 invoked by alias); 29 Jul 2016 13:17:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 129030 invoked by uid 89); 29 Jul 2016 13:17:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=H*M:0ea0, H*M:aeda, H*M:4d4b, HTo:U*cygwin-patches
X-HELO: out5-smtp.messagingengine.com
Received: from out5-smtp.messagingengine.com (HELO out5-smtp.messagingengine.com) (66.111.4.29) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 29 Jul 2016 13:17:22 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])	by mailout.nyi.internal (Postfix) with ESMTP id 9B78F20677	for <cygwin-patches@cygwin.com>; Fri, 29 Jul 2016 09:17:19 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])  by compute5.internal (MEProxy); Fri, 29 Jul 2016 09:17:19 -0400
Received: from [192.168.1.102] (host86-179-112-245.range86-179.btcentralplus.com [86.179.112.245])	by mail.messagingengine.com (Postfix) with ESMTPA id 22734CCDC7	for <cygwin-patches@cygwin.com>; Fri, 29 Jul 2016 09:17:19 -0400 (EDT)
Subject: Re: [PATCH 1/2] Add pthread_getname_np and pthread_setname_np
To: cygwin-patches@cygwin.com
References: <20160728114341.1728-1-jon.turney@dronecode.org.uk> <20160728114341.1728-2-jon.turney@dronecode.org.uk> <20160728192100.GA26311@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <85d78b0a-0ea0-aeda-4d4b-bf22c03b1857@dronecode.org.uk>
Date: Fri, 29 Jul 2016 13:17:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160728192100.GA26311@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2016-q3/txt/msg00017.txt.bz2

On 28/07/2016 20:21, Corinna Vinschen wrote:
> Hi Jon,
>
> On Jul 28 12:43, Jon Turney wrote:
>> This patch adds pthread_getname_np and pthread_setname_np.
>>
>> These were added to glibc in 2.12[1] and are also present in some form on
>> NetBSD and several UNIXes.
>>
>> The code is based on NetBSD's implementation with changes to better match
>> Linux behaviour.
>>
>> Implementation quirks:
>>
>> * pthread_setname_np with a NULL pointer segfaults (as linux)
>>
>> * pthread_setname_np accepts names longer than 16 characters (linux returns
>> ERANGE)
>
> Given the behaviour of pthread_getname_np we should do the same, I think.

Ok.

>
>> * pthread_getname_np with a NULL pointer returns EFAULT (as linux)
>>
>> * pthread_getname_np with a buffer length of less than 16 returns ERANGE (as
>> linux)
>>
>> * pthread_getname_np truncates the thread name to fit the buffer length.
>> This guarantees success even when the default thread name is longer than 16
>> characters, but means there is no way to discover the actual length of the
>> thread name. (Linux always truncates the thread name to 16 characters)
>>
>> * Changing program_invocation_short_name changes the default thread name.
>>
>> I'll leave it up to you to decide any of these matter.
>>
>> This is implemented via class pthread_attr to make it easier to add
>> pthread_attr_[gs]etname_np (present in NetBSD and some UNIXes) should it
>> ever be added to Linux (or we decide we want it anyway).
>
> Good thinking.

Yaakov's idea, not mine :)
