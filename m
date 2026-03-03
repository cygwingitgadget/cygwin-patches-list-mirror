Return-Path: <SRS0=xgHh=BD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 71A714B9DB63
	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2026 13:41:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 71A714B9DB63
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 71A714B9DB63
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772545272; cv=none;
	b=fHuI7sAZzYT/w9itHgMRufnd2kZdFufc63EzJcvOxbshSP9lhLme6tksVMPviRhZqE3L0h927/JqZ5ompe5wzd+HHphKLKbopaMBxU2f9zZD7BnVfyu2DlCBp+ZUmDrQmukuNGOQy7QYxcaK3Jh3sAOUQBUS5CByQjJ8I5y6WfM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772545272; c=relaxed/simple;
	bh=cVdwfG/DTmNlsTQodPkSFE4myu0D3so18shgmUBF6rk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=R/h5BdLlZ9ZBiPTBKps/rf0cBADGM4Yti8LQMfnZpSkdZC9Pr49xt4HTTZI+If6FiVaddLXAepK39xHSAov+7miIjgIcfYViTF5lPK6+3W1bnewJi8+iO4g1YaSVDtuRJmxykHVLLVF3lKxWGLxOqzzlQrTBIJvQLVUwodpugrg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 71A714B9DB63
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=e+QSPrtK
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20260303134107522.IPCP.116286.HP-Z230@nifty.com>;
          Tue, 3 Mar 2026 22:41:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Do not switch input to to_nat if native app is background
Date: Tue,  3 Mar 2026 22:40:46 +0900
Message-ID: <20260303134058.3517-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772545267;
 bh=oeh3KIKZWPPCnZCTAresVCUl/t1TEdEppDJ5p2IgURs=;
 h=From:To:Cc:Subject:Date;
 b=e+QSPrtKLuoj4gx6t2GO+7ix7sLRenns6Kbxb+R9rnoN+Npj7e8razIOZZ8/4p/9OQiWedQZ
 f3sUPN6m/Hui0o1t07424vMm7ZCYwhlsigNYELLz+vrzqg95KWXMJx5jTam2qb5JglF9yL9htN
 /vVYCCE1EDwGs7BJubV4ub08sCOL/+YewRu9VSg7Sty4+UTMsP81bDwZUUZODmD3/2CUsLQL1d
 kxf8AHCppCw2b+xabtfv/xa39fUSTub2yPll27PywkUikWyDQ+WVNCYWaPikGdfeK/FOjGSpyC
 8KjQw7FlYAl0nsw3+NlIFOXPrGi73mHtY8YGFCxcM/k8V9uQ==
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If the native (non-cygwin) app is started as background process,
the input should be kept in to_cyg mode because input data should
go to the cygwin shell that start the non-cygwin app. However,
currently it is switched to to_nat mode in a short time and reverted
to to_cyg mode just after that.

With this patch, to avoid this behaviour, switching to to_nat mode
is inhibited by checking PGID of the process, that is newly created
for a background process and differs from PGID of the tty.

Fixes: Fixes: 9fc746d17dc3 ("Cygwin: pty: Fix transferring type-ahead input between input pipes.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index b996880fb..3e8c7ff9f 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2210,6 +2210,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	{ /* Pseudo console initialization has been done in above code. */
 	  pinfo pp (get_ttyp ()->pcon_start_pid);
 	  if (get_ttyp ()->switch_to_nat_pipe
+	      && pp && pp->pgid == get_ttyp ()->getpgid ()
 	      && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
 	    {
 	      /* This accept_input() call is needed in order to transfer input
-- 
2.51.0

