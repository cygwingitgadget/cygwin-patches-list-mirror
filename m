Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-049.btinternet.com (mailomta27-re.btinternet.com
 [213.120.69.120])
 by sourceware.org (Postfix) with ESMTPS id B05653858D35
 for <cygwin-patches@cygwin.com>; Tue, 28 Jul 2020 21:04:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B05653858D35
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-049.btinternet.com with ESMTP id
 <20200728210418.YCDP4131.re-prd-fep-049.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
 Tue, 28 Jul 2020 22:04:18 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [31.51.206.146]
X-OWM-Source-IP: 31.51.206.146 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedriedvgdduheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeguefhkedvfeeigefhhedtjeehieegtdehhffhheffgfehheegtdffleejteeuueenucfkphepfedurdehuddrvddtiedrudegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepfedurdehuddrvddtiedrudegiedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeothgrkhgrshhhihdrhigrnhhosehnihhfthihrdhnvgdrjhhpqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (31.51.206.146) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD0092EA5B2; Tue, 28 Jul 2020 22:04:18 +0100
Subject: Re: [PATCH 5/5] Cygwin: Use MEMORY_WORKING_SET_EX_INFORMATION in
 dumper
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200718150028.1709-1-jon.turney@dronecode.org.uk>
 <20200718150028.1709-6-jon.turney@dronecode.org.uk>
 <20200728112056.86427f1c9e2a3e044dfa169e@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <1e95ce4f-da33-bf26-6727-a89641ff374a@dronecode.org.uk>
Date: Tue, 28 Jul 2020 22:04:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728112056.86427f1c9e2a3e044dfa169e@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 28 Jul 2020 21:04:21 -0000

On 28/07/2020 03:20, Takashi Yano via Cygwin-patches wrote:
> Hi Jon,
> 
> On Sat, 18 Jul 2020 16:00:28 +0100
> Jon Turney wrote:
>> Use the (undocumented) MEMORY_WORKING_SET_EX_INFORMATION in dumper to
>> determine if a MEM_IMAGE region is unsharable, and hence has been
>> modified.
>> ---
>>   winsup/doc/utils.xml     |  8 ++---
>>   winsup/utils/Makefile.in |  2 +-
>>   winsup/utils/dumper.cc   | 63 ++++++++++++++++++++++++++++++++++++++--
>>   3 files changed, 65 insertions(+), 8 deletions(-)
> 
> After this commit, 32bit build failes with:
> 
> /usr/lib/gcc/i686-pc-cygwin/9.3.0/../../../../i686-pc-cygwin/bin/ld: dumper.o:/home/yano/newlib-cygwin/i686-pc-cygwin/winsup/utils/../../.././winsup/utils/dumper.cc:295: undefined reference to `NtQueryVirtualMemory'

Thanks very much for pointing this out.

> This seems to be solved with the patch:

Yes, I guess that it needs that for stdcall.  I applied your patch.

> diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
> index 3af138b9e..36dbf9dbb 100644
> --- a/winsup/utils/dumper.cc
> +++ b/winsup/utils/dumper.cc
> @@ -272,7 +272,7 @@ typedef enum _MEMORY_INFORMATION_CLASS
>   } MEMORY_INFORMATION_CLASS;
> 
>   extern "C"
> -NTSTATUS
> +NTSTATUS NTAPI
>   NtQueryVirtualMemory(HANDLE ProcessHandle,
>                       LPVOID BaseAddress,
>                       MEMORY_INFORMATION_CLASS MemoryInformationClass,
> 
