Return-Path: <SRS0=5cOX=E2=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-048.btinternet.com (mailomta12-sa.btinternet.com [213.120.69.18])
	by sourceware.org (Postfix) with ESMTPS id 0CCD93858D33
	for <cygwin-patches@cygwin.com>; Sun, 10 Sep 2023 14:41:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0CCD93858D33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20230910144135.MFYZ7361.sa-prd-fep-048.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Sun, 10 Sep 2023 15:41:35 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64CAD98C03FBEB2F
X-Originating-IP: [86.143.43.46]
X-OWM-Source-IP: 86.143.43.46 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrudeivddgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeihfeghfdviedvjeevkeektdejuddvhedtveetgeevkefgtdeigeejvdeutefhvdenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgnecukfhppeekiedrudegfedrgeefrdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkeeirddugeefrdegfedrgeeipdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopeevhhhrihhsthhirghnrdfhrhgrnhhkvgesthdqohhnlhhinhgvrdguvgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekiedqudegfedqgeefqdegiedrrhgrnhhgvgekiedqudegfedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghu
	thhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttdeg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (86.143.43.46) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.814.02) (authenticated as jonturney@btinternet.com)
        id 64CAD98C03FBEB2F; Sun, 10 Sep 2023 15:41:35 +0100
Message-ID: <a691f19e-ec1b-3b5e-7495-77156799dbd0@dronecode.org.uk>
Date: Sun, 10 Sep 2023 15:41:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] Add initial support for SOURCE_DATE_EPOCH
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>,
 Christian Franke <Christian.Franke@t-online.de>
References: <a1890367-b100-2321-aca4-17eec98ebba7@t-online.de>
 <ZPsrFKgcmt2qrH34@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <ZPsrFKgcmt2qrH34@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 08/09/2023 15:09, Corinna Vinschen wrote:
> Jon,
> 
> you did all the latest work in terms of the build machinery.
> Would you mind to review this patch, please?

Sure.

Patch looks all right to me, so I applied it.

> On Sep  5 19:01, Christian Franke wrote:
>> This patch enables reproducible builds of cygwin package in conjunction with
>> this cygport patch:
>> https://sourceware.org/pipermail/cygwin-apps/2023-August/043108.html
>>
>> cygwin.cygport was enhanced for the test as described in the above post.
>>
>> If the same build path, SOURCE_DATE_EPOCH and toolchain are used, rebuilds
>> with cygport produce identical distribution tarballs. Adding proper
>> -fmacro-prefix-map gcc options (or remove all usages of __FILE__) could
>> possibly make this independent from the build path.
>>
>> Note that 'u' (replace with newer objects only) flag needed to be removed
>> from ar commands because it is incompatible with 'D' (deterministic
>> archive). I don't expect any negative effect because existing .a files are
>> always removed before ar is run.
>>
>> Not yet tested with different machines or different users accounts.
>>
>> Patch would be much simpler (mkvers.sh only) if binutils would support
>> SOURCE_DATE_EPOCH directly.
>>

