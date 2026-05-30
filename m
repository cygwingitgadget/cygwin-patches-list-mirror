Return-Path: <SRS0=t1ok=D3=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo007.btinternet.com (btprdrgo007.btinternet.com [65.20.50.168])
	by sourceware.org (Postfix) with ESMTP id E80FF4BA7988
	for <cygwin-patches@cygwin.com>; Sat, 30 May 2026 14:48:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E80FF4BA7988
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E80FF4BA7988
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.168
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780152527; cv=none;
	b=CbMz66ngwm0oQoLfrkrjQY9kBp8ut4bB+4KZ0jgCUxRxjapZaJTWCYDjpcZFtTPefg2QW467BZ4sVWHbQG7OhQf7faF6A5P3azT7nXe/sjEwvLNDmXqL49WU11bakwF4QHwDDtCPeR9QNOaHVE4QSeTV9jS+lozIDurtLSuZWjw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780152527; c=relaxed/simple;
	bh=rIF8sTT3O/3tCniWcWZnH2+ZXWc4GxmDcjFbKZ/btDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Hxr2hwuxiJ7O0KR6idEelE+O8ZNKbRR4AGSanAJwiMLZVvgAh9UXD+wYazT3TkUTm37rZLcGCnEaK8Qaz7+7o6QeNYVgoAqlpg5MkZj4tYghkJWZaqt4BKLlnPSxEFE3Vg3QUAFhpm79E1f9OZPu9ykLWY3EnL5haWtd702lC/Y=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E80FF4BA7988
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69E78BD4032BF735
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTFqi7w21kLQ/bsff4idq3gJOJxd1yeYNnOGCMTtvD6ZitLxrhcvxxhx9Fr7dtb9gGbZZRoGCH9qzjYIPlTMJ4Sd/KJoVocizA6W7nYvZUd1DuKvZnkAqZocOsNpcg2GhGMrraYj2TVXX8OZOsBbwTbeqs3OObQmEN7kyElI7caUC1oeOkyvPJlmgx7MkzfqzPKzkkoPkCzEy7E1AMDfGZN8oZBikoW8y03NySDkkhlyQbIyuMc34kLdSn3U+qNylY6cRM3JGpaJE8dVYiN72cw/lNTOesoA7VzmrqDF7XUUttLnPzaLyuyLd3KAx3lXI8q5SgOuuvVPHkqlR05paTYEjgdcJpcMm9JPv2u0XmzxXGKS1Y/WVaZ+0UHgGGK1I/38M56O7mQQRd1CQfveTUAq0oyuUvByduPy4/guIitGnQktBxxRMLfCKT2g10IR58c24eqdogK8evpsYXxFRTcNyb068gdSoBWC8N28uA0WqGmOGtCWOMeClZ7jaqLh58X7gRrSA4bmE4TwEQCBC41ZiJ+a+zQQCW0NkIEvFpwnyYH4CDDW8av2AOf+dafSdE97y6njT+z0ZSEcwM1pC+ePvCbMfvXzeDItJM6qQ0xzzVnAylpBm3ltZckmaN4zxTguNfShhdPC4SZOXsEWgUDpbquVosF12I2ZvmaAaPjp9w
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (83.105.142.8) by btprdrgo007.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69E78BD4032BF735; Sat, 30 May 2026 15:48:39 +0100
Content-Type: multipart/mixed; boundary="------------0ziXRr6E9jQ3nqZJ17FOeQm3"
Message-ID: <d86f951d-5bee-4c70-9180-54f3f47a2320@dronecode.org.uk>
Date: Sat, 30 May 2026 15:48:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Adapt math functions to use 64bit long double on
 aarch64
To: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
Newsgroups: gmane.os.cygwin.patches
References: <PN0P287MB029594AE234FC6A4B7F6B23A92342@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <PN0P287MB029594AE234FC6A4B7F6B23A92342@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>
Message-ID: <20260530144837.1qazlIH-pYANgQzkTdoukMomLPyF18vs5ZYbQenP2Vw@z>

This is a multi-part message in MIME format.
--------------0ziXRr6E9jQ3nqZJ17FOeQm3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2026 12:33, Chandru Kumaresan wrote:
> Hi Corinna,
> The previously mentioned changes are not the only ones required. A few additional files also need to be modified to ensure that Cygwin works correctly on aarch64.
> The approach taken is consistent with mingw-w64. mingw-w64 uses the __SIZEOF_LONG_DOUBLE__ == __SIZEOF_DOUBLE__ macro to implement aarch64-specific code for math functions.
> For reference, a similar approach is used in this upstream mingw-w64 commit:
> https://github.com/mingw-w64/mingw-w64/commit/dbb60ad07c2983027cd09f0f7221505400391caa
> 
[...]
> diff --git a/winsup/cygwin/math/remainderl.S b/winsup/cygwin/math/remainderl.S
> index a69e38296..f05724e94 100644
> --- a/winsup/cygwin/math/remainderl.S
> +++ b/winsup/cygwin/math/remainderl.S
> @@ -7,15 +7,15 @@
> 
>      .file   "remainderl.S"
>      .text
> -#ifdef __x86_64__
> +#if defined(__x86_64__)
>      .align 8
> -#else
> +#elif defined(__i386__)
>      .align 4
>   #endif
>   .globl __MINGW_USYMBOL(remainderl)
>      .def    __MINGW_USYMBOL(remainderl);    .scl    2;  .type   32; .endef
>   __MINGW_USYMBOL(remainderl):
> -#ifdef __x86_64__
> +#if defined(__x86_64__)
>      fldt    (%r8)
>      fldt    (%rdx)
>   1: fprem1
> @@ -27,7 +27,7 @@ __MINGW_USYMBOL(remainderl):
>      movq    $0,8(%rcx)
>      fstpt   (%rcx)
>      ret
> -#else
> +#elif defined(__i386__)
>      fldt    16(%esp)
>      fldt    4(%esp)
>   1: fprem1
> @@ -36,4 +36,9 @@ __MINGW_USYMBOL(remainderl):
>      jp  1b
>      fstp    %st(1)
>      ret
> +#elif _defined(__aarch64__)

Now I have a (minimal) ability to compile this, I've noticed that there 
seems to be typo here.

I'm assuming the attached trivial patch is what's needed.

> +   bl  remainder
> +   ret
> +#else
> +   .error "Not supported on your platform yet"
>   #endif

--------------0ziXRr6E9jQ3nqZJ17FOeQm3
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-Fix-typo-in-aarch64-preprocessor-conditional-.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-Fix-typo-in-aarch64-preprocessor-conditional-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzMTU2YzNjMzUwZWIwZTllMWExYjY1ZTg2NDE0Zjk0YmExYjRiN2U0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVHVybmV5IDxqb24udHVybmV5QGRyb25lY29k
ZS5vcmcudWs+CkRhdGU6IFRodSwgMjggTWF5IDIwMjYgMjI6MTc6MjkgKzAxMDAKU3ViamVj
dDogW1BBVENIXSBDeWd3aW46IEZpeCB0eXBvIGluIGFhcmNoNjQgcHJlcHJvY2Vzc29yIGNv
bmRpdGlvbmFsIGluCiByZW1haW5kZXJsLlMKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1U
eXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rp
bmc6IDhiaXQKCkZpeCBhIHR5cG8gaW4gdGhlIGFhcmNoNjQgcHJlcHJvY2Vzc29yIGNvbmRp
dGlvbmFsIHVzZWQgaW4gcmVtYWluZGVybC5TLgoKPiAuLi8uLi8uLi8uLi9zcmMvd2luc3Vw
L2N5Z3dpbi9tYXRoL3JlbWFpbmRlcmwuUzozOToxNTogZXJyb3I6IG1pc3NpbmcgYmluYXJ5
IG9wZXJhdG9yIGJlZm9yZSB0b2tlbiDigJgo4oCZCj4gICAgMzkgfCAjZWxpZiBfZGVmaW5l
ZChfX2FhcmNoNjRfXykKPiAgICAgICB8ICAgICAgICAgICAgICAgXgoKRml4ZXM6IGExZjM0
N2MwZDViOCAoIkN5Z3dpbjogQWRhcHQgbWF0aCBmdW5jdGlvbnMgdG8gdXNlIDY0Yml0IGxv
bmcgZG91YmxlIG9uIGFhcmNoNjQiKQotLS0KIHdpbnN1cC9jeWd3aW4vbWF0aC9yZW1haW5k
ZXJsLlMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL21hdGgvcmVtYWluZGVybC5TIGIv
d2luc3VwL2N5Z3dpbi9tYXRoL3JlbWFpbmRlcmwuUwppbmRleCBmMDU3MjRlOTQuLjliMDc5
ZWNhMyAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9tYXRoL3JlbWFpbmRlcmwuUworKysg
Yi93aW5zdXAvY3lnd2luL21hdGgvcmVtYWluZGVybC5TCkBAIC0zNiw3ICszNiw3IEBAIF9f
TUlOR1dfVVNZTUJPTChyZW1haW5kZXJsKToKIAlqcAkxYgogCWZzdHAJJXN0KDEpCiAJcmV0
Ci0jZWxpZiBfZGVmaW5lZChfX2FhcmNoNjRfXykKKyNlbGlmIGRlZmluZWQoX19hYXJjaDY0
X18pCiAJYmwJcmVtYWluZGVyCiAJcmV0CiAjZWxzZQotLSAKMi41MS4wCgo=

--------------0ziXRr6E9jQ3nqZJ17FOeQm3--
