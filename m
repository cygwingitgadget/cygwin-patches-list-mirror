Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-045.btinternet.com (mailomta8-sa.btinternet.com
 [213.120.69.14])
 by sourceware.org (Postfix) with ESMTPS id 822A73854810
 for <cygwin-patches@cygwin.com>; Wed, 16 Dec 2020 14:29:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 822A73854810
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-048.btinternet.com with ESMTP id
 <20201126210143.EOJE7754.sa-prd-fep-048.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Thu, 26 Nov 2020 21:01:43 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9AA6E1C476F58
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudehvddgudegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgeeuhfekvdefieeghfehtdejheeigedthefhhfehfffgheehgedtffeljeetueeunecukfhppeekiedrudefledrudehkedrudegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudefledrudehkedrudegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehmrghrkhesmhgrgihrnhgurdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.158.14) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AA6E1C476F58; Thu, 26 Nov 2020 21:01:43 +0000
Subject: Re: [PATCH] Cygwin: Speed up mkimport
To: Mark Geisert <mark@maxrnd.com>, Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201126095620.38808-1-mark@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <c9e9ed07-48fc-62d1-8288-c5ef88301a88@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126095620.38808-1-mark@maxrnd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3571.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
Date: Wed, 16 Dec 2020 14:29:49 -0000
X-Original-Date: Thu, 26 Nov 2020 21:01:42 +0000
X-List-Received-Date: Wed, 16 Dec 2020 14:29:49 -0000

On 26/11/2020 09:56, Mark Geisert wrote:
> Cut mkimport elapsed time in half by forking each iteration of the two
> time-consuming loops within.  Only do this if more than one CPU is
> present.  In the second loop, combine the two 'objdump' calls into one
> system() invocation to avoid a system() invocation per iteration.

Nice.  Thanks for looking into this.

> @@ -86,8 +94,18 @@ for my $f (keys %text) {
>       if (!$text{$f}) {
>   	unlink $f;
>       } else {
> -	system $objcopy, '-R', '.text', $f and exit 1;
> -	system $objcopy, '-R', '.bss', '-R', '.data', "t-$f" and exit 1;
> +	if ($forking && fork) {
> +	    # Testing shows parent does need to sleep a short time here,
> +	    # otherwise system is inundated with hundreds of objcopy processes
> +	    # and the forked perl processes that launched them.
> +	    my $delay = 0.01; # NOTE: Slower systems may need to raise this
> +	    select(undef, undef, undef, $delay); # Supports fractional seconds
> +	} else {
> +	    # Do two objcopy calls at once to avoid one system() call overhead
> +	    system '(', $objcopy, '-R', '.text', $f, ')', '||',
> +		$objcopy, '-R', '.bss', '-R', '.data', "t-$f" and exit 1;
> +	    exit 0 if $forking;
> +	}
>       }
>   }
>   

Hmm... not so sure about this.  This seems racy, as nothing ensures that 
these objcopies have finished before we combine all the produced .o 
files into a library.

I'm pretty sure with more understanding, this whole thing could be done 
better:  For example, from a brief look, it seems that the t-*.o files 
are produced by gas, and then we remove .bss and .data sections.  Could 
we not arrange to assemble these objects without those sections in the 
first place?
