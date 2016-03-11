Return-Path: <cygwin-patches-return-8391-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 127781 invoked by alias); 11 Mar 2016 10:28:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127763 invoked by uid 89); 11 Mar 2016 10:28:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=(unknown), 4000, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-lb0-f180.google.com
Received: from mail-lb0-f180.google.com (HELO mail-lb0-f180.google.com) (209.85.217.180) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Fri, 11 Mar 2016 10:28:30 +0000
Received: by mail-lb0-f180.google.com with SMTP id xr8so144657533lbb.1        for <cygwin-patches@cygwin.com>; Fri, 11 Mar 2016 02:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:date         :message-id:subject:from:to;        bh=fXXmMPLoeyRcNNqk9zSMG0CNrGnv6UosDm9xnlCN6VE=;        b=bCWj7z3CjoyH+CAusHj4TjCLKLDPu8w6qf58Ei/2t3QVKdGjEzlt6T3SnzurHZMrHX         ya8ZlogtyEYi3quYarZWtVVS0TOQ8NQRvC9sy1yUXW7JSj6TzxkCdOSbUGXu99Lp6gon         0gL0mnQsV6fG6fZYUCt/Y5xwDd9XmBrHrPOQy0dtZ0scbiqsiRkKcqEmcBJlwhisyEjp         XLj1Xq4Lh+v68tDfj9eQDsI1lUPP/GiXangFI17ob1F+rSNRER1sDVVxMQCAMJjam2+M         4KCGcYUWZzueONlQ0q5NK9dOBWGAr191MlXqM9NLl4esdPUPhpM37LHAMrsGTKVqFHvX         x/qA==
X-Gm-Message-State: AD7BkJID5aSfrgMpVq69CGvFcEPVvmVxYDxNvO/knjzr/OtqbjOehrMmrtMtR52U20dt8G37gjJUtVMGkD7RCA==
MIME-Version: 1.0
X-Received: by 10.112.132.65 with SMTP id os1mr2991915lbb.118.1457692107588; Fri, 11 Mar 2016 02:28:27 -0800 (PST)
Received: by 10.25.205.82 with HTTP; Fri, 11 Mar 2016 02:28:27 -0800 (PST)
In-Reply-To: <CAKw7uVgrjqZVznRMoCbsjyz4YXast5YtAAmpWQorOw7YXqbOhw@mail.gmail.com>
References: <CAKw7uVgrjqZVznRMoCbsjyz4YXast5YtAAmpWQorOw7YXqbOhw@mail.gmail.com>
Date: Fri, 11 Mar 2016 10:28:00 -0000
Message-ID: <CAKw7uVg78t2V8KKLYfPyhb97XjU+aUb4KV-poz7i_wwDeJ6b=g@mail.gmail.com>
Subject: Fwd: [PATCH] spinlock spin with pause instruction
From: =?UTF-8?Q?V=C3=A1clav_Haisman?= <vhaisman@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=047d7b3a81c4442fd9052dc36461
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00097.txt.bz2


--047d7b3a81c4442fd9052dc36461
Content-Type: text/plain; charset=UTF-8
Content-length: 283

Hi.

I have noticed that Cygwin's spinlock goes into heavy sleeping code
for each spin. It seems it would be a good idea to actually try to
spin a bit first. There is this 'pause' instruction which let's the
CPU make such busy loops be less busy. Here is a patch to do this.

-- 
VH

--047d7b3a81c4442fd9052dc36461
Content-Type: text/plain; charset=US-ASCII; name="spinlock-pause.patch.txt"
Content-Disposition: attachment; filename="spinlock-pause.patch.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ilnjxx3e0
Content-length: 1708

ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjIGIvd2luc3Vw
L2N5Z3dpbi90aHJlYWQuY2MKaW5kZXggMDFjZmQ1Yi4uNTZlNjZmMSAxMDA2
NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2MKKysrIGIvd2luc3Vw
L2N5Z3dpbi90aHJlYWQuY2MKQEAgLTE5MTcsNiArMTkxNywxOSBAQCBwdGhy
ZWFkX3NwaW5sb2NrOjpsb2NrICgpCiB7CiAgIHB0aHJlYWRfdCBzZWxmID0g
OjpwdGhyZWFkX3NlbGYgKCk7CiAgIGludCByZXN1bHQgPSAtMTsKKyAgdW5z
aWduZWQgc3BpbnMgPSAwOworCisgIC8qCisgICAgV2Ugd2FudCB0byBzcGlu
IHVzaW5nICdwYXVzZScgaW5zdHJ1Y3Rpb24gb24gbXVsdGktY29yZSBzeXN0
ZW0gYnV0IHdlCisgICAgd2FudCB0byBhdm9pZCB0aGlzIG9uIHNpbmdsZS1j
b3JlIHN5c3RlbXMuCisKKyAgICBUaGUgbGltaXQgb2YgMTAwMCBzcGlucyBp
cyBzZW1pLWFyYml0cmFyeS4gTWljcm9zb2Z0IHN1Z2dlc3RzIChpbiB0aGVp
cgorICAgIEluaXRpYWxpemVDcml0aWNhbFNlY3Rpb25BbmRTcGluQ291bnQg
ZG9jdW1lbnRhdGlvbiBvbiBNU0ROKSB0aGV5IGFyZQorICAgIHVzaW5nIHNw
aW4gY291bnQgbGltaXQgNDAwMCBmb3IgdGhlaXIgaGVhcCBtYW5hZ2VyIGNy
aXRpY2FsCisgICAgc2VjdGlvbnMuIE90aGVyIHNvdXJjZSBzdWdnZXN0IHNw
aW4gY291bnQgYXMgc21hbGwgYXMgMjAwIGZvciBmYXN0IHBhdGgKKyAgICBv
ZiBtdXRleCBsb2NraW5nLgorICAgKi8KKyAgdW5zaWduZWQgY29uc3QgRkFT
VF9TUElOU19MSU1JVCA9IHdpbmNhcC5jcHVfY291bnQgKCkgIT0gMSA/IDEw
MDAgOiAwOwogCiAgIGRvCiAgICAgewpAQCAtMTkyNSw4ICsxOTM4LDEzIEBA
IHB0aHJlYWRfc3BpbmxvY2s6OmxvY2sgKCkKIAkgIHNldF9vd25lciAoc2Vs
Zik7CiAJICByZXN1bHQgPSAwOwogCX0KLSAgICAgIGVsc2UgaWYgKHB0aHJl
YWQ6OmVxdWFsIChvd25lciwgc2VsZikpCisgICAgICBlbHNlIGlmICh1bmxp
a2VseShwdGhyZWFkOjplcXVhbCAob3duZXIsIHNlbGYpKSkKIAlyZXN1bHQg
PSBFREVBRExLOworICAgICAgZWxzZSBpZiAoc3BpbnMgPCBGQVNUX1NQSU5T
X0xJTUlUKQorICAgICAgICB7CisgICAgICAgICAgKytzcGluczsKKyAgICAg
ICAgICBfX2FzbV9fIHZvbGF0aWxlICgicGF1c2UiOjo6KTsKKyAgICAgICAg
fQogICAgICAgZWxzZQogCXsKIAkgIC8qIE1pbmltYWwgdGltZW91dCB0byBt
aW5pbWl6ZSBDUFUgdXNhZ2Ugd2hpbGUgc3RpbGwgc3Bpbm5pbmcuICovCg==

--047d7b3a81c4442fd9052dc36461--
