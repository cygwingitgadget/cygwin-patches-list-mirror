Return-Path: <SRS0=U68W=HK=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-049.btinternet.com (mailomta26-re.btinternet.com [213.120.69.119])
	by sourceware.org (Postfix) with ESMTPS id F353A3858C31;
	Wed, 29 Nov 2023 16:07:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F353A3858C31
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F353A3858C31
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.119
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1701274034; cv=none;
	b=DVkHeJCXKazfSRfp5fdEp2oylq1WZfN7jsfIGqgdhYAtYRHBVn0SCBjpZO4qf+etr8IERsj0DRiUkZtpmlaukKKCBwisaxy+vs2+8h4q5Te338TTWj6drjnVACkthor1J5UcG0mpRWGGyLd3EGvrksHbMFahI+fCC+ZabF2L1hc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1701274034; c=relaxed/simple;
	bh=L4AW9aGNY0Z8W2aFgufLSOmJ2VTsMPzSd1yu3Z8J/9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=bGasSpdrZnyX2oS4dDH1HItOEGsJN0Ys0XlkiU8w1FS0bLa4ELmifozO0DO5LgEpGAPGSpyZ+YqghRtDrpIMA5JT/K/x/eQ3OiSla5tB3JGccLdPER1nAVdKbhDCbsncRq27vAMnmty6IVhEsjmTUU3Mb0Kl+78ihiJ9MnG5z1U=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20231129160711.THAJ8012.re-prd-fep-049.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Wed, 29 Nov 2023 16:07:11 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64D16E730BDAC595
X-Originating-IP: [81.129.146.217]
X-OWM-Source-IP: 81.129.146.217 (GB)
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedgkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvvdeuheffuedvtdfhveekieefvdfhfeetffdvudehkeeigeetvdetjeetieeileenucfkphepkedurdduvdelrddugeeirddvudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdejngdpihhnvghtpeekuddruddvledrudegiedrvddujedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptghorhhinhhnrgdqtgihghifihhnsegthihgfihinhdrtghomhdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqvddujedrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessght
	ihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhstheprhgvqdhprhguqdhrghhouhhtqddttddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.107] (81.129.146.217) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814.02) (authenticated as jonturney@btinternet.com)
        id 64D16E730BDAC595; Wed, 29 Nov 2023 16:07:11 +0000
Message-ID: <6000336c-8342-41c7-86c4-5660c6906cb6@dronecode.org.uk>
Date: Wed, 29 Nov 2023 16:07:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Add '--names-only' flag to cygcheck
Content-Language: en-GB
To: Corinna Vinschen <corinna-cygwin@cygwin.com>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <20231124170657.28490-1-jon.turney@dronecode.org.uk>
 <ZWDsEt2Rfmm4T_f4@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <ZWDsEt2Rfmm4T_f4@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 24/11/2023 18:31, Corinna Vinschen wrote:
> On Nov 24 17:06, Jon Turney wrote:
>> Add '--names-only' flag to cygcheck, to output just the bare package
>> names.
> 
> Push it!
> 

I added changes to the manpage to document this option as well, before 
pushing it.

Thanks.

