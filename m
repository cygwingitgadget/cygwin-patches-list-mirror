Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta26-re.btinternet.com
 [213.120.69.119])
 by sourceware.org (Postfix) with ESMTPS id 6F5E83857346
 for <cygwin-patches@cygwin.com>; Thu, 28 Apr 2022 13:23:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6F5E83857346
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
 by re-prd-fep-045.btinternet.com with ESMTP id
 <20220428132307.XYGO3219.re-prd-fep-045.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Thu, 28 Apr 2022 14:23:07 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613A901C206DFC2D
X-Originating-IP: [86.139.167.41]
X-OWM-Source-IP: 86.139.167.41 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrudejgdeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppeekiedrudefledrudeijedrgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdehngdpihhnvghtpeekiedrudefledrudeijedrgedupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.105] (86.139.167.41) by
 re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613A901C206DFC2D for cygwin-patches@cygwin.com;
 Thu, 28 Apr 2022 14:23:07 +0100
Message-ID: <1d636cfc-6d0b-3ef0-38b3-9af31f423ce5@dronecode.org.uk>
Date: Thu, 28 Apr 2022 14:23:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/2] Fix build with w32api 10.0.0
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220412173210.50882-1-jon.turney@dronecode.org.uk>
 <YmkNRCnQq7pR00Ee@calimero.vinschen.de>
 <20220428092902.d7cb9331078f1e97f9fee144@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <20220428092902.d7cb9331078f1e97f9fee144@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3570.4 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_NUMSUBJECT, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Thu, 28 Apr 2022 13:23:10 -0000

On 28/04/2022 01:29, Takashi Yano wrote:
> On Wed, 27 Apr 2022 11:30:44 +0200
> Corinna Vinschen wrote:
>> On Apr 12 18:32, Jon Turney via Cygwin-patches wrote:
>>> Jon Turney (2):
>>>    Cygwin: Fix build with w32api 10.0.0
>>>    Cygwin: Fix typo KERB_S4U_LOGON_FLAG_IDENTITY -> IDENTIFY
>>                                           ^^^^^^^^^^^^^^^^^^^^
>>                                           Ooooops
>>
>> LGTM, thanks,
>> Corinna
> 
> Shouldn't these patches be applied also to cygwin-3_3-branch?
> 

Yes, I guess so.  My mistake that they weren't.
