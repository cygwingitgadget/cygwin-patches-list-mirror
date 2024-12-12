Return-Path: <SRS0=5kDa=TF=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.48])
	by sourceware.org (Postfix) with ESMTP id 4A80A3858D29
	for <cygwin-patches@cygwin.com>; Thu, 12 Dec 2024 14:14:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4A80A3858D29
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4A80A3858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.48
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1734012862; cv=none;
	b=QnQQYsMDtrrdoVDDwLbGCey37/2k/zOWJht/dsXsWVByHar03kWZ+6BFjtbakknwGjRq4ozaXGrRJiS0jMHJ09VyhrqZOg/3WbxIaBA2M3BaeacyISCu9Nq9tJZhnVbm3jNqGKpRvoNNu5PYIjz9knzhTJMCtieaYLn1/f5v0Hg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1734012862; c=relaxed/simple;
	bh=4YEsxPPPbpGCbHx+teHB4QvcduGGPEV2cBBvoJ8qZQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=tpwf1fMJJiLcEXPlT+dvCnxJrP/QjJoNcfd5V6+N+0ahQsOcTskgwrNLOefD0C9XNCHUVI1SEL69VNY0AntO5pRnxh/3mzJNvymcr8jSt0Ulro/3cg15R7yfbLnIK6fVzp3BWrXmV9pIPmjsS8ZCCMf3rboe480AaLi1L8mRU4w=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4A80A3858D29
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 674901E8017017F5
X-Originating-IP: [86.143.185.89]
X-OWM-Source-IP: 86.143.185.89
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtkeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeffheeljeevgeeigeelgeettdehffekueethffghfevledvheejudevfeffvefgieenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekiedrudegfedrudekhedrkeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegfedrudekhedrkeelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugeefqddukeehqdekledrrhgrnhhgvgekiedqudegfedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtfedpnhgspghrtghpthhtohepvddprhgtphhtthhopegt
	hihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepthgrkhgrshhhihdrhigrnhhosehnihhfthihrdhnvgdrjhhp
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.143.185.89) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 674901E8017017F5; Thu, 12 Dec 2024 14:14:07 +0000
Message-ID: <35f88d3c-f8b7-4ab2-9549-fddd5f3dd068@dronecode.org.uk>
Date: Thu, 12 Dec 2024 14:14:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: signal: Fix high load when retrying to process
 pending signal
To: Takashi Yano <takashi.yano@nifty.ne.jp>
References: <20241212083223.1891-1-takashi.yano@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20241212083223.1891-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 12/12/2024 08:32, Takashi Yano wrote:
> The commit e10f822a2b39 has a problem that CPU load gets high if
> pending signal is not processed successfully for a long time.
> With this patch, wait_sig() calls Sleep(1), rather than yield(),
> if the pending signal has not been processed successfully for a
> predetermined time to prevent CPU from high load.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256884.html
> Fixes: e10f822a2b39 ("Cygwin: signal: Handle queued signal without explicit __SIGFLUSH")
> Reported-by: 凯夏 <walkerxk@gmail.com>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>   winsup/cygwin/sigproc.cc | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 59b4208a6..e01a67ebe 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -1345,6 +1345,12 @@ wait_sig (VOID *)
>   
>     hntdll = GetModuleHandle ("ntdll.dll");
>   
> +  /* GetTickCount() here is enough because GetTickCount() - t0 does
> +     not overflow until 49 days psss. Even if GetTickCount() overflows,
> +     GetTickCount() - t0 returns correct value, since underflow in
> +     unsigned wraps correctly. Pending a signal for more thtn 49

"than"

> +     days would be noncense. */

"nonsense"

(makes no sense)

