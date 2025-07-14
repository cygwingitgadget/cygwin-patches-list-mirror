Return-Path: <SRS0=tYd+=Z3=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
	by sourceware.org (Postfix) with ESMTPS id EBDF23858D37
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 15:14:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EBDF23858D37
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EBDF23858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.83
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752506074; cv=none;
	b=fJhNX9FjS7kVZ+Y69s58kVOOowiZcRW4Gu4tFXo5a1G+4idgBI8E3/GQ8/a2g+Ih6iPUXC1uWfkTxkvBAbS4qPZzw31vXc+MhEUJPSXHjNSQ8FU/Sn9ftOAPKG0sOXGT2pHWA7WnUjohUTW+UnV/IuUyncQjSimmFZYk8YlzGjk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752506074; c=relaxed/simple;
	bh=VEMIDIL75iMAx71P/HfKrofZ6giNl5OE3UWMnKmd2uE=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=odz8YjYvKvQjnlgBdpZRLkJ5mHS0ppi/ny0IqY6Njp3pku1/hb5mgi2SDtgcmtr2XmlJGgXidYJu8rak77wP6A3NeewAiz//BQaUE5jFXI+e+Njv1zGCX9xUSHjqO99IThUZXgi5/fGqReySS4Nhvy4cP2P8HXdtBULvo8SH7/Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EBDF23858D37
Received: from fwd86.aul.t-online.de (fwd86.aul.t-online.de [10.223.144.112])
	by mailout07.t-online.de (Postfix) with SMTP id 96669E833
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 17:14:32 +0200 (CEST)
Received: from [192.168.2.101] ([79.230.172.57]) by fwd86.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1ubKsx-1Dk9Eu0; Mon, 14 Jul 2025 17:14:31 +0200
Subject: Re: [PATCH] Cygwin: doc: warn about unprivileged access to raw
 devices
To: cygwin-patches@cygwin.com
References: <7d18c6c8-3d74-0f97-cf45-05a7a263c386@t-online.de>
 <aHUIJb8zEUePlkut@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <ebbd9820-e2dd-cce5-a8af-1e70c87fb2f2@t-online.de>
Date: Mon, 14 Jul 2025 17:14:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <aHUIJb8zEUePlkut@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1752506071-9B7EFF9F-7F75A297/0/0 CLEAN NORMAL
X-TOI-MSGID: dbe16a60-dca9-47f5-8d1c-6eedeaf8a71d
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Jul 14 14:58, Christian Franke wrote:
>>  From 344a329a5706de125b3ef11dc7324101b08b3c67 Mon Sep 17 00:00:00 2001
>> From: Christian Franke <christian.franke@t-online.de>
>> Date: Mon, 14 Jul 2025 14:44:01 +0200
>> Subject: [PATCH] Cygwin: doc: warn about unprivileged access to raw devices
>>
>> Raw devices of partitions may be accessible from unprivileged
>> processes, for example if connected via USB.
>>
>> Signed-off-by: Christian Franke <christian.franke@t-online.de>
>> ...
>>
> Pushed.... oh, right, you have push perms, sigh :}

no problem :)

