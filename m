Return-Path: <cygwin-patches-return-9802-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123761 invoked by alias); 6 Nov 2019 12:09:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 123749 invoked by uid 89); 6 Nov 2019 12:09:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=sid, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 06 Nov 2019 12:09:05 +0000
Received: from localhost.localdomain (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conuserg-02.nifty.com with ESMTP id xA6C8eHE030629;	Wed, 6 Nov 2019 21:08:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com xA6C8eHE030629
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573042124;	bh=27HjyUCueMroe4bsT1xvCN365SZuPDAs60qbYxSX4tU=;	h=From:To:Cc:Subject:Date:From;	b=RoqvxAbDlcb3VQ7Hvg0pf6Yjx+yvekVMiBCkllYpoxPpSqS7UgfVc3BMyNOw8oBgX	 CCS0u5y4DFPUfiwKZ60eB3ztQBGvAMRSCB9+qVAHL9CTIfUcj+BlO56KLGqXgsdjIZ	 Z/qupuENZ/AYVFTz/yfWJjg4ELR/iq8V9JqfSWTmqf37XrUgUAuxhcQR/NjLQgtlU7	 x9axHt+qJzpjL8pjMTFonM2zGNLk8hhM9SiBYt+MgqauD77UscZCd3zLAT+ZOw6GnF	 kepWkEGeSXCagU0tvdkC+nP0U4oqKdzeVP1B1oS/EFQcgFt+PuP10O/XOTVf13bL+i	 dU8SSwXajUEdQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Change how to determine if running as service or not.
Date: Wed, 06 Nov 2019 12:09:00 -0000
Message-Id: <20191106120843.540-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00073.txt.bz2

---
 winsup/cygwin/fhandler_tty.cc | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index f87ac73f2..2b4ad6e58 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3095,22 +3095,11 @@ pty_master_fwd_thread (VOID *arg)
    the helper process is running as privileged user while
    slave process is not. This function is used to determine
    if the process is running as a srvice or not. */
-static bool
+inline static bool
 is_running_as_service (void)
 {
-  DWORD dwSize = 0;
-  PTOKEN_GROUPS pGroupInfo;
-  tmp_pathbuf tp;
-  pGroupInfo = (PTOKEN_GROUPS) tp.w_get ();
-  NtQueryInformationToken (hProcToken, TokenGroups, pGroupInfo,
-					2 * NT_MAX_PATH, &dwSize);
-  for (DWORD i=0; i<pGroupInfo->GroupCount; i++)
-    if (RtlEqualSid (well_known_service_sid, pGroupInfo->Groups[i].Sid))
-      return true;
-  for (DWORD i=0; i<pGroupInfo->GroupCount; i++)
-    if (RtlEqualSid (well_known_interactive_sid, pGroupInfo->Groups[i].Sid))
-      return false;
-  return true;
+  return check_token_membership (well_known_service_sid)
+    || cygheap->user.saved_sid () == well_known_system_sid;
 }
 
 bool
-- 
2.21.0
