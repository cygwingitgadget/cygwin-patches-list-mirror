Return-Path: <SRS0=O8Rr=KD=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
	by sourceware.org (Postfix) with ESMTPS id 0798F3858CDB
	for <cygwin-patches@cygwin.com>; Mon, 26 Feb 2024 11:14:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0798F3858CDB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0798F3858CDB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1708946061; cv=none;
	b=LOtI2eNRF+H23rtCIBrSyfwBFhBdGMxhB+qeNjhPnrkKP87BIgAEja/XXbiRKMNzjPmWj+dRZ196/u+IqWsxJj3MrzLYU8+9LRG20m6l4H+ixHvvX9l7O2Tq/cV6MmKlTVxRNfHvMo0dvKbSD4i7SYHKtq0zKCOH9TNFDH0l3D0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1708946061; c=relaxed/simple;
	bh=greUhG3AEuLVixFP1d1icb9QN/nMbHtahKm1oo5Ul44=;
	h=From:Subject:To:Message-ID:Date:MIME-Version; b=psWpHK1iejjUoJ1arWMGgHf/gstzHUta5KSnSq7O1EKFeExXtxHQM0U3C0E0pL9+9gzHIaEk1D6pR1gAZBL51paGVVRCS9sE6xlumZ17Q77+VsW1yo3bCi0hylIqj8FmGwfPfpNy2+qhPMpVJN/G1V2WBvTB220VAVrHQY8rNNM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd84.aul.t-online.de (fwd84.aul.t-online.de [10.223.144.110])
	by mailout08.t-online.de (Postfix) with SMTP id 4685829609
	for <cygwin-patches@cygwin.com>; Mon, 26 Feb 2024 12:14:17 +0100 (CET)
Received: from [192.168.2.102] ([87.187.47.57]) by fwd84.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1reYw3-2CmBFo0; Mon, 26 Feb 2024 12:14:15 +0100
From: Christian Franke <Christian.Franke@t-online.de>
Subject: Re: [PATCH] Cygwin: Map ERROR_NO_SUCH_DEVICE and ERROR_MEDIA_CHANGED
 to ENODEV
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <04f337bf-7197-b4af-3519-832ad2be5b14@t-online.de>
 <ZdnfSDqfh1ZCynjH@calimero.vinschen.de>
 <0894e3b9-1adf-f73f-9f66-160a15f5f137@t-online.de>
 <ZdxnmgMzIEdnr9GP@calimero.vinschen.de>
Message-ID: <d22da40f-ea54-096a-75ea-28a236125cf4@t-online.de>
Date: Mon, 26 Feb 2024 12:14:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZdxnmgMzIEdnr9GP@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1708946055-2EFFA9FB-1E413C6B/0/0 CLEAN NORMAL
X-TOI-MSGID: ac072851-1c0e-4669-8957-1b5dec2f897c
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Feb 25 10:12, Christian Franke wrote:
>> Corinna Vinschen wrote:
>>> So the default was EPERM at first and has been changed to EACCES
>>> because it "is better for the unknown error case".
>>>
>>> I'm open to ideas for an improved error mapping.
>> I have no better suggestion for a default errno. Adding a cygwin specific
>> one (like ENMFILE, ENOSHARE and ECASECLASH added 2000-2001) is possibly not
>> desired.
> ENOSHARE and ECASECLASH are not used anymore, fortunately, and ENMFILE
> is hopefully never returned to userspace.  It might be a good idea to
> remove it from Cygwin's code as well.
>
>> Some thoughts about minor improvements of the errmap.h file:
>> - Add error number to each /* ERROR_... */ comment, e.g. /* 2:
>> ERROR_FILE_NOT_FOUND */.
> Ok.
>
>> - Update /* NUMBER */ comments using current MinGW-w64's winerror.h (~850
>> changes).
> Why so many?  I used winerror.h to populate the list not too long ago,
> so I wonder why it suddenly has so many more error codes?

"Required for mozilla-central." - 850 insertions:
https://sourceforge.net/p/mingw-w64/mingw-w64/ci/ddeb05a

Most or all would possible never occur with the NTDLL/Win32 API subset 
used by Cygwin.

Includes interesting codes like "ERROR_NO_WORK_DONE" :-)


>> - Max errno is 143, so data type size could be reduced from int to uint8_t
>> aka unsigned char. Could even add a compile time check by using C++11's
>> braced initializers which do not allow narrowing conversions.
> Yeah, we could do that.
>
>> - Remove trailing entries which only map to 0.
>> - Append a static_assert which checks whether array size matches the last
>> mapped error number.
> Yeah, not so sure about that.  I'm aware that we only map errors
> below 3000 somewhere, but it's no safe bet that it stays that way.
>
> For instance, we handle NT status codes STATUS_TRANSACTIONAL_CONFLICT
> and STATUS_TRANSACTION_NOT_ENLISTED and those translate into the TxF
> error range between 6800 and 6899.  We don't convert those to userspace
> errno yet, but consider having to add them at one point and thus having
> to add the 3000 entries from the last used one up the newly used one.
>
> The reason to keep them is to allow us to be lazy about it.  The list
> also just takes ~36K, and with the change to uint8_t it only takes
> 9K, so what?

Ok.

>> I could provide separate patches if desired.
> Always welcome!

Ok.

Thanks,
Christian

