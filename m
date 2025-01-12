Return-Path: <SRS0=3OGZ=UE=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.159])
	by sourceware.org (Postfix) with ESMTP id BD1F03858C48
	for <cygwin-patches@cygwin.com>; Sun, 12 Jan 2025 17:59:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BD1F03858C48
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BD1F03858C48
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.159
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736704795; cv=none;
	b=uI/gW29oWAja+8+ZcDdINohNkZAohZMdtoUKgbU8ZE0fOLUm6uh2sRr/CB2+0X8vkmD6b5Xe45/1rW3yzCxgx4IUpMg+yRSdAr2t1nzCBVN7Bw534A96MLemkuRpkF7v/KmbhyQjSTDlXhA47OtkOYoAarsTl8U/V04MDS+oiMY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736704795; c=relaxed/simple;
	bh=wRDvbd7w3p07fmYGVbg1IfE6LuYaPPE6yLhyvdSCF5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=MbGUaxY6czNxwMcsvOCRuqEWMaYJARlDayIJ4g1QQTQ1rQjAZCdBff94CdzM2EB0iE/mLW7S2tkda9T8PYDNk4LLO4rPDVfu5j5rIJbbdXADqLCtiBqhRTRqO7/o/dfnSHf0wQWsNC6yX9VdgZE0pj1bwxBV8sHCM6UqPHZfu4c=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BD1F03858C48
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 674901FF04BA328F
X-Originating-IP: [86.140.193.34]
X-OWM-Source-IP: 86.140.193.34
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrudehvddguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevvdekgfffteetueehgfdugefgkeevleejudduheevuedtveejfeevvdevvdfgvdenucfkphepkeeirddugedtrdduleefrdefgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrdefgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelfedqfeegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdekpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepuehrihgrnhdrkfhnghhlihhssefuhihsthgv
	mhgrthhitgfuhgdrrggsrdgtrgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.193.34) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 674901FF04BA328F; Sun, 12 Jan 2025 17:59:51 +0000
Message-ID: <d9088746-b3ad-40d5-a9b0-37a01a7cfe89@dronecode.org.uk>
Date: Sun, 12 Jan 2025 17:59:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 group variants with base
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <76ec9f45a016f163efebca0ae7aa143682349a42.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <76ec9f45a016f163efebca0ae7aa143682349a42.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 11/01/2025 00:01, Brian Inglis wrote:
> Move circular Ff/Fl and similar functions before hyperbolic Fh? and
> similar entries to keep base entries together with their -f -l variants.
'alphabetic ordering except not in some places as an aesthetic choice' 
seems like a terrible idea to me.

