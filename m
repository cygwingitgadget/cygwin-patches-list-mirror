Return-Path: <SRS0=+5bO=GY=upm.es=pedroluis.castedo@sourceware.org>
Received: from neon-v2.ccupm.upm.es (neon-v2.ccupm.upm.es [138.100.198.70])
	by sourceware.org (Postfix) with ESMTPS id DE850385828E
	for <cygwin-patches@cygwin.com>; Sat, 11 Nov 2023 17:29:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DE850385828E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=upm.es
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=upm.es
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DE850385828E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=138.100.198.70
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699723800; cv=none;
	b=ies1W2bdyk1Vh4N/nHGW9nCFmYjI9BMhQqMsdr4cgU8D0Yw/CqbgOdQWtaPYgT++OA+m/jpyF/ZDHRU/euKnQTKwMEIVegghRVcK/4gnUamwaEVDyU7mJ5ak+N/C0YIVo0wpV25VLJvlkVisWNReHgm9GieawEdsGzkvYJ4la/4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699723800; c=relaxed/simple;
	bh=Sqyv4Y412w3YTyP/e36VzlEt5Rpjzm65e5UQZ7kqiU4=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From; b=mHjkLVKTb4prCUtFzkLyCLoyc7QB8RGjaLrEWbnR9jlZ7zMVFQFlSzxD+ipV3mRrONHQ3kicTfoMLuf9nMHL2W0EVu2DCpCW1xAwJVaxOX38tldlF0ohT8M4W6+qzl1KsvB3akSPWn6CgU9hPVJgzuM4W0Xr1pbnEdTlOc5jYvM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from [10.199.0.25] ([138.100.147.140])
        (user=pedroluis.castedo@upm.es mech=PLAIN bits=0)
        by neon-v2.ccupm.upm.es (8.15.2/8.15.2/neon-v2-001) with ESMTPSA id 3ABHTrRB017789
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <cygwin-patches@cygwin.com>; Sat, 11 Nov 2023 17:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=upm.es; s=upm;
	t=1699723793; bh=Sqyv4Y412w3YTyP/e36VzlEt5Rpjzm65e5UQZ7kqiU4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=k89Rq2OPIgbh0yL5tJ9IF92IrUC5XOpn+RpC9uinYYAqDHM4d+pe7Haz9RCTn+8+u
	 ci9mp/Wdv7o8zGoHNJBI/5KdYh6kDzqFzIR8a93zg2Jxr6gnm3eyphUDUgY2Py+llo
	 p0XN9XeXNCM28zO8sLSM+6Yj7c/UUgaex16vnEC4=
Content-Type: multipart/mixed; boundary="------------5bvHiTLhLNNGaKmH0NPOmSry"
Message-ID: <ac7355c3-7b25-4410-94eb-9bd2f602f4ac@upm.es>
Date: Sat, 11 Nov 2023 18:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix(libc): Fix handle of %E & %O modifiers at end of
 format string
Content-Language: es-ES
To: cygwin-patches@cygwin.com
References: <20231109190441.2826-1-pedroluis.castedo@upm.es>
 <4801ab90-2958-4fa2-87f2-21efdb41bbf4@Shaw.ca>
 <ZU4C+UIcYTtvWrrJ@calimero.vinschen.de>
 <27a7257d-1e06-40ff-89ec-f100b8734802@upm.es>
 <5cd4b96f-cad1-456c-b4d9-a6a649d36e3a@Shaw.ca>
From: Pedro Luis Castedo Cepeda <pedroluis.castedo@upm.es>
Autocrypt: addr=pedroluis.castedo@upm.es; keydata=
 xsBNBF5YKl0BCACzN1lKiHEXuVVewBovxPa1Mt7MHcmBcrRLSNy79qIcFzjlMI5m4h48X/73
 NKomCipsOD9o/n3XlVs6G95H4MqdF/1+SZitIFulp2A7Dcaqi16xWJHAAvEb2dbuDxIdZf9z
 fZ515ZYCarFujQJZ0/0wFm3XG8bkZ1FZA1v1th6m90quGw7FWXPkZW9HPjNEp6RbLJxZug9m
 kHtFkzu/INWqjF2s/+Mcdq6K9ITJe8Nd18k+N9hj07VUeLQFJ0BAbC/lpiopPKJ8s7cBbmMf
 /RCxV7sJN6NoHlzYk+NSG59jHgqFyrkAe2WSbDOhoU4NqX5QdqzeF8zdfIeqrGYu0l6/ABEB
 AAHNNFBlZHJvIEx1aXMgQ2FzdGVkbyBDZXBlZGEgPHBlZHJvbHVpcy5jYXN0ZWRvQHVwbS5l
 cz7CwJQEEwEIAD4WIQT4JX3bDIHOcDGQIiCmZyXoTSavkgUCZQAzxQIbAwUJCmscAwULCQgH
 AgYVCgkICwIEFgIDAQIeAQIXgAAKCRCmZyXoTSavkt3ECACGFXic1JvCEo9jGaCZlIkbXBMW
 MTWdAV2fFpHt8yavuSl9MmJ9tkx6vTeYF8CPzEwxtpioQCpMRi39bD8CdPsFaRklmvAWdsgQ
 xp/tORGxrQ2XDdx25jJPvMIR7PIMMBXBIYIl5hWKpA4OTKt1jkY1PE5LvgMkuCRAh4iDd2Ad
 VBo16sp9abNlfMpq9XXDtOse7XarIpA1o/OT2I25tg3zwW1cViUovs7Sy24Ee9EutEEYd5Tc
 E5skX8+YLygCnMV3pcGbaCB5iWUnK58cPvlvitLj+7beqVoreD4TLcHDYsYI/qf/QPfxbapb
 rY3sLjS1N5p5B5yhaDiWU6qrLrsFzsBNBF5YKl0BCAC+1kpa9CcXqC/oYaARH/PrLVdUNKIn
 U2GADlFVY527WHtHKqjABjY14kPq8yNAwwpUVqsA9NnvQAJUVNS3fHe0/IUvayhy45YnVa97
 d5hK8icdRziPFizVJtlFpu6RJiWH812bgvw3pectdbIS9gT+ZnDoBWbEuUfvphIXZwrQ9DiT
 yB2a1KLEUqOd9gZIoI2Jbc/ZGi7MTg95zB8WbGCSW+WNBD0LTFzFzCApJldrppgVqe7XXMSS
 M5sobvgnZH9tkl0MiwCSznol02/xs7Katlkf/7oF8oDbAXNhTELh3d2y5Z8Q/UqQOPuemBma
 yDiN8/Qq0dpLWA3zHSeuLyHLABEBAAHCwHwEGAEIACYWIQT4JX3bDIHOcDGQIiCmZyXoTSav
 kgUCZQAzxgIbDAUJCmscAwAKCRCmZyXoTSavkjcCB/40ejE9Sg25x0EXr3eo/blM+VCNjDRn
 KKLXB+ljw4axwNdQniWuifT7cCUr+srWMPadRHy8I38q6F1DMRIUISgXAYh/LOGs51XFxzLm
 hmGUUxcptDtLwnFb+NoncyIuayPdL75M7SrdGnBVRSpMXGgiJU4pK/AaXY6ZenV+eJ5P+TVG
 SA9tzO+nf9B9Rlr0IYNUa7XhxInBJE6wNe9yiKlY38yL88yTYYnjHidmP/d3gMqxhNB1Ukye
 FesNo7IlwicrkhV8+PqE3vBWoq2MMhjXrV0W3mENORYnNhFKgRG5LlC9kH+UrT3Umr36JEye
 KbTMJyJRQIdMD6/gE8m0F0gq
In-Reply-To: <5cd4b96f-cad1-456c-b4d9-a6a649d36e3a@Shaw.ca>
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------5bvHiTLhLNNGaKmH0NPOmSry
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

El 11/11/2023 a las 6:57, Brian Inglis escribió:
> On 2023-11-10 10:44, Pedro Luis Castedo Cepeda wrote:
>> El 10/11/2023 a las 11:16, Corinna Vinschen escribió:
>>> On Nov  9 23:17, Brian Inglis wrote:
>>>> On 2023-11-09 12:04, Pedro Luis Castedo Cepeda wrote:
>>>>> - Prevent strftime to parsing format string beyond its end when
>>>>>     it finish with "%E" or "%O".
>>>>> ---
>>>>>    newlib/libc/time/strftime.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/newlib/libc/time/strftime.c b/newlib/libc/time/strftime.c
>>>>> index 56f227c5f..c4e9e45a9 100644
>>>>> --- a/newlib/libc/time/strftime.c
>>>>> +++ b/newlib/libc/time/strftime.c
>>>>> @@ -754,6 +754,8 @@ __strftime (CHAR *s, size_t maxsize, const CHAR 
>>>>> *format,
>>>>>          switch (*format)
>>>>>        {
>>>>> +    case CQ('\0'):
>>>>> +      break;
>>>>>        case CQ('a'):
>>>>>          _ctloc (wday[tim_p->tm_wday]);
>>>>>          for (i = 0; i < ctloclen; i++)
>>>>
>>>> These cases appear to already be taken care of by setting and using
>>>> (depending on the config parameters) the "alt" variable for those 
>>>> modifiers,
>>>> and the default: return 0; for the format *character* (possibly 
>>>> wide) not
>>>> matching following any modifiers.
>>>>
>>>> Patches to newlib should go to the newlib mailing list at sourceware 
>>>> dot org.
>>>
>>> Also, a simple reproducer would be nice.
> 
>> My first contribution. Sorry about posting to wrong mail list and, at 
>> best, minimalistic patch motivation reasoning. First time with git 
>> send-mail, too.
>>
>> I came across this newlib "feature" trying to update GLib port to 
>> 2.78.1. When trying to find out why test_strftime (glib/test/date.c)
>> was failing I discovered that one of the test format strings, "%E" was 
>> triggering a loop in g_date_strftime (glib/gdate.c) requiring more and 
>> more memory till it was stopped by a fortunate maximum size check in 
>> function.
>>
>> The problem is that __strftime  (newlib/libc/time/strftime.c) doesn't 
>> check for '\0' after a terminal "%E" and it continues parsing the 
>> format string. Finally (not sure if intentionally), this triggers a 
>> direct return 0 from __strftime instead breaking the loop, preventing 
>> it from add '\0' to the end of returned string. Same for "%O", I think 
>> (not tested).
>>
>> It seems that this trailing '\0' allows to differentiate returning an 
>> empty string from needing more space (at least, in Glib).
>>
>> So, is it a newlib bug? Not really, I think this format string is 
>> bad-formed (%E should modify something, shouldn't it?) So undefined 
>> behaviour is OK. I could patch-out these format strings from the port.
>>
>> But... from Glib tests, it seems that, at least:
>>
>> - If G_OS_WIN32, terminal "%E" & "%O" are silently discarded.
>> - If __FreeBSD__ || __OpenBSD__ || __APPLE__ they are transformed to E 
>> & O, respectively.
>> - And if #else the same thing is expected.
>>
>> So it seems that returning 0-terminated string is a common practice 
>> and I also think that this is more deterministic and, potentially, 
>> safer. That's why I sent the patch. It tries to be the shortest 
>> addition to check for end of string after %E & %O modifiers and takes 
>> G_OS_WIN32 approach (only cause it's the simplest).
> 
> Not seeing any issue with any format - see attached source and log 
> output, built under Cygwin.
> [Derived from a bash script using printf %(...)T to do the same thing.]
> 

OK. It's not a newlib problem but a GLib one as it is relaying on common 
but non-standard strftime implementation details.

I attach a short program more focused in g_date_strftime implementation 
so it can be evaluated if it worths addressing this corner case.

Thanks.
--------------5bvHiTLhLNNGaKmH0NPOmSry
Content-Type: text/plain; charset=UTF-8; name="strftime_lonelyE.c"
Content-Disposition: attachment; filename="strftime_lonelyE.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmlu
Zy5oPgojaW5jbHVkZSA8dGltZS5oPgojaW5jbHVkZSA8YXNzZXJ0Lmg+CgppbnQgbWFpbihp
bnQgYXJnYywgY2hhciAqYXJndltdKQp7CiAgY29uc3Qgc3RydWN0IHRtIGRhdGUgPSB7CiAg
ICAudG1fc2VjID0gMCwgLnRtX21pbiA9IDAsIC50bV9ob3VyID0gMCwgLnRtX21kYXkgPSAx
LCAudG1fbW9uID0gMCwKICAgIC50bV95ZWFyID0gLTE4OTksIC50bV93ZGF5ID0gMSwgLnRt
X3lkYXkgPSAwLCAudG1faXNkc3QgPSAtMSwKICAgIC50bV9nbXRvZmYgPSAwLCAudG1fem9u
ZSA9IDB4MAogIH07CiAgY29uc3QgY2hhciAqZm10ID0gIiVFIjsKICBjb25zdCBzaXplX3Qg
bWF4c3ogPSA2NTUzNnU7CgogIHNpemVfdCBidWZzeiA9IDEyODsKICBjaGFyICpidWYgPSBO
VUxMOwoKICAvLyBNaW1pYyBnX2RhdGVfc3RyZnRpbWUgKGdsaWIvZ2RhdGUuYykgYXBwcm9h
Y2gKICBkbyB7CiAgICBidWYgPSAoY2hhciAqKXJlYWxsb2MoYnVmLCBidWZzeik7CiAgICBh
c3NlcnQoYnVmKTsKCiAgICBidWZbMF0gPSAnXDEnOyAvLyBNYXJrIHRvIGd1ZXNzIGlmIGVt
cHR5IG9yIG5vdCBlbm91Z2ggc3BhY2UKICAgIHNpemVfdCBsZW4gPSBzdHJmdGltZShidWYs
IGJ1ZnN6LCBmbXQsICZkYXRlKTsKICAgIGlmIChsZW4gIT0gMCB8fCBidWZbMF0gPT0gJ1ww
JykKICAgICAgYnJlYWs7ICAvLyBPSywgZG9uZS4KCiAgICBidWZzeiAqPSAyOyAgLy8gQXNz
dW1lIG1vcmUgc3BhY2UgbmVlZGVkCiAgfSB3aGlsZSAoYnVmc3ogPD0gbWF4c3opOyAgLy8g
Li4gdXAgdG8gYSBsaW1pdAoKICBpbnQgcmM7CiAgaWYgKGJ1ZnN6IDw9IG1heHN6KQogIHsK
ICAgIHByaW50ZigiRGF0ZTogJXNcbiIsIGJ1Zik7CiAgICByYyA9IEVYSVRfU1VDQ0VTUzsK
ICB9CiAgZWxzZQogIHsKICAgIHB1dHMoIkRhdGU6IGxvbmdlc3QgZGF0ZSBldmVyIDotXFwi
KTsKICAgIHJjID0gRVhJVF9GQUlMVVJFOwogIH0KICBmcmVlKGJ1Zik7CgogIHJldHVybiBy
YzsKfQoK

--------------5bvHiTLhLNNGaKmH0NPOmSry--
