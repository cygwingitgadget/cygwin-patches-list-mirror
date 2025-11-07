Return-Path: <SRS0=ruzz=5P=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.180])
	by sourceware.org (Postfix) with ESMTP id DDBFB3858D21
	for <cygwin-patches@cygwin.com>; Fri,  7 Nov 2025 20:23:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DDBFB3858D21
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DDBFB3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.180
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1762546998; cv=none;
	b=N6/jvIpPcSc9QmQSiHpqnGMxXL5uOT3GHfUxKBaLvxmPw8k5VC0b3j4nuUNZY0e/rYiHS5y9hTsvganKDhPdQNOX1jrFInU460YJe0NYNLBcxMsoRwQqh930KzG8SGLtuS+mKgrt0OZ31AaaJELJsXy5ocoOhKuuyjEoqofLeeE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1762546998; c=relaxed/simple;
	bh=IwLBSKd8iO+AbIu61DKmnbcPIqEzkL2SrnvrOWf1NPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=cYiEQLb8Uo5v5MNnq3W4/3YVQLz2g/+9v7oFVQWzOxSsnfdTMiihwoKfU2pZYg/o72hRuKvdoxJ5Jr2to7W+5oulDlqRpf4Xry3cehGI5W1zZSMMYtcdCRYqxD2oL/hcm3Si/R5qyd5900Sv8XcDXhU8UeKtEtezTj3iIfrBB3g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DDBFB3858D21
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1BDC0517FC72
X-Originating-IP: [81.158.20.254]
X-OWM-Source-IP: 81.158.20.254
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekuddrudehkedrvddtrddvheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekuddrudehkedrvddtrddvheegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduheekqddvtddqvdehgedrrhgrnhhgvgekuddqudehkedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtgedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgih
	ghifihhnrdgtohhmpdhrtghpthhtohepthhhihhruhhmrghlrghirdhnrghgrghlihhnghgrmhesmhhulhhtihgtohhrvgifrghrvghinhgtrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (81.158.20.254) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1BDC0517FC72; Fri, 7 Nov 2025 20:23:11 +0000
Message-ID: <b559bcfe-7067-409c-aac9-2334a5979807@dronecode.org.uk>
Date: Fri, 7 Nov 2025 20:23:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] Cygwin: Testsuite: fixes for compatibility with GCC 15
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
References: <MA0P287MB3082B86D9A27A995509C8EAC9FFCA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <PN3P287MB307716E6892DFD994EE173249FF8A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <PN3P287MB307716E6892DFD994EE173249FF8A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 31/10/2025 07:59, Thirumalai Nagalingam wrote:
> Hi,
> 
> Thanks for the suggestion, Mark (mark@maxrnd.com<mailto:mark@maxrnd.com>).
> Thank you for your feedback on the coding conventions. I have incorporated your comments and prepared the V2 patch accordingly. Kindly disregard the earlier patch submission.
> 
> For ease of review, I have included the patch inline below. Additionally, the patch file generated using git format-patch -1 is attached as file.
> Due to internal constraints, we are not currently using git send-email. However, this submission method has worked successfully for previous patches sent to the mailing list.

Thanks! Applied.

(A suggestion I hope you might consider for the future: it's perhaps 
sometimes useful to include the text of the warning which a patch fixes 
in the commentary for that patch )

