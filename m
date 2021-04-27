Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-043.btinternet.com (mailomta22-sa.btinternet.com
 [213.120.69.28])
 by sourceware.org (Postfix) with ESMTPS id 3F7C83896C2E
 for <cygwin-patches@cygwin.com>; Tue, 27 Apr 2021 18:33:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3F7C83896C2E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-043.btinternet.com with ESMTP id
 <20210427183304.JFEF6062.sa-prd-fep-043.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Tue, 27 Apr 2021 19:33:04 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 603871830885FE2D
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvddvtddguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepufhfhffvkffffgggjggtgfesthekredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleejjeeuhfdtkeehfedvjeffjeetkedtvddvveduffevkefhvdegjedtleeljeeunecukfhppeekuddrudehfedrleekrddvgeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekuddrudehfedrleekrddvgeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (81.153.98.246) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 603871830885FE2D for cygwin-patches@cygwin.com;
 Tue, 27 Apr 2021 19:33:04 +0100
Subject: Re: [PATCH] Use automake (v5)
References: <20210420201326.4876-1-jon.turney@dronecode.org.uk>
 <74ea8f75-8bbb-8a58-66d3-cf6ae68db2c3@dronecode.org.uk>
 <dd2be414-edd1-5502-050a-ecaaa5920db5@cornell.edu>
 <62ca4187-f798-38b3-f5dd-b3844b99fcf5@cornell.edu>
From: Jon Turney <jon.turney@dronecode.org.uk>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Message-ID: <a31e8cd1-2780-b1d8-8ca1-c529263f5f9b@dronecode.org.uk>
Date: Tue, 27 Apr 2021 19:32:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <62ca4187-f798-38b3-f5dd-b3844b99fcf5@cornell.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
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
X-List-Received-Date: Tue, 27 Apr 2021 18:33:06 -0000

On 27/04/2021 18:00, Ken Brown wrote:
> On 4/27/2021 12:52 PM, Ken Brown wrote:
>> On 4/27/2021 11:50 AM, Jon Turney wrote:
>>> On 20/04/2021 21:13, Jon Turney wrote:
>>>> For ease of reviewing, this patch doesn't contain changes to generated
>>>> files which would be made by running ./autogen.sh.
>>>   I pushed this patch.
>>>
>>> If you have an existing build directory, while you might get away 
>>> with invoking 'make' at the top-level, I would recommend blowing it 
>>> away and configuring again.
>>
>> I'm confused about how the generated files are going to get 
>> regenerated when necessary.  I see calls to autogen (which I guess is 
>> /usr/bin/autogen.exe from the autogen package) in the Makefiles, but I 

That's some cygnus top-level weirdness I don't understand.

>> don't see any calls to autogen.sh. Is the latter no longer needed?

There is (still) an autogen.sh in winsup/ ...

> Oh, never mind.  The Makefiles just call autoconf, etc., as needed.

... but you should now never need to explicitly use it, as 
('maintainer-mode') rules now exist in the Makefile to do what's needed.

If you do need to make changes in the autofoolery which are going to be 
pushed, then specific versions of the autotools still need to be used 
(to avoid these generated files thrashing between forms generated by 
different versions)
