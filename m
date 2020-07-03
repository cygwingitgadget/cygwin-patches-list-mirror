Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-046.btinternet.com (mailomta27-re.btinternet.com
 [213.120.69.120])
 by sourceware.org (Postfix) with ESMTPS id 852F63858D34
 for <cygwin-patches@cygwin.com>; Fri,  3 Jul 2020 13:10:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 852F63858D34
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
 by re-prd-fep-046.btinternet.com with ESMTP id
 <20200703131034.HFDW4657.re-prd-fep-046.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Fri, 3 Jul 2020 14:10:34 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [31.51.206.31]
X-OWM-Source-IP: 31.51.206.31 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrtdeigdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepufhfhffvkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhephefgheelvdelgedtfedvgefgtedttdehheeitdekteetvdekhfdvvddvveffvdegnecukfhppeefuddrhedurddvtdeirdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepfedurdehuddrvddtiedrfedupdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (31.51.206.31) by
 re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C74D050CC65B for cygwin-patches@cygwin.com;
 Fri, 3 Jul 2020 14:10:34 +0100
Subject: Re: [PATCH 8/8] Cygwin: Consider DLL rebasing when computing dumper
 exclusions
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
 <20200701212529.13998-9-jon.turney@dronecode.org.uk>
 <20200702074317.GM3499@calimero.vinschen.de>
 <20200702074857.GP3499@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Message-ID: <9b0e3ddf-2fdd-990a-00f4-22939e21fa2b@dronecode.org.uk>
Date: Fri, 3 Jul 2020 14:10:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702074857.GP3499@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
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
X-List-Received-Date: Fri, 03 Jul 2020 13:10:38 -0000

On 02/07/2020 08:48, Corinna Vinschen wrote:
> On Jul  2 09:43, Corinna Vinschen wrote:
>> On Jul  1 22:25, Jon Turney wrote:
>>> I think this would always have been neeeded, but is essential on x86_64,
>>> as kernel32.dll has an ImageBase of 00000001:80000000 (but is always
>>
>> Great, but that shouldn't matter much given that system DLLs are
>> ASLRed all the time.
>>
>>> +parse_pe (const char *file_name, exclusion * excl_list, LPVOID base_address)
>>>   {
>>>     if (file_name == NULL || excl_list == NULL)
>>>       return 0;
>>> @@ -104,7 +104,19 @@ parse_pe (const char *file_name, exclusion * excl_list)
>>>       }
>>>   
>>>     bfd_check_format (abfd, bfd_object);
>>> -  bfd_map_over_sections (abfd, &select_data_section, (PTR) excl_list);
>>> +
>>> +  /* Compute the relocation offset for this DLL.  Unfortunately, we have to
>>> +     guess at ImageBase (one page before vma of first section), since bfd
>>> +     doesn't let us get at backend-private data */
>>> +  bfd_vma imagebase = abfd->sections->vma - 0x1000;
>>
>> VirtualQueryEx?  The AllocationBase is identical to the base address
>> of the DLL loaded at that address.
> 
> Uhm... right.  Always assuming you get at the Windows process handle
> from bfd...

The problem is in the opposite direction.

We have the actual base address the DLL was loaded at in the process 
being dumped, and it's filename, from the LOAD_DLL_DEBUG_EVENT event.

(To my amazement) we then read that DLL using bfd, and examine it for 
sections with the 'CODE' or 'DEBUGGING' flags, the address ranges 
corresponding to which we believe we want to exclude from the dump.

Unfortunately, these addresses are based on the ImageBase in the PE header.

If that's different to the actual base address the PE was loaded at, we 
need to adjust these addresses appropriately.  But libbfd doesn't appear 
to provide a public interface to get at the ImageBase.
