Return-Path: <cygwin-patches-return-8173-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3989 invoked by alias); 16 Jun 2015 11:09:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3971 invoked by uid 89); 16 Jun 2015 11:09:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out5-smtp.messagingengine.com
Received: from out5-smtp.messagingengine.com (HELO out5-smtp.messagingengine.com) (66.111.4.29) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 16 Jun 2015 11:09:57 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])	by mailout.nyi.internal (Postfix) with ESMTP id 64C2020A47	for <cygwin-patches@cygwin.com>; Tue, 16 Jun 2015 07:09:54 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])  by compute2.internal (MEProxy); Tue, 16 Jun 2015 07:09:54 -0400
Received: from [192.168.1.102] (unknown [86.141.128.210])	by mail.messagingengine.com (Postfix) with ESMTPA id 0700BC00022	for <cygwin-patches@cygwin.com>; Tue, 16 Jun 2015 07:09:53 -0400 (EDT)
Message-ID: <558003FD.8060208@dronecode.org.uk>
Date: Tue, 16 Jun 2015 11:09:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/8] winsup/doc: Convert utils.xml to using refentry
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk> <1434371793-3980-6-git-send-email-jon.turney@dronecode.org.uk> <20150615171147.GE26901@calimero.vinschen.de> <557FEC25.8030303@dronecode.org.uk> <20150616094501.GC31537@calimero.vinschen.de>
In-Reply-To: <20150616094501.GC31537@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q2/txt/msg00074.txt.bz2

On 16/06/2015 10:45, Corinna Vinschen wrote:
> On Jun 16 10:28, Jon TURNEY wrote:
>> On 15/06/2015 18:11, Corinna Vinschen wrote:
>>> On Jun 15 13:36, Jon TURNEY wrote:
>>>> Convert utils.xml from using a sect2 to using a refentry for each utility
>>>> program.
>>>>
>>>> Unfortunately, using refentry seems to tickle a bug in dblatex when generating
>>>> pdf, which appears to not escape \ properly in the latex for refentry, so use
>>>> fop instead.
>>>
>>> Uhm... wasn't Yaakov's patch from 2014-11-28 explicitely meant to drop
>>> the requirement to use fop andd thus java?
>>>
>>> Is there really no other way to handle that, rather than reverting to
>>> fop?
>>
>> Now I try again --with-dblatex, it works fine, so that part of the patch can
>> be removed.
>>
>> I can only guess I must have had some other markup error causing me
>> problems, which has since been fixed.
>
> I'm relieved :}

Approved with that change?
