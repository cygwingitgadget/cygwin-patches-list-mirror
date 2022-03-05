Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 63C7B3858D39
 for <cygwin-patches@cygwin.com>; Sat,  5 Mar 2022 02:27:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 63C7B3858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 2252R9rd015575;
 Sat, 5 Mar 2022 11:27:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 2252R9rd015575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646447234;
 bh=8YtH3DSJ+85uVetaedRXMXgFKeo8IkQr1ksPimW+8hc=;
 h=From:To:Cc:Subject:Date:From;
 b=tiDhc4hSi6mt+i9DEernnTnAH1hWpsc7p7fydj2ZYUADCXqNIc93WqcjPo80Mfcl3
 JpX3P2JMQ5pN1V/WMx6nTixkHKWHuqkF6q1igrou5UwtAElXv9tvqsO4I3VgDXa/CA
 rzD1EMgKiQzR4qR1g2vzUSsLrBdwbJy+80VmUsPjAaPszz26mz106uNyqprkCs3WtD
 /lW7pTQPL0xFQuhsFLX4QRI/NbXFJ8+qwOjeVbDF0/HCdgNjq1v2mmbMx5xrtM3vh1
 8HOkXPJyF3W9krGUTGXK8QboFuiI5rIUROPhTp/Lut7G6C0qufuroJQ3QeTE7L98xH
 3MlmWJ1Lm1YIw==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: add 3.3.5 release notes
Date: Sat,  5 Mar 2022 11:27:10 +0900
Message-Id: <20220305022710.13179-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Sat, 05 Mar 2022 02:27:29 -0000

---
 winsup/cygwin/release/3.3.5 | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 winsup/cygwin/release/3.3.5

diff --git a/winsup/cygwin/release/3.3.5 b/winsup/cygwin/release/3.3.5
new file mode 100644
index 000000000..11698c4e4
--- /dev/null
+++ b/winsup/cygwin/release/3.3.5
@@ -0,0 +1,30 @@
+Bug Fixes
+---------
+
+- Fix a bug that accessing UNC path mounted to a drive letter using
+  SMB3.11 fails with error "Too many levels of symbolic links.".
+
+- Fix a console bug that escape sequence IL/DL (CSI Ps L, CSI Ps M)
+  does not work correctly at the last line.
+  Addresses: https://cygwin.com/pipermail/cygwin/2022-February/250736.html
+
+- Fix a problem that ENABLE_INSERT_MODE and ENABLE_QUICK_EDIT_MODE
+  flags are cleared if cygwin is started in console.
+
+- Fix an issue that cmd.exe also is terminated along with the cygwin
+  app started from the cmd.exe if the cygwin app is terminated by
+  Ctrl-C.
+
+- Fix deadlock caused when keys are typed in pty while a lot of text
+  output.
+
+- Fix a problem that the console mode for input is not set correctly
+  when non-cygwin app is started with stdin redirected.
+  Addresses:
+  https://github.com/GitCredentialManager/git-credential-manager/issues/576
+
+- Fix exit code when non-cygwin app is terminated by Ctrl-C.
+
+- Fix a bug that the order of the console key inputs are occasionally
+  swapped, especially when CPU load is high.
+  Addresses: https://cygwin.com/pipermail/cygwin/2022-February/250957.html
-- 
2.35.1

