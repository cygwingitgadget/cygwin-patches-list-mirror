Return-Path: <cygwin-patches-return-8599-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61439 invoked by alias); 14 Jul 2016 15:38:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61424 invoked by uid 89); 14 Jul 2016 15:38:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=ray, states, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-wm0-f49.google.com
Received: from mail-wm0-f49.google.com (HELO mail-wm0-f49.google.com) (74.125.82.49) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Thu, 14 Jul 2016 15:37:59 +0000
Received: by mail-wm0-f49.google.com with SMTP id p190so5188606wmp.1        for <cygwin-patches@cygwin.com>; Thu, 14 Jul 2016 08:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;        bh=SIM0t+WPXJi72i7iTbY/rzp2PW1HJhGqEuDFkEjbxQs=;        b=EXySyCH21KszIMt2SYA8PUC07gyC3/wIkw+ME+2K5C+2tea4cHV/wBfYglnGwrTMaU         4kcoZ8vTy2luOlIejHlT5tuugYXCR81Mh/giVvpDbfIuQ9MzwlLdw8Ibfh/yssAk66L+         weXYDK1/wYkBIpIkzU2TiFonVr9BYR01NekHheI15PhVkoP0vZuLN5VH/FdgsDZedHqB         Tu9NntzpeumMZKYCTsL+ZIEY11e/zxQu8T7JE7b4xlojYdUXbaNu27OaAqNxj5aYgdrG         NYs8MhHpVNp8CyUEpEdIevJj3+7yeLlmIEeuvBy5gi+9/vfaEphq2dB/9g4a58dslx7b         nAQg==
X-Gm-Message-State: ALyK8tLKC0Oc+xAaXkD/TbTU3E6F/EVaf5Bp72Zi8VN61sZbnjBL1a4IW4yp+SYrNNxRM8nV5LHp2fHujER1cA==
X-Received: by 10.28.216.67 with SMTP id p64mr17900797wmg.56.1468510676183; Thu, 14 Jul 2016 08:37:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.112.10 with HTTP; Thu, 14 Jul 2016 08:37:55 -0700 (PDT)
From: Ray Donnelly <mingw.android@gmail.com>
Date: Thu, 14 Jul 2016 15:38:00 -0000
Message-ID: <CAOYw7dtjewWMjXR2iO5454smDBxDKkLP9HirZzT4hPqMzZdpeQ@mail.gmail.com>
Subject: [PATCH 01/01] machine/_types.h: __blkcnt_t should be signed
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=001a11469630346c5305379a494c
X-IsSubscribed: yes
X-SW-Source: 2016-q3/txt/msg00007.txt.bz2


--001a11469630346c5305379a494c
Content-Type: text/plain; charset=UTF-8
Content-length: 393

Hi,

Please review and consider applying the attached patch. The commit message is:

[1] states: "blkcnt_t and off_t shall be signed integer types."
This causes pacman to fail when the size requirement
of the net update operation is negative, instead it
calculated a huge positive number.

[1] http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_types.h.html

--

Best regards,

Ray.

--001a11469630346c5305379a494c
Content-Type: application/octet-stream; 
	name="0001-machine-_types.h-__blkcnt_t-should-be-signed.patch"
Content-Disposition: attachment; 
	filename="0001-machine-_types.h-__blkcnt_t-should-be-signed.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iqmha3vo0
Content-length: 1436

RnJvbSBjYzJiNGQ1MzI2ZGRmZTUyODQ4NjNlMmQ5ZDk4YWFjMDA4YTEyZDIx
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBSYXkgRG9ubmVsbHkg
PG1pbmd3LmFuZHJvaWRAZ21haWwuY29tPgpEYXRlOiBUaHUsIDE0IEp1bCAy
MDE2IDEyOjQwOjQ3ICswMTAwClN1YmplY3Q6IFtQQVRDSCAyNC8yNF0gbWFj
aGluZS9fdHlwZXMuaDogX19ibGtjbnRfdCBzaG91bGQgYmUgc2lnbmVkCgpb
MV0gc3RhdGVzOiAiYmxrY250X3QgYW5kIG9mZl90IHNoYWxsIGJlIHNpZ25l
ZCBpbnRlZ2VyIHR5cGVzLiIKClRoaXMgY2F1c2VzIHBhY21hbiB0byBmYWls
IHdoZW4gdGhlIHNpemUgcmVxdWlyZW1lbnQKb2YgdGhlIG5ldCB1cGRhdGUg
b3BlcmF0aW9uIGlzIG5lZ2F0aXZlLCBpbnN0ZWFkIGl0CmNhbGN1bGF0ZWQg
YSBodWdlIHBvc2l0aXZlIG51bWJlci4KClsxXSBodHRwOi8vcHVicy5vcGVu
Z3JvdXAub3JnL29ubGluZXB1YnMvOTY5OTkxOTc5OS9iYXNlZGVmcy9zeXNf
dHlwZXMuaC5odG1sCi0tLQogd2luc3VwL2N5Z3dpbi9pbmNsdWRlL21hY2hp
bmUvX3R5cGVzLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3ln
d2luL2luY2x1ZGUvbWFjaGluZS9fdHlwZXMuaCBiL3dpbnN1cC9jeWd3aW4v
aW5jbHVkZS9tYWNoaW5lL190eXBlcy5oCmluZGV4IGU2ZWQzMTMuLjdlNjM2
ZjggMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9tYWNoaW5l
L190eXBlcy5oCisrKyBiL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9tYWNoaW5l
L190eXBlcy5oCkBAIC0xNCw3ICsxNCw3IEBAIHR5cGVkZWYgX191aW50MzJf
dCBfX2lubzMyX3Q7CiAjZW5kaWYKIAogI2RlZmluZSBfX21hY2hpbmVfYmxr
Y250X3RfZGVmaW5lZAotdHlwZWRlZiBfX3VpbnQ2NF90IF9fYmxrY250X3Q7
Cit0eXBlZGVmIF9faW50NjRfdCBfX2Jsa2NudF90OwogCiAjZGVmaW5lIF9f
bWFjaGluZV9ibGtzaXplX3RfZGVmaW5lZAogdHlwZWRlZiBfX2ludDMyX3Qg
X19ibGtzaXplX3Q7Ci0tIAoyLjguMgoK

--001a11469630346c5305379a494c--
