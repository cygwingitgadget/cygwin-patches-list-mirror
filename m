Return-Path: <cygwin-patches-return-8019-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27452 invoked by alias); 23 Sep 2014 16:01:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27328 invoked by uid 89); 23 Sep 2014 16:01:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: mailout08.t-online.de
Received: from mailout08.t-online.de (HELO mailout08.t-online.de) (194.25.134.20) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 23 Sep 2014 16:01:28 +0000
Received: from fwd41.aul.t-online.de (fwd41.aul.t-online.de [172.20.27.139])	by mailout08.t-online.de (Postfix) with SMTP id 8B97443E17D	for <cygwin-patches@cygwin.com>; Tue, 23 Sep 2014 18:01:25 +0200 (CEST)
Received: from [192.168.2.108] (VyCPhoZCrhxROqXg8-1j3QLn4-f4Um2lArM0huoWl7zzmAdDw5z3cTnLzs+CKktwRD@[79.224.105.159]) by fwd41.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-SHA encrypted)	esmtp id 1XWSWm-27vtqa0; Tue, 23 Sep 2014 18:01:20 +0200
Message-ID: <5421994E.5020808@t-online.de>
Date: Tue, 23 Sep 2014 16:01:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0 SeaMonkey/2.26.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix crash of ffs (0x80000000) on 64 bit
Content-Type: multipart/mixed; boundary="------------080506070709040307040206"
X-IsSubscribed: yes
X-SW-Source: 2014-q3/txt/msg00014.txt.bz2

This is a multi-part message in MIME format.
--------------080506070709040307040206
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 184

This fixes the issue reported here:
https://cygwin.com/ml/cygwin/2014-09/msg00341.html

On 64 bit, i = 0x80000000 results in x = 0xffffffff80000000 due to sign 
extension.

Christian


--------------080506070709040307040206
Content-Type: text/x-patch;
 name="ffs-crash-on-x86_64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ffs-crash-on-x86_64.patch"
Content-length: 726

2014-09-23  Christian Franke  <franke@computer.org>

	* syscall.cc (ffs): Fix crash of ffs (0x80000000) on 64 bit.

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 15ebf49..044e003 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -3847,10 +3847,9 @@ ffs (int i)
       8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,
       8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
     };
-  unsigned long int a;
-  unsigned long int x = i & -i;
+  unsigned x = i & -i;
 
-  a = x <= 0xffff ? (x <= 0xff ? 0 : 8) : (x <= 0xffffff ?  16 : 24);
+  int a = x <= 0xffff ? (x <= 0xff ? 0 : 8) : (x <= 0xffffff ?  16 : 24);
 
   return table[x >> a] + a;
 }

--------------080506070709040307040206--
