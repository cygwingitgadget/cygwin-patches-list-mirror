Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-046.btinternet.com (mailomta13-sa.btinternet.com
 [213.120.69.19])
 by sourceware.org (Postfix) with ESMTPS id 6EB07385701F
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 13:10:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6EB07385701F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
 by sa-prd-fep-046.btinternet.com with ESMTP id
 <20210323131016.JTKY27221.sa-prd-fep-046.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 13:10:16 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6038717E03909D76
X-Originating-IP: [81.153.98.229]
X-OWM-Source-IP: 81.153.98.229 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrudegiedghedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeguefhkedvfeeigefhhedtjeehieegtdehhffhheffgfehheegtdffleejteeuueenucfkphepkedurdduheefrdelkedrvddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkedurdduheefrdelkedrvddvledpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (81.153.98.229) by
 sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 6038717E03909D76 for cygwin-patches@cygwin.com;
 Tue, 23 Mar 2021 13:10:16 +0000
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
 <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
 <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
 <20210323205717.bf5c3a41695871ec70bf1229@nifty.ne.jp>
 <YFncTItWHhMlNH5Y@calimero.vinschen.de>
 <20210323213212.d2c5a9e7db7a508260693998@nifty.ne.jp>
 <YFnit7OtFJeflMQT@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <ee1366d1-d7bb-0bb3-b9e1-7715eb476985@dronecode.org.uk>
Date: Tue, 23 Mar 2021 13:09:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFnit7OtFJeflMQT@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3571.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Tue, 23 Mar 2021 13:10:19 -0000

On 23/03/2021 12:44, Corinna Vinschen via Cygwin-patches wrote:
> On Mar 23 21:32, Takashi Yano via Cygwin-patches wrote:
>> On Tue, 23 Mar 2021 13:17:16 +0100
>> Corinna Vinschen wrote:
>>> On Mar 23 20:57, Takashi Yano via Cygwin-patches wrote:
>>>> Corinna Vinschen wrote:
>>>>>>> On Mar 22 08:07, Takashi Yano via Cygwin-patches wrote:
>>>>>>>>> And also, following cygwin apps/dlls call GetStdHandle():
>>>>>>>>> ccmake.exe
>>>>>>>>> cmake.exe
>>>>>>>>> cpack.exe
>>>>>>>>> ctest.exe
>>>>>>>>> run.exe
>>>>>
>>>>> run creates its own conin/conout handles to create a hidden console.
>>>>> The code calling GetStdHandle() is only for debug purposes and never
>>>>> built into the executable.
>>>
>>> Sorry, but this was utterly wrong.  run calls GetStdHandle, then
>>> overwrites the handles, but only if it doesn't already is attached to a
>>> console.
>>>
>>>>> Looks right to me.  If we patch cmake to do the right thing, do we still
>>>>> need this patch, Takashi?
>>>>
>>>> I don't think so. If all is well with current code, nothing to be fixed.
>>>
>>> How do you evaluate this in light of the run behaviour above?
>>
>> I try to check run.exe behaviour and noticed that
>> run cmd.exe
>> and
>> run cat.exe
>> does not work with cygwin 3.0.7 and 3.2.0 (TEST) while these
>> work in 3.1.7.
>>
>> Is this expected behaviour?
> 
> The problem is that I never used run.  I can't actually tell what
> exactly is expected.  I *think* run was intended to start Cygwin
> applications without console window in the first place, not
> native Windows apps, but I could be wrong.
> 
> I don't even know if anybody is actually, seriously using it.

'run' is used by the start menu item which starts the X server.

If that doesn't use it, a visible console window is created for the bash 
process it starts (which is the parent of the X server process and lives 
for it's lifetime).

(As a separate issue, I'm not sure all the complex gymnastics run does 
to creste the window invisibly are doing anything useful, since we seem 
to briefly show the window and then hide it)
