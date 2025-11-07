Return-Path: <SRS0=79Ye=5P=kmaps.co=evgeny@sourceware.org>
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
	by sourceware.org (Postfix) with ESMTPS id B7D7C3858D1E
	for <cygwin-patches@cygwin.com>; Fri,  7 Nov 2025 21:29:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B7D7C3858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=kmaps.co
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=kmaps.co
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B7D7C3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::d2b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1762550967; cv=none;
	b=OmpA2CxpUW06fRRcHr9Imdv7jkUGYAWY63tBa9mG4DpLXpk5evI74EvdbHzq0MbZ/TgDtCo6HePr1S0ZayfAGvL5hrreA8ciiPwlvfTG142IZ800FP6teshW3kpLfAM0JHDn+PNq6EWRB0B7J856jha++SdPivkf3lNRlb2otNQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1762550967; c=relaxed/simple;
	bh=9mXH/8O+IjO1ChzuNaiGIL8KWf/Uzbj14dyqY4cgVRE=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=M9GHH1lTv2gmoxhp36GXcZRawRXF1mmR9R6fuOJG3c24wdk/v48tjXjW920MmFTs18ArORK+8h9nhYvGelI9nlDlWQKyMFD0MZUTm2f7g0N6WqxfkK2YNxbuTcs4pnLzoMdAekMA7NcXevZfDUUcDJfsgZ3hoLPzOXIA3M351Rs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B7D7C3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=kmaps-co.20230601.gappssmtp.com header.i=@kmaps-co.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=0j93ZjNz
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-948640d425aso93931539f.0
        for <cygwin-patches@cygwin.com>; Fri, 07 Nov 2025 13:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kmaps-co.20230601.gappssmtp.com; s=20230601; t=1762550961; x=1763155761; darn=cygwin.com;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M3TrP/64ndI1nNwE9fNFNkPNR7NLtK+AyqguDXg1zUE=;
        b=0j93ZjNzJLLGDxWx6lr5LTKoh5JA+DJDc+IcUiHIyIR8zeTLwfrxWUq9xAQWsO4oTP
         Hmh9TeQVBSAeKKMkSu3cx5wII0IXa+K+axex2VO2uOBxBonTJ9F9Cn4dOyhZoyNwLOJh
         tcqLAIs8OzT4+HlEK/mGJHkZxFzTsmMQ9tD95BFC98n25Jjj2qmUwQCIBxEW1euHbzeW
         ldXmopWeKh+Zd5R++8H7VV0pXFQf2jeT0BxvJ7I31XU4R1IHZ0skA0moJSsao4hFE7H3
         sP3DAUjCNOY9/+glev5ikojpeLCwHGFhxdOuPrtlFGOoeoa2WySZsvT8xkd/A0f0Y0dS
         iKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762550961; x=1763155761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3TrP/64ndI1nNwE9fNFNkPNR7NLtK+AyqguDXg1zUE=;
        b=EOEDeENDcmthY5OG5PvArj1pj/8NTfx2l1W+df3OrJ9xZVp2dlXN3x/mrPRBWzY05r
         dqLC1LWVpXbZx5WT3YuuZoRyOrh6CLDEUNniXO3tC94vrpAOyxV//W7hl14USNcGbEs+
         EJmZEkJN17RrTEvVJtJEqeE3BjLE1eyub3LDmtoXVPRsCchvHkPEovxcsFMemT7iXahT
         tu8V6uHIVDGYroMhk0Oo/xFyrbja6hid25O7I6oJSQZ61ubmhE+uIrQEVVEc3HhlORwx
         Xj5nfR1TsMdDT9+g0MpKSNA6maVePX+uZ0T5HrLPEhG7p6XriXrA86qwRCoXbmUjTA4E
         mHWQ==
X-Gm-Message-State: AOJu0YwEjSCgfdRa8omgm7q2P2qF37S1mMSss8WVM6tnDw9eOkdE1gmE
	y3HXfKC999QT7nKl9aF/EmEDINbyRo88Y/e3OiwtcncgFwxo0CuGYBHZ3I0MGoDu/CgNzClTxJ1
	UIK6pUAV8i+Hq7Q/qvif4pRbGJ/pbrKd6U/BVuKZzQ5D1WSWOdndU6M0=
X-Gm-Gg: ASbGnctWuw0c/A6qZ1TY+pIXteWfRmr2mFNUmybR+hvPk19rH8Fv9Tg5IqW+TkFvQlv
	YlLHDcbGL4ZwHgrGDKVEqHZmGrYBR2eyrfW2AIAivbhOx7H62HNu2zxr05NduIObrcWKHS9jgjD
	5OPVONcQ0uj7YLMoDmmKUtQr6n7jNNkIVgC5VY1E5MTy+gxz0E7HL3Bi3q5uVR3yQZI0Zc8Ro7j
	OBZOldUmNi+IayoTHR8bnvYwEQE1WjJMPTkufcVQGRn+xDWm9u+ahQw934rosO1eO+RgJBUVegg
	UeWXtg==
X-Google-Smtp-Source: AGHT+IEgHg8NQ2lsaKLMQR8M/Sj16v1DaZu01BYuNohXv+9LzgpMRRofqPxpzGWqyAz8/q4gVyjkJWJ5W3caewYM9Pw=
X-Received: by 2002:a05:6e02:2383:b0:433:3198:7995 with SMTP id
 e9e14a558f8ab-43367e455a6mr15134695ab.17.1762550961348; Fri, 07 Nov 2025
 13:29:21 -0800 (PST)
MIME-Version: 1.0
References: <CABd5JDC_=LLjR8_nRHxBzLCxMgEqMwJP+jf-E_CPvFxOYWR2nw@mail.gmail.com>
In-Reply-To: <CABd5JDC_=LLjR8_nRHxBzLCxMgEqMwJP+jf-E_CPvFxOYWR2nw@mail.gmail.com>
From: Evgeny Karpov <evgeny@kmaps.co>
Date: Fri, 7 Nov 2025 22:29:09 +0100
X-Gm-Features: AWmQ_bl-hX3Kz1v9kQfe4wWPqDvUTfEM3jzxbvwE8XC18x1DFGCvuzuphMLrIdo
Message-ID: <CABd5JDDKBrF8teHM3OPvp733-okLrbakjTMurAvprhN5_iSq8g@mail.gmail.com>
Subject: Re: [PATCH] Cygwin: aarch64: Add runtime pseudo relocation
To: cygwin-patches@cygwin.com
Cc: jon.turney@dronecode.org.uk
Content-Type: multipart/mixed; boundary="000000000000f34d88064307dfb6"
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--000000000000f34d88064307dfb6
Content-Type: multipart/alternative; boundary="000000000000f34d87064307dfb4"

--000000000000f34d87064307dfb4
Content-Type: text/plain; charset="UTF-8"

Jon Turney <jon.turney@dronecode.org.uk> wrote:
> Thanks! I applied this.
>
> I believe this file is also present in the MinGW-w64 runtime, so you
> should submit this change to that project as well.

Thanks. Yes, there is a similar implementation in MinGW (not upstreamed
yet).
https://github.com/eukarpov/mingw-windows-arm64/commit/a7b86e4867d47434c00b1542a4219e8864acd71c

Unfortunately the previous patch was incorrectly encoded.
Here is the correct version.

Regards,
Evgeny

--000000000000f34d87064307dfb4--

--000000000000f34d88064307dfb6
Content-Type: text/plain; charset="US-ASCII"; 
	name="v1-0001-Cygwin-aarch64-Add-runtime-pseudo-relocation.txt"
Content-Disposition: attachment; 
	filename="v1-0001-Cygwin-aarch64-Add-runtime-pseudo-relocation.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mhpd54gz0>
X-Attachment-Id: f_mhpd54gz0

RnJvbTogIkV2Z2VueSBLYXJwb3YiIDxldmdlbnlAa21hcHMuY28+ClN1Ympl
Y3Q6IFtQQVRDSF0gQ3lnd2luOiBhYXJjaDY0OiBBZGQgcnVudGltZSBwc2V1
ZG8gcmVsb2NhdGlvbgoKVGhlIHBhdGNoIGFkZHMgcnVudGltZSBwc2V1ZG8g
cmVsb2NhdGlvbiBoYW5kbGluZyBmb3IgMTItYml0IGFuZCAyMS1iaXQKcmVs
b2NhdGlvbnMuIFRoZSAyNi1iaXQgcmVsb2NhdGlvbiBpcyBoYW5kbGVkIHVz
aW5nIGEganVtcCBzdHViIGdlbmVyYXRlZCBieQp0aGUgbGlua2VyLgoKLS0t
CiB3aW5zdXAvY3lnd2luL3BzZXVkby1yZWxvYy5jYyB8IDM1ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwg
MzUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4v
cHNldWRvLXJlbG9jLmNjIGIvd2luc3VwL2N5Z3dpbi9wc2V1ZG8tcmVsb2Mu
Y2MKaW5kZXggNWEwZWFiOTM2Li5mZGMyYTVkMWIgMTAwNjQ0Ci0tLSBhL3dp
bnN1cC9jeWd3aW4vcHNldWRvLXJlbG9jLmNjCisrKyBiL3dpbnN1cC9jeWd3
aW4vcHNldWRvLXJlbG9jLmNjCkBAIC0xOTksNiArMTk5LDkgQEAgZG9fcHNl
dWRvX3JlbG9jICh2b2lkICogc3RhcnQsIHZvaWQgKiBlbmQsIHZvaWQgKiBi
YXNlKQogICBwdHJkaWZmX3QgcmVsb2NfdGFyZ2V0ID0gKHB0cmRpZmZfdCkg
KChjaGFyICopZW5kIC0gKGNoYXIqKXN0YXJ0KTsKICAgcnVudGltZV9wc2V1
ZG9fcmVsb2NfdjIgKnYyX2hkciA9IChydW50aW1lX3BzZXVkb19yZWxvY192
MiAqKSBzdGFydDsKICAgcnVudGltZV9wc2V1ZG9fcmVsb2NfaXRlbV92MiAq
cjsKKyNpZmRlZiBfX2FhcmNoNjRfXworICB1aW50MzJfdCBvcGNvZGU7Cisj
ZW5kaWYKIAogICAvKiBBIHZhbGlkIHJlbG9jYXRpb24gbGlzdCB3aWxsIGNv
bnRhaW4gYXQgbGVhc3Qgb25lIGVudHJ5LCBhbmQKICAgICogb25lIHYxIGRh
dGEgc3RydWN0dXJlICh0aGUgc21hbGxlc3Qgb25lKSByZXF1aXJlcyB0d28g
RFdPUkRzLgpAQCAtMzA3LDYgKzMxMCwxMyBAQCBkb19wc2V1ZG9fcmVsb2Mg
KHZvaWQgKiBzdGFydCwgdm9pZCAqIGVuZCwgdm9pZCAqIGJhc2UpCiAJICBp
ZiAoKHJlbGRhdGEgJiAweDgwMDApICE9IDApCiAJICAgIHJlbGRhdGEgfD0g
figocHRyZGlmZl90KSAweGZmZmYpOwogCSAgYnJlYWs7CisjaWZkZWYgX19h
YXJjaDY0X18KKwljYXNlIDEyOgorCWNhc2UgMjE6CisJICBvcGNvZGUgPSAo
KigodW5zaWduZWQgaW50ICopcmVsb2NfdGFyZ2V0KSk7CisJICByZWxkYXRh
ID0gMDsKKwkgIGJyZWFrOworI2VuZGlmCiAJY2FzZSAzMjoKIAkgIHJlbGRh
dGEgPSAocHRyZGlmZl90KSAoKigodW5zaWduZWQgaW50ICopcmVsb2NfdGFy
Z2V0KSk7CiAjaWYgZGVmaW5lZCAoX194ODZfNjRfXykgfHwgZGVmaW5lZCAo
X1dJTjY0KQpAQCAtMzM5LDYgKzM0OSwzMSBAQCBkb19wc2V1ZG9fcmVsb2Mg
KHZvaWQgKiBzdGFydCwgdm9pZCAqIGVuZCwgdm9pZCAqIGJhc2UpCiAJY2Fz
ZSAxNjoKIAkgIF9fd3JpdGVfbWVtb3J5ICgodm9pZCAqKSByZWxvY190YXJn
ZXQsICZyZWxkYXRhLCAyKTsKIAkgIGJyZWFrOworI2lmZGVmIF9fYWFyY2g2
NF9fCisJY2FzZSAxMjoKKwkgIC8qIFJlcGxhY2UgYWRkIFhuLCBYbiwgOmxv
MTI6bGFiZWwgd2l0aCBsZHIgWG4sIFtYbiwgOmxvMTI6X19pbXBfX2Z1bmNd
LgorCSAgICAgVGhhdCBsb2FkcyB0aGUgYWRkcmVzcyBvZiBfZnVuYyBpbnRv
IFhuLiAgKi8KKwkgIG9wY29kZSA9IDB4Zjk0MDAwMDAgfCAob3Bjb2RlICYg
MHgzZmYpOyAvLyBsZHIKKwkgIHJlbGRhdGEgPSAoKHB0cmRpZmZfdCkgYmFz
ZSArIHItPnN5bSkgJiAoKDEgPDwgMTIpIC0gMSk7CisJICByZWxkYXRhID4+
PSAzOworCSAgb3Bjb2RlIHw9IHJlbGRhdGEgPDwgMTA7CisJICBfX3dyaXRl
X21lbW9yeSAoKHZvaWQgKikgcmVsb2NfdGFyZ2V0LCAmb3Bjb2RlLCA0KTsK
KwkgIGJyZWFrOworCWNhc2UgMjE6CisJICAvKiBSZXBsYWNlIGFkcnAgWG4s
IGxhYmVsIHdpdGggYWRycCBYbiwgX19pbXBfX2Z1bmMuICAqLworCSAgb3Bj
b2RlICY9IDB4OWYwMDAwMWY7CisJICByZWxkYXRhID0gKCgocHRyZGlmZl90
KSBiYXNlICsgci0+c3ltKSA+PiAxMikKKwkJICAgIC0gKCgocHRyZGlmZl90
KSBiYXNlICsgci0+dGFyZ2V0KSA+PiAxMik7CisJICByZWxkYXRhICY9ICgx
IDw8IDIxKSAtIDE7CisJICBvcGNvZGUgfD0gKHJlbGRhdGEgJiAzKSA8PCAy
OTsKKwkgIHJlbGRhdGEgPj49IDI7CisJICBvcGNvZGUgfD0gcmVsZGF0YSA8
PCA1OworCSAgX193cml0ZV9tZW1vcnkgKCh2b2lkICopIHJlbG9jX3Rhcmdl
dCwgJm9wY29kZSwgNCk7CisJICBicmVhazsKKwkvKiBBIG5vdGUgcmVnYXJk
aW5nIDI2IGJpdHMgcmVsb2NhdGlvbi4KKwkgICBBIHNpbmdsZSBvcGNvZGUg
aXMgbm90IHN1ZmZpY2llbnQgZm9yIDI2IGJpdHMgcmVsb2NhdGlvbiBpbiBk
eW5hbWljIGxpbmtpbmcuCisJICAgVGhlIGxpbmtlciBnZW5lcmF0ZXMgYSBq
dW1wIHN0dWIgaW5zdGVhZC4gICovCisjZW5kaWYKIAljYXNlIDMyOgogI2lm
IGRlZmluZWQgKF9fQ1lHV0lOX18pICYmIGRlZmluZWQgKF9feDg2XzY0X18p
CiAJICBpZiAocmVsZGF0YSA+IChwdHJkaWZmX3QpIF9fSU5UMzJfTUFYX18K
LS0gCjIuMzkuNQoK

--000000000000f34d88064307dfb6--
