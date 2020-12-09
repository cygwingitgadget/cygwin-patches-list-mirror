Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id AFE903850418
 for <cygwin-patches@cygwin.com>; Wed,  9 Dec 2020 19:27:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org AFE903850418
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 5478ECB59
 for <cygwin-patches@cygwin.com>; Wed,  9 Dec 2020 14:27:11 -0500 (EST)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 42379CB4E
 for <cygwin-patches@cygwin.com>; Wed,  9 Dec 2020 14:27:11 -0500 (EST)
Date: Wed, 9 Dec 2020 11:27:11 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] cygwin: use CREATE_DEFAULT_ERROR_MODE in spawn
Message-ID: <alpine.BSO.2.21.2012091123460.9707@resin.csoft.net>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-13.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_LOW,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 09 Dec 2020 19:27:12 -0000

This allows native processes to get Windows-default error handling
behavior (such as invoking the registered JIT debugger).

---
 winsup/cygwin/spawn.cc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 92d190d1a..83b216f52 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -431,6 +431,13 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,

       c_flags |= CREATE_SEPARATE_WOW_VDM | CREATE_UNICODE_ENVIRONMENT;

+      /* Add CREATE_DEFAULT_ERROR_MODE flag for non-Cygwin processes so they
+	 get the default error mode instead of inheriting the mode Cygwin
+	 uses.  This allows things like Windows Error Reporting/JIT debugging
+	 to work with processes launched from a Cygwin shell. */
+      if (!real_path.iscygexec ())
+	c_flags |= CREATE_DEFAULT_ERROR_MODE;
+
       /* We're adding the CREATE_BREAKAWAY_FROM_JOB flag here to workaround
 	 issues with the "Program Compatibility Assistant (PCA) Service".
 	 For some reason, when starting long running sessions from mintty(*),
-- 
2.29.2.windows.3

