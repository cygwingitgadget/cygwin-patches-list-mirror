Return-Path: <SRS0=32dc=CT=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-047.btinternet.com (mailomta10-re.btinternet.com [213.120.69.103])
	by sourceware.org (Postfix) with ESMTPS id 85E593858D35
	for <cygwin-patches@cygwin.com>; Sat,  1 Jul 2023 14:20:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 85E593858D35
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20230701142015.ENRO28253.re-prd-fep-047.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Sat, 1 Jul 2023 15:20:15 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 63FE9A2B0E1999AA
X-Originating-IP: [86.140.193.89]
X-OWM-Source-IP: 86.140.193.89 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrtdekgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhephfffveeuieetgfeiledtvdeitdejvdefudeltdegudehfeehffdvtdejtdffleehnecuffhomhgrihhnpegthihgfihinhdrtghomhdpghhithhhuhgsrdgtohhmnecukfhppeekiedrudegtddrudelfedrkeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdeingdpihhnvghtpeekiedrudegtddrudelfedrkeelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepmhgrrhhksehmrgigrhhnugdrtghomhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqdekledrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghu
	shgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhstheprhgvqdhprhguqdhrghhouhhtqddttdeg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (86.140.193.89) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 63FE9A2B0E1999AA; Sat, 1 Jul 2023 15:20:15 +0100
Message-ID: <1cf85bfc-9865-e4f7-5c2e-5acc89c3e77f@dronecode.org.uk>
Date: Sat, 1 Jul 2023 15:20:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] Cygwin: Fix type mismatch on sys/cpuset.h
To: Mark Geisert <mark@maxrnd.com>, Cygwin Patches <cygwin-patches@cygwin.com>
References: <20230314085601.18635-1-mark@maxrnd.com>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <20230314085601.18635-1-mark@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 14/03/2023 08:56, Mark Geisert wrote:
> Addresses https://cygwin.com/pipermail/cygwin/2023-March/253220.html
> 
> Take the opportunity to follow FreeBSD's and Linux's lead in recasting
> macro inline code as calls to static inline functions.  This allows the
> macros to be type-safe.  In addition, added a lower bound check to the
> functions that use a cpu number to avoid a potential buffer underrun on
> a bad argument.  h/t to Corinna for the advice on recasting.
> 
> Fixes: 362b98b49af5 ("Cygwin: Implement CPU_SET(3) macros")
> 

There's been a couple of reports that this leads to compilation failures 
when this header is included in -std=c89 mode.

Solutions are probably something like:

* Use __inline__ rather than inline
* Don't use initial declaration inside the for loop's init-statement

e.g. https://github.com/tinyproxy/tinyproxy/issues/499

