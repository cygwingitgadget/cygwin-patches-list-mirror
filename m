Return-Path: <cygwin-patches-return-8065-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67145 invoked by alias); 12 Mar 2015 17:30:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 67135 invoked by uid 89); 12 Mar 2015 17:30:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.5 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,KAM_FROM_URIBL_PCCC,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=no version=3.3.2
X-HELO: mail-qc0-f177.google.com
Received: from mail-qc0-f177.google.com (HELO mail-qc0-f177.google.com) (209.85.216.177) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Thu, 12 Mar 2015 17:30:30 +0000
Received: by qcwr17 with SMTP id r17so20279772qcw.11        for <cygwin-patches@cygwin.com>; Thu, 12 Mar 2015 10:30:28 -0700 (PDT)
MIME-Version: 1.0
X-Received: by 10.229.246.201 with SMTP id lz9mr105407qcb.14.1426181427837; Thu, 12 Mar 2015 10:30:27 -0700 (PDT)
Received: by 10.96.180.199 with HTTP; Thu, 12 Mar 2015 10:30:27 -0700 (PDT)
Date: Thu, 12 Mar 2015 17:30:00 -0000
Message-ID: <CABEPuQL27_wzE=fRWAR-FqV1vXBcOcLF5-aLvAKWddLkPx=LfQ@mail.gmail.com>
Subject: Fix typo
From: Alexey Pavlov <alexpux@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2015-q1/txt/msg00020.txt.bz2

From 9c11fcf2fc74601eb48e8060b6575b56be111a02 Mon Sep 17 00:00:00 2001
From: Alexpux <alexey.pawlow@gmail.com>
Date: Thu, 12 Mar 2015 14:33:39 +0300
Subject: [PATCH] Fix typos.

---
 winsup/cygwin/include/cygwin/version.h | 2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/winsup/cygwin/include/cygwin/version.h
b/winsup/cygwin/include/cygwin/version.h
index b46fe24..71d118e 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -467,7 +467,7 @@ details. */
            putwc_unlocked, putwchar_unlocked.
       284: Export sockatmark.
       285: Export wcstold.
-      285: Export cabsl, cimagl, creall, finitel, hypotl, sqrtl.
+      286: Export cabsl, cimagl, creall, finitel, hypotl, sqrtl.
       287: Export issetugid.
      */

-- 
2.3.0
