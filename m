Return-Path: <SRS0=bps0=UO=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.180])
	by sourceware.org (Postfix) with ESMTP id AA7543858416
	for <cygwin-patches@cygwin.com>; Wed, 22 Jan 2025 19:47:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AA7543858416
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AA7543858416
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.180
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737575267; cv=none;
	b=p5XHRiB9YJLIeXjWIfTpYQjIxPrY8UlygVfrjrNjPXmFkfH9oPFG7DEgCSTn7xcSlzIPLLROSB9yvvEBIIfMmpZ4/OuH0UTzkmTT3fA0GWhaFadSOZanaUJDFEY1Kq+lW76lLv/4MQS/lTFpeFkFwx+lx1XuRHhqSIn4vKbSVyI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737575267; c=relaxed/simple;
	bh=IUpnuh8konlk/R+2f4ZziQqE6N1ZtbjJvsRxJv3awoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=DmCLDMRKSygyunJ8TiBr/PG/ejV9KZ0GMaWSyRXt5LTsjUNmtnWz1VK2yd8vsEh7djgq2gBBo09moyT/vAqmYxNlx5Xj7ag3uj5w2+RhtOP9r0I1e7a29fX8v1SZyRk+spsovpewhzzEwXPC1e69KpXjZtpR1c67yu403EsmAB0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AA7543858416
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 674901FF05E0A53E
X-Originating-IP: [86.140.193.34]
X-OWM-Source-IP: 86.140.193.34
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvdehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevvdekgfffteetueehgfdugefgkeevleejudduheevuedtveejfeevvdevvdfgvdenucfkphepkeeirddugedtrdduleefrdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrdefgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelfedqfeegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdegpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepuehrihgrnhdrkfhnghhlihhssefuhihsthgv
	mhgrthhitgfuhgdrrggsrdgtrgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.193.34) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 674901FF05E0A53E; Wed, 22 Jan 2025 19:47:43 +0000
Message-ID: <931a7037-20ba-4463-97c5-f175608bbdd2@dronecode.org.uk>
Date: Wed, 22 Jan 2025 19:47:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 not implemented new additions
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <342fdec23f175f816177ac73945ed7fbf5538b90.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z5DQzmtsrcGeFPxx@calimero.vinschen.de>
 <Z5DRovbwX9QpofDO@calimero.vinschen.de>
 <d4249a94-5efa-43c0-92f3-4586b8cff507@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <d4249a94-5efa-43c0-92f3-4586b8cff507@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 22/01/2025 17:36, Brian Inglis wrote:
[...]
> "Please note some changes are displaced due to rebase conflicts."
> 
> which only appear after commit --amend/rebase --continue!
> 
> As I said before, I am now noticing the limitations of interactive 
> rebasing and cherry-picking, sometimes skipping patches or hunks, 
> especially after conflicts!
> 
> If you have any advice for avoiding those conflicts, please hit me with 
> your clue stick! ;^>
  If a 'git rebase' reports merge conflicts, I would suggest using 'git 
mergetool' to invoke your favorite 3-way graphical merge tool (I like 
kdiff3, but you might have a different preference).

