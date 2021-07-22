Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-049.btinternet.com (mailomta31-re.btinternet.com
 [213.120.69.124])
 by sourceware.org (Postfix) with ESMTPS id 506713864814
 for <cygwin-patches@cygwin.com>; Thu, 22 Jul 2021 13:54:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 506713864814
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
 by re-prd-fep-049.btinternet.com with ESMTP id
 <20210722135439.BZYN8938.re-prd-fep-049.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Thu, 22 Jul 2021 14:54:39 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C5063D001220
X-Originating-IP: [86.139.167.43]
X-OWM-Source-IP: 86.139.167.43 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvtddrfeeigdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepteelffegteeiudeuteehffevledvffeffeekgffhhfehvdfhgffhteehteelteeknecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkeeirddufeelrdduieejrdegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkeeirddufeelrdduieejrdegfedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.167.43) by
 re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C5063D001220 for cygwin-patches@cygwin.com;
 Thu, 22 Jul 2021 14:54:39 +0100
Subject: Re: [PATCH 0/3] Add more winsymlinks values
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
 <YPfYgz0EHe7Yw5ko@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <0b2f3506-b5f8-5e73-b92f-62583dbd4fdb@dronecode.org.uk>
Date: Thu, 22 Jul 2021 14:53:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPfYgz0EHe7Yw5ko@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1194.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Thu, 22 Jul 2021 13:54:44 -0000

On 21/07/2021 09:19, Corinna Vinschen wrote:
> On Jul 19 17:31, Jon Turney wrote:
>> I'm not sure this is the best idea, since it adds more configurations that
>> aren't going to get tested often, but the idea is that this would enable
>> proper and consistent control of the symlink type used from setup, as
>> discussed in [1].
>>
>> [1] https://cygwin.com/pipermail/cygwin-apps/2021-May/041327.html
> 
> Why isn't it sufficient to use 'winsymlinks:native' from setup?

I think in the default Windows configuration (developer mode off, no 
SeCreateSymbolicLinkPrivilege), 'native' will try to create a native 
symlink and fail, and fallback to WSL IO_REPARSE_TAG_LX_SYMLINK reparse 
point, then magic cookie + sys attribute.

This leads to cygwin installations with WSL symlinks created by 
post-install scripts, which can't be put into Docker containers [1], 
which is the original problem I was trying to fix.

[1] https://cygwin.com/pipermail/cygwin/2020-August/245994.html

I haven't yet looked at adding 'native' symlink support to setup itself, 
but it's probably going to be a bit of a pain.

> The way we express symlinks shouldn't be a user choice, really.  The
> winsymlinks thingy was only ever introduced in a desperate attempt to
> improve access to symlinks from native tools, and I still don't see a
> way around that.  But either way, what's the advantage in allowing the
> user complete control over the type, even if the type is only useful in
> Cygwin?
  If we can come up with a fixed policy that works everywhere, there is 
no advantage.  But that seems unlikely :)

I could buy an argument that 'native' should be the default (although 
maybe all that does is slow things down in the majority of installs?).

