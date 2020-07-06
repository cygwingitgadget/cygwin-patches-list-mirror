Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-045.btinternet.com (mailomta5-sa.btinternet.com
 [213.120.69.11])
 by sourceware.org (Postfix) with ESMTPS id E61B43857C57
 for <cygwin-patches@cygwin.com>; Mon,  6 Jul 2020 13:34:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E61B43857C57
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-045.btinternet.com with ESMTP id
 <20200706133417.TSAY4112.sa-prd-fep-045.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Mon, 6 Jul 2020 14:34:17 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [31.51.206.31]
X-OWM-Source-IP: 31.51.206.31 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnheptdevveffteelgfekieevieekleevvdehtddvgfdvgefgjedujedviedugeeghfefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepfedurdehuddrvddtiedrfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeefuddrhedurddvtdeirdefuddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (31.51.206.31) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AA6E0570C4B3 for cygwin-patches@cygwin.com;
 Mon, 6 Jul 2020 14:34:17 +0100
Subject: Re: [PATCH 0/8] Fix dumper for x86_64
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
 <e058a12f-97b2-d237-a97f-4a691bf5c6e3@dronecode.org.uk>
 <20200702074444.GN3499@calimero.vinschen.de>
 <b2a72bb3-1852-46fe-81d2-0107c0076564@dronecode.org.uk>
 <20200706081200.GA514059@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <edcb449d-43b1-b80a-a4f7-e7b8c64d4b3d@dronecode.org.uk>
Date: Mon, 6 Jul 2020 14:34:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706081200.GA514059@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_NUMSUBJECT, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Mon, 06 Jul 2020 13:34:21 -0000

On 06/07/2020 09:12, Corinna Vinschen wrote:
> On Jul  5 17:49, Jon Turney wrote:
>> On 02/07/2020 08:44, Corinna Vinschen wrote:
>>> On Jul  1 22:29, Jon Turney wrote:
>>>>
>>>> This needs to be aligned with some changes to gdb to consume the dumps it
>>>> produces, so it's probably best to hold off applying this until it's more
>>>> obvious what's going to happen with those.
>>>>
>>>> Random notes:
>>>>
>>>> - objdump identifies the output of dumper on x86_64 as
>>>> 'elf64-x86-64-cloudabi' (perhaps due to some over-eager sniffer).
>>>>
>>>> - regions excluded from the dump aren't rounded up to page size, so we may
>>>> end up writing the excess into the dump.
>>>>
>>>> - looking at the loaded modules and inspecting them to determine what memory
>>>> regions don't need to appear in the dump seems odd.  I'm not sure we don't
>>>> just exclude MEMORY_BASIC_INFORMATION.Type == MEM_IMAGE regions (assuming
>>>> they get converted to MEM_PRIVATE regions if written when copy-on-write).
>>
>> Unfortunately, that doesn't happen, and the region appears to stay
>> MEM_IMAGE, even if it's been modified.
>>
>> I'm inclined to just dump MEM_IMAGE regions if they are writable (although
>> using the current protection isn't 100% correct, because it may have been
>> changed using VirtualProtect())
>>
>> I suspect there's probably some undocumented MemoryInformationClass for
>> NtQueryVirtualMemory() that would let us determine if a region is sharable
>> or not, but ...
> 
> Surprisingly, there's nothing undocumented in NtQueryVirtualMemory and
> the API is fully exposed by VirtualQuery(Ex).

I came across [1], which seems to use some MemoryInformationClass values 
I can't find any MSDN documentation on, but perhaps I'm getting lost.

[1] 
https://github.com/processhacker/processhacker/blob/master/phnt/include/ntmmapi.h#L87

> What about the two protection fields in MEMORY_BASIC_INFORMATION?  If
> something changed, Protect != AllocationProtect.  Is that insufficient
> to handle your case?

Unfortunately that doesn't seem to provide any additional information. 
The Windows loader seems to allocate all regions with EXWC protection, 
then change it to match the section. (Not that there are any guarantees 
about it's behaviour)

I wasn't able to observe a region corresponding to an unmodified .data 
section with WC protection, which is somewhat confusing.
