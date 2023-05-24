Return-Path: <SRS0=KXep=BN=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-048.btinternet.com (mailomta11-sa.btinternet.com [213.120.69.17])
	by sourceware.org (Postfix) with ESMTPS id EF2253858289
	for <cygwin-patches@cygwin.com>; Wed, 24 May 2023 19:51:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EF2253858289
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20230524195131.YFZH1091.sa-prd-fep-048.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 24 May 2023 20:51:31 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64067E9B09523335
X-Originating-IP: [86.139.158.65]
X-OWM-Source-IP: 86.139.158.65 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgudegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeludfggefhteetueelieeltddufeevieduiefgudelueektdeutefftedvheejnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkeeirddufeelrdduheekrdeiheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkeeirddufeelrdduheekrdeihedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqdeihedrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhh
	pghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttddv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (86.139.158.65) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067E9B09523335; Wed, 24 May 2023 20:51:31 +0100
Message-ID: <4697cccf-90f3-35e7-c5f0-4c29a2f5ec09@dronecode.org.uk>
Date: Wed, 24 May 2023 20:51:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Adjust CWD magic to accommodate for the latest Windows
 previews
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <60e1e112b1c293a69bfa4df3fe5094e562898bbb.1684755365.git.johannes.schindelin@gmx.de>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <60e1e112b1c293a69bfa4df3fe5094e562898bbb.1684755365.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 22/05/2023 12:36, Johannes Schindelin wrote:
> Reportedly Windows 11 build 25*** from Insider changed the current
> working directory logic a bit, and Cygwin's "magic" (or:
> "technologically sufficiently advanced") code needs to be adjusted
> accordingly.
> 
> This fixes https://github.com/git-for-windows/git/issues/4429
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Applied. Thanks.

