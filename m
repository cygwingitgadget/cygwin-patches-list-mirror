Return-Path: <SRS0=9e7z=JC=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-048.btinternet.com (mailomta20-re.btinternet.com [213.120.69.113])
	by sourceware.org (Postfix) with ESMTPS id ED8513858D1E
	for <cygwin-patches@cygwin.com>; Wed, 24 Jan 2024 13:28:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ED8513858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ED8513858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.113
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706102940; cv=none;
	b=AH7kIwztgJfqlQDkYZDGI3yAnp8kOitsQZZ3wPv/vtgyQqFry3UTX8RKqZDZLhRxidJ08oMcFirPhbs7mHRrtue/dJ1MtDHMD6M01HJY7Te+voeeJJ4yvNKpmduOqMdCiYUGD0m1i+xgB19ARhdtp6t3+9AVf3+C461y0s/S/n4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706102940; c=relaxed/simple;
	bh=9wdNzUHvU26QtqAf0KISnkkwJQr1u2qxChvqFduO4Ak=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=Qbfgy6kh90GCQz8+uqMgspyK5p8uEr9L9xTPC2dpXMhd/rK0JBhXzFfCVGxmYlmJSDtEdA6OF8OCqUNrwafPStvia97wRLSzHaMZqZDtP6uVD2mP70WFYWY8qLNNMmpeYMHrbScFDG7Yrr/8RO+/3lW8h6wLLnqfdkPFq4ON0Ds=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20240124132857.LIUB17945.re-prd-fep-048.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Wed, 24 Jan 2024 13:28:57 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6577B9C50521377E
X-Originating-IP: [86.140.193.68]
X-OWM-Source-IP: 86.140.193.68
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddghedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfufhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvtdfgudduueehveffvdejgfeileeugfeivedvgfehueelffffgeejudduhfegtdenucfkphepkeeirddugedtrdduleefrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrdeikedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqdeikedrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhstheprhgvqdhp
	rhguqdhrghhouhhtqddttdeh
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.140.193.68) by re-prd-rgout-005.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6577B9C50521377E for cygwin-patches@cygwin.com; Wed, 24 Jan 2024 13:28:57 +0000
Message-ID: <c4cde4ee-f908-4944-8a77-8b86f3e51e8f@dronecode.org.uk>
Date: Wed, 24 Jan 2024 13:28:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Cygwin: Make 'ulimit -c' control writing a coredump
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
 <20240112140958.1694-2-jon.turney@dronecode.org.uk>
 <238901bf-db88-4d99-bb82-2b98ff6ebdf6@dronecode.org.uk>
 <Za_NQNPhRNU7fRv0@calimero.vinschen.de>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Za_NQNPhRNU7fRv0@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 23/01/2024 14:29, Corinna Vinschen wrote:
> On Jan 23 14:20, Jon Turney wrote:
> 
>> Even then this is clearly not totally bullet-proof. Maybe the right thing to
>> do is add a suitable timeout here, so even if we fail to notice the
>> DebugActiveProcess() (or there's a custom JIT debugger which just writes the
>> fact a process crashed to a logfile or something), we'll exit eventually?
> 
> Timeouts are just that tiny little bit more bullet-proof, they still
> aren't totally bullet-proof.
> 
> What timeout were you thinking of?  milliseconds?

Oh no, tens of seconds or something, just as a fail-safe.

To be clear, I'm suggesting something like this:

-      while (!being_debugged ())
+      while (!being_debugged () || GetTickCount64() > timeout)
         Sleep (0);


As the comment above identifies, the concern is that if the executed 
command runs too quickly, we don't notice and get stuck there.

This isn't a concern when invoking gdb, as if the debugee is allowed to 
continue, being_debugged will return TRUE and we'll exit the loop.

But if we're invoking dumper, if it attaches and detaches quickly 
enough, we never notice and just get stuck.

(Ofc, all this is working around the fact that Win32 API doesn't have a
WaitForDebuggerPresent(timeout) function)

