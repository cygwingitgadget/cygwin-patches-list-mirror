Return-Path: <SRS0=ZdHa=7Q=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-046.btinternet.com (mailomta25-re.btinternet.com [213.120.69.118])
	by sourceware.org (Postfix) with ESMTPS id 63AF43858D35
	for <cygwin-patches@cygwin.com>; Fri, 24 Mar 2023 14:20:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 63AF43858D35
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20230324142049.MGZQ7994.re-prd-fep-046.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Fri, 24 Mar 2023 14:20:49 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 63FE9A2B02AD27DD
X-Originating-IP: [81.153.98.181]
X-OWM-Source-IP: 81.153.98.181 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedgieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeejkedtudevhedukeetteeuieefteeutdfghfejkeejiedtuedvkeekueetgeelueenucffohhmrghinhepghhfvgdvheeghegvlehfrggrfhdrihhtnecukfhppeekuddrudehfedrleekrddukedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdeingdpihhnvghtpeekuddrudehfedrleekrddukedupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekuddqudehfedqleekqddukedurdhrrghnghgvkeduqdduheefrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtgho
	mhdpghgvohfkrfepifeupdfovfetjfhoshhtpehrvgdqphhrugdqrhhgohhuthdqtddtge
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.153.98.181) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 63FE9A2B02AD27DD for cygwin-patches@cygwin.com; Fri, 24 Mar 2023 14:20:49 +0000
Message-ID: <8f3311b2-30c8-6688-657d-fb135f78af48@dronecode.org.uk>
Date: Fri, 24 Mar 2023 14:20:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/3] fix unlink/rename failure in hyper-v container
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <b5553609-8ce3-41fd-4215-2504a8491652@ac.auone-net.jp>
 <ZBWL85hJIlbZHc/D@calimero.vinschen.de>
 <608a78b6-f523-14f1-333d-f59e9f2bb8d5@ac.auone-net.jp>
 <ZBhy7E4vKHTRNW6k@calimero.vinschen.de>
 <ZBjD9exM9ZBGDzK3@calimero.vinschen.de>
 <434bbf77-6a08-3be2-747f-13dfc4637275@ac.auone-net.jp>
 <ZBnwKcr+ZL6sv0jh@calimero.vinschen.de>
 <f82458c2-72be-7485-66da-82b0342ae729@ac.auone-net.jp>
 <ZB2Ph+7EkP8evVJo@calimero.vinschen.de>
 <3ca8b41e-41c4-7c34-8912-dc515b3da57e@dronecode.org.uk>
 <ZB2kCC4TF2xCns47@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <ZB2kCC4TF2xCns47@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1191.2 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 24/03/2023 13:22, Corinna Vinschen wrote:
> On Mar 24 13:20, Jon Turney wrote:
>> On 24/03/2023 11:54, Corinna Vinschen wrote:
>>> On Mar 24 01:40, Yoshinao Muramatsu wrote:
>>>> On 2023/03/22 2:58, Corinna Vinschen wrote:
>>>>> I pushed a new Cygwin DLL, test release 3.5.0-0.251.gfe2545e9faaf.
>>>>> This should do what we want, now.  If you can confirm, I'll push
>>>>> your workaround afterwards.
>>>>
>>>> I have tested cygwin-3.5.0-0.251.gfe2545e9faaf.
>>>> It works fine with bind mounted directory in the hyper-v container.
>>>
>>> Thanks, I pushed your patches.  We can reevaluate the
>>> FILE_SUPPORTS_OPEN_BY_FILE_ID handling if Microsoft actually
>>> changes this in Hyper-V.
>>>
>>>> Slightly off-topic, but since I could not use gui to set up cygwin
>>>> in the container, I am using setup-x86_64.exe with cli.
>>>> Is there a way to install the cygwin package by specifying
>>>> the package version from cli?
>>>
>>> Uhm... I don't think so.  I'm not aware of such a way to define the
>>> desired package version on the CLI.  That would be a nice feature...
>>
>> '-P cygwin=3.5.0-0.251.gfe2545e9faaf' allegedly works, for a while now.
> 
> Oh, wow, great!

In this particular instance, just using '-t' (equivalent to the 'enable 
test packages') checkbox, might be less typing and just as good.

