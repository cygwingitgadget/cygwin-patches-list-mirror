Return-Path: <cygwin-patches-return-8681-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28641 invoked by alias); 11 Jan 2017 13:21:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28610 invoked by uid 89); 11 Jan 2017 13:21:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=ham version=3.3.2 spammy=HX-Provags-ID:V03, H*r:Nemesis, signed-off-by, signedoffby
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.15.18) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 11 Jan 2017 13:21:35 +0000
Received: from virtualbox ([213.133.108.164]) by mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKZLb-1cPvvn1L31-001wbg for <cygwin-patches@cygwin.com>; Wed, 11 Jan 2017 14:21:32 +0100
Date: Wed, 11 Jan 2017 13:21:00 -0000
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] FAST_CWD: adjust the initial search scope
Message-ID: <5b4e3785c193feb56fa31eef637db2641e69eefd.1484140876.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:V9vJLSIkx88=:mkxLzxQrkijVO+rK1IWWaD zw4wQSUwTMnd4ahayLAGqSvRN85qFYAdI6Q65c7o5FLBBRzA8L5w1O9BzPlNO25ks41PX0l40 Qww/QWpK+w5lkm+LPT8324WBSa7zfiE7ADRo0JY73zooJVelDP0+AQBuTrixEKk3GFM1PDhwy z1JmYIQLHNnHB4rSoje06Z+7mqKRzEgzSKmBDvPQc3utwcDyyxjl+2UrdwRmQI4NIaWcSO7wr YiOk1VBAaSX6KVYxJSl+8N8A0fSo+4HtsZsg+rr5VBa6nFyQh7thKmsmFCFAGrq7GAZK9BaDV BRhr+87LdRSxfshvIKOjNMmU83gXM4GU3cBUDDDwpSfjeXJHtMrSLpDRru3rrUwlXbydZY1ne 79hhF/GJJF6imHxbOM4ZKgBixKtZh1HXGTkdrdfzS5InOvDZDOBIElFJHaNRDJ9NYi9wIKp5o 3mgkmNlZnNcdgUYElnKWHwwn/Ogbbu2/F+dri1UucwV2JerJTukUBqheqbifYtPtmSZ1nY5BB Z0iBCxC8LolqS4z5n/54iVNV0paqC2VuzGICSHJJQgkjnXzHDDL5ldkHLxA/A2+Aer8Jf78u9 vO5v3EhzVIuRXfvrGQC8gyCxABIqwxvE06VIwi8GEYIdtP49Hbgz42v7piR2FN+rkl0X1yfsw vjubdAIeaJACV98p2IwolO71VafknjNIItEYSHFGtxHkVZBSwluPbHX8q0CpLrxfBSO9TkwrI AF3UtZR4Xl5SHq2WFy6iHaWeUA4rLd3oqOcun7baRtrcsGG1sF2ITY5y6COBv6hA2S/bPHwHb 0uSBv5f3kVFfrmwFcKFOk3tC0127w==
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00022.txt.bz2

A *very* recent Windows build adds more code to the preamble of
RtlGetCurrentDirectory_U() so that the previous heuristic failed to find
the call to the locking routine.

This only affects the 64-bit version of ntdll, where the 0xe8 byte is
now found at offset 40, not the 32-bit version. However, let's just
double the area we search for said byte for good measure.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fast-cwd-v1
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fast-cwd-v1

 winsup/cygwin/path.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index c3b304ab5..ee7636dbf 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -4034,7 +4034,7 @@ find_fast_cwd_pointer ()
   if (!get_dir || !ent_crit)
     return NULL;
   /* Search first relative call instruction in RtlGetCurrentDirectory_U. */
-  const uint8_t *rcall = (const uint8_t *) memchr (get_dir, 0xe8, 40);
+  const uint8_t *rcall = (const uint8_t *) memchr (get_dir, 0xe8, 80);
   if (!rcall)
     return NULL;
   /* Fetch offset from instruction and compute address of called function.
@@ -4133,7 +4133,7 @@ find_fast_cwd_pointer ()
   if (!get_dir || !ent_crit)
     return NULL;
   /* Search first relative call instruction in RtlGetCurrentDirectory_U. */
-  const uint8_t *rcall = (const uint8_t *) memchr (get_dir, 0xe8, 32);
+  const uint8_t *rcall = (const uint8_t *) memchr (get_dir, 0xe8, 64);
   if (!rcall)
     return NULL;
   /* Fetch offset from instruction and compute address of called function.

base-commit: e0477b4a0ba2b842d4f81350f7fa9a03b1f3d27b
-- 
2.11.0.310.g4ee6bc8b50
