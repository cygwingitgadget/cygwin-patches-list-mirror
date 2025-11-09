Return-Path: <SRS0=n1w5=5R=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.70])
	by sourceware.org (Postfix) with ESMTP id A77233858D33
	for <cygwin-patches@cygwin.com>; Sun,  9 Nov 2025 20:49:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A77233858D33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A77233858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.70
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1762721392; cv=none;
	b=qq0KS8DZbkb/aQzhvUK/t4nZANlVpQs5xDe/QJfgCkQj4+Z+4z8zPs3552Kamrg2I/f3aztnL6oYk3ZeIJb1bbYxOFBlLZtT66TNCyIS1bdDf/3h7RO7BwNJSuzNWIkRxdsAl34rovvsvnCeEiuZkTN+Kez5te7hBgsggAQVwcE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1762721392; c=relaxed/simple;
	bh=tP9/1ZMO1nXH9axKy2I0HHNBdaq5J6LB26yWXN5EK68=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Lekh5N1loTQ+XmeHzic6Nua5lN+Xj4lsuGv+7wWOJdAM3xBlEQ4oWseiIDOZH9foYyK+U1Sc9kRhQp1wvpMFGe1bSYpHhviSGstDP12JwylwbaRab/tjK5BHGQ67tHVotD8G92dJrlYqyOKjOCJXJ8g0CcH/3GmE7yh02WMJe9k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A77233858D33
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1AB8054880B4
X-Originating-IP: [81.158.20.254]
X-OWM-Source-IP: 81.158.20.254
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeigedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekuddrudehkedrvddtrddvheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekuddrudehkedrvddtrddvheegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduheekqddvtddqvdehgedrrhgrnhhgvgekuddqudehkedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtvddpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgih
	ghifihhnrdgtohhmpdhrtghpthhtohepvghvghgvnhihsehkmhgrphhsrdgtoh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (81.158.20.254) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1AB8054880B4; Sun, 9 Nov 2025 20:49:50 +0000
Message-ID: <99796d78-ce2e-4692-9c3c-b2904a5ccc0d@dronecode.org.uk>
Date: Sun, 9 Nov 2025 20:49:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Generalize error handling in gentls_offsets
To: Evgeny Karpov <evgeny@kmaps.co>
References: <CABd5JDBzuSB2BN0qs4pkHCrCQw3cqLs_OOS7MkzdTBZqph1miQ@mail.gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <CABd5JDBzuSB2BN0qs4pkHCrCQw3cqLs_OOS7MkzdTBZqph1miQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 28/10/2025 13:17, Evgeny Karpov wrote:
> The patch introduces general error handling in gentls_offsets. Explicit
> validation for the presence of gawk is no longer required. gawk has been
> utilizing 'exit', which might lead to broken pipes in the current
> implementation. When 'exit' is triggered, gawk finishes the process,
> however the upstream command might still be active. This has been resolved
> by avoiding the use of 'exit' in gawk.

Hmmm... a little bit confused to what 'in the current implementation' is 
referring to here?

You previously wrote 'there is an issue with broken pipes on aarch64'

Is this a general consequence of turning on pipefail?

Or is there some aarch64-specific bug this is working around (in which 
case, I'm not sure this is suitable for applying, since... we'll need 
some reminder to fix it eventually :) )

> ---
>   winsup/cygwin/scripts/gentls_offsets | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/winsup/cygwin/scripts/gentls_offsets
> b/winsup/cygwin/scripts/gentls_offsets
> index bf84dd0cb..a364ea57a 100755
> --- a/winsup/cygwin/scripts/gentls_offsets
> +++ b/winsup/cygwin/scripts/gentls_offsets
> @@ -4,14 +4,9 @@ input_file=$1
>   output_file=$2
>   tmp_file=/tmp/${output_file}.$$
> 
> +set -eo pipefail # fail if any command or pipeline fails
>   trap "rm -f ${tmp_file}" 0 1 2 15
> 
> -# Check if gawk is available
> -if ! command -v gawk &> /dev/null; then
> -    echo "$0: gawk not found." >&2
> -    exit 1
> -fi
> -
>   # Preprocess cygtls.h and filter out only the member lines from
>   # class _cygtls to generate an input file for the cross compiler
>   # to generate the member offsets for tlsoffsets-$(target_cpu).h.
> @@ -29,14 +24,13 @@ gawk '
>     }
>     /^class _cygtls$/ {
>       # Ok, bump marker, next we are expecting a "public:" line
> -    marker=1;
> +    if (marker == 0) marker=1;
>     }
>     /^public:/ {
>       # We are only interested in the lines between the first (marker == 2)
>       # and the second (marker == 3) "public:" line in class _cygtls.  These
>       # are where the members are defined.
>       if (marker > 0) ++marker;
> -    if (marker > 2) exit;
>     }
>     {
>       if (marker == 2 && $1 != "public:") {
