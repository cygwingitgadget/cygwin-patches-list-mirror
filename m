Return-Path: <cygwin-patches-return-9138-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 103096 invoked by alias); 23 Jul 2018 16:06:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 103085 invoked by uid 89); 23 Jul 2018 16:06:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.1 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=H*Ad:D*edu
X-HELO: limerock01.mail.cornell.edu
Received: from limerock01.mail.cornell.edu (HELO limerock01.mail.cornell.edu) (128.84.13.241) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 23 Jul 2018 16:06:04 +0000
Received: from authusersmtp.mail.cornell.edu (granite3.serverfarm.cornell.edu [10.16.197.8])	by limerock01.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w6NG61UQ005252	for <cygwin-patches@cygwin.com>; Mon, 23 Jul 2018 12:06:02 -0400
Received: from [192.168.0.4] (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w6NG60T4009728	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Mon, 23 Jul 2018 12:06:01 -0400
Subject: Re: getfacl output
To: cygwin-patches@cygwin.com
References: <48785885-6501-f00e-1949-d923fe7ed41b@cornell.edu> <20180723150622.GB3312@calimero.vinschen.de> <2961960c-9b29-708d-8491-72f938728f90@cornell.edu> <20180723153700.GC3312@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <4da0ada7-bfb0-4ac1-030b-6b7253d60a1b@cornell.edu>
Date: Mon, 23 Jul 2018 16:06:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723153700.GC3312@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00033.txt.bz2

On 7/23/2018 11:37 AM, Corinna Vinschen wrote:
> On Jul 23 11:15, Ken Brown wrote:
>> [Redirecting to cygwin-patches.]
>>
>> On 7/23/2018 11:06 AM, Corinna Vinschen wrote:
>>> On Jul 23 10:43, Ken Brown wrote:
>>>> This is obviously very minor, but I bumped into it because of a failing
>>>> emacs test.
>>>>
>>>> Cygwin's getfacl prints only one colon after "mask" and "other", but Linux's
>>>> prints two.  I'm sure this was done for a reason, but I'm wondering if it
>>>> would be better to follow Linux.
>>>
>>> The original version was designed after Solaris documentation,
>>> but the layout is supposed to look like Linux for a while, so
>>> ther missing colon is a bug.
>>>
>>>>     I'll be glad to submit a patch.
>>>
>>> Glad to review it :)
>>
>> Attached.

> Pushed.  I just wonder if we shouldn't simplify getfacl to use
> acl_to_text instead.

Yes, that makes sense.  I'll take a look.

Ken
