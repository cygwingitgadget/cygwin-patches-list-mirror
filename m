Return-Path: <SRS0=46A2=IY=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
	by sourceware.org (Postfix) with ESMTPS id 9008D3858D20
	for <cygwin-patches@cygwin.com>; Sun, 14 Jan 2024 18:53:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9008D3858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9008D3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1705258415; cv=none;
	b=RZGbXSorXaDIoZN5EKQc9juFZ3cwD7Hi1WiWVbA4DwXQJlClE5+dMR7lO/UK1Tylw5lW4yIOsBsD2P3+Bi/y7JiDFTWQKHND1X/0mhD2aAyCqH29bmffLM+h2tfHP6G0ED2MHWVjyL4aFn7DG9jvqxNG1jdUrnoyk816DjPWDV4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1705258415; c=relaxed/simple;
	bh=Ae19OITIxwgAEFplh6Joc59dJczdqRMaijwfkDz63uI=;
	h=Subject:From:To:Message-ID:Date:MIME-Version; b=DMxn4sUmWkMKWaB4Na4+BC9RUXqfGNcB13ErL/IY9GRqihxqdvaQwqDEocvggfUQLsAsPByQzvPquX9Z+onU/tAykhSdVGFHg9jxhoL16Vzm84NvOqxEJpb+IKkxvuYnkfKcAuJBLrVHD1rLNvsWATm9sGK7tTfzzXUI4U3x1Kk=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd70.aul.t-online.de (fwd70.aul.t-online.de [10.223.144.96])
	by mailout10.t-online.de (Postfix) with SMTP id 91CBB183C1
	for <cygwin-patches@cygwin.com>; Sun, 14 Jan 2024 19:53:30 +0100 (CET)
Received: from [192.168.2.104] ([79.230.174.55]) by fwd70.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1rP5bs-4Wj0am0; Sun, 14 Jan 2024 19:53:28 +0100
Subject: Re: [PATCH] Cygwin: introduce close_range
References: <83cfd6b3-6824-fd9f-794b-7fc428f8c80d@t-online.de>
 <3ab13e94-fd3a-41c8-8392-fcd72042d0e9@dronecode.org.uk>
From: Christian Franke <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
Message-ID: <6b1723b1-12b1-a240-ff22-1f0f5ba73214@t-online.de>
Date: Sun, 14 Jan 2024 19:53:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <3ab13e94-fd3a-41c8-8392-fcd72042d0e9@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1705258408-33FFC937-423ABA2A/0/0 CLEAN NORMAL
X-TOI-MSGID: e382bff2-eecb-4a49-acd3-efd8f2029747
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,KAM_SHORT,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon Turney wrote:
> On 14/01/2024 16:07, Christian Franke wrote:
>> Recently I learned about the existence and usefulness of close_range():
>> https://github.com/smartmontools/smartmontools/issues/235
>>
>> https://man.freebsd.org/cgi/man.cgi?query=close_range&sektion=2
>> https://man7.org/linux/man-pages/man2/close_range.2.html
>>
>> Note that the above Linux man page is not fully correct. The include 
>> file "linux/close_range.h" exists, but provides only the defines. It 
>> is sufficient to include "unistd.h" as on FreeBSD.
>>
>> The attached patch adds this to Cygwin. It does not implement the 
>> Linux-specific CLOSE_RANGE_UNSHARE as I have no idea how to do this :-)
>
> This API should also be mentioned in the
> "System interfaces compatible with GNU or Linux extensions" section of 
> doc/posix.xml
>
>

Thanks for the info. I used the recent "Cygwin: introduce fallocate(2)" 
patch as a blueprint for which other files should be changed (fallocate 
is also missing in the posix.xml file).

I will provide a new patch soon which also fixes an unlikely but 
possible corner case: Pass a value larger than MAX_INT as lower limit.

