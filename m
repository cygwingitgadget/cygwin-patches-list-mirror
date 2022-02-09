Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-046.btinternet.com (mailomta28-re.btinternet.com
 [213.120.69.121])
 by sourceware.org (Postfix) with ESMTPS id D9E1C3858D20
 for <cygwin-patches@cygwin.com>; Wed,  9 Feb 2022 15:32:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D9E1C3858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
 by re-prd-fep-046.btinternet.com with ESMTP id
 <20220209153240.DFVJ23644.re-prd-fep-046.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Wed, 9 Feb 2022 15:32:40 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 61A69BAC0845C9C9
X-Originating-IP: [213.120.30.10]
X-OWM-Source-IP: 213.120.30.10 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrheelgdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppedvudefrdduvddtrdeftddruddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdefngdpihhnvghtpedvudefrdduvddtrdeftddruddtpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.103] (213.120.30.10) by
 re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 61A69BAC0845C9C9 for cygwin-patches@cygwin.com;
 Wed, 9 Feb 2022 15:32:40 +0000
Message-ID: <98550a9b-2ce0-328b-d737-a59cf7c7434a@dronecode.org.uk>
Date: Wed, 9 Feb 2022 15:32:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] update site goldstar award types images from jpg/png to
 webp
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220202065958.6840-1-Brian.Inglis@SystematicSW.ab.ca>
 <YfpSaFiy7EH6BwAy@calimero.vinschen.de>
 <5d10614e-adbc-38e4-2b69-f5794d1e24c9@SystematicSw.ab.ca>
 <Yfrskl5AsCMMepFc@calimero.vinschen.de>
 <dc63c4eb-489d-be97-8f54-3aedc7645ebf@dronecode.org.uk>
 <3f2dd608-351b-c105-7191-e1992f034c9e@gmail.com>
 <df2f4097-35c1-78b0-3cb2-30d424fc167e@SystematicSw.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <df2f4097-35c1-78b0-3cb2-30d424fc167e@SystematicSw.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3569.0 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_PASS, SPF_NONE, TXREP, T_SCC_BODY_TEXT_LINE,
 WINNER_SUBJECT autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 09 Feb 2022 15:32:48 -0000

On 05/02/2022 23:18, Brian Inglis wrote:
> 
> One issue I found is that our DocBook 4 does not support webp, so there 
> is currently no support for webp images in generated docs from 
> cygwin-apps/cygwin-x-doc, so no value in converting, unless we want to 
> script an update to the image sources in the *generated* html.
> This affects only cygwin-htdocs/xfree/docs/ug/figures/ ~640KB reduced to 
> ~195KB in the attached image summary log.

Those docs are currently produced by an ancient docbook toolchain (using 
jade), so the whole thing could do with modernizing (assuming it's 
worthwhile having at all...).

> Directory summary totals are grouped at the bottom to show overall numbers.
> 
> It also looks like cygwin-htdocs/xfree/docs/ug/stylesheet-images/ and 
> cygwin-htdocs/xfree/images/ are not referenced anywhere so can be rm'ed: 
> checked with egrep -iR 'png|gif|bmp' cygwin-htdocs/.
> 
> So the net effect would be a reduction in image sizes from <4MB to <1MB.

I've removed cygwin-htdocs/xfree/images/.  Thanks for pointing that out.

I'm not sure what to do about that stylesheet.  It looks like was 
half-written when added (in 2001!).

