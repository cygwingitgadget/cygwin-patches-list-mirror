Return-Path: <cygwin-patches-return-7677-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18102 invoked by alias); 11 Jun 2012 20:58:54 -0000
Received: (qmail 18090 invoked by uid 22791); 11 Jun 2012 20:58:53 -0000
X-SWARE-Spam-Status: No, hits=-4.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-vb0-f43.google.com (HELO mail-vb0-f43.google.com) (209.85.212.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 11 Jun 2012 20:58:40 +0000
Received: by vbbfq11 with SMTP id fq11so2681868vbb.2        for <cygwin-patches@cygwin.com>; Mon, 11 Jun 2012 13:58:39 -0700 (PDT)
Received: by 10.52.19.232 with SMTP id i8mr11250065vde.38.1339448319559;        Mon, 11 Jun 2012 13:58:39 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id g10sm21746135vdk.2.2012.06.11.13.58.38        (version=TLSv1/SSLv3 cipher=OTHER);        Mon, 11 Jun 2012 13:58:38 -0700 (PDT)
Message-ID: <4FD65BFC.1060900@users.sourceforge.net>
Date: Mon, 11 Jun 2012 20:58:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] regex: fix for kernel cross-compile
Content-Type: multipart/mixed; boundary="------------070909020108070705050906"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q2/txt/msg00046.txt.bz2

This is a multi-part message in MIME format.
--------------070909020108070705050906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 500

The attached patch fixes the issue I reported previously:

http://cygwin.com/ml/cygwin/2012-06/msg00161.html

According to POSIX[1], a '|' following '(' produces undefined results. 
However, glibc and PCRE both allow the regex in question, so there is 
basis for omitting this error.  I believe this is the last issue which 
needs to be fixed within Cygwin to allow cross-compiling the Linux kernel.


Yaakov

[1] 
http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_04_03

--------------070909020108070705050906
Content-Type: application/x-itunes-itlp;
 name="regex-kernel-relocs.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="regex-kernel-relocs.patch"
Content-length: 1078

MjAxMi0wNi0xMSAgWWFha292IFNlbGtvd2l0eiAgPHlzZWxrb3dpdHpALi4u
PgoKCSogcmVnZXgvcmVnY29tcC5jIChwX2VyZSk6IEFsbG93IHZlcnRpY2Fs
LWxpbmUgZm9sbG93aW5nCglsZWZ0LXBhcmVudGhlc2lzIGluIEVSRSwgYXMg
aW4gZ2xpYmMuCgpJbmRleDogcmVnZXgvcmVnY29tcC5jCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3ln
d2luL3JlZ2V4L3JlZ2NvbXAuYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4x
MwpkaWZmIC11IC1wIC1yMS4xMyByZWdjb21wLmMKLS0tIHJlZ2V4L3JlZ2Nv
bXAuYwkxMyBGZWIgMjAxMiAxMzoxMjozNyAtMDAwMAkxLjEzCisrKyByZWdl
eC9yZWdjb21wLmMJMTEgSnVuIDIwMTIgMjA6NDE6MTUgLTAwMDAKQEAgLTMy
NCw3ICszMjQsMTAgQEAgcF9lcmUoc3RydWN0IHBhcnNlICpwLAogCQljb25j
ID0gSEVSRSgpOwogCQl3aGlsZSAoTU9SRSgpICYmIChjID0gUEVFSygpKSAh
PSAnfCcgJiYgYyAhPSBzdG9wKQogCQkJcF9lcmVfZXhwKHApOworI2lmbmRl
ZiBfX0NZR1dJTl9fCisJCS8qIHVuZGVmaW5lZCBiZWhhdmlvdXIgYWNjb3Jk
aW5nIHRvIFBPU0lYOyBhbGxvd2VkIGJ5IGdsaWJjICovCiAJCSh2b2lkKVJF
UVVJUkUoSEVSRSgpICE9IGNvbmMsIFJFR19FTVBUWSk7CS8qIHJlcXVpcmUg
bm9uZW1wdHkgKi8KKyNlbmRpZgogCiAJCWlmICghRUFUKCd8JykpCiAJCQli
cmVhazsJCS8qIE5PVEUgQlJFQUsgT1VUICovCg==

--------------070909020108070705050906--
