Return-Path: <SRS0=tdPk=6Q=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 5916D4BA540C;
	Wed, 10 Dec 2025 19:34:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5916D4BA540C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5916D4BA540C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765395287; cv=none;
	b=LcESIRr2jdROBK09q7Jr8bnqsIkXMfZqnAOwEha0vFD4xNPbf8P8xEtyRVmC/DBRL5ywW8BrCB9nUn6pPhnPqUuNo2jIbTlNYMdUk1NDJChj4IeWWiLGeuoKpbrvWHl6JoygZZM2PzeJRfvk/n+2JqLmx37iRhigzJJXz5LXfBA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765395287; c=relaxed/simple;
	bh=+5ZXuvJ6IVVg+rpmWUtQTvoORBLTrCQWhW5XIki/uWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=EKC5bZDwRxjl9KpjoUvP3hGZZZGv5P8jJySluB8O2UOsxI8aNP3YDMmAgVZ0lRC1M9hzsseIhUKLyA9gAPboLGoDPmAqfnG0tx+2WFsj+DQ2oJPlX1k8GmBDWosCrZoCjcuIRWoTw/kkXcYI+vj34a7jklkGtoegnVY/zNBtGEc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5916D4BA540C
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1C95086EB6B4
X-Originating-IP: [81.158.20.216]
X-OWM-Source-IP: 81.158.20.216
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeghfdvvdeijeettdfgleetffetfedtuefgfeevhedthefgffelfeethfdvleffnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkedurdduheekrddvtddrvdduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkedurdduheekrddvtddrvdduiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddqudehkedqvddtqddvudeirdhrrghnghgvkeduqdduheekrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdehpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptghorhhinhhnrgdqtgihghifihhnsegthihg
	fihinhdrtghomhdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (81.158.20.216) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1C95086EB6B4; Wed, 10 Dec 2025 19:34:46 +0000
Message-ID: <67ef9614-59ec-49b9-ad75-6117e0e3b643@dronecode.org.uk>
Date: Wed, 10 Dec 2025 19:34:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Cygwin: newgrp(1): fix POSIX compatibility
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
References: <20251210173201.193740-1-corinna-cygwin@cygwin.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20251210173201.193740-1-corinna-cygwin@cygwin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 10/12/2025 17:31, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> As outlined in the thread starting at
> https://cygwin.com/pipermail/cygwin/2025-December/259055.html,
> newgrp(1) didn't allow numerical group IDs.  While this is in line with
> the shadow-utils version of newgrp(1), it's not what POSIX allows.
> Fix up the code and the documentation to be more in line with POSIX.
> 
> Corinna Vinschen (3):
>    Cygwin: newgrp(1): improve POSIX compatibility
>    Cygwin: doc: utils.xml: improve newgrp(1) documentation
>    Cygwin: add release note for newgrp(1) fixes
> 
>   winsup/cygwin/release/3.6.6 |  3 +++
>   winsup/doc/utils.xml        | 27 ++++++++++++++++-----------
>   winsup/utils/newgrp.c       | 30 ++++++++++++++++++++----------
>   3 files changed, 39 insertions(+), 21 deletions(-)

This is good. No notes :)

