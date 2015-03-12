Return-Path: <cygwin-patches-return-8067-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1045 invoked by alias); 12 Mar 2015 18:18:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1035 invoked by uid 89); 12 Mar 2015 18:18:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.6 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,KAM_FROM_URIBL_PCCC,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=no version=3.3.2
X-HELO: mail-qg0-f48.google.com
Received: from mail-qg0-f48.google.com (HELO mail-qg0-f48.google.com) (209.85.192.48) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Thu, 12 Mar 2015 18:18:15 +0000
Received: by qgaj5 with SMTP id j5so20180294qga.12        for <cygwin-patches@cygwin.com>; Thu, 12 Mar 2015 11:18:13 -0700 (PDT)
MIME-Version: 1.0
X-Received: by 10.55.31.101 with SMTP id f98mr46326670qkf.34.1426184293703; Thu, 12 Mar 2015 11:18:13 -0700 (PDT)
Received: by 10.96.180.199 with HTTP; Thu, 12 Mar 2015 11:18:13 -0700 (PDT)
Date: Thu, 12 Mar 2015 18:18:00 -0000
Message-ID: <CABEPuQJGji9Ue5E+j55to-u+VZV_oZ5kqF6piJFjhmMR+OJbhQ@mail.gmail.com>
Subject: braces around scalar initializer for type
From: Alexey Pavlov <alexpux@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2015-q1/txt/msg00022.txt.bz2

Building MSYS2 runtime I'm get:

/build2/msys2-runtime/src/msys2-runtime/winsup/cygwin/net.cc:82:56:
error: braces around scalar initializer for type 'u_char {aka unsigned
char}'
 const struct in6_addr in6addr_any = {{IN6ADDR_ANY_INIT}};

                          ^
/build2/msys2-runtime/src/msys2-runtime/winsup/cygwin/net.cc:83:66:
error: braces around scalar initializer for type 'u_char {aka unsigned
char}'
 const struct in6_addr in6addr_loopback = {{IN6ADDR_LOOPBACK_INIT}};

                                               ^
/build2/msys2-runtime/src/msys2-runtime/winsup/cygwin/../Makefile.common:43:
recipe for target 'net.o' failed

So I think next patch can be applied:



From 9c11fcf2fc74601eb48e8060b6575b56be111a02 Mon Sep 17 00:00:00 2001
From: Alexpux <alexey.pawlow@gmail.com>
Date: Thu, 12 Mar 2015 14:33:39 +0300
Subject: [PATCH] Fix error "braces around scalar initializer for type"

---
 winsup/cygwin/net.cc                   | 4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

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
