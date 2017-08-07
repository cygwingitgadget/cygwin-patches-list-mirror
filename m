Return-Path: <cygwin-patches-return-8815-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 49226 invoked by alias); 6 Aug 2017 21:46:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48654 invoked by uid 89); 6 Aug 2017 21:46:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: limerock04.mail.cornell.edu
Received: from limerock04.mail.cornell.edu (HELO limerock04.mail.cornell.edu) (128.84.13.244) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 06 Aug 2017 21:46:42 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock04.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v76Lkeal032031	for <cygwin-patches@cygwin.com>; Sun, 6 Aug 2017 17:46:40 -0400
Received: from [192.168.0.15] (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v76LkcgX031167	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Sun, 6 Aug 2017 17:46:39 -0400
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: Define sigsetjmp/siglongjmp only if __POSIX_VISIBLE
Message-ID: <def00c5d-15d9-237e-8579-371eebdfc5fe@cornell.edu>
Date: Mon, 07 Aug 2017 09:36:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2EA3451E27F539436BE7EBC7"
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00017.txt.bz2

This is a multi-part message in MIME format.
--------------2EA3451E27F539436BE7EBC7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 272

The attached patch fixes the issue reported here:

   https://cygwin.com/ml/cygwin/2017-08/msg00060.html

I'm not sure if I was correct in including RTEMS or if this should have 
been Cygwin only.  If the former, I probably should have sent this to 
the Newlib list.

Ken

--------------2EA3451E27F539436BE7EBC7
Content-Type: text/plain; charset=UTF-8;
 name="0001-Define-sigsetjmp-siglongjmp-only-if-__POSIX_VISIBLE.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Define-sigsetjmp-siglongjmp-only-if-__POSIX_VISIBLE.pat";
 filename*1="ch"
Content-length: 1570

RnJvbSA0NTA2MDMwN2IxZThlMDZhNTIyY2Q5NWU5NTY3MTU1ZTk4ZGRhODMy
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogU3VuLCA2IEF1ZyAyMDE3IDE3OjQw
OjQzIC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gRGVmaW5lIHNpZ3NldGptcC9z
aWdsb25nam1wIG9ubHkgaWYgX19QT1NJWF9WSVNJQkxFCgotLS0KIG5ld2xp
Yi9saWJjL2luY2x1ZGUvbWFjaGluZS9zZXRqbXAuaCB8IDYgKysrKy0tCiAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL25ld2xpYi9saWJjL2luY2x1ZGUvbWFjaGluZS9z
ZXRqbXAuaCBiL25ld2xpYi9saWJjL2luY2x1ZGUvbWFjaGluZS9zZXRqbXAu
aAppbmRleCAyYjRkZDhiOTEuLmZjNTYzOWYzZCAxMDA2NDQKLS0tIGEvbmV3
bGliL2xpYmMvaW5jbHVkZS9tYWNoaW5lL3NldGptcC5oCisrKyBiL25ld2xp
Yi9saWJjL2luY2x1ZGUvbWFjaGluZS9zZXRqbXAuaApAQCAtMzY4LDcgKzM2
OCw3IEBAIHR5cGVkZWYJaW50IGptcF9idWZbX0pCTEVOXTsKIAogX0VORF9T
VERfQwogCi0jaWYgZGVmaW5lZChfX0NZR1dJTl9fKSB8fCBkZWZpbmVkKF9f
cnRlbXNfXykKKyNpZiAoZGVmaW5lZChfX0NZR1dJTl9fKSB8fCBkZWZpbmVk
KF9fcnRlbXNfXykpICYmIF9fUE9TSVhfVklTSUJMRQogI2luY2x1ZGUgPHNp
Z25hbC5oPgogCiAjaWZkZWYgX19jcGx1c3BsdXMKQEAgLTM3Niw2ICszNzYs
OCBAQCBleHRlcm4gIkMiIHsKICNlbmRpZgogCiAvKiBQT1NJWCBzaWdzZXRq
bXAvc2lnbG9uZ2ptcCBtYWNyb3MgKi8KKworCiAjaWZkZWYgX0pCVFlQRQog
dHlwZWRlZiBfSkJUWVBFIHNpZ2ptcF9idWZbX0pCTEVOKzErKChzaXplb2Yg
KF9KQlRZUEUpICsgc2l6ZW9mIChzaWdzZXRfdCkgLSAxKQogCQkJCSAgICAg
L3NpemVvZiAoX0pCVFlQRSkpXTsKQEAgLTQ1MCw0ICs0NTIsNCBAQCBleHRl
cm4gaW50IF9zZXRqbXAgKGptcF9idWYpOwogI2lmZGVmIF9fY3BsdXNwbHVz
CiB9CiAjZW5kaWYKLSNlbmRpZiAvKiBfX0NZR1dJTl9fIG9yIF9fcnRlbXNf
XyAqLworI2VuZGlmIC8qIChfX0NZR1dJTl9fIG9yIF9fcnRlbXNfXykgYW5k
IF9fUE9TSVhfVklTSUJMRSAqLwotLSAKMi4xMy4yCgo=

--------------2EA3451E27F539436BE7EBC7--
