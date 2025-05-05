Return-Path: <SRS0=NWjx=XV=gmail.com=pavlov.pavel@sourceware.org>
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by sourceware.org (Postfix) with ESMTPS id 1D82F3858420
	for <cygwin-patches@cygwin.com>; Mon,  5 May 2025 18:26:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1D82F3858420
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1D82F3858420
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::231
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746469615; cv=none;
	b=YEqis127+o9vYrJ3Rhz4LBEWkXgoB+F1YPdE55Xrgj3dsVbf8IB5rVSP5zM5OIcb5oiqHk/QXCNf7IXhDrOVIuv5C9j0A3pihWcqzZoiAQYNvPPg/aFJN04Ax0UIUcLyjlrnjIGozYLAs4p4alHQoHOiXcVcXWeKZaxqfrP3PLM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746469615; c=relaxed/simple;
	bh=M078f+JSo3oESF+Y1uqJ/wH4+3NcKv8m09lGmDjkts0=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=ffgjE+i8tAOfxGqiCkn3aulKZUoULI9AgTnjYHXQZJrzTzVQonVd7fa52zpnyCegbxR8CDyVSOh+I59FoYK8S97hXeoDL9I2oa1rfURAMFqOMzkLXsbSvZvfJnkKs4hwhc/i4k09D5qPHXXcqWdmKGgAbb4xit32FXsjwL3i894=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1D82F3858420
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TxP3ojd9
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-30de488cf81so48905051fa.1
        for <cygwin-patches@cygwin.com>; Mon, 05 May 2025 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746469613; x=1747074413; darn=cygwin.com;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UsPWOTSIovZp7JvB8UmPuf5msCPml1UwDRkxVGfCW14=;
        b=TxP3ojd9n/63hfmxa04Q06F9VunbhYQZgAyxDbLTXBU61Lm36SfTybxi1TMxZqadZx
         ZON7Fz4e8lBXNazSU7lWBSr9hmhRWlpEBQoAy8LGbXLw6vSPHWMGj+3V3+wL5WkI0dpG
         m3NS/186ebwQadrvscPGZXFzQ1mdqLm4sguNkKp1R/QGPMpKid5GSzHcB7jGkYTHwP1X
         /+OC0rUcM+k3nlk918P2eiI/kSo/jRX5qQUNdxalLHTFGUVw0DlM1f1NeLeRH/UyXta6
         aXpfyZbwpgu03k7P+6JkoqI1gJnqgi2Geyv+TEptB/hxNC22gSLDXI4ejpyTzMustEyK
         s3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746469613; x=1747074413;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UsPWOTSIovZp7JvB8UmPuf5msCPml1UwDRkxVGfCW14=;
        b=Nv4qooO+jqi0XSQaPIxYLMJ8bWAR0esXIaecBei+UL2ZRkbJbspRaiYOlaLVNGJnG7
         bwWajdarxt72PwOvOGayep8YkLV5w+LenEEUim0LO6b1LRXqJ+vb0aWBAuQZ3Mtz+ofA
         5LNSKoXuJYUil9xODu+ksaMAOfuUxCsfcjg420OsTJg/AkFX3XzV5Lnlb/ciaTuurh9V
         Fxz4QFGH5Eq4Ug08v6R4kV50Q89oG1wSsMsrdzk8OlbS1HqD7sNGuk58DslHaloG0m33
         DXZ8883NyjODnPxqfLGXLxhGZOGG3B9hW0y0alk110OrSUeaWHtSRvOtIvCmKk26d6CE
         BJ0g==
X-Gm-Message-State: AOJu0YychISBxC/B1rmTYx7WgjTiVU0RW/sSnW4vT8UNqmdiH2leNJsH
	gZChAMd3qjvRqy/bM/S6h+U0s57nVh7E93OUgohZj948ANaB41U1cbcnbjZWHfg2kUB6jV/BgaJ
	8Bbh4ugt38yOYDJ43oj3pByBqHIV/DiuqEiA=
X-Gm-Gg: ASbGncutKVqJsG50HN8y8OFM6wuz7FtBOmZw6eI0mFQClydIjO7GAYPNcSNfugVgFrc
	dpRxXH7gJjVX3XOJadMRzM3dmasMnybTpkdBy9VMfFo2eBlp2S3WOgErm1SVR53qz3p8MkzhVK5
	/ayl5LeOIqOrkUWUx9DlrNf9c=
X-Google-Smtp-Source: AGHT+IFvhJBIOSBOriZ82j2N5hhKXFyU9UxX7QnYTZmRiDOt02LYMgYd618FLl8KmCqRakYxF671YdDXP0ouZhpK/5s=
X-Received: by 2002:a05:651c:1607:b0:30c:2da3:1493 with SMTP id
 38308e7fff4ca-321db5a07a6mr33093301fa.19.1746469612777; Mon, 05 May 2025
 11:26:52 -0700 (PDT)
MIME-Version: 1.0
From: Pavel Pavlov <pavlov.pavel@gmail.com>
Date: Mon, 5 May 2025 20:26:39 +0200
X-Gm-Features: ATxdqUHp26IW-1qA3BVJ43KvuVYqJXA-mTU8pxhqbvRqwBn3bCsSljQXdEAmflw
Message-ID: <CAG_s-qpuwURKxdz1oG9wj0sdQDw=ntd9q22cmBg0fK8LVFKkgQ@mail.gmail.com>
Subject: netdb.h: remove const from hostent.h_name
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary="000000000000e18d4f063467a4de"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--000000000000e18d4f063467a4de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

the patch is self explanatory. This fixes errors/waring from hostent::h_nam=
e:

```
[6/14] Building C object CMakeFiles/http.dir/ext/c-ares/libcares.c.o
In file included from /d/work-pps/backtest-engine/ext/c-ares/libcares.c:26:
/d/work-pps/backtest-engine/ext/c-ares/src/lib/ares_free_hostent.c: In
function =E2=80=98ares_free_hostent=E2=80=99:
/d/work-pps/backtest-engine/ext/c-ares/src/lib/ares_free_hostent.c:41:17:
warning: passing argument 1 of =E2=80=98ares_free=E2=80=99 discards =E2=80=
=98const=E2=80=99 qualifier
from pointer target type [-Wdiscarded-qualifiers]
   41 |   ares_free(host->h_name);
      |             ~~~~^~~~~~~~
```

The patches to the Cygwin sources are under the 2-clause BSD license.

--000000000000e18d4f063467a4de
Content-Type: application/octet-stream; 
	name="0001-Cygwin-netdb.h-remove-const-from-hostent.h_name.patch"
Content-Disposition: attachment; 
	filename="0001-Cygwin-netdb.h-remove-const-from-hostent.h_name.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mabeta8e0>
X-Attachment-Id: f_mabeta8e0

RnJvbSAzZDZmZTkwNmMyZjZiZjk2YTdkZjU5ODdhNzg3NTRjNGE3ODFjYjlmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBQIDxwYXZsb3YucGF2ZWxAZ21haWwuY29tPgpEYXRl
OiBNb24sIDUgTWF5IDIwMjUgMjA6MTk6MTggKzAyMDAKU3ViamVjdDogW1BBVENIXSBDeWd3aW46
IG5ldGRiLmg6IHJlbW92ZSBjb25zdCBmcm9tIGhvc3RlbnQuaF9uYW1lCgpob3N0ZW50OjpoX25h
bWUgaXMgZGVmaW5lZCBhcyBub24tY29uc3QgY2hhciogYnkgdGhlIHNwZWMuCi0tLQogd2luc3Vw
L2N5Z3dpbi9pbmNsdWRlL25ldGRiLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2luY2x1ZGUv
bmV0ZGIuaCBiL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9uZXRkYi5oCmluZGV4IDE1MGZhNGU0Mi4u
NWNlZTk2N2I1IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2luY2x1ZGUvbmV0ZGIuaAorKysg
Yi93aW5zdXAvY3lnd2luL2luY2x1ZGUvbmV0ZGIuaApAQCAtNzMsNyArNzMsNyBAQCBleHRlcm4g
IkMiIHsKIAogICAvKiBEaWZmZXJlbnQgZnJvbSB0aGUgbGludXggdmVyc2lvbnMgLSBub3RlIHRo
ZSBzaG9ydHMuLiAqLwogc3RydWN0CWhvc3RlbnQgewotCWNvbnN0IGNoYXIJKmhfbmFtZTsJLyog
b2ZmaWNpYWwgbmFtZSBvZiBob3N0ICovCisJY2hhcgkqaF9uYW1lOwkvKiBvZmZpY2lhbCBuYW1l
IG9mIGhvc3QgKi8KIAljaGFyCSoqaF9hbGlhc2VzOwkvKiBhbGlhcyBsaXN0ICovCiAJc2hvcnQJ
aF9hZGRydHlwZTsJLyogaG9zdCBhZGRyZXNzIHR5cGUgKi8KIAlzaG9ydAloX2xlbmd0aDsJLyog
bGVuZ3RoIG9mIGFkZHJlc3MgKi8KLS0gCjIuNDkuMC53aW5kb3dzLjEKCg==
--000000000000e18d4f063467a4de--
