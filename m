Return-Path: <cygwin-patches-return-8058-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 393 invoked by alias); 19 Feb 2015 13:21:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 379 invoked by uid 89); 19 Feb 2015 13:21:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out4-smtp.messagingengine.com
Received: from out4-smtp.messagingengine.com (HELO out4-smtp.messagingengine.com) (66.111.4.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 19 Feb 2015 13:21:53 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])	by mailout.nyi.internal (Postfix) with ESMTP id 0D2B320CFD	for <cygwin-patches@cygwin.com>; Thu, 19 Feb 2015 08:21:52 -0500 (EST)
Received: from frontend2 ([10.202.2.161])  by compute6.internal (MEProxy); Thu, 19 Feb 2015 08:21:52 -0500
Received: from [192.168.1.102] (unknown [86.179.113.106])	by mail.messagingengine.com (Postfix) with ESMTPA id AB86768008C	for <cygwin-patches@cygwin.com>; Thu, 19 Feb 2015 08:21:51 -0500 (EST)
Message-ID: <54E5E36E.7060407@dronecode.org.uk>
Date: Thu, 19 Feb 2015 13:21:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: [PATCH] Compile sigfe.s with CFLAGS
Content-Type: multipart/mixed; boundary="------------080304090902080301020909"
X-SW-Source: 2015-q1/txt/msg00013.txt.bz2

This is a multi-part message in MIME format.
--------------080304090902080301020909
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 127


CFLAGS isn't used when compiling the generated file sigfe.s, so if that 
contains -g, it lacks source debugging information.


--------------080304090902080301020909
Content-Type: text/plain; charset=windows-1252;
 name="sigfe_cflags.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sigfe_cflags.patch"
Content-length: 773

MjAxNS0wMi0xOSAgSm9uIFRVUk5FWSAgPGpvbi50dXJuZXlAZHJvbmVjb2Rl
Lm9yZy51az4KCgkqIE1ha2VmaWxlLmluIChzaWdmZS5vKTogVXNlIENGTEFH
Uy4KCkluZGV4OiBjeWd3aW4vTWFrZWZpbGUuaW4KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4v
TWFrZWZpbGUuaW4sdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMjc4CmRpZmYg
LXUgLXUgLXAgLXIxLjI3OCBNYWtlZmlsZS5pbgotLS0gY3lnd2luL01ha2Vm
aWxlLmluCTI4IEphbiAyMDE1IDExOjQzOjA2IC0wMDAwCTEuMjc4CisrKyBj
eWd3aW4vTWFrZWZpbGUuaW4JMTkgRmViIDIwMTUgMTM6MTI6MTEgLTAwMDAK
QEAgLTcxMCw3ICs3MTAsNyBAQCBzaWdmZS5zOiAkKERFRl9GSUxFKQogCVsg
LXMgJEAgXSAmJiB0b3VjaCAkQAogCiBzaWdmZS5vOiBzaWdmZS5zCi0JJChD
QykgLWMgLW8gJEAgJDwKKwkkKENDKSAke0NGTEFHU30gLWMgLW8gJEAgJDwK
IAogY3RhZ3M6IENUQUdTCiB0YWdzOiAgQ1RBR1MK

--------------080304090902080301020909--
