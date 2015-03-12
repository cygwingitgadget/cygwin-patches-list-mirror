Return-Path: <cygwin-patches-return-8069-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73995 invoked by alias); 12 Mar 2015 19:47:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73973 invoked by uid 89); 12 Mar 2015 19:47:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.6 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,KAM_FROM_URIBL_PCCC,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=no version=3.3.2
X-HELO: mail-qc0-f172.google.com
Received: from mail-qc0-f172.google.com (HELO mail-qc0-f172.google.com) (209.85.216.172) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Thu, 12 Mar 2015 19:47:55 +0000
Received: by qcwb13 with SMTP id b13so21399607qcw.12        for <cygwin-patches@cygwin.com>; Thu, 12 Mar 2015 12:47:53 -0700 (PDT)
MIME-Version: 1.0
X-Received: by 10.55.31.101 with SMTP id f98mr47084839qkf.34.1426189672920; Thu, 12 Mar 2015 12:47:52 -0700 (PDT)
Received: by 10.96.180.199 with HTTP; Thu, 12 Mar 2015 12:47:52 -0700 (PDT)
In-Reply-To: <20150312192253.GD11522@calimero.vinschen.de>
References: <CABEPuQJGji9Ue5E+j55to-u+VZV_oZ5kqF6piJFjhmMR+OJbhQ@mail.gmail.com>	<20150312192253.GD11522@calimero.vinschen.de>
Date: Thu, 12 Mar 2015 19:47:00 -0000
Message-ID: <CABEPuQ+cpnyy3Ov6XHsLoJT=RDmNZoR7RvWwz0ZoqAieowcYgg@mail.gmail.com>
Subject: Re: braces around scalar initializer for type
From: Alexey Pavlov <alexpux@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2015-q1/txt/msg00024.txt.bz2

2015-03-12 22:22 GMT+03:00 Corinna Vinschen:
> Alexey,
>
> On Mar 12 21:18, Alexey Pavlov wrote:
>> Building MSYS2 runtime I'm get:
>>
>> /build2/msys2-runtime/src/msys2-runtime/winsup/cygwin/net.cc:82:56:
>> error: braces around scalar initializer for type 'u_char {aka unsigned
>> char}'
>>  const struct in6_addr in6addr_any = {{IN6ADDR_ANY_INIT}};
>>
>>                           ^
>> /build2/msys2-runtime/src/msys2-runtime/winsup/cygwin/net.cc:83:66:
>> error: braces around scalar initializer for type 'u_char {aka unsigned
>> char}'
>>  const struct in6_addr in6addr_loopback = {{IN6ADDR_LOOPBACK_INIT}};
>>
>>                                                ^
>> /build2/msys2-runtime/src/msys2-runtime/winsup/cygwin/../Makefile.common:43:
>> recipe for target 'net.o' failed
>>
>> So I think next patch can be applied:
>
> I'm ok with that patch, but it's missing the ChangeLog entry,  Please
> provide ChangeLog entries per https://cygwin.com/contrib.html.
>

From c416f9666f21084ce73d13b479d13308c0fc7340 Mon Sep 17 00:00:00 2001
From: Alexpux <alexey.pawlow@gmail.com>
Date: Thu, 12 Mar 2015 22:46:01 +0300
Subject: [PATCH] Remove extra braces around single values.

---
 winsup/cygwin/ChangeLog | 4 ++++
 winsup/cygwin/net.cc    | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
index 1305dfa..96d3de9 100644
--- a/winsup/cygwin/ChangeLog
+++ b/winsup/cygwin/ChangeLog
@@ -1,5 +1,9 @@
 2015-03-12  Alexey Pavlov  <alexpux@gmail.com>

+ * net.cc: Remove extra braces.
+
+2015-03-12  Alexey Pavlov  <alexpux@gmail.com>
+
  * include/cygwin/version.h: Fix typo.

 2015-03-12  Corinna Vinschen  <corinna@vinschen.de>
diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
index e06fd52..f9b317c 100644
--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -79,8 +79,8 @@ extern "C"
  const unsigned char *);
 } /* End of "C" section */

-const struct in6_addr in6addr_any = {{IN6ADDR_ANY_INIT}};
-const struct in6_addr in6addr_loopback = {{IN6ADDR_LOOPBACK_INIT}};
+const struct in6_addr in6addr_any = IN6ADDR_ANY_INIT;
+const struct in6_addr in6addr_loopback = IN6ADDR_LOOPBACK_INIT;

 static fhandler_socket *
 get (const int fd)
-- 
2.3.0


>
> Thanks,
> Corinna
>
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Maintainer                 cygwin AT cygwin DOT com
> Red Hat
