Return-Path: <cygwin-patches-return-8816-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 112679 invoked by alias); 6 Aug 2017 22:26:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112005 invoked by uid 89); 6 Aug 2017 22:26:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: limerock03.mail.cornell.edu
Received: from limerock03.mail.cornell.edu (HELO limerock03.mail.cornell.edu) (128.84.13.243) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 06 Aug 2017 22:26:44 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock03.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v76MQgsc007512	for <cygwin-patches@cygwin.com>; Sun, 6 Aug 2017 18:26:42 -0400
Received: from [192.168.0.15] (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v76MQfEY017573	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Sun, 6 Aug 2017 18:26:42 -0400
Subject: Re: Define sigsetjmp/siglongjmp only if __POSIX_VISIBLE
To: cygwin-patches@cygwin.com
References: <def00c5d-15d9-237e-8579-371eebdfc5fe@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <410ce828-c054-3ad8-dfaa-a7a3ab4819a8@cornell.edu>
Date: Thu, 17 Aug 2017 01:41:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <def00c5d-15d9-237e-8579-371eebdfc5fe@cornell.edu>
Content-Type: multipart/mixed; boundary="------------90378C32982F41F30A03E0CA"
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00018.txt.bz2

This is a multi-part message in MIME format.
--------------90378C32982F41F30A03E0CA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 400

On 8/6/2017 5:46 PM, Ken Brown wrote:
> The attached patch fixes the issue reported here:
> 
>    https://cygwin.com/ml/cygwin/2017-08/msg00060.html
> 
> I'm not sure if I was correct in including RTEMS or if this should have 
> been Cygwin only.  If the former, I probably should have sent this to 
> the Newlib list.

Sorry, I accidentally made a whitespace change.  Corrected patch attached.

Ken

--------------90378C32982F41F30A03E0CA
Content-Type: text/plain; charset=UTF-8;
 name="0001-Define-sigsetjmp-siglongjmp-only-if-__POSIX_VISIBLE.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Define-sigsetjmp-siglongjmp-only-if-__POSIX_VISIBLE.pat";
 filename*1="ch"
Content-length: 1273

RnJvbSA1MGNjZWFmMGUxZDMzZGRmM2ZjNjIzOTliYzE1NzYxYWY5M2ZhMjlk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogU3VuLCA2IEF1ZyAyMDE3IDE3OjQw
OjQzIC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gRGVmaW5lIHNpZ3NldGptcC9z
aWdsb25nam1wIG9ubHkgaWYgX19QT1NJWF9WSVNJQkxFCgotLS0KIG5ld2xp
Yi9saWJjL2luY2x1ZGUvbWFjaGluZS9zZXRqbXAuaCB8IDQgKystLQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9uZXdsaWIvbGliYy9pbmNsdWRlL21hY2hpbmUvc2V0
am1wLmggYi9uZXdsaWIvbGliYy9pbmNsdWRlL21hY2hpbmUvc2V0am1wLmgK
aW5kZXggMmI0ZGQ4YjkxLi5lNmMzMTQyZWQgMTAwNjQ0Ci0tLSBhL25ld2xp
Yi9saWJjL2luY2x1ZGUvbWFjaGluZS9zZXRqbXAuaAorKysgYi9uZXdsaWIv
bGliYy9pbmNsdWRlL21hY2hpbmUvc2V0am1wLmgKQEAgLTM2OCw3ICszNjgs
NyBAQCB0eXBlZGVmCWludCBqbXBfYnVmW19KQkxFTl07CiAKIF9FTkRfU1RE
X0MKIAotI2lmIGRlZmluZWQoX19DWUdXSU5fXykgfHwgZGVmaW5lZChfX3J0
ZW1zX18pCisjaWYgKGRlZmluZWQoX19DWUdXSU5fXykgfHwgZGVmaW5lZChf
X3J0ZW1zX18pKSAmJiBfX1BPU0lYX1ZJU0lCTEUKICNpbmNsdWRlIDxzaWdu
YWwuaD4KIAogI2lmZGVmIF9fY3BsdXNwbHVzCkBAIC00NTAsNCArNDUwLDQg
QEAgZXh0ZXJuIGludCBfc2V0am1wIChqbXBfYnVmKTsKICNpZmRlZiBfX2Nw
bHVzcGx1cwogfQogI2VuZGlmCi0jZW5kaWYgLyogX19DWUdXSU5fXyBvciBf
X3J0ZW1zX18gKi8KKyNlbmRpZiAvKiAoX19DWUdXSU5fXyBvciBfX3J0ZW1z
X18pIGFuZCBfX1BPU0lYX1ZJU0lCTEUgKi8KLS0gCjIuMTMuMgoK

--------------90378C32982F41F30A03E0CA--
