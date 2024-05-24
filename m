Return-Path: <SRS0=qzkW=M3=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-045.btinternet.com (mailomta9-re.btinternet.com [213.120.69.102])
	by sourceware.org (Postfix) with ESMTPS id 260073858D29
	for <cygwin-patches@cygwin.com>; Fri, 24 May 2024 16:24:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 260073858D29
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 260073858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.102
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1716567850; cv=none;
	b=F+qFTq9voa62St1ZxmMVT1dhWG97vzxi9LESHIZIIuNvnPtA9AZI+NkUiCTqifmdlgki+EAAl+a7LBF8UJK5wK+KUnC4q6bYtgFnqY0Qs9DrUsy4gaC0F+JgNJyYuW4j9AGHrn/6nEhxKQURBoK5nYw6/rab/u81Gr8DjoNGh2Q=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1716567850; c=relaxed/simple;
	bh=/F3Mi34Txt9GkMibcyY9jhwsvBgqitREKJrsUtE3eSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Qj++NZZLXsciTwkDSZjj4VOsXPZhtko71smlZ7Nz6plnHeeLWqKS25IFU4CWJs9LqRDdjMPU8vxwH7Hde2oOFj2DcX7B9xez3gGObOs6k7qVDEh13cZGfs6AWEK/IvP/wfjicPiip+YGeHqTDFgFMrTj+ZgUKYhogS4KSLruUos=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20240524162407.RZKX21611.re-prd-fep-045.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 24 May 2024 17:24:07 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6577B465131012E9
X-Originating-IP: [86.139.167.83]
X-OWM-Source-IP: 86.139.167.83
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeelteeiteduledufefgueetveefiefffeevteffvdeiiefggedvgefftddvfeelhfenucffohhmrghinheptgihghifihhnrdgtohhmpdhprghsthgpmhhishhtrghkvghsrdhphienucfkphepkeeirddufeelrdduieejrdekfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddufeelrdduieejrdekfedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptggrlhgvshhthihosehstghivghnthhirgdrohhrghdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekiedqudefledqudeijedqkeefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehj
	ohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehrvgdqphhrugdqrhhgohhuthdqtddtud
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.139.167.83) by re-prd-rgout-001.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6577B465131012E9; Fri, 24 May 2024 17:24:06 +0100
Message-ID: <a3ab184d-20b1-422f-96c1-c85f115bf16e@dronecode.org.uk>
Date: Fri, 24 May 2024 17:24:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] make `cygcheck --find-package` output parseable
To: Christoph Anton Mitterer <calestyo@scientia.org>
References: <20240522003627.486983-1-calestyo@scientia.org>
 <20240522003627.486983-2-calestyo@scientia.org>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20240522003627.486983-2-calestyo@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 22/05/2024 01:35, Christoph Anton Mitterer wrote:
> From: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>

Thanks very much for this patch.

> Both, package names and version numbers, are allowed to contain `-`, which makes
> the output of `cygcheck --find-package` not parseable.

So, this isn't really true, per the rules [1].  However, there are some 
historical exceptions [2], which ideally we'd remove or replace.

Even with those exceptions, I think the heuristic of (i) split PVR on 
the leftmost hyphen followed by a digit, to split P and VR, (ii) then 
split VR on the rightmost hyphen, to split V and R, always gives the 
right answer.

[1] https://cygwin.com/packaging-package-files.html
[2] https://cygwin.com/cgit/cygwin-apps/calm/tree/calm/past_mistakes.py#n30

> This changes the separator between package name and version to be a space, which
> is not allowed in package names.

That's not to say something like this isn't a good idea, but I think it 
would perhaps be better to have an option explicitly produce something 
machine readable (as csv or whatever...)

> 
> Signed-off-by: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
> ---
>   winsup/utils/mingw/dump_setup.cc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/utils/mingw/dump_setup.cc b/winsup/utils/mingw/dump_setup.cc
> index 050679a0d..e30f0f8ed 100644
> --- a/winsup/utils/mingw/dump_setup.cc
> +++ b/winsup/utils/mingw/dump_setup.cc
> @@ -590,7 +590,7 @@ package_find (int verbose, char **argv)
>   		{
>   		  if (verbose)
>   		    printf ("%s: found in package ", filename);
> -		  printf ("%s-%s\n", packages[i].name, packages[i].ver);
> +		  printf ("%s %s\n", packages[i].name, packages[i].ver);
>   		}
>   	    }
>   	}

