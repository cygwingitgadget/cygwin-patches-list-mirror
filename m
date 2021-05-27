Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-041.btinternet.com (mailomta17-re.btinternet.com
 [213.120.69.110])
 by sourceware.org (Postfix) with ESMTPS id 9D3933844007
 for <cygwin-patches@cygwin.com>; Thu, 27 May 2021 17:30:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9D3933844007
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-041.btinternet.com with ESMTP id
 <20210527173011.JZXG30450.re-prd-fep-041.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Thu, 27 May 2021 18:30:11 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C0CC34E491F8
X-Originating-IP: [86.140.69.112]
X-OWM-Source-IP: 86.140.69.112 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvdekhedguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgeeuhfekvdefieeghfehtdejheeigedthefhhfehfffgheehgedtffeljeetueeunecukfhppeekiedrudegtddrieelrdduuddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudegtddrieelrdduuddvpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.140.69.112) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC34E491F8 for cygwin-patches@cygwin.com;
 Thu, 27 May 2021 18:30:11 +0100
Subject: Re: [PATCH] Ensure PSAPI_VERSION is 1 when building ldd
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210520174635.24163-1-jon.turney@dronecode.org.uk>
 <YKalBKpjhBx6mZBg@calimero.vinschen.de>
 <2c57cf3a-ed8f-f3e8-d3bc-a4c5dbe8edaf@dronecode.org.uk>
 <0d7d66f2-48f6-684d-946a-f05d07b329c3@dronecode.org.uk>
 <YK4PIlepWXUOiCHb@calimero.vinschen.de>
 <104966fe-2e78-c28f-dcbe-53af7221f117@dronecode.org.uk>
 <b3286aea4562bbd9b705060b44892c8fbc3e4a2c.camel@cygwin.com>
 <YK6fCkQurJr8KEPq@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <967c6083-0ce3-2325-c4de-0e707dbde55b@dronecode.org.uk>
Date: Thu, 27 May 2021 18:30:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YK6fCkQurJr8KEPq@calimero.vinschen.de>
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
X-List-Received-Date: Thu, 27 May 2021 17:30:15 -0000

On 26/05/2021 20:18, Corinna Vinschen wrote:
> On May 26 13:04, Yaakov Selkowitz wrote:
>> On Wed, 2021-05-26 at 17:51 +0100, Jon Turney wrote:
>>> On 26/05/2021 10:04, Corinna Vinschen wrote:
>>>> On May 25 22:37, Jon Turney wrote:
>>>>> On 22/05/2021 16:08, Jon Turney wrote:
>>>>>> On 20/05/2021 19:05, Corinna Vinschen wrote:
>>>>>>> Hi Jon,
>>>>>>>
>>>>>>> On May 20 18:46, Jon Turney wrote:
>>>>>>>> The default PSAPI_VERSION is controlled by WIN32_WINNT, which we
>>>>>>>> set to
>>>>>>>> 0x0a00 when building ldd, which gets PSAPI_VERSION=2.
>>>>>
>>>>> In the just released w32api 9.0.0, _WIN32_WINNT is now set to 0xa00 by
>>>>> default, so this issue is probably going to surface in a few other
>>>>> places as
>>>>> well.
>>>>
>>>> I added _WIN32_WINNT and NTDDI_VERSION settings to make sure we notice
>>>> any problems right away.
>>>
>>> I'm not sure what the mechanism by which we're going to notice is?
> 
> Build problems?

:confused:

This is a run time problem, not a build time problem.

#define WIN32_WINNT=0x0a00 ->
#define PSAPI_VERSION 2 ->
#define GetModuleFileNameExA K32GetModuleFileNameExA ->
The procedure entry point K32GetModuleFilenameExA could not be located 
in the dynamic link library kernel32.dll

>>> Adding WIN32_WINNT=0x0a00 everywhere changes the meaning of '#include
>>> <psapi.h>' in a way that is incompatible with Vista.
> 
> Isn't that easily fixed by adding PSAPI_VERSION=1 prior to including
> psapi.h?  We can add that to the Makefile as well...
> 
>>> So this has broken dumper, and possibly other utils, on Vista.
>>>
>>> I don't know if there are any other imports in other header which also
>>> have this annoying behaviour...
> 
> I think the psapi stuff is the only one changing their imports.
> 
>> Does Vista REALLY still need to be supported at this point?
> 
> It's probably not much of a problem but per the latest statistics
> we still have... uhm... about 4 Vista users...

'4 users running setup per week' != '4 users'

but yes, it's not very many.
