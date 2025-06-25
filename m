Return-Path: <SRS0=a7JR=ZI=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.133])
	by sourceware.org (Postfix) with ESMTP id 964B93858039
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 12:03:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 964B93858039
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 964B93858039
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.133
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750852988; cv=none;
	b=We24n28vBcKbsecbgJ1uPF8/fyQXLlt6I4t4CvZmD2XCUeP2bzqTcbKTjiQ9Epqq2ihrZtDpZbwZx2ErgNzrcGT3S13EsxmXuXxF/MM+uglv0q8wByw8o2r+oDigsw45EaEnJsFUBEu3NU6labSt1nzG4vL5no7f6CH9nMGqqXw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750852988; c=relaxed/simple;
	bh=bNiVLsuKuwKBa4G6ShZjrVeRNDH0ue4RdICyZkK22lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=xYboVMv6TlMPgn6eBeAUL1n/NfBut/zadpPr/4sGGOiNHDlngXLjVmBv6CquXTMAYiPL7JN27J2KMoSMAN2p/CH+XZ3nyfIGYAwrRQwNGLr9YaOV+VMOxb/ilkNfVkM2MbY59pFg5Npo2D2ZmFj8nFJ5A+BqyI2VAxqeyFer32Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 964B93858039
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89E080AB3D4C1
X-Originating-IP: [86.139.167.63]
X-OWM-Source-IP: 86.139.167.63
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeghfdvvdeijeettdfgleetffetfedtuefgfeevhedthefgffelfeethfdvleffnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkeeirddufeelrdduieejrdeifeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddufeelrdduieejrdeifedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudefledqudeijedqieefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdtuddtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihg
	fihinhdrtghomhdprhgtphhtthhopehjohhhnhhhrghughgrsghoohhksehgmhgrihhlrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.139.167.63) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89E080AB3D4C1; Wed, 25 Jun 2025 13:03:06 +0100
Message-ID: <90d4d80b-bdcb-4fc8-81da-7b4e49fbd4b3@dronecode.org.uk>
Date: Wed, 25 Jun 2025 13:03:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] install.html: add tip for -P as preliminary search
To: johnhaugabook@gmail.com
References: <20250622083213.1871-1-johnhaugabook@gmail.com>
 <20250622083213.1871-3-johnhaugabook@gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20250622083213.1871-3-johnhaugabook@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 22/06/2025 09:32, johnhaugabook@gmail.com wrote:
> From: jhauga <johnhaugabook@gmail.com>
> 
> ---
>   install.html | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/install.html b/install.html
> index 4a9e54ff..13acf430 100755
> --- a/install.html
> +++ b/install.html
> @@ -61,6 +61,11 @@ Tip: if you don't want to also upgrade existing packages, select 'Keep' at the
>   top-right of the package chooser page.
>   </p>
>   
> +<p>
> +Tip: use the <code>-P</code> option to perform a preliminary package search i.e.
> +<code>setup-x86_64.exe -P <i>packageName</i></code>.
> +</p>
> +

I mean, yes it can, but... I don't think that's a good way of doing it.

(For a start, for historical reasons, we only warn, not error, on 
unavailable package names, so you have to pay close attention to the 
output to see if setup did anything or not with the packagename you gave it)

And I mean, typing guesses here, like is it foo-devel, or libfoo-devel 
or foo-dev or... is not ideal.

Maybe what's needed here is another Q&A: "What packages are available? 
How can I find out what package contains X?" which links to 
https://cygwin.com/packages/?

(and maybe mentions various appropriate cygcheck options like -e/-p)?

