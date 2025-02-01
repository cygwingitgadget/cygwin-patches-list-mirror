Return-Path: <SRS0=asCP=UY=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.197])
	by sourceware.org (Postfix) with ESMTP id AAB0B3858D39
	for <cygwin-patches@cygwin.com>; Sat,  1 Feb 2025 15:52:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AAB0B3858D39
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AAB0B3858D39
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.197
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1738425141; cv=none;
	b=I1XMm+97zRm63ACBWHPqKPT14jgor6dTadHi1xuIjexeomp5/ZLEXQDL/3uhiYak6PK4XlAvkNXKUI8sQW0WEoAiMTT9a/57YfmkGkzcl99Y3cKOvZrTRQJhhbwUhc45fI+z5on98YVulqwteelqJTm0E+hm0Wf3OkOrQvLa2TY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1738425141; c=relaxed/simple;
	bh=uVLK2QzOIzt5t1GdWYviGxZGgBSuimlYasPqKYwXMc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=g28zq1+VQuCgQOA5VFyiPv+A8uUSeBkdD0hUmwSKT9iYFrPn9Vd2qi36q+ID3rogzYJoFo7i2XiKwfOYb9dgzx2xxJnw47PS00y7tW7g+mfBUEZVu409Deod93H6KnBXusY15G+A5tg9axp8igvmSO5d1Zh05wtsSkigrEQoUy4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AAB0B3858D39
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 674901FF06F9D0BB
X-Originating-IP: [86.133.181.121]
X-OWM-Source-IP: 86.133.181.121
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeejiefhkeffleehhedvjeevfefftdfhffevieeiudevvdfgtdeltdehffevjeeigfenucffohhmrghinhepgidrohhrghdptgihghifihhnrdgtohhmnecukfhppeekiedrudeffedrudekuddruddvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddufeefrddukedurdduvddupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeefqddukeduqdduvddurdhrrghnghgvkeeiqddufeefrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdekpdhnsggprhgtphhtthho
	pedvpdhrtghpthhtohepuehrihgrnhdrkfhnghhlihhssefuhihsthgvmhgrthhitgfuhgdrrggsrdgtrgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.133.181.121) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 674901FF06F9D0BB; Sat, 1 Feb 2025 15:52:16 +0000
Message-ID: <17478133-a196-41bd-92f4-ac3eb7866f5c@dronecode.org.uk>
Date: Sat, 1 Feb 2025 15:52:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] update Cygwin-X news page X.Org and Cygwin release
 announcements to current stable releases
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
References: <4c395f96efe5f7e7026c91125c832d431dcc145f.1738294648.git.Brian.Inglis@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <4c395f96efe5f7e7026c91125c832d431dcc145f.1738294648.git.Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 31/01/2025 03:39, Brian Inglis wrote:
> might want to change the older messages to a more general Cygwin-X FAQ reference

I don't really understand how this statement applies to the change 
suggested?

> 
> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> ---
>   xfree/cygx-news-new.html | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/xfree/cygx-news-new.html b/xfree/cygx-news-new.html
> index e326fa084c2c..a9ff136ea684 100644
> --- a/xfree/cygx-news-new.html
> +++ b/xfree/cygx-news-new.html
> @@ -1,14 +1,14 @@
>   <p>
> -<a href="https://lists.x.org/archives/xorg-announce/2021-October/003115.html">
> -X server 21.1</a> and

Thanks, but:

This is deliberately the major release number.

> -<a href="http://lists.x.org/archives/xorg-announce/2012-June/001977.html">
> -X.Org X11 Release 7.7</a>
> +<a href="https://lists.x.org/archives/xorg-announce/2024-December/003576.html">
> +X.Org X Server 21.1.15</a> and
> +<a href="https://lists.x.org/archives/xorg-announce/2024-July/003521.html">
> +X.Org X11 Release 1.8.10</a>

This is wrong.

R7.7 is the X11 rollup release number (informally called a "katamari"), 
inherited from the days when X11 was distributed as a monolithic source 
tree.

This is not the libX11 version number.

>   are included in Cygwin.
> -Details are available in the announcements
> -<a href="https://cygwin.com/pipermail/cygwin-announce/2021-November/010286.html">
> -here</a> and
> -<a href="http://cygwin.com/ml/cygwin-xfree-announce/2012-07/msg00001.html">
> -here</a>.
> +Details are available in the announcements of the respective Cygwin packages
> +<a href="https://cygwin.com/pipermail/cygwin-announce/2025-January/012120.html">
> +X.Org Server 21.1.15</a> and
> +<a href="https://cygwin.com/pipermail/cygwin-announce/2025-January/012082.html">
> +X.Org X11 refresh</a>.
>   </p>

If I was going to change this, I'd probably just remove it all, since 
X11 development velocity is slow enough these days that it doesn't 
really communicate much useful information.

