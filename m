Return-Path: <SRS0=G2Zx=DT=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
	by sourceware.org (Postfix) with ESMTPS id 3ED324C900E1
	for <cygwin-patches@cygwin.com>; Fri, 22 May 2026 14:22:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3ED324C900E1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3ED324C900E1
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=194.25.134.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779459723; cv=none;
	b=BFsJvdEXjMKNC0guBKid/wRI5N1FDcAHbUvrQgyEzy8mLpzv5x0HjB/ISfJCFizKdwAWsCs7b5F1vP+tW707knRCkhTFPR4zVMstWDEoyJK/U7tbC96jXMWuZL2i9aOOgXhV3hQgcKRLWY7ly+P0Myz/J1M5Cq0Egg1ykGKPQ6M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779459723; c=relaxed/simple;
	bh=dhKX1wu5nlvQziW4zEVtUupdxnOetp8wh2FYVNxExxI=;
	h=Subject:To:From:Message-ID:Date:MIME-Version:DKIM-Signature; b=Jee2kB/xj4kaxupXxWtMqEXaDqe/8QpHTVlhNWhya/lCZJszaYoMW9iVUXcfcShy86l+FSLhT1F14SsMcOVfXEYgmGSQmL4hPjhii/8xzeIx+o6HL+drJR3ukWp7ZxSB4cs16CMisH+77J6oEZa/DVrgfZlWVR51V477p9MNb18=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=t-online.de header.i=Christian.Franke@t-online.de header.a=rsa-sha256 header.s=20260216 header.b=XUlCoxL2
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3ED324C900E1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=t-online.de header.i=Christian.Franke@t-online.de header.a=rsa-sha256 header.s=20260216 header.b=XUlCoxL2
Received: from fwd87.aul.t-online.de (fwd87.aul.t-online.de [10.223.144.113])
	by mailout01.t-online.de (Postfix) with SMTP id 63C811BF97
	for <cygwin-patches@cygwin.com>; Fri, 22 May 2026 16:21:59 +0200 (CEST)
Received: from [192.168.2.103] ([87.187.47.244]) by fwd87.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1wQQlB-1EvIFU0; Fri, 22 May 2026 16:21:57 +0200
Subject: Re: [PATCH] Cygwin: Implement 'reserved' marker in fdtable entries
To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
 <20260522072913.574-1-mark@maxrnd.com>
 <e5a59828-cdab-4d8a-980c-14b52a5c0d32@dronecode.org.uk>
From: Christian Franke <Christian.Franke@t-online.de>
Reply-To: cygwin-patches@cygwin.com
Message-ID: <d457a7fd-1eee-0dd0-b2f7-d46b84eeaa42@t-online.de>
Date: Fri, 22 May 2026 16:21:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.23
MIME-Version: 1.0
In-Reply-To: <e5a59828-cdab-4d8a-980c-14b52a5c0d32@dronecode.org.uk>
Content-Type: multipart/mixed;
 boundary="------------44F5E84901DE9F7DDA3A09EC"
X-TOI-EXPURGATEID: 150726::1779459717-9A7FBA22-48F8D467/0/0 CLEAN NORMAL
X-TOI-MSGID: 39a6bfb3-a484-432b-9316-69704979e336
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-online.de;
	s=20260216; t=1779459719; i=Christian.Franke@t-online.de;
	bh=0EqmfjVlFf8VJUD0VDsZkUjsekR8guVo50GCTilMasM=;
	h=Subject:To:References:From:Reply-To:Date:In-Reply-To;
	b=XUlCoxL2u7/bjMkdq5GxpVaZj4EaxDhegj9pjlr2JIssq0zZwXBs8su/bwGqetkdK
	 nkVbzlF/RhjrQ+HijWUdeJdOwM+kGKg27eCefxhslfcxYb0rESN0LMqzp8Iq8nY1ji
	 rPAmK516ZEfmxP27gcNSsV3vkBarD65vr5hOJwRdMjekW73xVcIHxk0WF74S9UPOC9
	 8/sWP7wWQK4gitBcOG/MWNwutwm2YnNY+kMZyU+pW7/Q60LZAkbjXdlP+7kL8lD06w
	 nnKEv8ib/WQOe4DmhAC4fnR9St52Nbg3pnTy/PXAErure8TkmaS8+C24zSgPwmL3Iw
	 3/KJ04L5E7eQQ==
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,TONLINE_FAKE_DKIM,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------44F5E84901DE9F7DDA3A09EC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Jon Turney wrote:
> On 22/05/2026 08:28, Mark Geisert wrote:
>> ...
>>
>> The notion is that an fdtable entry provided by cygheap_fdnew is marked
>> so that another thread can't obtain it.  Care is taken to reset the
>> marker when the entry is no longer needed.  Actually, in the usual case
>> the marker is overwritten with a pointer to an fhandler_base structure,
>> by the reserving thread, as the syscall completes.
>>
>> Reported-by: Christian Franke <Christian.Franke@t-online.de>
>> Addresses: https://cygwin.com/pipermail/cygwin/2026-May/259664.html
>> Signed-off-by: Mark Geisert <mark@maxrnd.com>
>> Fixes: e859706578ba (* autoload.cc (NtCreateFile): Add.)
>
> Thanks!
>
> This all seems fine and reasonable, but I have a couple of small 
> comments.

A test with an enhanced version of the STC was successful.
I could push this version (attached) to cygwin-apps/stc if desired.


>
> ...
>
>>     }
>>   };
>> @@ -595,7 +599,11 @@ class cygheap_fdnew : public cygheap_fdmanip
>>       else
>>         fd = cygheap->fdtab.find_unused_handle (seed_fd + 1);
>>       if (fd >= 0)
>> -      locked = lockit;
>> +      {
>> +        locked = lockit;
>> +        /* mark as "reserved" for open(), or other syscall, in 
>> progress */
>> +        cygheap->fdtab[fd] = (fhandler_base *)(int64_t) fd;
>
> So, we're already relying on "a small integer cast to pointer can't 
> collide with an actual pointer value we might get" (which is fine).
>
> But then there's no reason why we can't use a distinct constant (like 
> 1 or -1), to indicate a reserved slow throughout, which would make 
> this easier to understand?

If the current method is kept, I would suggest to change the cast to:
   (fhandler_base *)(intptr_t) fd


>
>> ...
>> @@ -607,7 +615,18 @@ class cygheap_fdnew : public cygheap_fdmanip
>>     ~cygheap_fdnew ()
>>     {
>>       if (cygheap->fdtab[fd])
>> -      cygheap->fdtab[fd]->inc_refcnt ();
>> +      {
>> +        /* check if fdtab entry is a "reserved" marker */
>> +        if (cygheap->fdtab[fd] == (fhandler_base *)(int64_t) fd)
>> +          {
>> +            /* remove "reserved" marker */
>> +            cygheap->fdtab.lock ();
>> +            cygheap->fdtab[fd] = NULL;
>> +            cygheap->fdtab.unlock ();
>> +          }
>> +        else
>> +          cygheap->fdtab[fd]->inc_refcnt ();
>> +      }

Are the fdtab.lock()/unlock() calls really needed here?

If yes, this variant prevents nested lock()ing and leaves the unlock() 
for the base class dtor:

           {
             /* remove "reserved" marker */
            if (!locked)
               {
                 cygheap->fdtab.lock ();
                 locked = true;
               }
             cygheap->fdtab[fd] = NULL;
           }


-- 
Regards,
Christian


--------------44F5E84901DE9F7DDA3A09EC
Content-Type: text/plain; charset=UTF-8;
 name="many_files.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="many_files.c"

Ly8gaHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9waXBlcm1haWwvY3lnd2luLzIwMjYtTWF5LzI1
OTY2NC5odG1sCi8vCi8vIFRoaXMgdGVzdCBjcmVhdGVzIGZpbGVzIHVudGlsIG5vIGZpbGUg
ZGVzY3JpcHRvcnMgYXJlIGxlZnQgYW5kIGNoZWNrcyB3aGV0aGVyCi8vIC0gb3BlbigpIGZh
aWxzIGlmIGFuZCBvbmx5IGlmIFJMSU1JVF9OT0ZJTEUgaGFzIGJlZW4gZXhhY3RseSByZWFj
aGVkLAovLyAtIG9wZW4oKSBmYWlscyBvbmx5IHdpdGggZXJybm89RU1GSUxFLAovLyAtIGZp
bGUgZGVzY3JpcHRvcnMgYXJlIGFsbG9jYXRlZCBpbiBhc2NlbmRpbmcgb3JkZXIgd2l0aG91
dCBnYXBzLAovLyAtIHN0YXQoKSBhbmQgdW5saW5rKCkgc3VjY2VlZCBpZiBhbmQgb25seSBp
ZiBvcGVuKCkgc3VjY2VlZGVkLgoKI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxmY250
bC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8
c3lzL3Jlc291cmNlLmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5oPgoKaW50IG1haW4oKQp7CiAg
c3RydWN0IHJsaW1pdCBybDsKICBpZiAoZ2V0cmxpbWl0KFJMSU1JVF9OT0ZJTEUsICZybCkp
IHsKICAgIGZwcmludGYoc3RkZXJyLCAiZ2V0cmxpbWl0KCkgZmFpbGVkLCBlcnJubz0lZFxu
IiwgZXJybm8pOwogICAgcmV0dXJuIDE7CiAgfQogIGludCBuID0gKHJsLnJsaW1fY3VyIDwg
MTAwMDAgPyAoaW50KXJsLnJsaW1fY3VyIDogMTAwMDApOwoKICBpZiAoY2xvc2VfcmFuZ2Uo
MywgfjBVLCAwKSkgewogICAgZnByaW50ZihzdGRlcnIsICJjbG9zZV9yYW5nZSgpIGZhaWxl
ZCwgZXJybm89JWRcbiIsIGVycm5vKTsKICAgIHJldHVybiAxOwogIH0KCiAgaW50IHN0YXR1
cyA9IDA7CiAgY2hhciBuYW1lWzMyXTsKICBpbnQgaTsKICBmb3IgKGkgPSAzOyAhc3RhdHVz
ICYmIGkgPD0gbjsgaSsrKSB7CiAgICBzbnByaW50ZihuYW1lLCBzaXplb2YobmFtZSksICJm
aWxlLSUwNGQudG1wIiwgaSk7CiAgICBpZiAodW5saW5rKG5hbWUpICYmIGVycm5vICE9IEVO
T0VOVCkgewogICAgICBmcHJpbnRmKHN0ZGVyciwgIiVzOiB1bmxpbmsoKSBmYWlsZWQgd2l0
aCB1bmV4cGVjdGVkIGVycm5vPSVkXG4iLCBuYW1lLCBlcnJubyk7CiAgICAgIHN0YXR1cyA9
IDE7CiAgICAgIGJyZWFrOwogICAgfQoKICAgIGludCBmZCA9IG9wZW4obmFtZSwgT19XUk9O
TFkgfCBPX0NSRUFULCAwNjAwKTsKICAgIHN0cnVjdCBzdGF0IHN0OwogICAgaWYgKGZkID09
IC0xKSB7CiAgICAgIGlmICghKGVycm5vID09IEVNRklMRSAmJiAocmxpbV90KWkgPT0gcmwu
cmxpbV9jdXIpKSB7CiAgICAgICAgZnByaW50ZihzdGRlcnIsICIlczogb3BlbigpIGZhaWxl
ZCwgZXJybm89JWRcbiIsIG5hbWUsIGVycm5vKTsKICAgICAgICBzdGF0dXMgPSAxOwogICAg
ICB9CiAgICAgIGlmICghc3RhdChuYW1lLCAmc3QpKSB7CiAgICAgICAgZnByaW50ZihzdGRl
cnIsICIlczogb3BlbigpIGZhaWxlZCBidXQgc3RhdCgpIHN1Y2NlZWRlZFxuIiwgbmFtZSk7
CiAgICAgICAgaSsrOwogICAgICAgIHN0YXR1cyA9IDE7CiAgICAgIH0KICAgICAgYnJlYWs7
CiAgICB9CgogICAgaWYgKChybGltX3QpaSA+PSBybC5ybGltX2N1cikgewogICAgICBmcHJp
bnRmKHN0ZGVyciwgIiVzOiBvcGVuKCkgc3VjY2VlZGVkIGRlc3BpdGUgJWQgPj0gJWx1XG4i
LCBuYW1lLCBpLCBybC5ybGltX2N1cik7CiAgICAgIHN0YXR1cyA9IDE7CiAgICB9CiAgICBp
ZiAoZmQgIT0gaSkgewogICAgICBmcHJpbnRmKHN0ZGVyciwgIiVzOiB1bmV4cGVjdGVkIGZk
ICVkLCBleHBlY3RlZCAlZFxuIiwgbmFtZSwgZmQsIGkpOwogICAgICBzdGF0dXMgPSAxOwog
ICAgfQogICAgaWYgKHN0YXQobmFtZSwgJnN0KSkgewogICAgICBmcHJpbnRmKHN0ZGVyciwg
IiVzOiBzdGF0KCkgZmFpbGVkLCBlcnJubz0lZFxuIiwgbmFtZSwgZXJybm8pOwogICAgICBz
dGF0dXMgPSAxOwogICAgfQogIH0KCiAgaWYgKGkgPiAzICYmIGNsb3NlX3JhbmdlKDMsIGkg
LSAxLCAwKSkgewogICAgZnByaW50ZihzdGRlcnIsICJjbG9zZV9yYW5nZSgpIGZhaWxlZCwg
ZXJybm89JWRcbiIsIGVycm5vKTsKICAgIHN0YXR1cyA9IDE7CiAgfQoKICB3aGlsZSAoLS1p
ID49IDMpIHsKICAgIHNucHJpbnRmKG5hbWUsIHNpemVvZihuYW1lKSwgImZpbGUtJTA0ZC50
bXAiLCBpKTsKICAgIGlmICh1bmxpbmsobmFtZSkpIHsKICAgICAgZnByaW50ZihzdGRlcnIs
ICIlczogdW5saW5rKCkgZmFpbGVkLCBlcnJubz0lZFxuIiwgbmFtZSwgZXJybm8pOwogICAg
ICBzdGF0dXMgPSAxOwogICAgfQogIH0KCiAgaWYgKCFzdGF0dXMpCiAgICBwcmludGYoIiVk
IGZpbGVzIGNyZWF0ZWQgYW5kIHJlbW92ZWQgc3VjY2Vzc2Z1bGx5XG4iLCBuIC0gMyk7CiAg
cmV0dXJuIHN0YXR1czsKfQo=
--------------44F5E84901DE9F7DDA3A09EC--
