Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-046.btinternet.com (mailomta22-re.btinternet.com
 [213.120.69.115])
 by sourceware.org (Postfix) with ESMTPS id 446543882155
 for <cygwin-patches@cygwin.com>; Wed, 12 Jan 2022 19:17:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 446543882155
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
 by re-prd-fep-046.btinternet.com with ESMTP id
 <20220112191755.KDNP24326.re-prd-fep-046.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Wed, 12 Jan 2022 19:17:55 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613A901C1040AC48
X-Originating-IP: [81.129.146.209]
X-OWM-Source-IP: 81.129.146.209 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrtddugdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppeekuddruddvledrudegiedrvddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtfegnpdhinhgvthepkedurdduvdelrddugeeirddvtdelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.103] (81.129.146.209) by
 re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613A901C1040AC48 for cygwin-patches@cygwin.com;
 Wed, 12 Jan 2022 19:17:55 +0000
Message-ID: <31607842-7ac3-44ee-8099-ae53de5d1ed0@dronecode.org.uk>
Date: Wed, 12 Jan 2022 19:17:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Cygwin: doc: drop mention of 32-bit installer
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220112155241.1635-1-jon.turney@dronecode.org.uk>
 <Yd8jSyIZCPmkKd1E@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <Yd8jSyIZCPmkKd1E@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3571.0 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Wed, 12 Jan 2022 19:17:58 -0000

On 12/01/2022 18:51, Corinna Vinschen wrote:
> On Jan 12 15:52, Jon Turney wrote:
>> Drop mention of 32-bit installer, since it's offically discouraged, and
>> planned to be dropped soon.
>>
>> Adjust various references to be something more generic, like 'the Cygwin
>> Setup program' to accomodate this.
>> ---
>>   winsup/doc/faq-setup.xml | 12 +++----
>>   winsup/doc/setup-net.xml | 74 ++++++++++++++++------------------------
>>   2 files changed, 34 insertions(+), 52 deletions(-)
>> [...]
>>   <para>
>> -On Windows Vista and later, <command>setup.exe</command> will check by
>> +On Windows Vista and later, <command>setup</command> will check by
>                ^^^^^
> This will have to be changed for the master branch to mention W7
> instead.  Vista is a dead stinkin' fish at that time.  That reminds me,
> we have to do this throughout.  Do you want to or shall I?

Please go ahead.

In this particular case, the leading clause can simply be dropped, since 
"setup will check by default if it runs with administrative privileges 
..." describes the behaviour on all supported Windows versions.
