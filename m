Return-Path: <cygwin-patches-return-7923-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10329 invoked by alias); 22 Dec 2013 01:03:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10316 invoked by uid 89); 22 Dec 2013 01:03:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-we0-f173.google.com
Received: from mail-we0-f173.google.com (HELO mail-we0-f173.google.com) (74.125.82.173) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Sun, 22 Dec 2013 01:03:13 +0000
Received: by mail-we0-f173.google.com with SMTP id u57so3814902wes.18        for <cygwin-patches@cygwin.com>; Sat, 21 Dec 2013 17:03:09 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.194.89.233 with SMTP id br9mr12964477wjb.15.1387674189788; Sat, 21 Dec 2013 17:03:09 -0800 (PST)
Received: by 10.227.143.73 with HTTP; Sat, 21 Dec 2013 17:03:09 -0800 (PST)
Date: Sun, 22 Dec 2013 01:03:00 -0000
Message-ID: <CAOYw7duMgGSfpxa4OtOPRhY5Mw6q=__shhJxELZ53Ez9_WETRQ@mail.gmail.com>
Subject: [PATCH] Reattach trailing dirsep on existing directories too.
From: Ray Donnelly <mingw.android@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=089e0102fb5c25fad304ee151398
X-IsSubscribed: yes
X-SW-Source: 2013-q4/txt/msg00019.txt.bz2


--089e0102fb5c25fad304ee151398
Content-Type: text/plain; charset=ISO-8859-1
Content-length: 93

I hope this is OK and I've done it in the best place. Please advise if
it needs any changes.

--089e0102fb5c25fad304ee151398
Content-Type: application/octet-stream; 
	name="0003-winsup-cygwin-path.cc-path_conv-check-Reattach-trail.patch"
Content-Disposition: attachment; 
	filename="0003-winsup-cygwin-path.cc-path_conv-check-Reattach-trail.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hphldnc60
Content-length: 1351

RnJvbSA4ZDMwZDQ3YWU2YmNhNmI4YWI0ZGE2ZGY2MjYxNmFiOTUyMWE0OGQx
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBSYXkgRG9ubmVsbHkg
PG1pbmd3LmFuZHJvaWRAZ21haWwuY29tPgpEYXRlOiBUaHUsIDE5IERlYyAy
MDEzIDE5OjA0OjE1ICswMDAwClN1YmplY3Q6IFtQQVRDSCAzLzNdICogd2lu
c3VwL2N5Z3dpbi9wYXRoLmNjIChwYXRoX2NvbnY6OmNoZWNrKTogUmVhdHRh
Y2gKIHRyYWlsaW5nIGRpcnNlcCBvbiBleGlzdGluZyBkaXJlY3RvcmllcyB0
b28gKHByZXZpb3VzbHkgdGhpcyB3b3VsZCBvbmx5CiBoYXBwZW4gdG8gbm9u
LWV4aXN0aW5nIG9uZXMpLgoKLS0tCiB3aW5zdXAvY3lnd2luL3BhdGguY2Mg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3BhdGguY2Mg
Yi93aW5zdXAvY3lnd2luL3BhdGguY2MKaW5kZXggMDQ3ODEwZi4uMjRlMmMw
MSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9wYXRoLmNjCisrKyBiL3dp
bnN1cC9jeWd3aW4vcGF0aC5jYwpAQCAtMTA3NSw3ICsxMDc1LDcgQEAgb3V0
OgogICAgIH0KICAgZWxzZSBpZiAoIW5lZWRfZGlyZWN0b3J5IHx8IGVycm9y
KQogICAgIC8qIG5vdGhpbmcgdG8gZG8gKi87Ci0gIGVsc2UgaWYgKGZpbGVh
dHRyID09IElOVkFMSURfRklMRV9BVFRSSUJVVEVTKQorICBlbHNlIGlmIChm
aWxlYXR0ciA9PSBJTlZBTElEX0ZJTEVfQVRUUklCVVRFUyB8fCAoKGZpbGVh
dHRyICYgRklMRV9BVFRSSUJVVEVfRElSRUNUT1JZKSAmJiAhY29tcG9uZW50
KSkKICAgICBzdHJjYXQgKG1vZGlmaWFibGVfcGF0aCAoKSwgIlxcIik7IC8q
IFJlYXR0YWNoIHRyYWlsaW5nIGRpcnNlcCBpbiBuYXRpdmUgcGF0aC4gKi8K
ICAgZWxzZSBpZiAoZmlsZWF0dHIgJiBGSUxFX0FUVFJJQlVURV9ESVJFQ1RP
UlkpCiAgICAgcGF0aF9mbGFncyAmPSB+UEFUSF9TWU1MSU5LOwotLSAKMS44
LjUuMgoK

--089e0102fb5c25fad304ee151398--
