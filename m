Return-Path: <SRS0=1s5g=4A=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.146])
	by sourceware.org (Postfix) with ESMTP id E75763858D38
	for <cygwin-patches@cygwin.com>; Sun, 21 Sep 2025 18:44:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E75763858D38
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E75763858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.146
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1758480275; cv=none;
	b=KsRpm8wlj6mjSNm70fPv3kCEp6Gi42tyOFJ40xAlwj+r8WL2CsB4RyGdagl5RQUTEie9GyixgZ3HRZjFcbXqzRFrrI7AH6inZkHCoxLeuuJTrYAg38c8IvxxszxNEkQI+plncFRT7USxnLb7hHnBgvVpEU+skJsNOQqKpkTZpKk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1758480275; c=relaxed/simple;
	bh=CkuTxfB6+cDBkEWSZCFXqvGvz1Xkm9YIUljy9RK/Asw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=LsOyXRw6fvkomHlPJKxKtvWnhljkLbk9J81Z+rbW9sjAnetfkXp/UrH6rfcMAOnCD/Cdg/p6fHaruSZZ6imMecB9FKtZYJTIPkp5izn0ynFNd9ydJCFFolavERtxJcQpvPYJdoKIpFNFTAgJhnJeMZPShT2IuJrGwaKYaHU6J98=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E75763858D38
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1AB80076BF07
X-Originating-IP: [86.144.41.51]
X-OWM-Source-IP: 86.144.41.51
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehheejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeghfdvvdeijeettdfgleetffetfedtuefgfeevhedthefgffelfeethfdvleffnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkeeirddugeegrdeguddrhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudeggedrgedurdehuddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudeggedqgeduqdehuddrrhgrnhhgvgekiedqudeggedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtvddpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhn
	rdgtohhmpdhrtghpthhtoheptgihghifihhnsehjughrrghkvgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.144.41.51) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1AB80076BF07; Sun, 21 Sep 2025 19:44:32 +0100
Message-ID: <38ff84d9-6924-4a7d-bdee-0266810a7d5d@dronecode.org.uk>
Date: Sun, 21 Sep 2025 19:44:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: lock cygheap during fork
To: Jeremy Drake <cygwin@jdrake.com>
References: <e3dfa011-3ddd-6f69-439e-87746ae3a2b2@jdrake.com>
 <d4551d29-1128-4ff1-b8e8-8238f192de3f@dronecode.org.uk>
 <397323a1-e83c-ef1f-3dd3-a019adf2ab69@jdrake.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <397323a1-e83c-ef1f-3dd3-a019adf2ab69@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 20/09/2025 20:52, Jeremy Drake via Cygwin-patches wrote:
> On Sat, 20 Sep 2025, Jon Turney wrote:
> 
>> On 19/09/2025 22:43, Jeremy Drake via Cygwin-patches wrote:
>>> another thread may simultaneously be doing a cmalloc/cfree while the
>>> cygheap is being copied to the child.
>>
>> Makes sense. Please apply.
> 
> Done (and cygwin-3_6-branch)
> 
>>
>>> Addresses: https://cygwin.com/pipermail/cygwin/2025-September/258801.html
>>> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
>>> ---
>>> I'm seeing a timeout failure of pthread/cancel2.exe test in GitHub CI.
>>> This seems to be happening even without this change, so perhaps it is more
>>> to do with the update to windows-2025 runners?  In any event, this
>>> prevents the 'stress' jobs from running against this change.
>>
>> Thank you *so much* for keeping an eye on that!
> 
> I did a test run downgrading the windows-build job to windows-2022, and
> all the tests succeed there.  I still have no idea why the pthread/cancel2
> test times out on windows-2025 though.

Hmm... odd.

Please feel free to push that change to the yml, if you think that's 
appropriate.

I did have some struggles with the cancel tests when I was getting the 
testsuite working again, because there's a bit of funkiness in cygwin 
where async cancellation sometimes silently turns into a deferred 
cancellation because we can't stop a thread while it's inside the NT 
kernel... but I can't see how that could cause a test like this to 
timeout rather than simply fail?

