Return-Path: <SRS0=K2UI=55=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-049.btinternet.com (mailomta14-re.btinternet.com [213.120.69.107])
	by sourceware.org (Postfix) with ESMTPS id 871ED3858D33
	for <cygwin-patches@cygwin.com>; Wed,  1 Feb 2023 18:04:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 871ED3858D33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20230201180402.KEIF13495.re-prd-fep-049.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Wed, 1 Feb 2023 18:04:02 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A91244CF0C3E9
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrudefiedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpefgledugfeghfetteeuleeiledtudefveeiudeigfduleeukedtueetffetvdehjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeekuddrudehfedrleekrddvgeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdeingdpihhnvghtpeekuddrudehfedrleekrddvgeeipdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.153.98.246) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 613A91244CF0C3E9 for cygwin-patches@cygwin.com; Wed, 1 Feb 2023 18:04:02 +0000
Message-ID: <6aa67503-30af-cf66-0b3a-1c4d9ba9c396@dronecode.org.uk>
Date: Wed, 1 Feb 2023 18:04:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dumper: avoid linker problem when `libbfd` depends on
 `libsframe`
Content-Language: en-GB
To: cygwin-patches@cygwin.com
References: <50ed771a961112edb5c4b69421d9ad8cecf7a7cb.1675260460.git.johannes.schindelin@gmx.de>
 <Y9qiVIHEaUFPrztO@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <Y9qiVIHEaUFPrztO@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1191.6 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 01/02/2023 17:33, Corinna Vinschen wrote:
> On Feb  1 15:08, Johannes Schindelin wrote:
>> A recent binutils version introduced `libsframe` and made it a
>> dependency of `libbfd`. This caused a linker problem in the MSYS2
>> project, and once Cygwin upgrades to that binutils version it would
>> cause the same problems there.
>>
>> Let's preemptively detect the presence of `libsframe` and if detected,
>> link to it in addition to `libbfd`.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>> Published-As: https://github.com/dscho/msys2-runtime/releases/tag/do-link-libsframe-if-available-v1
>> Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime do-link-libsframe-if-available-v1
>>
>>   winsup/configure.ac      | 5 +++++
>>   winsup/utils/Makefile.am | 4 ++++
>>   2 files changed, 9 insertions(+)
> 
> LGTM.  Jon, what do you think?

Well, the real solution here is for binutils to stop pretending that 
no-one links with libbfd and provide a .pc file for it, because we'll 
just be in the same situation the next time it grows another dependency.

Until that happens :), this seems fine.

