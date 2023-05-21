Return-Path: <SRS0=Zhbh=BK=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-046.btinternet.com (mailomta22-re.btinternet.com [213.120.69.115])
	by sourceware.org (Postfix) with ESMTPS id 712733858C2B
	for <cygwin-patches@cygwin.com>; Sun, 21 May 2023 20:32:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 712733858C2B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20230521203232.LIPR7994.re-prd-fep-046.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Sun, 21 May 2023 21:32:32 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 63F6BC5E0A36FB53
X-Originating-IP: [86.139.158.65]
X-OWM-Source-IP: 86.139.158.65 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiledgudeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvddtteffkeevveejgeehgeelhfdtgefgieelgffgudetudefvdeggfeiiefftdevnecukfhppeekiedrudefledrudehkedrieehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdeingdpihhnvghtpeekiedrudefledrudehkedrieehpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopeeurhhirghnrdfknhhglhhishesufhhrgifrdgtrgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekiedqudefledqudehkedqieehrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgv
	thdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehrvgdqphhrugdqrhhgohhuthdqtddtud
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (86.139.158.65) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 63F6BC5E0A36FB53; Sun, 21 May 2023 21:32:32 +0100
Message-ID: <8818056b-6bc9-9e18-c5dd-a88a9106d535@dronecode.org.uk>
Date: Sun, 21 May 2023 21:32:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3
 cpuinfo
Content-Language: en-GB
To: Brian Inglis <Brian.Inglis@Shaw.ca>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <68bbf3607bdf37fcd32613aa962abe50846d968a.1682994011.git.Brian.Inglis@Shaw.ca>
 <0a50e9ad-59c8-65e9-95f5-f53843fbf918@dronecode.org.uk>
 <8e45602e-91c6-9621-1e70-4b1b3c400679@Shaw.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <8e45602e-91c6-9621-1e70-4b1b3c400679@Shaw.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,BODY_8BITS,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 12/05/2023 19:09, Brian Inglis wrote:
> On 2023-05-12 09:36, Jon Turney wrote:
>> On 08/05/2023 04:12, Brian Inglis wrote:
>>> cpuid    0x00000007:0 ecx:7 shstk Shadow Stack support & Windows 
>>> [20]20H1/[20]2004+
>>>             => user_shstk User mode program Shadow Stack support
>>> AMD SVM  0x8000000a:0 edx:25 vnmi virtual Non-Maskable Interrrupts
>>> Sync AMD 0x80000008:0 ebx flags across two output locations
>>
>> Thanks.  I applied this.
>>
>> Does this need applying to the 3.4 branch as well?
> 
> How many users with the latest models will worry about this before 3.5 
> release about October, and may Cygwin have support by then?

I don't have the data to answer that question.

Instead, I would ask what have we done for previous additions to 
/proc/cpuinfo ?

