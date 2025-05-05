Return-Path: <SRS0=NWjx=XV=gmail.com=pavlov.pavel@sourceware.org>
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by sourceware.org (Postfix) with ESMTPS id E76EA3857BB6
	for <cygwin-patches@cygwin.com>; Mon,  5 May 2025 20:28:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E76EA3857BB6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E76EA3857BB6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746476903; cv=none;
	b=qw3CgbtaJug0ONkzkHpPqHv9874h37RtWR/S3lD25kXKNrxoEZb3fRJ/XC7T55vUPzYE5tVcwZUiP0xh5gXwclXblWR+fvtYg3gollztg3+5cQ1qGMmjbxaB0mDyfxgPDiHvv5eUf9L7bl8Bl074mcKGcBYWNMNphcy8xpRoE8I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746476903; c=relaxed/simple;
	bh=yqKvkw9BhjPpHLDl20LknvFeV9/+25ch8kF9BOUpJNw=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=Jq8ZOCLcQ/d68PC+9pxD78EWpKWfccfX0ubUhr379W1N+Cq/iphIV0wNuiGUsqjxUrrrJwmmtP/1Dh8DAhjve6bnJlCLmO+z8pyrTlS9ZWx88XWTTFPXj7UjfxclCTg3HDAwLxnkUCegtipKuPa6QXEHj4G8j1d1pSwciWhVrq0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E76EA3857BB6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iM96Hlve
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so6119901e87.2
        for <cygwin-patches@cygwin.com>; Mon, 05 May 2025 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746476899; x=1747081699; darn=cygwin.com;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bgmXdbjXf2RQD7EMsEpcxxjylD8bkUnoiaO8prPi8zs=;
        b=iM96HlveBXfgNLDLilwdvd9T7i5EgEh5XRKtEnEbACp2QRITpKvBlD1V0AVMYf5qdy
         FXkatSAaZaboyxFssthHPHhIN+9K3BNnbRjvElkz3RGGBByMOQ8pSKHc0Wj4RZeSCnX0
         b5E38rXDf4zxkKZOqna1x6u6MN528j956ahZfpntjDONY2KPKS+8AInkafMt7hskq/2c
         UYTnHEEilK8SmeK4yZWZn+XH7uJxwZecyBuoUgVX2Eqrd3+oSdg+Sr0/+VBsI8HrLNEp
         1C7xzOwnPyosJHqsnZmeLnJ0wqxPZynIQigvcWP2t6K7AR/hw4icA+NQwlivnQI7BVxC
         puHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746476899; x=1747081699;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgmXdbjXf2RQD7EMsEpcxxjylD8bkUnoiaO8prPi8zs=;
        b=i5ASl6LTGXvfyoGSFK+tZAFTZ5Hatvu1ocDXMVE2KjAZc+Mw5VjZWeCw8G99fT0nAp
         CYAqTBT927xhg1R+pvkiqNg51ryEVoVC5XEVmS/10L1v3+pML27BpkoJHgKsCYiWMr/m
         0EEEmkZigHXhbqKvfd7gQR17w3uP/lsjA9pft18tfvvh1tHzga9WSF1btaT456mJaPY8
         OR9/ayoB34gFkYf3a4GnNET8LdrXEeD0aODsSXIELXRUJAbH+c1rI4lK9pRjuSNr1cHK
         z5NOKE07XbwIog45AMxGJwNqedI1bGv+1bNkYR7JvMocGdTBwHgcaMbqtOc0kF4OSoOW
         4vNA==
X-Gm-Message-State: AOJu0Yy2uE68NDrKK3jvbAQ7Nd8HJGfmp++7Ntcx7P/GBOorlqohq4a2
	GO1gQjoswOL7yz4+8Nvt5pefdqzF34/MQ37IzScBv1LrU8SyNID6b4gHiRC1cFCLiCjZbmLRv0N
	5Eri0dug+pjrpvYBFIZJT5GEHJ1RV7EUh6qk=
X-Gm-Gg: ASbGncshxulbmnz4AmPnRRaqTUXMXynwA3PtkeAHfKbrYOxzLgbsbihv+S8pe3++Aqk
	UEkXBvXfOOTd1z7JhYMStSiVkv4HFM7NY3GnXIK8MzcqrS7q78H8jjrppHwAFUELsHgt3nuBZP7
	HxheP1Ia8bx6KMNj7fVg==
X-Google-Smtp-Source: AGHT+IEM1eAt1ckUXPRTbK7Jg5Ec8uj+DQec2ASht/i1tHd8VHP/zlJ2R8smdcLhDjW5szJp136q0o0y13QWO5Z+jJU=
X-Received: by 2002:ac2:5687:0:b0:548:de7f:b3be with SMTP id
 2adb3069b0e04-54f9efc616emr2569106e87.21.1746476899172; Mon, 05 May 2025
 13:28:19 -0700 (PDT)
MIME-Version: 1.0
From: Pavel Pavlov <pavlov.pavel@gmail.com>
Date: Mon, 5 May 2025 22:28:04 +0200
X-Gm-Features: ATxdqUFowVUNjf_3u8cSfHL9WzqsIo344Plcjfaqb8lXETEPZFvdgyOeqjxgh2o
Message-ID: <CAG_s-qrP8XqJpuX4sEWOAS1xKHKBF=51325wTFE4-AmgKb-khQ@mail.gmail.com>
Subject: netdb.h: remove const from hostent.h_name
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary="0000000000002f4a0b06346957a9"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--0000000000002f4a0b06346957a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The patch is self explanatory. This fixes errors/waring from hostent::h_nam=
e:

```
[6/14] Building C object CMakeFiles/http.dir/ext/c-ares/libcares.c.o
In file included from /d/work-pps/ext/c-ares/libcares.c:26:
/d/work-pps/ext/c-ares/src/lib/ares_free_hostent.c: In
function =E2=80=98ares_free_hostent=E2=80=99:
/d/work-pps/backtest-engine/ext/c-ares/src/lib/ares_free_hostent.c:41:17:
warning: passing argument 1 of =E2=80=98ares_free=E2=80=99 discards =E2=80=
=98const=E2=80=99 qualifier
from pointer target type [-Wdiscarded-qualifiers]
   41 |   ares_free(host->h_name);
      |             ~~~~^~~~~~~~
```

The patches to the Cygwin sources are under the 2-clause BSD license.

--0000000000002f4a0b06346957a9
Content-Type: application/octet-stream; 
	name="0001-Cygwin-netdb.h-remove-const-from-hostent.h_name.patch"
Content-Disposition: attachment; 
	filename="0001-Cygwin-netdb.h-remove-const-from-hostent.h_name.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mabj81c80>
X-Attachment-Id: f_mabj81c80

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
--0000000000002f4a0b06346957a9--
