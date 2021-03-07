Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-041.btinternet.com (mailomta2-re.btinternet.com
 [213.120.69.95])
 by sourceware.org (Postfix) with ESMTPS id E9BBE385DC37
 for <cygwin-patches@cygwin.com>; Sun,  7 Mar 2021 19:16:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E9BBE385DC37
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-041.btinternet.com with ESMTP id
 <20210307191613.RSOK26832.re-prd-fep-041.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Sun, 7 Mar 2021 19:16:13 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C0CC299EF57A
X-Originating-IP: [81.153.98.229]
X-OWM-Source-IP: 81.153.98.229 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledruddutddgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfedtgfefgfehvdegteekiedtfefgveevfeeujeektefgjedujeffffeiueelvddvnecuffhomhgrihhnpehmihhnghifrdhorhhgpdgthihgfihinhdrtghomhdpmhhinhhgfidqfieigedrohhrghenucfkphepkedurdduheefrdelkedrvddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkedurdduheefrdelkedrvddvledpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoeeurhhirghnrdfknhhglhhishesufihshhtvghmrghtihgtufifrdgrsgdrtggrqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (81.153.98.229) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC299EF57A; Sun, 7 Mar 2021 19:16:13 +0000
Subject: Re: [PATCH] winsup/doc/dll.xml: update MinGW/.org to MinGW-w64/.org
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210307163155.63871-1-Brian.Inglis@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <aada0b19-26ea-9db0-85f4-8f959441e05a@dronecode.org.uk>
Date: Sun, 7 Mar 2021 19:15:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210307163155.63871-1-Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3570.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Sun, 07 Mar 2021 19:16:17 -0000

On 07/03/2021 16:31, Brian Inglis wrote:
> ---
>   winsup/doc/dll.xml | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)


I don't think the link here actually has much value, and would be 
inclined to drop it, as far as I can tell it's just giving that as an 
example of a toolchain which produces 'lib'-prefixed DLLs.

Also, reading the whole page, the section "Linking against DLLs" needs 
updating since GNU ld has had the ability to link directly against DLLs 
(automatically generating the necessary import stubs) for a number of years.

Also, there are other mentions of MinGW.org on the cygwin website (e.g. 
https://cygwin.com/links.html) which also need updating, if that URL is 
no longer valid.
