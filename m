Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-044.btinternet.com (mailomta2-sa.btinternet.com
 [213.120.69.8])
 by sourceware.org (Postfix) with ESMTPS id BE3EB3857C53
 for <cygwin-patches@cygwin.com>; Sat,  5 Feb 2022 14:27:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BE3EB3857C53
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-044.btinternet.com with ESMTP id
 <20220205142701.MJKQ24689.sa-prd-fep-044.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Sat, 5 Feb 2022 14:27:01 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 6139417C14351483
X-Originating-IP: [213.120.30.10]
X-OWM-Source-IP: 213.120.30.10 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrhedugdeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppedvudefrdduvddtrdeftddruddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdefngdpihhnvghtpedvudefrdduvddtrdeftddruddtpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.103] (213.120.30.10) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 6139417C14351483 for cygwin-patches@cygwin.com;
 Sat, 5 Feb 2022 14:27:01 +0000
Message-ID: <dc63c4eb-489d-be97-8f54-3aedc7645ebf@dronecode.org.uk>
Date: Sat, 5 Feb 2022 14:26:32 +0000
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
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <Yfrskl5AsCMMepFc@calimero.vinschen.de>
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
X-List-Received-Date: Sat, 05 Feb 2022 14:27:04 -0000

On 02/02/2022 20:41, Corinna Vinschen wrote:
> On Feb  2 11:49, Brian Inglis wrote:
>> On 2022-02-02 02:44, Corinna Vinschen wrote:
>>> On Feb  1 23:59, Brian Inglis wrote:
[...]
>>
>> Would you be interested in a similar patch series for the whole site?

Do you have any information on how widespread browser support for webp is?

> It's not *my* interest as such, rather it's a great idea... as would be
> any and all patches to make the entire site mobile-aware.  Always feel
> free to send patches for stuff like that!

If you're going to make the site more mobile friendly, I think the first 
thing which needs to be done is some responsive CSS to stop the navbar 
taking up the majority of the screen.
