Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 238C93858430
 for <cygwin-patches@cygwin.com>; Sat,  9 Jul 2022 05:55:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 238C93858430
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 2695tLLI022058;
 Sat, 9 Jul 2022 14:55:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 2695tLLI022058
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1657346127;
 bh=aH8vsrP7XpVO0oJFqnfVK/jgL+i8as4PAmOgM87ppcE=;
 h=From:To:Cc:Subject:Date:From;
 b=K+MfzBdsVDiFUKnS2cnUvZg5rueQ81Er3dURiQHmr0ryi9P8aHi1DHz0jBZInE6qw
 eZq+mKQkHDDurxPubq/WRHEAfb/foJByGvprEvpbLYT6dNSI6uq5wz38ZJhOwNGTP7
 sa+VXZWkLmu+UA0lgSJm2EyqKn1BWdtNg7Mv7mh7+GhXkaV/QEd/tnWxzIDela4vAU
 5sAn+XAWvabHInrpSWyp8Q50seDUP90Km20XEO2njopQj7l7ZOTD2LDTFTDFEOWYWn
 EUv5HvsX3TWSkCQ69jWn/yl7cWxGnu/i7Uf1Av6IzlrVB5imUGCe6iTIiC/PR6TGw/
 5Xx46bX7O1eiA==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix an issue which causes when realloc()
 fails.
Date: Sat,  9 Jul 2022 14:55:12 +0900
Message-Id: <20220709055512.1072-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Sat, 09 Jul 2022 05:55:53 -0000

---
 winsup/cygwin/fhandler_console.cc | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 47d30bc88..c542fa46e 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -296,7 +296,11 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
     (INPUT_RECORD *) malloc (inrec_size * sizeof (INPUT_RECORD));
 
   if (!input_rec || !input_tmp)
-    return; /* Cannot continue */
+    { /* Cannot continue */
+      free (input_rec);
+      free (input_tmp);
+      return;
+    }
 
   DWORD inrec_size1 =
     wincap.cons_need_small_input_record_buf () ? INREC_SIZE : inrec_size;
@@ -343,13 +347,15 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	  DWORD new_inrec_size = total_read + additional_space;
 	  INPUT_RECORD *new_input_rec = (INPUT_RECORD *)
 	    realloc (input_rec, m::bytes (new_inrec_size));
+	  if (new_input_rec)
+	    input_rec = new_input_rec;
 	  INPUT_RECORD *new_input_tmp = (INPUT_RECORD *)
 	    realloc (input_tmp, m::bytes (new_inrec_size));
+	  if (new_input_tmp)
+	    input_tmp = new_input_tmp;
 	  if (new_input_rec && new_input_tmp)
 	    {
 	      inrec_size = new_inrec_size;
-	      input_rec = new_input_rec;
-	      input_tmp = new_input_tmp;
 	      if (!wincap.cons_need_small_input_record_buf ())
 		inrec_size1 = inrec_size;
 	    }
@@ -478,13 +484,15 @@ remove_record:
 		  DWORD new_inrec_size = n + additional_space;
 		  INPUT_RECORD *new_input_rec = (INPUT_RECORD *)
 		    realloc (input_rec, m::bytes (new_inrec_size));
+		  if (new_input_rec)
+		    input_rec = new_input_rec;
 		  INPUT_RECORD *new_input_tmp = (INPUT_RECORD *)
 		    realloc (input_tmp, m::bytes (new_inrec_size));
+		  if (new_input_tmp)
+		    input_tmp = new_input_tmp;
 		  if (new_input_rec && new_input_tmp)
 		    {
 		      inrec_size = new_inrec_size;
-		      input_rec = new_input_rec;
-		      input_tmp = new_input_tmp;
 		      if (!wincap.cons_need_small_input_record_buf ())
 			inrec_size1 = inrec_size;
 		    }
-- 
2.37.0

