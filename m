Return-Path: <cygwin-patches-return-9520-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128812 invoked by alias); 24 Jul 2019 16:25:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128802 invoked by uid 89); 24 Jul 2019 16:25:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-120.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*MI:cygwin, HContent-Transfer-Encoding:8bit
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 24 Jul 2019 16:25:33 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MK3BO-1i7RUZ1eZy-00LUIy; Wed, 24 Jul 2019 18:25:25 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D6789A80871; Wed, 24 Jul 2019 18:25:24 +0200 (CEST)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Ken Brown <kbrown@cornell.edu>,	Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Fix the address of myself
Date: Wed, 24 Jul 2019 16:25:00 -0000
Message-Id: <20190724162524.5604-1-corinna-cygwin@cygwin.com>
Reply-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SW-Source: 2019-q3/txt/msg00040.txt.bz2

From: Corinna Vinschen <corinna@vinschen.de>

Introducing an independent Cygwin PID introduced a regression:

The expectation is that the myself pinfo pointer always points to a
specific address right in front of the loaded Cygwin DLL.

However, commit b5e1003722cb14235c4f166be72c09acdffc62ea "Cygwin:
processes: use dedicated Cygwin PID rather than Windows PID" and commit
88605243a19bbc2b6b9be36b99f513140b972e38 "Cygwin: fix child getting
another pid after spawnve" broke this.  To get myself at the right
address requires to call init with h0 set to INVALID_HANDLE_VALUE or an
existing address:

void
pinfo::init (pid_t n, DWORD flag, HANDLE h0)
{
  [...]
  if (!h0 || myself.h)
    [...]
  else
    {
      shloc = SH_MYSELF;
      if (h0 == INVALID_HANDLE_VALUE)       <-- !!!
        h0 = NULL;
    }

That was not the case anymore after the above commits.  This patch makes
sure to set the handle to INVALID_HANDLE_VALUE again when creating a new
process, so init knows that myself has to be created in the right spot.

While at it, fix a potential uninitialized handle value in
child_info_spawn::handle_spawn.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/dcrt0.cc | 2 +-
 winsup/cygwin/pinfo.cc | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index fb726a739ccf..86ab7256484c 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -652,7 +652,7 @@ void
 child_info_spawn::handle_spawn ()
 {
   extern void fixup_lockf_after_exec (bool);
-  HANDLE h;
+  HANDLE h = INVALID_HANDLE_VALUE;
   if (!dynamically_loaded || get_parent_handle ())
       {
 	cygheap_fixup_in_child (true);
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index cdbd8bd7eaf3..b67d660ae04d 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -62,11 +62,10 @@ pinfo::thisproc (HANDLE h)
     {
       cygheap->pid = create_cygwin_pid ();
       flags |= PID_NEW;
+      h = INVALID_HANDLE_VALUE;
     }
   /* spawnve'd process got pid in parent, cygheap->pid has been set in
      child_info_spawn::handle_spawn. */
-  else if (h == INVALID_HANDLE_VALUE)
-    h = NULL;
 
   init (cygheap->pid, flags, h);
   procinfo->process_state |= PID_IN_USE;
-- 
2.20.1
