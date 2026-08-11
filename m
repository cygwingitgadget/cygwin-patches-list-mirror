Return-Path: <SRS0=Rah3=GE=gmail.com=chenlijon@sourceware.org>
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by sourceware.org (Postfix) with ESMTPS id 0FACF4BA2E3C
	for <cygwin-patches@cygwin.com>; Tue, 11 Aug 2026 06:03:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0FACF4BA2E3C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0FACF4BA2E3C
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2607:f8b0:4864:20::32e
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1786428199; cv=pass;
	b=DP43rI0gyTA3RaDfAj3oya5wNEdFn4KqZIvhviWQEaieVRJPRshAzJFGeEdrXk1tYxmEx5W2qawmceIDY+qOAejVfC/mtChILpQEmeGVB+2luprBNMc8NHksbmCHBpO1L3UNl1JGct17DEe+sOzZpoh7EfQf65OjpwxY2Yum7+4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786428199; c=relaxed/simple;
	bh=Xpehcd1mvEsrI6qGNOBo1wPIBD1rb0vpPAalxbaqQMI=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=oL2nGW1z7O9AnZ9E6tLegrcE+1QCQESjltEt2p9Ptz+RXFtlCikoqd9TeuIhezJ387QJi2Xbfpjx8Z4ynYiv7umpv0W0DDCL5lydhsqFHGz45HynF0cZ/wgbaLVfLUS0ftMFNopsLlVWCZBSpiti5Ijxomsa7Ma/UwSkTDJbZq8=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bwiUIxzY
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0FACF4BA2E3C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bwiUIxzY
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-7eb6573bd52so1898194a34.3
        for <cygwin-patches@cygwin.com>; Mon, 10 Aug 2026 23:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786428198; cv=none;
        d=google.com; s=arc-20260327;
        b=VqJZVNrOdLZdx622N/KeLl4Maf+uzfnK8cLMC3Ck6Awb37ayLGd/R23DSARjRfgPqt
         zfmHLqvISQK/ZYfPH4ov3MyAOHQHrxRSCARGJHtKbfuzP3nO8brtVp9n5iiKUfenkymI
         IfCUjj45Jdk/bp6LCozpEjmn9G/34udOZd2KWZbPhkIOTnMf1PsFRlkdehIQDhR3tGXU
         iBBLBqJDLF/COAnhHorHxGknPRqPXEFp/y03/RzhxkpGmM8Zb7G30omuSd+eujlW4Rg9
         l7jopP/njHx34NCqnGHr2OQB080HmUY/xtcuhJXYdgxd8DNPlllYiLM2E1HrUiGu+DyB
         I8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=F6hnxympPleZKRD50x7UhVBOw45xx8eBQy2C5oMiTCc=;
        fh=YLobnwiB6mlxg8mZw4jwzI5+9rNrzFWI954radGPi+I=;
        b=cedTcpI3nhXzSD2WPsb4EryAHMplAANOusu/SdtIoqxkIq9bmLvtV0W3jh/duBU62C
         K18zkBnBT9czv6pFz0QbpC+RZhS5kUMobaaIXPUJnMdwBPDAgoJPswaDatP3bpWUCa4W
         CsaothbTwhVrT558fRY4xzcJ13+r923/b+8lYNLjN/lsY0dlrLNjIuFXdTVuWAvzByHP
         fUQbKWJquy0dNXnTptJfvDY055kTUPrVkwD364oXb9bOmkfxLTLwB8iH63D2LKkcC5HA
         XSgkxCYHieHeKVKDwckr1qI8O7oiJwotSxl7driQFpqXmvI/1o7E/TTLoEl5rR4Q10e2
         xIPA==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786428198; x=1787032998; darn=cygwin.com;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=F6hnxympPleZKRD50x7UhVBOw45xx8eBQy2C5oMiTCc=;
        b=bwiUIxzYPaEi9amjases3+lLxegR+nV2uji6DmTK6K3J41eP+1zaR+nDdx3/dyPsmV
         qSJcyC0oRQkQH9Lv4VeqCf2NlbGUmpdAVa2b0LI6c4KetHkCVXtiwKXzMBf0lHgAHyeD
         u6pKJjzbGsx9/8hHuvJ6i3jjnc36C3fdoGQCQdgVkbWnCcAJt0LtowGXz4TTIP54IUZ3
         8j/+/AiP0tNwuosFWa5AYI6MIbHFT7LLl1cvYGpPBUJXcWN62b7z6HrJ8/LHFriyTG6R
         a6ocaPb85Rr0JSd3CLmmuBKow2akqOqy0mr2mhwQV+TAtx4BkpPCZgXSNBG6O06h9Rfq
         XMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786428198; x=1787032998;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6hnxympPleZKRD50x7UhVBOw45xx8eBQy2C5oMiTCc=;
        b=b1IdT+xXB9RYYA+fO8sm+hBw9qpv2ITa2A2hrLa+Db7bS+dXfISBnb2tExm+bo9XZf
         L7Nh0sPdWd2zD6bi4xKmv/BYM8kuDnZahJ1aHcV/yjtuAR26jxHfaMsBiyjPXltUfBeD
         13rEjRWIXuP0PqwPRmt32qdEagMTzlV1ipWxkf2WzSqEb+HmSuG18gE7H43W4UYyGgB6
         s61LLpg61fKkFGV4XWc7tO7DeEsVMqFyNGfnJDJdB8S9LGD26XZHmouCtRoqoL+ktYAI
         ox9PjoI98TOC63iZyH+o2zUU6n2kK2SPUnjOlbyqmpRwsijySw4l2tQAbW8Xz6f8iWnz
         sgyA==
X-Gm-Message-State: AOJu0Yz2nSfSnPH284YjYfq7pHmIMaf127685ot8+7Uw8vha9fmcUkcJ
	wOV+9KnLVdvDas+Xve2PLOwc5kMtvzhBG2cNtEpkGi35lsbPIjB+xBttUYH1Q8oF8HtvZZ/u+hi
	e3RJd1K1W1RKB0PWae6y6GuzxqLVvPzZDcZL32Ls=
X-Gm-Gg: AR+sD107rZ9VR7xPFMuOJnEQ+B0PIw892eWow5RzyNXAnf5QkQIfBd/t6s9w5yITKyH
	/GmOfoAyAgMkfGrRnoXXfFCODNTLIicFfIVeN6mn6PSuJaF40A1dPxDxuKy70BMRI8H7Mjytitx
	NLm/965OihkB5BFTSdQjaIDFy2jtecNYYf49lkZyyMlyjg+UPFrM6cOkLNeiD+UpoLWBHZHl462
	Wd1MEz1aDUc3JDBGXvEV0H/liz7l+kZqTOHFKOiMI5Vv1teFgqmor/IW7S46fh/EUWFRtpGNGOx
	Q3mtwIjjefE2BPJwR8UsHT8w+FHwW2VokhmuDg92KcUl75aEUFpBKsTsnmoQWrURYa4qOY1cGUP
	sFw==
X-Received: by 2002:a05:6808:c2a7:b0:49a:65bf:a91d with SMTP id
 5614622812f47-4b1fd7fad8emr543254b6e.11.1786428198305; Mon, 10 Aug 2026
 23:03:18 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?6aOb6aOb6aOb?= <chenlijon@gmail.com>
Date: Tue, 11 Aug 2026 14:03:04 +0800
X-Gm-Features: AUfX_myAVUOYtuXt_ZKjHw-d-t99YrzjKqgsFxVZ0ZuJUhzmv0ROtCv3Ufo5f2k
Message-ID: <CAD8hRBMNcuh+k0btNomyhcmn=yuNyn-Hh1bkC7gBKEiT=9kT0Q@mail.gmail.com>
Subject: [PATCH] winsup: console: validate duplicated handle set for master thread
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary="0000000000002d89540658bf3adc"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--0000000000002d89540658bf3adc
Content-Type: multipart/alternative; boundary="0000000000002d89530658bf3ada"

--0000000000002d89530658bf3ada
Content-Type: text/plain; charset="UTF-8"

Hi Cygwin maintainers,

I originally came across this issue while working on LibreOffice development
on Windows.

My main development environment is:

  CPU: AMD Ryzen 7 9800X3D, 8 cores / 16 hardware threads
  OS: Windows
  Visual Studio: Visual Studio 2022
  Windows SDK / UCRT: 10.0.26100.0
  Cygwin runtime: E:\LibreOfficeDev\cygwin64
  LibreOffice source tree: E:\LibreOfficeDev\src

While developing LibreOffice, I found that parallel builds could become
unreliable in my environment, and I often had to reduce the parallelism
significantly to avoid a stuck build.

Out of curiosity, I started reading the Cygwin source to understand what was
happening under parallel workloads. I used ChatGPT as an assistant while
inspecting logs, dumps, source code and synchronization paths, but I
reproduced,
built and validated the changes locally myself.

During the investigation, I reproduced a console-related failure path:

  close_handle: CloseHandle(p->input_handle<0x0>) failed, Win32 error 6

Reviewing the console master-thread handle setup showed that
get_duplicated_handle_set() assumed that all DuplicateHandle() calls
succeeded, while cleanup could later attempt to close members of a partially
initialized handle set.

The attached patch makes handle acquisition all-or-nothing.

It:

  * initializes handle_set_t before duplication;
  * changes get_duplicated_handle_set() to return bool;
  * checks every DuplicateHandle() result;
  * cleans up already duplicated handles if a later duplication fails;
  * avoids starting the console master thread with an incomplete handle set;
  * releases duplicated console handles if thread_sync_event duplication
fails;
  * makes close_handle_set() tolerate partially initialized handle sets.

The patch does not intentionally change console synchronization semantics.

I tested this against the current official newlib-cygwin source.

Upstream base:

  81f45549e771fd4da7b88ad04bd9e6ec5c765d50

Patch commit:

  1d5fbfa8e
  winsup: console: validate duplicated handle set for master thread

The patch was also verified in both directions:

  reverse apply against the patched HEAD: PASS
  forward apply against the upstream parent: PASS

The resulting current-master Cygwin DLL was built and tested locally.

Runtime smoke tests:

  true.exe   PASS
  uname.exe  PASS

I then installed the resulting DLL into the Cygwin runtime used by my actual
LibreOffice development environment and tested real parallel LibreOffice
builds:

  make -j4   PASS, exit status 0, elapsed time 25 seconds
  make -j8   PASS, exit status 0

The -j8 run exercised the normal LibreOffice gbuild process tree, including
make, sh, touch, cp and other Cygwin utilities.

I am submitting this because I believe that when an open-source failure path
can be reproduced and hardened without changing intended behavior, it is
worth
trying to fix it rather than only working around it.

I am not a Cygwin maintainer, so I would be grateful for review and any
corrections needed to better match Cygwin conventions.

Thank you for maintaining Cygwin.

Regards,
Chris Chen
chenlijon@gmail.com

--0000000000002d89530658bf3ada--

--0000000000002d89540658bf3adc
Content-Type: application/octet-stream; 
	name="0001-winsup-console-validate-duplicated-handle-set-for-ma.patch"
Content-Disposition: attachment; 
	filename="0001-winsup-console-validate-duplicated-handle-set-for-ma.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mso953240>
X-Attachment-Id: f_mso953240

RnJvbSAxZDVmYmZhOGUxYmYyNTkzMjMxNDE3ZTgyMDBmMzU0MjQwYWQ0ZWNj
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpcyBDaGVuIDxj
aGVubGlqb25AZ21haWwuY29tPgpEYXRlOiBUdWUsIDExIEF1ZyAyMDI2IDA0
OjQ4OjI3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gd2luc3VwOiBjb25zb2xl
OiB2YWxpZGF0ZSBkdXBsaWNhdGVkIGhhbmRsZSBzZXQgZm9yIG1hc3Rlcgog
dGhyZWFkCgpUaGUgY29uc29sZSBtYXN0ZXIgdGhyZWFkIGN1cnJlbnRseSBh
c3N1bWVzIHRoYXQgYWxsIGhhbmRsZXMgaW4gdGhlCmR1cGxpY2F0ZWQgaGFu
ZGxlIHNldCB3ZXJlIGR1cGxpY2F0ZWQgc3VjY2Vzc2Z1bGx5LgoKSWYgb25l
IG9mIHRoZSBEdXBsaWNhdGVIYW5kbGUgY2FsbHMgZmFpbHMsIGhvd2V2ZXIs
IHRoZSBtYXN0ZXIgdGhyZWFkCm1heSBiZSBzdGFydGVkIHdpdGggYSBwYXJ0
aWFsbHkgaW5pdGlhbGl6ZWQgaGFuZGxlIHNldC4gIEZhaWx1cmUgdG8KZHVw
bGljYXRlIHRocmVhZF9zeW5jX2V2ZW50IGNhbiBhbHNvIGxlYXZlIGFscmVh
ZHkgZHVwbGljYXRlZCBjb25zb2xlCmhhbmRsZXMgdW5yZWxlYXNlZC4KCkNo
YW5nZSBnZXRfZHVwbGljYXRlZF9oYW5kbGVfc2V0IHRvIHJldHVybiBib29s
IGFuZCB0cmVhdCB0aGUgaGFuZGxlIHNldAphcyBhbiBhbGwtb3Itbm90aGlu
ZyByZXNvdXJjZS4KCkluaXRpYWxpemUgdGhlIGhhbmRsZSBzZXQgYmVmb3Jl
IGR1cGxpY2F0aW9uLCBjbGVhbiB1cCBoYW5kbGVzIGFscmVhZHkKYWNxdWly
ZWQgd2hlbiBhIHN1YnNlcXVlbnQgZHVwbGljYXRpb24gZmFpbHMsIGFuZCBk
byBub3Qgc3RhcnQgdGhlCm1hc3RlciB0aHJlYWQgdW5sZXNzIHRoZSBjb21w
bGV0ZSBoYW5kbGUgc2V0IGlzIGF2YWlsYWJsZS4KCkFsc28gcmVsZWFzZSB0
aGUgZHVwbGljYXRlZCBjb25zb2xlIGhhbmRsZXMgaWYgZHVwbGljYXRpb24g
b2YKdGhyZWFkX3N5bmNfZXZlbnQgZmFpbHMsIGFuZCBtYWtlIGNsb3NlX2hh
bmRsZV9zZXQgdG9sZXJhdGUgcGFydGlhbGx5CmluaXRpYWxpemVkIGhhbmRs
ZSBzZXRzLgoKVGhpcyBjaGFuZ2UgZG9lcyBub3QgYWx0ZXIgY29uc29sZSBz
eW5jaHJvbml6YXRpb24gc2VtYW50aWNzLiAgSXQgb25seQpoYXJkZW5zIGhh
bmRsZSBhY3F1aXNpdGlvbiBhbmQgY2xlYW51cCBvbiBmYWlsdXJlIHBhdGhz
LgotLS0KIHdpbnN1cC9jeWd3aW4vZmhhbmRsZXIvY29uc29sZS5jYyAgICAg
ICB8IDEwMSArKysrKysrKysrKysrKysrKystLS0tLS0KIHdpbnN1cC9jeWd3
aW4vbG9jYWxfaW5jbHVkZXMvZmhhbmRsZXIuaCB8ICAgMiArLQogMiBmaWxl
cyBjaGFuZ2VkLCA4MCBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyL2NvbnNvbGUu
Y2MgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyL2NvbnNvbGUuY2MKaW5kZXgg
YmEzNWNhNDRjLi5iNGQxOGQ0ZjcgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3
aW4vZmhhbmRsZXIvY29uc29sZS5jYworKysgYi93aW5zdXAvY3lnd2luL2Zo
YW5kbGVyL2NvbnNvbGUuY2MKQEAgLTI4Miw5ICsyODIsMTcgQEAgY29uc19t
YXN0ZXJfdGhyZWFkIChWT0lEICphcmcpCiB7CiAgIGZoYW5kbGVyX2NvbnNv
bGUgKmZoID0gKGZoYW5kbGVyX2NvbnNvbGUgKikgYXJnOwogICB0dHkgKnR0
eXAgPSAodHR5ICopIGZoLT50YyAoKTsKLSAgZmhhbmRsZXJfY29uc29sZTo6
aGFuZGxlX3NldF90IGhhbmRsZV9zZXQ7Ci0gIGZoLT5nZXRfZHVwbGljYXRl
ZF9oYW5kbGVfc2V0ICgmaGFuZGxlX3NldCk7Ci0gIEhBTkRMRSB0aHJlYWRf
c3luY19ldmVudDsKKyAgZmhhbmRsZXJfY29uc29sZTo6aGFuZGxlX3NldF90
IGhhbmRsZV9zZXQgPSB7fTsKKworICAvKiBSZXF1aXJlIGEgY29tcGxldGUg
ZHVwbGljYXRlZCBjb25zb2xlIGhhbmRsZSBzZXQuICovCisgIGlmICghZmgt
PmdldF9kdXBsaWNhdGVkX2hhbmRsZV9zZXQgKCZoYW5kbGVfc2V0KSkKKyAg
ICB7CisgICAgICBkZWJ1Z19wcmludGYgKCJjb25zX21hc3Rlcl90aHJlYWQg
bm90IHN0YXJ0ZWQgYmVjYXVzZSBjb25zb2xlICIKKwkJICAgICJoYW5kbGUg
ZHVwbGljYXRpb24gZmFpbGVkIik7CisgICAgICByZXR1cm4gMDsKKyAgICB9
CisKKyAgSEFORExFIHRocmVhZF9zeW5jX2V2ZW50ID0gTlVMTDsKICAgaWYg
KER1cGxpY2F0ZUhhbmRsZSAoR2V0Q3VycmVudFByb2Nlc3MgKCksIGZoLT50
aHJlYWRfc3luY19ldmVudCwKIAkJICAgICAgIEdldEN1cnJlbnRQcm9jZXNz
ICgpLCAmdGhyZWFkX3N5bmNfZXZlbnQsCiAJCSAgICAgICAwLCBGQUxTRSwg
RFVQTElDQVRFX1NBTUVfQUNDRVNTKSkKQEAgLTMwMCw4ICszMDgsMTMgQEAg
Y29uc19tYXN0ZXJfdGhyZWFkIChWT0lEICphcmcpCiAgICAgICBtYXN0ZXJf
dGhyZWFkX3N0YXJ0ZWQgPSBmYWxzZTsKICAgICB9CiAgIGVsc2UKLSAgICBk
ZWJ1Z19wcmludGYgKCJjb25zX21hc3Rlcl90aHJlYWQgbm90IHN0YXJ0ZWQg
YmVjYXVzZSB0aHJlYWRfc3luY19ldmVudCAiCi0JCSAgImNvdWxkIG5vdCBi
ZSBkdXBsaWNhdGVkICUwOHgiLCBHZXRMYXN0RXJyb3IgKCkpOworICAgIHsK
KyAgICAgIERXT1JEIGVyciA9IEdldExhc3RFcnJvciAoKTsKKyAgICAgIC8q
IFJlbGVhc2UgZHVwbGljYXRlZCBjb25zb2xlIGhhbmRsZXMgaWYgc3luYy1l
dmVudCBkdXBsaWNhdGlvbiBmYWlscy4gKi8KKyAgICAgIGZoYW5kbGVyX2Nv
bnNvbGU6OmNsb3NlX2hhbmRsZV9zZXQgKCZoYW5kbGVfc2V0KTsKKyAgICAg
IGRlYnVnX3ByaW50ZiAoImNvbnNfbWFzdGVyX3RocmVhZCBub3Qgc3RhcnRl
ZCBiZWNhdXNlIHRocmVhZF9zeW5jX2V2ZW50ICIKKwkJICAgICJjb3VsZCBu
b3QgYmUgZHVwbGljYXRlZCAlMDh4IiwgZXJyKTsKKyAgICB9CiAgIHJldHVy
biAwOwogfQogCkBAIC00ODAzLDIyICs0ODE2LDU4IEBAIGZoYW5kbGVyX2Nv
bnNvbGU6Ol9fcmVsZWFzZV9vdXRwdXRfbXV0ZXggKGNvbnN0IGNoYXIgKmZu
LCBpbnQgbG4pCiAjZW5kaWYKIH0KIAotdm9pZAorYm9vbAogZmhhbmRsZXJf
Y29uc29sZTo6Z2V0X2R1cGxpY2F0ZWRfaGFuZGxlX3NldCAoaGFuZGxlX3Nl
dF90ICpwKQogewotICBEdXBsaWNhdGVIYW5kbGUgKEdldEN1cnJlbnRQcm9j
ZXNzICgpLCBnZXRfaGFuZGxlICgpLAotCQkgICBHZXRDdXJyZW50UHJvY2Vz
cyAoKSwgJnAtPmlucHV0X2hhbmRsZSwKLQkJICAgMCwgRkFMU0UsIERVUExJ
Q0FURV9TQU1FX0FDQ0VTUyk7Ci0gIER1cGxpY2F0ZUhhbmRsZSAoR2V0Q3Vy
cmVudFByb2Nlc3MgKCksIGdldF9vdXRwdXRfaGFuZGxlICgpLAotCQkgICBH
ZXRDdXJyZW50UHJvY2VzcyAoKSwgJnAtPm91dHB1dF9oYW5kbGUsCi0JCSAg
IDAsIEZBTFNFLCBEVVBMSUNBVEVfU0FNRV9BQ0NFU1MpOwotICBEdXBsaWNh
dGVIYW5kbGUgKEdldEN1cnJlbnRQcm9jZXNzICgpLCBpbnB1dF9tdXRleCwK
LQkJICAgR2V0Q3VycmVudFByb2Nlc3MgKCksICZwLT5pbnB1dF9tdXRleCwK
LQkJICAgMCwgRkFMU0UsIERVUExJQ0FURV9TQU1FX0FDQ0VTUyk7Ci0gIER1
cGxpY2F0ZUhhbmRsZSAoR2V0Q3VycmVudFByb2Nlc3MgKCksIG91dHB1dF9t
dXRleCwKLQkJICAgR2V0Q3VycmVudFByb2Nlc3MgKCksICZwLT5vdXRwdXRf
bXV0ZXgsCi0JCSAgIDAsIEZBTFNFLCBEVVBMSUNBVEVfU0FNRV9BQ0NFU1Mp
OworICAvKiBWYWxpZGF0ZSBkdXBsaWNhdGVkIGNvbnNvbGUgaGFuZGxlcyBi
ZWZvcmUgc3RhcnRpbmcgdGhlIG1hc3RlciB0aHJlYWQuCisgICAgIEEgbWFz
dGVyIHRocmVhZCBtdXN0IG5ldmVyIHN0YXJ0IHdpdGggYSBwYXJ0aWFsIGhh
bmRsZSBzZXQuICovCisgIHAtPmlucHV0X2hhbmRsZSA9IE5VTEw7CisgIHAt
Pm91dHB1dF9oYW5kbGUgPSBOVUxMOworICBwLT5pbnB1dF9tdXRleCA9IE5V
TEw7CisgIHAtPm91dHB1dF9tdXRleCA9IE5VTEw7CiAgIHAtPnVuaXQgPSB1
bml0OworCisgIGlmICghRHVwbGljYXRlSGFuZGxlIChHZXRDdXJyZW50UHJv
Y2VzcyAoKSwgZ2V0X2hhbmRsZSAoKSwKKwkJCUdldEN1cnJlbnRQcm9jZXNz
ICgpLCAmcC0+aW5wdXRfaGFuZGxlLAorCQkJMCwgRkFMU0UsIERVUExJQ0FU
RV9TQU1FX0FDQ0VTUykpCisgICAgeworICAgICAgZGVidWdfcHJpbnRmICgi
RHVwbGljYXRlSGFuZGxlKGlucHV0X2hhbmRsZSAlcCkgZmFpbGVkICUwOHgi
LAorCQkgICAgZ2V0X2hhbmRsZSAoKSwgR2V0TGFzdEVycm9yICgpKTsKKyAg
ICAgIGdvdG8gZmFpbDsKKyAgICB9CisKKyAgaWYgKCFEdXBsaWNhdGVIYW5k
bGUgKEdldEN1cnJlbnRQcm9jZXNzICgpLCBnZXRfb3V0cHV0X2hhbmRsZSAo
KSwKKwkJCUdldEN1cnJlbnRQcm9jZXNzICgpLCAmcC0+b3V0cHV0X2hhbmRs
ZSwKKwkJCTAsIEZBTFNFLCBEVVBMSUNBVEVfU0FNRV9BQ0NFU1MpKQorICAg
IHsKKyAgICAgIGRlYnVnX3ByaW50ZiAoIkR1cGxpY2F0ZUhhbmRsZShvdXRw
dXRfaGFuZGxlICVwKSBmYWlsZWQgJTA4eCIsCisJCSAgICBnZXRfb3V0cHV0
X2hhbmRsZSAoKSwgR2V0TGFzdEVycm9yICgpKTsKKyAgICAgIGdvdG8gZmFp
bDsKKyAgICB9CisKKyAgaWYgKCFEdXBsaWNhdGVIYW5kbGUgKEdldEN1cnJl
bnRQcm9jZXNzICgpLCBpbnB1dF9tdXRleCwKKwkJCUdldEN1cnJlbnRQcm9j
ZXNzICgpLCAmcC0+aW5wdXRfbXV0ZXgsCisJCQkwLCBGQUxTRSwgRFVQTElD
QVRFX1NBTUVfQUNDRVNTKSkKKyAgICB7CisgICAgICBkZWJ1Z19wcmludGYg
KCJEdXBsaWNhdGVIYW5kbGUoaW5wdXRfbXV0ZXggJXApIGZhaWxlZCAlMDh4
IiwKKwkJICAgIGlucHV0X211dGV4LCBHZXRMYXN0RXJyb3IgKCkpOworICAg
ICAgZ290byBmYWlsOworICAgIH0KKworICBpZiAoIUR1cGxpY2F0ZUhhbmRs
ZSAoR2V0Q3VycmVudFByb2Nlc3MgKCksIG91dHB1dF9tdXRleCwKKwkJCUdl
dEN1cnJlbnRQcm9jZXNzICgpLCAmcC0+b3V0cHV0X211dGV4LAorCQkJMCwg
RkFMU0UsIERVUExJQ0FURV9TQU1FX0FDQ0VTUykpCisgICAgeworICAgICAg
ZGVidWdfcHJpbnRmICgiRHVwbGljYXRlSGFuZGxlKG91dHB1dF9tdXRleCAl
cCkgZmFpbGVkICUwOHgiLAorCQkgICAgb3V0cHV0X211dGV4LCBHZXRMYXN0
RXJyb3IgKCkpOworICAgICAgZ290byBmYWlsOworICAgIH0KKworICByZXR1
cm4gdHJ1ZTsKKworZmFpbDoKKyAgY2xvc2VfaGFuZGxlX3NldCAocCk7Cisg
IHJldHVybiBmYWxzZTsKIH0KIAogLyogVGhlIGZ1bmN0aW9uIGNsb3NlX2hh
bmRsZV9zZXQoKSBzaG91bGQgYmUgc3RhdGljIHNvIHRoYXQgdGhleSBjYW4K
QEAgLTQ4MjYsMTMgKzQ4NzUsMjEgQEAgZmhhbmRsZXJfY29uc29sZTo6Z2V0
X2R1cGxpY2F0ZWRfaGFuZGxlX3NldCAoaGFuZGxlX3NldF90ICpwKQogdm9p
ZAogZmhhbmRsZXJfY29uc29sZTo6Y2xvc2VfaGFuZGxlX3NldCAoaGFuZGxl
X3NldF90ICpwKQogewotICBDbG9zZUhhbmRsZSAocC0+aW5wdXRfaGFuZGxl
KTsKKyAgLyogQ2xvc2Ugb25seSBjb25zb2xlIGhhbmRsZXMgdGhhdCB3ZXJl
IHN1Y2Nlc3NmdWxseSBkdXBsaWNhdGVkLiAqLworICBpZiAocC0+aW5wdXRf
aGFuZGxlKQorICAgIENsb3NlSGFuZGxlIChwLT5pbnB1dF9oYW5kbGUpOwog
ICBwLT5pbnB1dF9oYW5kbGUgPSBOVUxMOwotICBDbG9zZUhhbmRsZSAocC0+
b3V0cHV0X2hhbmRsZSk7CisKKyAgaWYgKHAtPm91dHB1dF9oYW5kbGUpCisg
ICAgQ2xvc2VIYW5kbGUgKHAtPm91dHB1dF9oYW5kbGUpOwogICBwLT5vdXRw
dXRfaGFuZGxlID0gTlVMTDsKLSAgQ2xvc2VIYW5kbGUgKHAtPmlucHV0X211
dGV4KTsKKworICBpZiAocC0+aW5wdXRfbXV0ZXgpCisgICAgQ2xvc2VIYW5k
bGUgKHAtPmlucHV0X211dGV4KTsKICAgcC0+aW5wdXRfbXV0ZXggPSBOVUxM
OwotICBDbG9zZUhhbmRsZSAocC0+b3V0cHV0X211dGV4KTsKKworICBpZiAo
cC0+b3V0cHV0X211dGV4KQorICAgIENsb3NlSGFuZGxlIChwLT5vdXRwdXRf
bXV0ZXgpOwogICBwLT5vdXRwdXRfbXV0ZXggPSBOVUxMOwogfQogCmRpZmYg
LS1naXQgYS93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2ZoYW5kbGVy
LmggYi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2ZoYW5kbGVyLmgK
aW5kZXggZDExYjNlYzRmLi5hOTY4MzYzN2QgMTAwNjQ0Ci0tLSBhL3dpbnN1
cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvZmhhbmRsZXIuaAorKysgYi93aW5z
dXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2ZoYW5kbGVyLmgKQEAgLTIzNTAs
NyArMjM1MCw3IEBAIHByaXZhdGU6CiAgIHNpemVfdCAmcmFpeHB1dCAoKTsK
ICAgc2l6ZV90ICZyYWJ1ZmxlbiAoKTsKIAotICB2b2lkIGdldF9kdXBsaWNh
dGVkX2hhbmRsZV9zZXQgKGhhbmRsZV9zZXRfdCAqcCk7CisgIGJvb2wgZ2V0
X2R1cGxpY2F0ZWRfaGFuZGxlX3NldCAoaGFuZGxlX3NldF90ICpwKTsKICAg
c3RhdGljIHZvaWQgY2xvc2VfaGFuZGxlX3NldCAoaGFuZGxlX3NldF90ICpw
KTsKIAogICBzdGF0aWMgdm9pZCBjb25zX21hc3Rlcl90aHJlYWQgKGhhbmRs
ZV9zZXRfdCAqcCwgdHR5ICp0dHlwKTsKLS0gCjIuNTUuMC53aW5kb3dzLjMK
Cg==

--0000000000002d89540658bf3adc--
