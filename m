Return-Path: <cygwin-patches-return-7921-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17324 invoked by alias); 22 Dec 2013 00:39:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17311 invoked by uid 89); 22 Dec 2013 00:39:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_05,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-wg0-f41.google.com
Received: from mail-wg0-f41.google.com (HELO mail-wg0-f41.google.com) (74.125.82.41) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Sun, 22 Dec 2013 00:39:30 +0000
Received: by mail-wg0-f41.google.com with SMTP id y10so8145331wgg.0        for <cygwin-patches@cygwin.com>; Sat, 21 Dec 2013 16:39:27 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.194.48.74 with SMTP id j10mr5739504wjn.41.1387672767368; Sat, 21 Dec 2013 16:39:27 -0800 (PST)
Received: by 10.227.143.73 with HTTP; Sat, 21 Dec 2013 16:39:27 -0800 (PST)
Date: Sun, 22 Dec 2013 00:39:00 -0000
Message-ID: <CAOYw7dvX5CUc_zKyy4R8CxEe2=3fqCFUCpAnAvHZOzRU5o9Bdg@mail.gmail.com>
Subject: [PATCH] Fix some debug string format specifiers.
From: Ray Donnelly <mingw.android@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=047d7ba975c85e202b04ee14be54
X-IsSubscribed: yes
X-SW-Source: 2013-q4/txt/msg00017.txt.bz2


--047d7ba975c85e202b04ee14be54
Content-Type: text/plain; charset=ISO-8859-1
Content-length: 63

I hope patches generated with git are OK?

Best regards,

Ray.

--047d7ba975c85e202b04ee14be54
Content-Type: application/octet-stream; 
	name="0001-winsup-cygwin-gmon.c-_mcleanup-Fix-some-debug-string.patch"
Content-Disposition: attachment; 
	filename="0001-winsup-cygwin-gmon.c-_mcleanup-Fix-some-debug-string.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hphkhwry0
Content-length: 1469

RnJvbSBkNWUwNmM0MGJhMzBkM2Y4ZWJiZGNiOTlhODI3OWQwYzM4ZGI0NTZh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBSYXkgRG9ubmVsbHkg
PG1pbmd3LmFuZHJvaWRAZ21haWwuY29tPgpEYXRlOiBUaHUsIDE5IERlYyAy
MDEzIDE5OjAxOjUzICswMDAwClN1YmplY3Q6IFtQQVRDSCAxLzNdICogd2lu
c3VwL2N5Z3dpbi9nbW9uLmMgKF9tY2xlYW51cCk6IEZpeCBzb21lIGRlYnVn
IHN0cmluZwogZm9ybWF0IHNwZWNpZmllcnMKCi0tLQogd2luc3VwL2N5Z3dp
bi9nbW9uLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5
Z3dpbi9nbW9uLmMgYi93aW5zdXAvY3lnd2luL2dtb24uYwppbmRleCA5NmIx
MTg5Li4xNmYxMDM0IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2dtb24u
YworKysgYi93aW5zdXAvY3lnd2luL2dtb24uYwpAQCAtMjMzLDcgKzIzMyw3
IEBAIF9tY2xlYW51cCh2b2lkKQogCQlwZXJyb3IoIm1jb3VudDogZ21vbi5s
b2ciKTsKIAkJcmV0dXJuOwogCX0KLQlsZW4gPSBzcHJpbnRmKGRidWYsICJb
bWNsZWFudXAxXSBrY291bnQgMHgleCBzc2l6ICVkXG4iLAorCWxlbiA9IHNw
cmludGYoZGJ1ZiwgIlttY2xlYW51cDFdIGtjb3VudCAweCVwIHNzaXogJXpk
XG4iLAogCSAgICBwLT5rY291bnQsIHAtPmtjb3VudHNpemUpOwogCXdyaXRl
KGxvZywgZGJ1ZiwgbGVuKTsKICNlbmRpZgpAQCAtMjU2LDcgKzI1Niw3IEBA
IF9tY2xlYW51cCh2b2lkKQogCQkgICAgIHRvaW5kZXggPSBwLT50b3NbdG9p
bmRleF0ubGluaykgewogI2lmZGVmIERFQlVHCiAJCQlsZW4gPSBzcHJpbnRm
KGRidWYsCi0JCQkiW21jbGVhbnVwMl0gZnJvbXBjIDB4JXggc2VsZnBjIDB4
JXggY291bnQgJWRcbiIgLAorCQkJIlttY2xlYW51cDJdIGZyb21wYyAweCV6
ZCBzZWxmcGMgMHglemQgY291bnQgJXpkXG4iICwKIAkJCQlmcm9tcGMsIHAt
PnRvc1t0b2luZGV4XS5zZWxmcGMsCiAJCQkJcC0+dG9zW3RvaW5kZXhdLmNv
dW50KTsKIAkJCXdyaXRlKGxvZywgZGJ1ZiwgbGVuKTsKLS0gCjEuOC41LjIK
Cg==

--047d7ba975c85e202b04ee14be54--
