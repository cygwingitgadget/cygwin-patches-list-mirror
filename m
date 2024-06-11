Return-Path: <SRS0=vLp3=NN=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-043.btinternet.com (mailomta7-sa.btinternet.com [213.120.69.13])
	by sourceware.org (Postfix) with ESMTPS id B50043858C5F
	for <cygwin-patches@cygwin.com>; Tue, 11 Jun 2024 13:16:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B50043858C5F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B50043858C5F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1718111814; cv=none;
	b=JD9O8A57wmSXcWBF+DP+wv+7lNuzVMy6xURW8cEmuUHoCxvQJhFkvHOwWokYQSfaRhN4HJeTyH7W+eaPtOdbAnwZiorOEJhnEyS3BnlXmqvRosbJhnnmZvedX1Etz6H18G2ZexxKOPm6DfsdOxfYreCUiDYZxEGdEGlcAC1ntsA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1718111814; c=relaxed/simple;
	bh=GxQ2uSgDcc7/6izdYY4pkN0Pu3NILzj75EqW4ZA+ki4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=lFom+cS4wezkXHynXuoRbg7YAcBlp5pZPk+SLDvJUFr5fPgQVwAqjT0N8DYpTSzMYGJhaydTuJCoe6VJtn8IesoimnEMH3db20YquhOmOUQ9K2K0dk2oCtnjgAlVOsZMmQzgR5wf9QGLYJqBOoXXjUVYhqLDiltFYdQu8u+ZcZw=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20240611131650.NYFI1396.sa-prd-fep-043.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Tue, 11 Jun 2024 14:16:50 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 65A567CD107A74DD
X-Originating-IP: [86.139.167.83]
X-OWM-Source-IP: 86.139.167.83
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeliedtfedttdeijeegteevfeetvdefkedthefgteeuhfffveeiveehleevffffnecuffhomhgrihhnpegtrhhouhgthhhinhhgthhighgvrhhhihguuggvnhhfrhhuihhtsggrthdrohhrghenucfkphepkeeirddufeelrdduieejrdekfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddufeelrdduieejrdekfedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehmrghrkhesmhgrgihrnhgurdgtohhmpdhrvghvkffrpehhohhsthekiedqudefledqudeijedqkeefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhl
	uhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddtvd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.139.167.83) by sa-prd-rgout-002.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 65A567CD107A74DD; Tue, 11 Jun 2024 14:16:50 +0100
Message-ID: <56fe85a3-d7b2-4c35-a057-ddb2f018a6ef@dronecode.org.uk>
Date: Tue, 11 Jun 2024 14:16:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cygwin-htdocs: Upgrade 32-bit note to Q and A
To: Mark Geisert <mark@maxrnd.com>
References: <20240610044718.8237-1-mark@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20240610044718.8237-1-mark@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 10/06/2024 05:47, Mark Geisert wrote:
> Upgrade the note about 32-bit Cygwin to a full question and answer(s).
> Also close a couple of HTML tags that need it.

Thanks for this.

I'm minded to apply something like this, but you might care to revise it 
in light of my comments below.

> 
> ---
>   install.html | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/install.html b/install.html
> index cdb9948b..c948e647 100755
> --- a/install.html
> +++ b/install.html
> @@ -201,7 +201,7 @@ version for an old, unsupported Windows?</h2>
>         </p>
>         <p>
>           Also use <code>--no-verify</code> with this URL.
> -      </p
> +      </p>
>       </td>
>     </tr>
>     <tr>
> @@ -242,7 +242,7 @@ version for an old, unsupported Windows?</h2>
>         64-bit: http://ctm.crouchingtigerhiddenfruitbat.org/pub/cygwin/circa/64bit/2016/08/30/104235
>         <p>
>           Also use <code>--no-verify</code> with these URLs.
> -      </p
> +      </p>
>       </td>
>     </tr>
>     <tr>
> @@ -273,15 +273,23 @@ version for an old, unsupported Windows?</h2>
>     Time Machine</a> for providing this archive.
>   </p>
>   
> -  <h4>A note about 32-bit Cygwin</h4>
> +<h2 class="cartouche" id="unsup32bit">Q: Can I still run unsupported 32-bit Cygwin?</h2>
> +
> +  <p>
> +    A1: You can, but why would you?  32-bit Cygwin was frozen at version

Answering a question with a question seems like bad style.

There are (what seems like to the asker) legitimate reasons for using 
32-bit Cygwin.

I'm not sure if we want to discuss them here, or just say "We don't 
advise it, but if you really think you have to..."

> +    3.3.6, around August 2022.  There have been and there will be no bug
> +    fixes or security updates, and no new functionality added.  No longer
> +    supported on the mailing lists; it has joined the choir invisible.
> +  </p>

Haha! I know it's dull, but in the interests of clarity, I don't think 
this is appropriate here. :)

