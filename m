Return-Path: <SRS0=zU+l=ZO=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout12.t-online.de (mailout12.t-online.de [194.25.134.22])
	by sourceware.org (Postfix) with ESMTPS id 71AC038560AB
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 09:25:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 71AC038560AB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 71AC038560AB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751361911; cv=none;
	b=UjmeOFgV3rgnaX1T3/LxKnsOmLKtO6xXdfZoITcRWgvhs7KztUPrhWRz8kn7sEYrQflvJhsfA+1sD8gQpEBAITKAsYOZ9q8is/KTSjGK2+qYeI/cX6KgBzzH5ym93/mUv+6jtEHK2SuVbybik4QDeW8oP9+ZOAfPFXwr1SFcVWk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751361911; c=relaxed/simple;
	bh=UX0ypRV782QryBPlUPYnx3DlkXZvHsVsnv/TKYcxPhw=;
	h=Subject:From:To:Message-ID:Date:MIME-Version; b=skXkH8MNoV4bS25fMVq9/IK7/XwX/RwbgEoYcjw8Hp9ySlCppMQqpnfH1/stTqXi6d8noOQgfOVgBc5WwEi4QY8pSAege6XtqkJ/pJHsy1QnqM/Z0ir6pxevcSLlbwGiGNvX5bwoSp4cyKpnTpP53JzvUZ36LMoLKBwu+tKwPDs=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd80.aul.t-online.de (fwd80.aul.t-online.de [10.223.144.106])
	by mailout12.t-online.de (Postfix) with SMTP id 2EE49ED53
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 11:24:39 +0200 (CEST)
Received: from [192.168.2.101] ([79.230.172.57]) by fwd80.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1uWXE8-2BT3pI0; Tue, 1 Jul 2025 11:24:32 +0200
Subject: Re: [PATCH] wcrtomb: fix CESU-8 value of leftover lone high surrogate
From: Christian Franke <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
References: <6bdab1bf-192e-d1b0-22dc-c678e94e35d9@t-online.de>
 <aGJmkh_2yM4Y416a@calimero.vinschen.de>
 <3ab5bc76-a73e-9279-3230-9be1b678efea@t-online.de>
Message-ID: <4d17850c-06d4-d1ed-796d-7a4544abc160@t-online.de>
Date: Tue, 1 Jul 2025 11:24:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <3ab5bc76-a73e-9279-3230-9be1b678efea@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1751361872-EB7FC505-670F86C1/0/0 CLEAN NORMAL
X-TOI-MSGID: 8017cb6a-a83d-4b85-a71e-7502cfffc037
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,BODY_8BITS,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Christian Franke wrote:
> Corinna Vinschen wrote:
>> On Jun 29 19:13, Christian Franke wrote:
>>> Fixes the CESU-8 value, but not the missing encoding if the high 
>>> surrogate
>>> is at the very end of the string.
>> Are you going to provide a patch for that issue?
>
> Not very soon as this possibly requires non-trivial rework including 
> comprehensive testing.
>
> The function behind __WCTOMB() must also be called with the final 
> L'\0' as input. This is not the case. For example in _wcstombs_r() 
> only the second __WCTOMB() is called with L'\0'. The (s == NULL) part 
> implicitly assumes that it would only append '\0' and return 1.
>
> newlib/libc/stdlib/wctomb_r.c:
>
> size_t
> _wcstombs_r (...)
> {
>   ...
>   if (s == NULL)
>     {
>       ...
>       while (*pwcs != 0)
>         {
>           bytes = __WCTOMB (r, buff, *pwcs++, state);
>           ...
>           num_bytes += bytes;
>         }
>         return num_bytes;
>     }
>   else
>     {
>       while (n > 0)
>         {
>           bytes = __WCTOMB (r, buff, *pwcs, state);
>           ...
>           if (*pwcs == 0x00)
>             return ptr - s - (n >= bytes);
>           ...
>         }
>         ...
>     }
> }
>

Proposed fix for the above function only: 
https://sourceware.org/pipermail/newlib/2025/021937.html

Unfortunately my first try to fix Cygwin's own sys_wcstombs() had not 
the desired effect:

--- b/winsup/cygwin/strfuncs.cc
+++ a/winsup/cygwin/strfuncs.cc
@@ -1012,9 +1012,14 @@ _sys_wcstombs (char *dst, size_t len, const 
wchar_t *src, size_t nwc,
               for (int i = 0; i < bytes; ++i)
                 *ptr++ = buf[i];
             }
-         if (*pwcs++ == 0x00)
-           break;
           n += bytes;
+         if (*pwcs++ == 0x00)
+           {
+             /* n is the size without trailing NUL. */
+             if (n > 0)
+               --n;
+             break;
+           }


-- 
Regards,
Christian

