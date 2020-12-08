Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-047.btinternet.com (mailomta4-sa.btinternet.com
 [213.120.69.10])
 by sourceware.org (Postfix) with ESMTPS id C9B89385800D
 for <cygwin-patches@cygwin.com>; Tue,  8 Dec 2020 15:50:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C9B89385800D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
 by sa-prd-fep-047.btinternet.com with ESMTP id
 <20201208155023.YVCI28522.sa-prd-fep-047.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Tue, 8 Dec 2020 15:50:23 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9B8A71DD597F4
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudejiedgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeguefhkedvfeeigefhhedtjeehieegtdehhffhheffgfehheegtdffleejteeuueenucfkphepkeeirddufeelrdduheekrddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkeeirddufeelrdduheekrddugedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.158.14) by
 sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B8A71DD597F4 for cygwin-patches@cygwin.com;
 Tue, 8 Dec 2020 15:50:23 +0000
Subject: Re: [PATCH] Use automake (v3)
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201124133720.45823-1-jon.turney@dronecode.org.uk>
 <20201130102524.GC303847@calimero.vinschen.de>
 <20201130104718.GD303847@calimero.vinschen.de>
 <6fa43a94-c29d-fa48-07d0-1ef095d9f5e3@dronecode.org.uk>
 <20201201091833.GJ303847@calimero.vinschen.de>
 <b8610713-5e7d-7b19-93f1-3ded9ca12bc6@dronecode.org.uk>
 <20201202170526.GW303847@calimero.vinschen.de>
 <161bd779-bd17-1e98-5644-bea42c3206cf@dronecode.org.uk>
 <42d8f1f139939b45fef85d00c3e368cf2500b603.camel@cygwin.com>
 <20201202190349.GY303847@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <4d97646f-0d7f-2980-f6da-91c6bd7d15cc@dronecode.org.uk>
Date: Tue, 8 Dec 2020 15:50:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201202190349.GY303847@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3571.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 08 Dec 2020 15:50:26 -0000

On 02/12/2020 19:03, Corinna Vinschen via Cygwin-patches wrote:
> On Dec  2 13:33, Yaakov Selkowitz via Cygwin-patches wrote:
>> On Wed, 2020-12-02 at 18:03 +0000, Jon Turney wrote:
>>> On 02/12/2020 17:05, Corinna Vinschen via Cygwin-patches wrote:
>>>> On Dec  2 15:36, Jon Turney wrote:
>>>>> On 01/12/2020 09:18, Corinna Vinschen wrote:
>>>>>> What bugs me is that the mingw executables are built in
>>>>>> utils/mingw,
>>>>>> but the object files are still in utils.  Any problem
>>>>>> generating the
>>>>>> object files in utils/mingw, too?
>>>>>
>>>>> Not easily.
>>>>>
>>>>> This behaviour can be turned off by not using the 'subdir-
>>>>> objects' automake
>>>>> option.
>>>>>
>>>>> But then automake warns that option is disabled (since it's going
>>>>> to be the
>>>>> default in future).
>>>>
>>>> So why not just move the mingw source files to utils/mingw, too?
>>>
>>> There's probably some scope for doing that, but not in all cases, as
>>> some files are built multiple times with different compilers and/or
>>> flags.
>>>
>>> e.g. path.cc is built with a cygwin compiler and -DFSTAB as part of
>>> mount, with a MinGW compiler as part of cygcheck, and with a MinGW
>>> compiler and -DTESTSUITE as part of path-testsuite.
>>
>> Then something like:
>>
>> $ cat > winsup/utils/mingw/path.cc <<_EOF
>> #define MINGW // whatever is needed here...
>> #include "../path.cc"
>> _EOF
>>
>> ??
> 
> +1

Sure, there are plenty of ways of rearranging the code to address this.

I'm not sure I see what the benefit of that additional complexity is.

