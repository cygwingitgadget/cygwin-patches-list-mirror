Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-043.btinternet.com (mailomta6-re.btinternet.com
 [213.120.69.99])
 by sourceware.org (Postfix) with ESMTPS id 700583850401
 for <cygwin-patches@cygwin.com>; Fri, 28 May 2021 15:13:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 700583850401
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
 by re-prd-fep-043.btinternet.com with ESMTP id
 <20210528151316.MZJS29864.re-prd-fep-043.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Fri, 28 May 2021 16:13:16 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C50635083DAC
X-Originating-IP: [81.153.98.171]
X-OWM-Source-IP: 81.153.98.171 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvdekjedgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeguefhkedvfeeigefhhedtjeehieegtdehhffhheffgfehheegtdffleejteeuueenucfkphepkedurdduheefrdelkedrudejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkedurdduheefrdelkedrudejuddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (81.153.98.171) by
 re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C50635083DAC for cygwin-patches@cygwin.com;
 Fri, 28 May 2021 16:13:16 +0100
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
 <967c6083-0ce3-2325-c4de-0e707dbde55b@dronecode.org.uk>
 <YK/uL8Y6vR5opKSM@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <96d77c6b-0b46-527e-40bb-40adca640aff@dronecode.org.uk>
Date: Fri, 28 May 2021 16:13:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YK/uL8Y6vR5opKSM@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3571.3 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Fri, 28 May 2021 15:13:19 -0000

On 27/05/2021 20:08, Corinna Vinschen wrote:
> On May 27 18:30, Jon Turney wrote:
>> On 26/05/2021 20:18, Corinna Vinschen wrote:
>>> On May 26 13:04, Yaakov Selkowitz wrote:
>>>> On Wed, 2021-05-26 at 17:51 +0100, Jon Turney wrote:
[...]
>>>>> I'm not sure what the mechanism by which we're going to notice is?
>>>
>>> Build problems?
>>
>> :confused:
>>
>> This is a run time problem, not a build time problem.
>>
>> #define WIN32_WINNT=0x0a00 ->
>> #define PSAPI_VERSION 2 ->
>> #define GetModuleFileNameExA K32GetModuleFileNameExA ->
>> The procedure entry point K32GetModuleFilenameExA could not be located in
>> the dynamic link library kernel32.dll
> 
> I didn't mean PSAPI_VERSION above, but the _WIN32_WINNT setting in the first
> place.  Changing them can lead to surprising results in terms of what's defined
> and what isn't.  PSAPI_VERSION is the icing, of course.

Ah, I see.

>>>>> Adding WIN32_WINNT=0x0a00 everywhere changes the meaning of '#include
>>>>> <psapi.h>' in a way that is incompatible with Vista.
>>>
>>> Isn't that easily fixed by adding PSAPI_VERSION=1 prior to including
>>> psapi.h?  We can add that to the Makefile as well...
> 
> What about this?

Yeah, we should do that.

I considered adding it everywhere we include psapi.h in my initial 
patch, but it wasn't needed at the time.
