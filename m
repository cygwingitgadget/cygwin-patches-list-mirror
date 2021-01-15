Return-Path: <ben@wijen.net>
Received: from 5.mo7.mail-out.ovh.net (5.mo7.mail-out.ovh.net [178.32.120.239])
 by sourceware.org (Postfix) with ESMTPS id 45F84385800D
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 13:45:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 45F84385800D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.109.146.213])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 27BAF18FE9F
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 14:45:57 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id C79C41A22019B;
 Fri, 15 Jan 2021 13:45:54 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0068f5a16be-5610-40f2-a372-be0ad076c6c4,
 A7E4B4729D754038BE6A0219279DD51DC757EBD6) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 06/11] cxx.cc: Fix dynamic initialization for static local
 variables
Date: Fri, 15 Jan 2021 14:45:29 +0100
Message-Id: <20210115134534.13290-7-ben@wijen.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11282924445424436996
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtddvgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-13.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 15 Jan 2021 13:45:59 -0000

The old implementation for __cxa_guard_acquire did not return 1,
therefore dynamic initialization was never performed.

If concurrent-safe dynamic initialisation is ever needed, CXX ABI
must be followed when re-implementing __cxa_guard_acquire (et al.)
---
 winsup/cygwin/Makefile.in |  2 +-
 winsup/cygwin/cxx.cc      | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index a840f2b83..73d9b37fd 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -69,7 +69,7 @@ COMMON_CFLAGS=-MMD ${$(*F)_CFLAGS} -Wimplicit-fallthrough=5 -Werror -fmerge-cons
 ifeq ($(target_cpu),x86_64)
 COMMON_CFLAGS+=-mcmodel=small
 endif
-COMPILE.cc+=${COMMON_CFLAGS} # -std=gnu++14
+COMPILE.cc+=${COMMON_CFLAGS} -fno-threadsafe-statics # -std=gnu++14
 COMPILE.c+=${COMMON_CFLAGS}
 
 AR:=@AR@
diff --git a/winsup/cygwin/cxx.cc b/winsup/cygwin/cxx.cc
index be3268549..b69524aca 100644
--- a/winsup/cygwin/cxx.cc
+++ b/winsup/cygwin/cxx.cc
@@ -83,16 +83,6 @@ __cxa_pure_virtual (void)
   api_fatal ("pure virtual method called");
 }
 
-extern "C" void
-__cxa_guard_acquire ()
-{
-}
-
-extern "C" void
-__cxa_guard_release ()
-{
-}
-
 /* These routines are made available as last-resort fallbacks
    for the application.  Should not be used in practice; the
    entries in this struct get overwritten by each DLL as it
-- 
2.29.2

