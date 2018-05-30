Return-Path: <cygwin-patches-return-9061-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128818 invoked by alias); 30 May 2018 20:28:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128792 invoked by uid 89); 30 May 2018 20:28:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=1877, H*MI:edu, HTo:U*cygwin-patches
X-HELO: limerock04.mail.cornell.edu
Received: from limerock04.mail.cornell.edu (HELO limerock04.mail.cornell.edu) (128.84.13.244) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 30 May 2018 20:28:38 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite3.serverfarm.cornell.edu [10.16.197.8])	by limerock04.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w4UKSau2024321	for <cygwin-patches@cygwin.com>; Wed, 30 May 2018 16:28:36 -0400
Received: from [10.128.159.202] (dhcp-gs-8138.eduroam.cornell.edu [10.128.159.202])	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w4UKSYWS004520	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Wed, 30 May 2018 16:28:35 -0400
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: Fix declaration of pthread_rwlock_* functions
Message-ID: <cfb6a3b0-57f6-8594-0872-db65d371a997@cornell.edu>
Date: Wed, 30 May 2018 20:28:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------506630A15D5EEFFBE244BCFB"
X-PMX-Cornell-Gauge: Gauge=X
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00018.txt.bz2

This is a multi-part message in MIME format.
--------------506630A15D5EEFFBE244BCFB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 155

The attached patch fixes the second problem reported in 
https://cygwin.com/ml/cygwin/2018-05/msg00316.html, though I'm not sure 
it's the right fix.

Ken

--------------506630A15D5EEFFBE244BCFB
Content-Type: text/plain; charset=UTF-8;
 name="0001-Declare-the-pthread_rwlock_-functions-if-__cplusplus.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Declare-the-pthread_rwlock_-functions-if-__cplusplus.pa";
 filename*1="tch"
Content-length: 1383

RnJvbSA0OTQwYmFhYzA4Y2Q5MzM5ZDc3MWQ5ZGI5MGE4ODBjNjE2MTBhZTRj
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogV2VkLCAzMCBNYXkgMjAxOCAxNjox
OTowMSAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIERlY2xhcmUgdGhlIHB0aHJl
YWRfcndsb2NrXyogZnVuY3Rpb25zIGlmIF9fY3BsdXNwbHVzID49CiAyMDE0
MDJMCgpTb21lIG9mIHRoZXNlIGZ1bmN0aW9ucyBhcmUgdXNlZCBpbiB0aGUg
PHNoYXJlZF9tdXRleD4gQysrIGhlYWRlci4KLS0tCiB3aW5zdXAvY3lnd2lu
L2luY2x1ZGUvcHRocmVhZC5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvd2lu
c3VwL2N5Z3dpbi9pbmNsdWRlL3B0aHJlYWQuaCBiL3dpbnN1cC9jeWd3aW4v
aW5jbHVkZS9wdGhyZWFkLmgKaW5kZXggM2RmYzJiYzgwLi5mZWQ2MTY1MzIg
MTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9wdGhyZWFkLmgK
KysrIGIvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL3B0aHJlYWQuaApAQCAtMTg3
LDcgKzE4Nyw3IEBAIGludCBwdGhyZWFkX3NwaW5fdW5sb2NrIChwdGhyZWFk
X3NwaW5sb2NrX3QgKik7CiAjZW5kaWYKIAogLyogUlcgTG9ja3MgKi8KLSNp
ZiBfX1hTSV9WSVNJQkxFID49IDUwMCB8fCBfX1BPU0lYX1ZJU0lCTEUgPj0g
MjAwMTEyCisjaWYgX19YU0lfVklTSUJMRSA+PSA1MDAgfHwgX19QT1NJWF9W
SVNJQkxFID49IDIwMDExMiB8fCBfX2NwbHVzcGx1cyA+PSAyMDE0MDJMCiBp
bnQgcHRocmVhZF9yd2xvY2tfZGVzdHJveSAocHRocmVhZF9yd2xvY2tfdCAq
cndsb2NrKTsKIGludCBwdGhyZWFkX3J3bG9ja19pbml0IChwdGhyZWFkX3J3
bG9ja190ICpyd2xvY2ssIGNvbnN0IHB0aHJlYWRfcndsb2NrYXR0cl90ICph
dHRyKTsKIGludCBwdGhyZWFkX3J3bG9ja19yZGxvY2sgKHB0aHJlYWRfcnds
b2NrX3QgKnJ3bG9jayk7Ci0tIAoyLjE3LjAKCg==

--------------506630A15D5EEFFBE244BCFB--
