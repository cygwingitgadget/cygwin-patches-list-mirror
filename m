Return-Path: <SRS0=tBSv=37=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.180])
	by sourceware.org (Postfix) with ESMTP id 730A43858C98
	for <cygwin-patches@cygwin.com>; Sat, 20 Sep 2025 16:19:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 730A43858C98
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 730A43858C98
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.180
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1758385188; cv=none;
	b=kz0EeW65D5kHm0b78bNgjsWrAkrbPzGkuJ6Oi7B1zbdZgRhpIdHhGLqtreR318fad5M482UhzN5/BeDNRqZvz+1omVl7hovJ7T+DfZ8OOn8ZqTNeIgv0UuHwg+oqgxh+wFdGQI5UGAh1Dvn/VG+Ms1Yrf3+8X3P6+OXB0N8EP4g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1758385188; c=relaxed/simple;
	bh=AyhvT7Tz5Zeb++FBv9oBx5KBQEV/YFhs+3c4eHrihug=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=l98XvJ94V9w8H0uQ3uXde5xC7I3fjqjRbMhCE6wTxJvgEATAn1R1OYl3hmNHk5xMVQcW7Urg9jGD2h/0/rsQIJMX+lUfyoduG55XMcN0eR1pzLTWoFvXx1MghrktQ8umbQDLSl9uxkJrExpLuPAylL3byXp1NS067vnvcudrtmo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 730A43858C98
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1BDC00601E39
X-Originating-IP: [86.144.41.51]
X-OWM-Source-IP: 86.144.41.51
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehvdehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeghfdvvdeijeettdfgleetffetfedtuefgfeevhedthefgffelfeethfdvleffnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkeeirddugeegrdeguddrhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudeggedrgedurdehuddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudeggedqgeduqdehuddrrhgrnhhgvgekiedqudeggedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtgedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhn
	rdgtohhmpdhrtghpthhtoheptgihghifihhnsehjughrrghkvgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.144.41.51) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1BDC00601E39; Sat, 20 Sep 2025 17:19:45 +0100
Message-ID: <d4551d29-1128-4ff1-b8e8-8238f192de3f@dronecode.org.uk>
Date: Sat, 20 Sep 2025 17:19:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: lock cygheap during fork
To: Jeremy Drake <cygwin@jdrake.com>
References: <e3dfa011-3ddd-6f69-439e-87746ae3a2b2@jdrake.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <e3dfa011-3ddd-6f69-439e-87746ae3a2b2@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 19/09/2025 22:43, Jeremy Drake via Cygwin-patches wrote:
> another thread may simultaneously be doing a cmalloc/cfree while the
> cygheap is being copied to the child.

Makes sense. Please apply.

> Addresses: https://cygwin.com/pipermail/cygwin/2025-September/258801.html
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
> I'm seeing a timeout failure of pthread/cancel2.exe test in GitHub CI.
> This seems to be happening even without this change, so perhaps it is more
> to do with the update to windows-2025 runners?  In any event, this
> prevents the 'stress' jobs from running against this change.

Thank you *so much* for keeping an eye on that!

