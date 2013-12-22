Return-Path: <cygwin-patches-return-7922-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17946 invoked by alias); 22 Dec 2013 00:40:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17933 invoked by uid 89); 22 Dec 2013 00:40:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-we0-f182.google.com
Received: from mail-we0-f182.google.com (HELO mail-we0-f182.google.com) (74.125.82.182) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Sun, 22 Dec 2013 00:40:23 +0000
Received: by mail-we0-f182.google.com with SMTP id q59so3882534wes.27        for <cygwin-patches@cygwin.com>; Sat, 21 Dec 2013 16:40:21 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.180.85.202 with SMTP id j10mr13237136wiz.35.1387672821061; Sat, 21 Dec 2013 16:40:21 -0800 (PST)
Received: by 10.227.143.73 with HTTP; Sat, 21 Dec 2013 16:40:20 -0800 (PST)
Date: Sun, 22 Dec 2013 00:40:00 -0000
Message-ID: <CAOYw7dvP64FFXUJS60ixUqj2jr01Dzf3YrchyR79m7AQEb8TKA@mail.gmail.com>
Subject: [PATCH] Fix potentially uninitialized variable p
From: Ray Donnelly <mingw.android@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=f46d04428ebe90745904ee14c174
X-IsSubscribed: yes
X-SW-Source: 2013-q4/txt/msg00018.txt.bz2


--f46d04428ebe90745904ee14c174
Content-Type: text/plain; charset=ISO-8859-1
Content-length: 1



--f46d04428ebe90745904ee14c174
Content-Type: application/octet-stream; 
	name="0002-winsup-cygwin-strace.cc-strace-vsprntf-Fix-potential.patch"
Content-Disposition: attachment; 
	filename="0002-winsup-cygwin-strace.cc-strace-vsprntf-Fix-potential.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hphkk98t0
Content-length: 1131

RnJvbSBmZDc4ZDlmNjg3NmMzYTk2YTM1ZGUwZTE5ZjBmMGVhYThiNmY5OWQ1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBSYXkgRG9ubmVsbHkg
PG1pbmd3LmFuZHJvaWRAZ21haWwuY29tPgpEYXRlOiBUaHUsIDE5IERlYyAy
MDEzIDE5OjAzOjIzICswMDAwClN1YmplY3Q6IFtQQVRDSCAyLzNdICogd2lu
c3VwL2N5Z3dpbi9zdHJhY2UuY2MgKHN0cmFjZTo6dnNwcm50Zik6IEZpeAog
cG90ZW50aWFsbHkgdW5pbml0aWFsaXplZCB2YXJpYWJsZSBwCgotLS0KIHdp
bnN1cC9jeWd3aW4vc3RyYWNlLmNjIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
d2luc3VwL2N5Z3dpbi9zdHJhY2UuY2MgYi93aW5zdXAvY3lnd2luL3N0cmFj
ZS5jYwppbmRleCAzYzczYTcxLi5mNTE1NjZmIDEwMDY0NAotLS0gYS93aW5z
dXAvY3lnd2luL3N0cmFjZS5jYworKysgYi93aW5zdXAvY3lnd2luL3N0cmFj
ZS5jYwpAQCAtMTU2LDcgKzE1Niw3IEBAIHN0cmFjZTo6dnNwcm50ZiAoY2hh
ciAqYnVmLCBjb25zdCBjaGFyICpmdW5jLCBjb25zdCBjaGFyICppbmZtdCwg
dmFfbGlzdCBhcCkKICAgICAgIGVsc2UgaWYgKF9fcHJvZ25hbWUpCiAJc3lz
X21ic3Rvd2NzKHBuID0gcHJvZ25hbWUsIE5UX01BWF9QQVRILCBfX3Byb2du
YW1lKTsKIAotICAgICAgUFdDSEFSIHA7CisgICAgICBQV0NIQVIgcCA9IE5V
TEw7CiAgICAgICBpZiAoIXBuKQogCUdldE1vZHVsZUZpbGVOYW1lVyAoTlVM
TCwgcG4gPSBwcm9nbmFtZSwgc2l6ZW9mIChwcm9nbmFtZSkpOwogICAgICAg
aWYgKCFwbikKLS0gCjEuOC41LjIKCg==

--f46d04428ebe90745904ee14c174--
