Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-042.btinternet.com (mailomta1-re.btinternet.com
 [213.120.69.94])
 by sourceware.org (Postfix) with ESMTPS id 9923E398300B
 for <cygwin-patches@cygwin.com>; Mon,  9 Nov 2020 21:01:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9923E398300B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
 by re-prd-fep-042.btinternet.com with ESMTP id
 <20201109210153.PLMJ19415.re-prd-fep-042.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Mon, 9 Nov 2020 21:01:53 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C50619668238
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudduhedgudegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeigeehgefhveefvefhvdeiudfgvdeuhfejheetjefffefhueduteehuefgfffhnecukfhppeekiedrudefledrudehkedrudegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudefledrudehkedrudegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.158.14) by
 re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C50619668238 for cygwin-patches@cygwin.com;
 Mon, 9 Nov 2020 21:01:53 +0000
Subject: Re: [PATCH 11/11] Ensure temporary directory used by tests exists
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
 <20201105194748.31282-12-jon.turney@dronecode.org.uk>
 <8e13e92f-7aca-65ee-8978-d0b6cd7b062f@cornell.edu>
 <bae783a3-1098-85da-c2b8-00a65db6e00c@dronecode.org.uk>
 <643396a1-21b0-88a6-3f6b-2eb2083821e7@cornell.edu>
 <666af9fa-194d-7b6e-a165-18f8d5169b94@dronecode.org.uk>
 <2c5fbe84-338e-c470-68cf-cefaf5692613@cornell.edu>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <1119060a-04d3-b966-b237-08af004a6337@dronecode.org.uk>
Date: Mon, 9 Nov 2020 21:01:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <2c5fbe84-338e-c470-68cf-cefaf5692613@cornell.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3570.2 required=5.0 tests=BAYES_00, BODY_8BITS,
 FORGED_SPF_HELO, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS,
 SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 09 Nov 2020 21:01:57 -0000

On 09/11/2020 17:48, Ken Brown via Cygwin-patches wrote:
> On 11/9/2020 11:25 AM, Jon Turney wrote:
>> On 08/11/2020 19:27, Ken Brown via Cygwin-patches wrote:
>>> On 11/8/2020 1:52 PM, Jon Turney wrote:
>>>> On 08/11/2020 18:19, Ken Brown via Cygwin-patches wrote:
>>>>> On 11/5/2020 2:47 PM, Jon Turney wrote:
>>>>>> +# temporary directory to be used for files created by tests (as 
>>>>>> an absolute,
>>>>>> +# /cygdrive path, so it can be understood by the test DLL, which 
>>>>>> will have
>>>>>> +# different mount table)
>>>>>> +tmpdir = $(shell cygpath -ma $(objdir)/testsuite/tmp/ | sed -e 
>>>>>> 's#^\([A-Z]\):#/cygdrive/\L\1#')
>>>>>
>>>>> This isn't right if the cygdrive prefix is not 'cygdrive'.  Maybe 
>>>>> use 'proc/cygdrive' instead of 'cygdrive'?
>>>>>
>>>>
>>>> That's how I originally had it.  Unfortunately, test ltp/symlink01 
>>>> relies on the test directory being specified as a canonicalized 
>>>> pathname (i.e. is the same after realpath()).
>>>>
>>>> Since there's no /etc/fstab in the the filesystem relative to the 
>>>> test DLL, I think it should always be using the default cygdrive 
>>>> prefix?
>>>
>>> But there's a mkdir command that seems to be run in the context of 
>>> the user running 'make check'.  If the cygdrive prefix is not 
>>> 'cygdrive', 'make check' fails as follows:
>>>
>>> ERROR: tcl error sourcing 
>>> /home/kbrown/src/cygdll/newlib-cygwin/winsup/testsuite/winsup.api/winsup.exp. 
>>>
>>> ERROR: can't create directory "/cygdrive": permission denied
>>>      while executing
>>> "file mkdir $tmpdir/$base"
>>>
>>
>> Ah, I see.
>>
>> Maybe something like the attached is needed.
> 
> That fixes it, thanks.  I get
> 
>                  === winsup Summary ===
> 
> # of expected passes            253
> # of unexpected failures        23
> # of unexpected successes       1
> # of expected failures          7

Yup. I get the same numbers.
