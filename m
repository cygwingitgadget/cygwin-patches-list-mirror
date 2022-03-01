Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-049.btinternet.com (mailomta26-re.btinternet.com
 [213.120.69.119])
 by sourceware.org (Postfix) with ESMTPS id B1B203858415
 for <cygwin-patches@cygwin.com>; Tue,  1 Mar 2022 14:26:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B1B203858415
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-049.btinternet.com with ESMTP id
 <20220301142618.OKFJ31284.re-prd-fep-049.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
 Tue, 1 Mar 2022 14:26:18 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613A8CC316BF0F26
X-Originating-IP: [86.139.156.65]
X-OWM-Source-IP: 86.139.156.65 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvddgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehudeuveeujeeujeegueefhedttdekvedtudeileefteetfeefjeejudekfefggfenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekiedrudefledrudehiedrieehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdefngdpihhnvghtpeekiedrudefledrudehiedrieehpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepvhgrphhivghrsehgvghnthhoohdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.103] (86.139.156.65) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613A8CC316BF0F26; Tue, 1 Mar 2022 14:26:18 +0000
Message-ID: <9a4b4c3c-f35f-920f-5937-bf119f63983e@dronecode.org.uk>
Date: Tue, 1 Mar 2022 14:26:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] winsup: enable maintainer mode support
Content-Language: en-GB
To: Mike Frysinger <vapier@gentoo.org>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220301005439.23139-1-vapier@gentoo.org>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <20220301005439.23139-1-vapier@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1199.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_PASS, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 01 Mar 2022 14:26:24 -0000

On 01/03/2022 00:54, Mike Frysinger wrote:
> We do this in newlib & libgloss, so enable in winsup too for consistency.
> ---
>   winsup/configure.ac | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/configure.ac b/winsup/configure.ac
> index b8d2100dbe90..6c6e1cb0893a 100644
> --- a/winsup/configure.ac
> +++ b/winsup/configure.ac
> @@ -13,6 +13,7 @@ AC_INIT([Cygwin],[0],[cygwin@cygwin.com],[cygwin],[https://cygwin.com])
>   AC_CONFIG_AUX_DIR(..)
>   AC_CANONICAL_TARGET
>   AM_INIT_AUTOMAKE([dejagnu foreign no-define no-dist subdir-objects -Wall -Wno-portability -Wno-extra-portability])
> +AM_MAINTAINER_MODE

I'm not sure having maintainer-mode disabled by default for cygwin makes 
a lot of sense.

We don't check in the autotools generated files, so for the handful of 
people in the world who build cygwin from source from the git repo, they 
should have autotools already installed and this just requires them to 
know and remember to use '--enable-maintainer-mode'.

(There are no meaningful source archive releases of cygwin.)

I take the point about consistency, but I'm not sure what the arguments 
are against using 'AM_MAINTAINER_MODE([enabled])' everywhere.
