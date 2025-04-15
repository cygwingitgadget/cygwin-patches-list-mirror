Return-Path: <SRS0=e/p2=XB=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
	by sourceware.org (Postfix) with ESMTPS id A1C863857B90
	for <cygwin-patches@cygwin.com>; Tue, 15 Apr 2025 09:02:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A1C863857B90
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A1C863857B90
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.83
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744707761; cv=none;
	b=mio5wt/4amxZ1mEtE7b9jqtGi2RCIMe8bOQVdQzpizV9MbWrN6DYtBYKj3B1/dnVZwecNk6G2zYDjHeNgXtHVSIngJJhEsssdwl2rJpyBb1ERPxF/VDhtmsA3qJQCFoNSTAqj4RtZkzxoIcJUAWB22FujfA0mD7mh/3Qp3LwQsY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744707761; c=relaxed/simple;
	bh=pr3sTugP3P8dN2OyJ5iMpvXdb0z1LPvxEbwWpW92hZY=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=MzY3RBNB86gnt0OxuptL1VSvuK912J6qKC91za2L3Oz0FJkLqsm0QwExSqv1Xve26OgucagYSuDYkBzTiZGhZouDIKuRNXmrr49Hqqicyb3C7HCg/fAPJflGfSxeqgTVNDP7fywgL3eYIJeGHsi4/XfAWLLTPRXTxkU9e4YJeAE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A1C863857B90
Received: from fwd73.aul.t-online.de (fwd73.aul.t-online.de [10.223.144.99])
	by mailout07.t-online.de (Postfix) with SMTP id AEECD1E06
	for <cygwin-patches@cygwin.com>; Tue, 15 Apr 2025 11:02:36 +0200 (CEST)
Received: from [192.168.2.101] ([91.57.247.175]) by fwd73.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1u4cBf-3KD1to0; Tue, 15 Apr 2025 11:02:35 +0200
Subject: Re: [PATCH] Cygwin: kill(1): skip kill(2) call if '-f -s -' is used
To: cygwin-patches@cygwin.com, cygwin-patches@cygwin.com
References: <16c95bad-2310-e66c-d538-403321033d2c@t-online.de>
 <20250415164029.c118309bc33c25f4b404b48d@nifty.ne.jp>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <4356587f-51ed-302d-03f1-7415590813f6@t-online.de>
Date: Tue, 15 Apr 2025 11:02:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <20250415164029.c118309bc33c25f4b404b48d@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1744707755-3CFF6936-8F9EEBD2/0/0 CLEAN NORMAL
X-TOI-MSGID: 6faec8af-0fdb-4e4d-874a-a57688ad8011
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

Takashi Yano wrote:
> Hi Christian,
>
> On Fri, 11 Apr 2025 16:46:07 +0200
> Christian Franke wrote:
>> In rare cases, '/bin/kill -f PID' hangs because kill(2) is always tried
>> first. With this patch, this could be prevented with '/bin/kill -f -s -
>> PID'.
> I wonder why kill(2) hangs. Do you have any idea?

Sorry no. I observed this in early (Cygwin 3.5.4) testing of stress-ng 
for ITP, but could no longer reproduce it.

Here are tests which currently (3.7.0-0.51.gd35cc82b5ec1) ignore but not 
hang kill(pid, SIGKILL):

stress-ng --mprotect 1 -t 5 -v
stress-ng --priv-instr 1 -t 5 -v
stress-ng --sigchld 1 -t 5 -v
stress-ng --sigsegv 1 -t 5 -v

Run this in another window to see that child processes are left behind:

killall -v -9 stress-ng; sleep 4; taskkill /F /T /IM stress-ng.exe

For a minimal testcase regarding --priv-instr, see:
https://sourceware.org/pipermail/cygwin/2025-March/257726.html


> If kill(2) hangs in some cases, shouldn't we fix that
> rather than patching to kill(1)?

Of course. This feature was intended as a first step for an 'onboard' 
tool for the CI tests suggested by Jon Turney. A second step could be an 
--all option to replace 'taskill' or 'pskill'.

-- 
Regards,
Christian

