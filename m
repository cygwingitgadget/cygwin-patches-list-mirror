Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-042.btinternet.com (mailomta17-re.btinternet.com
 [213.120.69.110])
 by sourceware.org (Postfix) with ESMTPS id 7F9A53858C54
 for <cygwin-patches@cygwin.com>; Sun,  8 May 2022 10:27:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7F9A53858C54
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-042.btinternet.com with ESMTP id
 <20220508102729.FYQM3291.re-prd-fep-042.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Sun, 8 May 2022 11:27:29 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613A8DE8223D5D2E
X-Originating-IP: [86.139.167.41]
X-OWM-Source-IP: 86.139.167.41 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejgddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeevgffghfdtvdetvddvfeduhedukeettdekveeflefgkeekieefgfehhfffudetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkeeirddufeelrdduieejrdegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddthegnpdhinhgvthepkeeirddufeelrdduieejrdeguddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehmrghrkhesmhgrgihrnhgurdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.105] (86.139.167.41) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613A8DE8223D5D2E; Sun, 8 May 2022 11:27:29 +0100
Message-ID: <223aa826-7bf9-281a-aed8-e16349de5b96@dronecode.org.uk>
Date: Sun, 8 May 2022 11:27:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: load average calculation failing
Content-Language: en-GB
To: Mark Geisert <mark@maxrnd.com>, Cygwin Patches <cygwin-patches@cygwin.com>
References: <Pine.BSF.4.63.2205051618470.42373@m0.truegem.net>
 <3a3edd10-2617-0919-4eb0-7ca965b48963@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <3a3edd10-2617-0919-4eb0-7ca965b48963@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1194.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_PASS, SPF_NONE, TXREP, T_SCC_BODY_TEXT_LINE,
 WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sun, 08 May 2022 10:27:32 -0000

On 08/05/2022 08:01, Mark Geisert wrote:
> Mark Geisert wrote (on the main Cygwin mailing list):
>> I've recently noticed that the 'xload' I routinely run shows zero load 
>> even with compute-bound processes running.  This is on both Cygwin 
>> pre-3.4.0 as well as 3.3.4.  A test program, shown below, indicates 
>> that getloadavg() is returning with 0 status, i.e. not an error but no 
>> elems
>> of the passed-in array updated.
>>
>> Stepping with gdb through the test program seems weird within the 
>> loadavginfo::load_init method.  Single-stepping at line loadavg.cc:68 
>> goes to strace.h:52 and then to _sigbe ?!
>>
>> I had recently updated both Cygwin and Windows 10 to latest at the 
>> same time so I cannot say when the failure started.  Last day or two 
>> at most.
>>
[...]
> 
> I've debugged a bit further..  Within Cygwin's loadavg.cc:load_init(), 
> the PdhOpenQueryW() call returns successfully.  The subsequent 
> PdhAddEnglishCounterW() call is unsuccessful.  It returns status 
> 0x800007D0 == PDH_CSTATUS_NO_MACHINE. The code (at line 68 mentioned 
> above) calls debug_printf() to conditionally display the error, which is 
> what leads to the strace.h and _sigbe; that's fine.
> 
> The weird PDH_CSTATUS_NO_MACHINE is the problem.  I'll try running the 
> example from an elevated shell.  Or rebooting the machine.  After that 
> it's consulting some oracle TBD. :-(
> 

Thanks for looking into this.
You can find the user space version of this code I initially wrote at 
https://github.com/jon-turney/windows-loadavg, which might save you some 
time.

I can't reproduce this on W10 21H1, so I think this must be due to some 
change in later Windows...

