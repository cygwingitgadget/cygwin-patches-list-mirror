Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.13])
 by sourceware.org (Postfix) with ESMTPS id A67FC3851C19
 for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2020 13:51:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A67FC3851C19
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id qGfPjYFMn62brqGfQjNDjb; Tue, 30 Jun 2020 07:51:21 -0600
X-Authority-Analysis: v=2.3 cv=LKf9vKe9 c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=jChkm-x5hCMFubTIiR0A:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3 v3] Cygwin: tzcode resync: basics
To: cygwin-patches@cygwin.com
References: <20200522093253.995-1-mark@maxrnd.com>
 <20200522093253.995-2-mark@maxrnd.com>
 <20200525120634.GD6801@calimero.vinschen.de>
 <20200525154901.GG6801@calimero.vinschen.de>
 <bcff83ee-c3b6-0b99-90d6-650694562250@maxrnd.com>
 <20200526082736.GH6801@calimero.vinschen.de>
 <394b2ab3-f239-72a1-21b2-a28952137253@SystematicSw.ab.ca>
 <Pine.BSF.4.63.2006092130070.1307@m0.truegem.net>
 <c24d5439-aed4-4ec6-65a0-92f3fcfa0edb@SystematicSw.ab.ca>
 <20200630101857.GB3499@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Autocrypt: addr=Brian.Inglis@SystematicSw.ab.ca; prefer-encrypt=mutual;
 keydata=
 mDMEXopx8xYJKwYBBAHaRw8BAQdAnCK0qv/xwUCCZQoA9BHRYpstERrspfT0NkUWQVuoePa0
 LkJyaWFuIEluZ2xpcyA8QnJpYW4uSW5nbGlzQFN5c3RlbWF0aWNTdy5hYi5jYT6IlgQTFggA
 PhYhBMM5/lbU970GBS2bZB62lxu92I8YBQJeinHzAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQW
 AgMBAh4BAheAAAoJEB62lxu92I8Y0ioBAI8xrggNxziAVmr+Xm6nnyjoujMqWcq3oEhlYGAO
 WacZAQDFtdDx2koSVSoOmfaOyRTbIWSf9/Cjai29060fsmdsDLg4BF6KcfMSCisGAQQBl1UB
 BQEBB0Awv8kHI2PaEgViDqzbnoe8B9KMHoBZLS92HdC7ZPh8HQMBCAeIfgQYFggAJhYhBMM5
 /lbU970GBS2bZB62lxu92I8YBQJeinHzAhsMBQkJZgGAAAoJEB62lxu92I8YZwUBAJw/74rF
 IyaSsGI7ewCdCy88Lce/kdwX7zGwid+f8NZ3AQC/ezTFFi5obXnyMxZJN464nPXiggtT9gN5
 RSyTY8X+AQ==
Organization: Systematic Software
Message-ID: <482e623f-7b4b-1650-96c3-4fc85d7abede@SystematicSw.ab.ca>
Date: Tue, 30 Jun 2020 07:51:19 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630101857.GB3499@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfD4iGEeIldAlZ8tcdfHq1GsEZ4lo4TrMMSI9M8MdR8O11baJSkN71gL4qR5ZdFyAARJTrkbdxh6tcRcmPmdb+7XZNKIHq5CeQIqoQO1Ek/xLUGI8qK1B
 cnLhTlEQ6AQ77Zp3sIdxLz9J7ExMO9Bi1pJEazggGIj8ZuB3nFoZPeDY4sLrTJ/bby/dKztaTbAZNA==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 30 Jun 2020 13:51:24 -0000

On 2020-06-30 04:18, Corinna Vinschen wrote:
> On Jun 10 15:53, Brian Inglis wrote:
>> On 2020-06-09 22:37, Mark Geisert wrote:
>>> On Tue, 9 Jun 2020, Brian Inglis wrote:
>>>> On 2020-05-26 02:27, Corinna Vinschen wrote:
>>>>> On May 26 00:09, Mark Geisert wrote:
>>>>>> Corinna Vinschen wrote:
>>>>>>>> On May 22 02:32, Mark Geisert wrote:
>>>>>>> On May 25 14:06, Corinna Vinschen wrote:
>>>> The tzcode package needs updated to get fixes into zic and zdump.
>>>> Also tzdata was maintained by Yaakov.
>>>>
>>>> Corinna, would you like to keep tzcode co-maintained with Yaakov?
>>>>
>>>> Or Mark, would you like to ITA tzcode and/or tzdata to keep it in sync with the
>>>> base code?
>>>>
>>>> Or would you like me to ITA tzcode and/or tzdata?
>>>> I currently check tzdb weekly in cron to download updates for my own interests.
>>>> I could add cygport builds to that job.
>>>
>>> This "tzcode" patch I did was a one-shot task just getting some time zone
>>> handling code within the Cygwin DLL up to date.  I don't know if there's any
>>> overlap between what I worked on and the tzcode+tzdata packages.  Eh, just the
>>> internal binary copy of a particular tzdata file which should be kept up to
>>> date: /usr/share/zoneinfo/posixrules.  Dunno how often that changes though.
>>>
>>> It's fine with me for you to take over both tzcode+tzdata if nobody else
>>> objects.  Sounds like you have a regular schedule for looking over updates which
>>> is more than I have :-).
>>
>> Thanks Mark,
>>
>> I'll wait to see if we hear from Corinna or ITA if no response soon.
> 
> You don't have to ask me to ITA packages, really :)

They are currently under your/Yaakov's maintainership - I assume as little as
possible so have an ITA under apps - please respond there - if you agree
Jon/Marco can update

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
