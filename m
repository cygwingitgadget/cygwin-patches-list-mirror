Return-Path: <SRS0=R7Qm=6M=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.244])
	by sourceware.org (Postfix) with ESMTP id 69BDA4AB0F9F
	for <cygwin-patches@cygwin.com>; Sat,  6 Dec 2025 11:53:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 69BDA4AB0F9F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 69BDA4AB0F9F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.244
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765022006; cv=none;
	b=hDt9wDd/C3UGLH1FMzUsPA3TDvXOo96SGhoHPymvTnZornvRtOX3A+nMWeKB/i06NXvjy1pCvnHU2agIqAKNeBb6rdHAryyFQBE66VqQY5nrTWd8lHvqcYDW2zDE+cClA2B2HBNm26T2ur6OZPtXiL4XtjFw2DL9/MyjBK6jItQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765022006; c=relaxed/simple;
	bh=ste0WxJfVHVtON1Yi5hHLz6XIWJ/zmswce7xqGo/+TU=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=TYMRL/UIotwwHz1mkMmXgeR8fLGO01HnXLTrYvstsKfdfj2byXIrvoovkFn1dp4BIjRcvT5DxHKC8tPfbO3q//b+x6XWfNaXIjqk1y3r6q0hhwMing6+2yfZ1X4Knya04YSwFfcnkuBEnk0OmQAFNF9WnuGUuX5sZPTXFOYPxeI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 69BDA4AB0F9F
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1DF707F34F6D
X-Originating-IP: [86.139.199.212]
X-OWM-Source-IP: 86.139.199.212
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenuchmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhepkfffgggfufhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvddtgfduudeuheevffdvjefgieeluefgieevvdfgheeuleffffegjeduudfhgedtnecukfhppeekiedrudefledrudelledrvdduvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddufeelrdduleelrddvuddvpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduleelqddvuddvrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdtuddtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghs
	segthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.139.199.212) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1DF707F34F6D for cygwin-patches@cygwin.com; Sat, 6 Dec 2025 11:53:24 +0000
Message-ID: <3206c23d-4701-4145-9ac1-2b6f74d33f05@dronecode.org.uk>
Date: Sat, 6 Dec 2025 11:53:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Cygwin: doc: utils.xml: improve newgrp(1)
 documentation
References: <20251205194200.4011206-1-corinna-cygwin@cygwin.com>
 <20251205194200.4011206-3-corinna-cygwin@cygwin.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20251205194200.4011206-3-corinna-cygwin@cygwin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 05/12/2025 19:41, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> Especially document -l as primary option and - just for Linux
> compatibility.  Note that a command on the commandline is a
> Cygwin extension and incompatible with POSIX and Linux.
> 
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>   winsup/doc/utils.xml | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
> index 6a55b3a0e790..31106f36e45f 100644
> --- a/winsup/doc/utils.xml
> +++ b/winsup/doc/utils.xml
> @@ -2108,13 +2108,13 @@ D: on /d type fat (binary,user,noumount)
>   
>       <refnamediv>
>         <refname>newgrp</refname>
> -      <refpurpose>change primary group for a command</refpurpose>
> +      <refpurpose>change to a new primary group</refpurpose>
>       </refnamediv>
>   
>       <refsynopsisdiv>
>         <cmdsynopsis>
>   	<command>newgrp</command>
> -	<arg choice="opt">-</arg>
> +	<arg choice="opt">-l</arg>
>   	<arg choice="opt"><replaceable>group</replaceable></arg>
>   	<arg><replaceable>command</replaceable>
>   	<arg rep="repeat"><replaceable>args</replaceable></arg>
> @@ -2124,22 +2124,24 @@ D: on /d type fat (binary,user,noumount)
>   
>       <refsect1 id="newgrp-desc">
>         <title>Description</title>
> -      <para><command>newgrp</command> changes the primary group for a
> -        command.</para>
> +      <para><command>newgrp</command> starts a new shell environment under
> +      a new primary group.</para>
>   
> -      <para>If the <option>-</option> flag is given as first argument, the
> +      <para>If the <option>-l</option> flag is given as first argument, the
>   	user's environment will be reinitialized as though the user had logged
>   	in, otherwise the current environment, including current working
> -	directory, remains unchanged.</para>
> +	directory, remains unchanged.  For Linux compatibility, the flag
> +	<option>-</option> is allowed as well.</para>
>   
>         <para><command>newgrp</command> changes the current primary group to the
>           named group, or to the default group listed in /etc/passwd if no group
> -	name is given.</para>
> +	name is given.  The user's standard shell is started, called as login
> +        shell if the <option>-l</option> or <option>-</option> flag has been
> +	specified.</para>

Maybe this should mention somewhere that a numeric group id is also 
accepted?

>   
> -      <para>By default, the user's standard shell is started, called as login
> -        shell if the <option>-</option> flag has been specified.  If a group
> -	has been given as argument, a command and its arguments can be
> -	specified on the command line.</para>
> +      <para> If a group has been given as argument, a command and its
> +	arguments can be specified on the command line.  Note that this
> +	usage is Cygwin-only and incompatible with POSIX and Linux.</para>
>   
>         <para>The new primary group must be either the old primary group, or
>           it must be part of the supplementary group list.  Setting the primary



