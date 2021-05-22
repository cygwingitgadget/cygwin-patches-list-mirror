Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-049.btinternet.com (mailomta2-re.btinternet.com
 [213.120.69.95])
 by sourceware.org (Postfix) with ESMTPS id 5CD0A387088D
 for <cygwin-patches@cygwin.com>; Sat, 22 May 2021 15:08:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5CD0A387088D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-049.btinternet.com with ESMTP id
 <20210522150825.GWBI8822.re-prd-fep-049.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Sat, 22 May 2021 16:08:25 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9BDD03421342F
X-Originating-IP: [86.140.112.109]
X-OWM-Source-IP: 86.140.112.109 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvdejhedgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeguefhkedvfeeigefhhedtjeehieegtdehhffhheffgfehheegtdffleejteeuueenucfkphepkeeirddugedtrdduuddvrddutdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudegtddrudduvddruddtledpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.140.112.109) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD03421342F for cygwin-patches@cygwin.com;
 Sat, 22 May 2021 16:08:25 +0100
Subject: Re: [PATCH] Ensure PSAPI_VERSION is 1 when building ldd
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210520174635.24163-1-jon.turney@dronecode.org.uk>
 <YKalBKpjhBx6mZBg@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <2c57cf3a-ed8f-f3e8-d3bc-a4c5dbe8edaf@dronecode.org.uk>
Date: Sat, 22 May 2021 16:08:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKalBKpjhBx6mZBg@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3569.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Sat, 22 May 2021 15:08:27 -0000

On 20/05/2021 19:05, Corinna Vinschen wrote:
> Hi Jon,
> 
> On May 20 18:46, Jon Turney wrote:
>> The default PSAPI_VERSION is controlled by WIN32_WINNT, which we set to
>> 0x0a00 when building ldd, which gets PSAPI_VERSION=2.
>>
>> This causes K32GetModuleFileNameEx to be used for GetFileNameFromHandle,
>> which isn't available on Windows Vista.
> 
> Patch is ok, but the description needs a tweak.  GetModuleFileNameEx is
> called from load_dll and print_dll, not from GetFileNameFromHandle.

Yeah, that part is just gibberish.  Thanks. Fixed.

> In terms of GetFileNameFromHandle, given the GetFinalPathNameByHandle
> function is availabe since Vista, we should probably go ahead and use
> it in ldd.cc, too.
