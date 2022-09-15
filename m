Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-045.btinternet.com (mailomta13-sa.btinternet.com [213.120.69.19])
	by sourceware.org (Postfix) with ESMTPS id 1C4E5385AC23
	for <cygwin-patches@cygwin.com>; Thu, 15 Sep 2022 17:45:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1C4E5385AC23
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20220915174509.BGNB16833.sa-prd-fep-045.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Thu, 15 Sep 2022 18:45:09 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613943C63A8F8CF3
X-Originating-IP: [81.153.98.219]
X-OWM-Source-IP: 81.153.98.219 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrfedukedguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppeekuddrudehfedrleekrddvudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdeingdpihhnvghtpeekuddrudehfedrleekrddvudelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopeeurhhirghnrdfknhhglhhishesufihshhtvghmrghtihgtufghrdgrsgdrtggrpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.153.98.219) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 613943C63A8F8CF3; Thu, 15 Sep 2022 18:45:09 +0100
Message-ID: <90d51419-b247-848d-6754-8ffd24792d31@dronecode.org.uk>
Date: Thu, 15 Sep 2022 18:45:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/3] strftime, strptime: add %i, %q, %v, tests; tweak %Z
 docs
Content-Language: en-GB
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220914025236.54080-1-Brian.Inglis@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <20220914025236.54080-1-Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3569.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 14/09/2022 03:52, Brian Inglis wrote:
> [Please Reply All due to email issues]
> 
> newlib/libc/time/strftime.c(strftime): add %i, %q, %v, tests; tweak %Z docs
> newlib/libc/time/strptime.c(strptime_l): add %i, %q, %v
> winsup/cygwin/libc/strptime.cc(__strptime): add %i, %q, %v
> 
> %i year in century [00..99] Synonym for "%y". Non-POSIX extension. [tm_year]
> %q GNU quarter of the year (from `<<1>>' to `<<4>>') [tm_mon]
> %v OSX/Ruby VMS/Oracle date "%d-%b-%Y". Non-POSIX extension. [tm_mday, tm_mon, tm_year]
> add %i %q %v tests
> %Z clarify current time zone *abbreviation* not "name" [tm_isdst]

The newlib patches should go to the newlib list.

Do you have a reference for an OS supporting the %i extension?  I'm just 
curious if it specifies the same pivot year for strptime() as POSIX does 
for %y?

