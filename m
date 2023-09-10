Return-Path: <SRS0=5cOX=E2=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-041.btinternet.com (mailomta30-sa.btinternet.com [213.120.69.36])
	by sourceware.org (Postfix) with ESMTPS id 641703858433
	for <cygwin-patches@cygwin.com>; Sun, 10 Sep 2023 13:38:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 641703858433
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20230910133806.UKVU7232.sa-prd-fep-041.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Sun, 10 Sep 2023 14:38:06 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64CAD81103FB43CE
X-Originating-IP: [86.143.43.46]
X-OWM-Source-IP: 86.143.43.46 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrudeivddgieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehudeuveeujeeujeegueefhedttdekvedtudeileefteetfeefjeejudekfefggfenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekiedrudegfedrgeefrdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkeeirddugeefrdegfedrgeeipdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekiedqudegfedqgeefqdegiedrrhgrnhhgvgekiedqudegfedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefi
	uedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttdef
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (86.143.43.46) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.814.02) (authenticated as jonturney@btinternet.com)
        id 64CAD81103FB43CE for cygwin-patches@cygwin.com; Sun, 10 Sep 2023 14:38:06 +0100
Message-ID: <e339c75e-1dae-6c58-c26b-efcddbe64da0@dronecode.org.uk>
Date: Sun, 10 Sep 2023 14:38:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] Cygwin: Fix __cpuset_zero_s prototype
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20230908053639.5689-1-mark@maxrnd.com>
 <ZPzjskmDV+RIynoS@calimero.vinschen.de>
 <20230910083709.0b7c6de6da6c46e1705a8873@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <20230910083709.0b7c6de6da6c46e1705a8873@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 10/09/2023 00:37, Takashi Yano wrote:
> Hi Corinna,
> 
> On Sat, 9 Sep 2023 23:29:22 +0200
> Corinna Vinschen wrote:
>> On Sep  7 22:36, Mark Geisert wrote:
>>> Add a missing "void" to the prototype for __cpuset_zero_s().
>>>
>>> Reported-by: Marco Mason <marco.mason@gmail.com>
>>> Addresses: https://cygwin.com/pipermail/cygwin/2023-September/254423.html
>>> Signed-off-by: Mark Geisert <mark@maxrnd.com>
>>> Fixes: c6cfc99648d6 (Cygwin: sys/cpuset.h: add cpuset-specific external functions)
>>>
>>> ---
>>>   winsup/cygwin/include/sys/cpuset.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Pushed, including doc fix.
> 
> These patch shoud be applied also to cygwin-3_4-branch, but didn't.
> 

Good point.  I went ahead and did that.

