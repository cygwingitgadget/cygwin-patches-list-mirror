Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-047.btinternet.com (mailomta18-re.btinternet.com
 [213.120.69.111])
 by sourceware.org (Postfix) with ESMTPS id 951CE3856241
 for <cygwin-patches@cygwin.com>; Sun, 29 May 2022 13:39:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 951CE3856241
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-047.btinternet.com with ESMTP id
 <20220529133932.ODCQ3222.re-prd-fep-047.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Sun, 29 May 2022 14:39:32 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613A8DE825CB501E
X-Originating-IP: [86.139.167.41]
X-OWM-Source-IP: 86.139.167.41 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrkeeggdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppeekiedrudefledrudeijedrgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdehngdpihhnvghtpeekiedrudefledrudeijedrgedupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.105] (86.139.167.41) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613A8DE825CB501E for cygwin-patches@cygwin.com;
 Sun, 29 May 2022 14:39:32 +0100
Message-ID: <ce7de251-14d1-e54d-e2ef-5b67ad256a64@dronecode.org.uk>
Date: Sun, 29 May 2022 14:39:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 7/7] Cygwin: remove miscellaneous 32-bit code
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <2de3539b-efc2-b6f1-b9e3-8429ecb24c0b@cornell.edu>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <2de3539b-efc2-b6f1-b9e3-8429ecb24c0b@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1192.9 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_LINKBAIT, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_PASS, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Sun, 29 May 2022 13:39:35 -0000

On 26/05/2022 20:17, Ken Brown wrote:
>   winsup/cygwin/autoload.cc                | 136 -----------------------

Looks good.

I think that perhaps the stdcall decoration number n is unused on 
x86_64, so can be removed also in a followup?
