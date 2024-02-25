Return-Path: <SRS0=dGUz=KC=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
	by sourceware.org (Postfix) with ESMTPS id 252AD3858291
	for <cygwin-patches@cygwin.com>; Sun, 25 Feb 2024 09:12:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 252AD3858291
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 252AD3858291
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1708852362; cv=none;
	b=GhMXtntl1zkM2wxDIQYH5lltG1SthJoECwYsSfBxE9/Z7ljGUxGeWOdFKdeU8G/T89djZEQfdMytf0Tmlr/LuQ2FhW+OAg3FfvmpQQZPBk38Z1IjQvmCGgjwYuKaCV9CC9pfJfi30lFcbB8Vg27UF5dkwH3qZN4a6DiQLTpw0pM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1708852362; c=relaxed/simple;
	bh=o0PVlY1TLUSI5PRCOTYJ5GucYyzR5kdwKU25scroHVw=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=A0wrutGnNbJfMS1NOmG3wLbPUtylxzfJ0mQ1KuVMiV1WuoSchBwPwTpNugjTKxYCD3nt2esu08/C6mXkNyT7xWz3Ce4wTVEnOKRupjXeEs5LNT2TPhe6Zs1WyuaARmxJELs1XQB4gg8Su6Qad6hHPZ4Vjr9TQUL06T98v50kqKo=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd76.aul.t-online.de (fwd76.aul.t-online.de [10.223.144.102])
	by mailout01.t-online.de (Postfix) with SMTP id D9F5B2888A
	for <cygwin-patches@cygwin.com>; Sun, 25 Feb 2024 10:12:38 +0100 (CET)
Received: from [192.168.2.102] ([87.187.47.57]) by fwd76.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1reAYo-4OlPns0; Sun, 25 Feb 2024 10:12:38 +0100
Subject: Re: [PATCH] Cygwin: Map ERROR_NO_SUCH_DEVICE and ERROR_MEDIA_CHANGED
 to ENODEV
To: cygwin-patches@cygwin.com
References: <04f337bf-7197-b4af-3519-832ad2be5b14@t-online.de>
 <ZdnfSDqfh1ZCynjH@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <0894e3b9-1adf-f73f-9f66-160a15f5f137@t-online.de>
Date: Sun, 25 Feb 2024 10:12:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZdnfSDqfh1ZCynjH@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1708852358-FB7FD94C-F344DD5C/0/0 CLEAN NORMAL
X-TOI-MSGID: 79671d6e-2054-46f0-99a3-6d131317e15d
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Feb 23 19:14, Christian Franke wrote:
>> Experiments with damaged USB flash drives and ddrescue revealed that the
>> current mapping of these Win32 errors to the fallback EACCES could be
>> improved.
>>
>> BTW: I wonder why EACCES was selected as the fallback. Source code control
>> forensics suggest that this was decided in the last millennium. A related
>> comment from CGF added August 2000 persists until today :-)
>> /* FIXME: what's so special about EACCESS? */
> This goes back until 1997 in pre-CVS times.  There's a ChangeLog entry
>
>    Wed Oct 29 22:43:57 1997  Geoffrey Noer  <noer@cygnus.com>
>
>          [...]
>          * syscalls.cc (seterrno): on failure, set EACCES instead of EPERM
>          which is better for the unknown error case
>
> So the default was EPERM at first and has been changed to EACCES
> because it "is better for the unknown error case".
>
> I'm open to ideas for an improved error mapping.

I have no better suggestion for a default errno. Adding a cygwin 
specific one (like ENMFILE, ENOSHARE and ECASECLASH added 2000-2001) is 
possibly not desired.

Some thoughts about minor improvements of the errmap.h file:
- Add error number to each /* ERROR_... */ comment, e.g. /* 2: 
ERROR_FILE_NOT_FOUND */.
- Update /* NUMBER */ comments using current MinGW-w64's winerror.h 
(~850 changes).
- Max errno is 143, so data type size could be reduced from int to 
uint8_t aka unsigned char. Could even add a compile time check by using 
C++11's braced initializers which do not allow narrowing conversions.
- Remove trailing entries which only map to 0.
- Append a static_assert which checks whether array size matches the 
last mapped error number.

I could provide separate patches if desired.

Thanks,
Christian

