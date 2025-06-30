Return-Path: <SRS0=g/f5=ZN=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
	by sourceware.org (Postfix) with ESMTPS id 7132538505DB
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 14:46:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7132538505DB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7132538505DB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.83
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751294786; cv=none;
	b=w3NGbXeboP3eOCRUqE8+LYaqbzmCuVn3ZyX0q4fiWdKuYycE0GWWgoHizQkpj2GMoXfGM/AsBBga900lqcHeaoWW7R91exkHlNXKOc+CVvDgz/zmXFkj56I01sCaEYeCvL8+u1nHN6TRE8ED/PR89HwCYX2y4ddkzgkESnwLRtM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751294786; c=relaxed/simple;
	bh=jKsjvZBRwqsXvk8T/To7GRYgPwThki7y+IFlXFFfYD4=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=M9Qif/X+Bw6qwoqXhPG4SlQGgWKIepUvLJYHt8Ewb1AOWwNPQoSS3sVDO8MliWOqZwcfzY24pgNoDH7y6LWGX7yHXZ7PQcl2pdEnwC6FdMlgbsIfnqdiUzFNQk/GuUGoovcITsfOzGKMagGxbLJw5QKnKq2S8bvdeIp7Czt4ufQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7132538505DB
Received: from fwd88.aul.t-online.de (fwd88.aul.t-online.de [10.223.144.114])
	by mailout07.t-online.de (Postfix) with SMTP id F2458E05F
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 16:46:24 +0200 (CEST)
Received: from [192.168.2.101] ([79.230.172.57]) by fwd88.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1uWFm4-0HPa0e0; Mon, 30 Jun 2025 16:46:24 +0200
Subject: Re: [PATCH] wcrtomb: fix CESU-8 value of leftover lone high surrogate
To: cygwin-patches@cygwin.com
References: <6bdab1bf-192e-d1b0-22dc-c678e94e35d9@t-online.de>
 <aGJmkh_2yM4Y416a@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <3ab5bc76-a73e-9279-3230-9be1b678efea@t-online.de>
Date: Mon, 30 Jun 2025 16:46:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <aGJmkh_2yM4Y416a@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1751294784-2CFF75CB-2A10206D/0/0 CLEAN NORMAL
X-TOI-MSGID: 0fa87e62-7fed-4d41-b20e-f0e4e2c3b6be
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,BODY_8BITS,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Jun 29 19:13, Christian Franke wrote:
>> Fixes the CESU-8 value, but not the missing encoding if the high surrogate
>> is at the very end of the string.
> Are you going to provide a patch for that issue?

Not very soon as this possibly requires non-trivial rework including 
comprehensive testing.

The function behind __WCTOMB() must also be called with the final L'\0' 
as input. This is not the case. For example in _wcstombs_r() only the 
second __WCTOMB() is called with L'\0'. The (s == NULL) part implicitly 
assumes that it would only append '\0' and return 1.

newlib/libc/stdlib/wctomb_r.c:

size_t
_wcstombs_r (...)
{
   ...
   if (s == NULL)
     {
       ...
       while (*pwcs != 0)
         {
           bytes = __WCTOMB (r, buff, *pwcs++, state);
           ...
           num_bytes += bytes;
         }
         return num_bytes;
     }
   else
     {
       while (n > 0)
         {
           bytes = __WCTOMB (r, buff, *pwcs, state);
           ...
           if (*pwcs == 0x00)
             return ptr - s - (n >= bytes);
           ...
         }
         ...
     }
}


> ...
>> +      tmp = (((state->__value.__wchb[0] << 16 | state->__value.__wchb[1] << 8)
>> +	    - 0x10000) >> 10) | 0xd800;
>>         *s++ = 0xe0 | ((tmp & 0xf000) >> 12);
>>         *s++ = 0x80 | ((tmp &  0xfc0) >> 6);
>>         *s++ = 0x80 |  (tmp &   0x3f);
>> -- 
>> 2.45.1
>>
> LGTM, please push.

Done.

-- 
Thanks,
Christian

