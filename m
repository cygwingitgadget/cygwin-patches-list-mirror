Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-046.btinternet.com (mailomta22-re.btinternet.com
 [213.120.69.115])
 by sourceware.org (Postfix) with ESMTPS id B27B83973045
 for <cygwin-patches@cygwin.com>; Thu, 24 Sep 2020 14:04:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B27B83973045
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-046.btinternet.com with ESMTP id
 <20200924140421.NHCL4657.re-prd-fep-046.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Thu, 24 Sep 2020 15:04:21 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [86.176.137.240]
X-OWM-Source-IP: 86.176.137.240 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgeeuhfekvdefieeghfehtdejheeigedthefhhfehfffgheehgedtffeljeetueeunecukfhppeekiedrudejiedrudefjedrvdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkeeirddujeeirddufeejrddvgedtpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehksghrohifnhestghorhhnvghllhdrvgguuheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.176.137.240) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC127FEAAD; Thu, 24 Sep 2020 15:04:21 +0100
Subject: Re: [PATCH] Cygwin: winlean.h: remove most of extended memory API
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200923235225.46299-1-kbrown@cornell.edu>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <ddeace5b-33a2-ed1f-5b30-0d33bfe61ca3@dronecode.org.uk>
Date: Thu, 24 Sep 2020 15:04:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200923235225.46299-1-kbrown@cornell.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Thu, 24 Sep 2020 14:04:25 -0000

On 24/09/2020 00:52, Ken Brown via Cygwin-patches wrote:
> This was added as a temporary measure in commit e18f7f99 because it
> wasn't yet in the mingw-w64 headers.  With one exception, it is now in
> the current release of the headers (version 8.0.0), so we don't need
> it in winlean.h.  The exception is that VirtualAlloc2 is only declared
> conditionally in <w32api/memoryapi.h>, so retain it in winlean.h.  Add

I assume it's conditional on the windows version targetted, but it might 
help to mention that in a comment.

> "WINAPI" to its declaration for consistency with the delaration in
> memoryapi.h.
> 
> Also revert commit 3d136011, which was a related temporary workaround.

Looks good to me.

I think this isn't going work any more with older win32api, but we 
probably don't care about that.  It would perhaps be nice to explicitly 
complain about that (checking __MINGW64_VERSION_MAJOR somehow), rather 
than exploding incomprehensibly if the w32api is too old?

> In particular, I'd like to know if my handling of the 
> declaration of VirtualAlloc2 seems reasonable.  Among other things, I'm 
> puzzled by the apparent need to add WINAPI.  If it's really needed, I 
> don't know how the calls of that function could have worked before.  Can 
> anyone enlighten me?

I believe that WINAPI only does something (stdcall) on x86, so it might 
well be that it's never worked on Windows 10 =>1803 x86?

