Return-Path: <SRS0=xsK9=XN=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.62])
	by sourceware.org (Postfix) with ESMTP id 70856385840B
	for <cygwin-patches@cygwin.com>; Sun, 27 Apr 2025 18:22:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 70856385840B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 70856385840B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.62
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745778159; cv=none;
	b=l3fNTxr8aF76YA1UfN9uTLjsv19ma73c4yVS2VXR/NOPOPtLr0CsrSFPuvdGNfDVLTmjqovcx2SHThNRZ0QPqhN4OImj7ma9nfgy+v2LG7T3D7pSiOG7+rH/CNXAmuM5gY6fk4eijwSI1ybY9hpnl1xsTM5u85ZQnuR/Kke6XjQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745778159; c=relaxed/simple;
	bh=XT1+ScRhdKnbTLXIj/byG2SecjlB96YHSf6zhuYaM1s=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=Gto4Mk0mxiOfTVp82Rf4PQDtmO/kP7ywC+Q8mncu/4t36uoMAks9ROJxpTaCZgqhO0OqyBpzoKzBLPLEADN0I2POVGRO+rvABiljjAvdOabIrKAeWDSvW9EaDqf7Zigz8osNMu37s685BW2/5SuMIQXgstLdGwvsoDkGqb4W4Q0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 70856385840B
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89E4E04D33319
X-Originating-IP: [86.143.43.122]
X-OWM-Source-IP: 86.143.43.122
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfufhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvtdfgudduueehveffvdejgfeileeugfeivedvgfehueelffffgeejudduhfegtdenucfkphepkeeirddugeefrdegfedruddvvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugeefrdegfedruddvvddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegfedqgeefqdduvddvrdhrrghnghgvkeeiqddugeefrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdtuddupdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegt
	hihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.143.43.122) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89E4E04D33319 for cygwin-patches@cygwin.com; Sun, 27 Apr 2025 19:22:38 +0100
Message-ID: <ac9d481c-00f0-46fd-a28f-c6938418e5d1@dronecode.org.uk>
Date: Sun, 27 Apr 2025 19:22:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: kill(1): skip kill(2) call if '-f -s -' is used
References: <16c95bad-2310-e66c-d538-403321033d2c@t-online.de>
 <20250415164029.c118309bc33c25f4b404b48d@nifty.ne.jp>
 <4356587f-51ed-302d-03f1-7415590813f6@t-online.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <4356587f-51ed-302d-03f1-7415590813f6@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 15/04/2025 10:02, Christian Franke wrote:
> Hi Takashi,
> 
> Takashi Yano wrote:
>> Hi Christian,
>>
>> On Fri, 11 Apr 2025 16:46:07 +0200
>> Christian Franke wrote:
>>> In rare cases, '/bin/kill -f PID' hangs because kill(2) is always tried
>>> first. With this patch, this could be prevented with '/bin/kill -f -s -
>>> PID'.

As it currently stands, the -f flag to kill seems a bit misdesigned, 
i.e. if the signal isn't SIGKILL, -f shouldn't be accepted?

>> I wonder why kill(2) hangs. Do you have any idea?

I think there's something if we end up trying to do "Windows PID to 
cygwin PID mapping", that requires the target PID to respond to us?

