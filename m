Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 9703F385828E
 for <cygwin-patches@cygwin.com>; Tue,  5 Jul 2022 03:11:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9703F385828E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 2653ArWL013028;
 Tue, 5 Jul 2022 12:10:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 2653ArWL013028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1656990658;
 bh=ngkRpKsdm/fjIhzAzpLzmlRC9FeEDOTmOSQSUn/uqKw=;
 h=From:To:Cc:Subject:Date:From;
 b=NpP5uaCQvfZEc3cZvvmPfEFozSAMozt2CxUosGtUPDQO09eMV+qJYeHlUFHYaXOje
 qAoeGzKXlfH2wPutSStNezb+GD0O3957uS6oxA+VTX5Be4WEcHJc+dsyA6CUN95TxW
 Nbl9L3pF1mDTs1IX65++txQHNaO6hh2SF4A5JA2/k1pc7L0dgIupKvfokNBM8Qmjtm
 BtT8L0d7Kt+oyiSyOKqLbj0jbRDW7udtqQHO5OvAeDF9C1lcYlzq6MJzlk3KpLocg6
 SSrvxEYCgBBjkgjG84T4Z1vzm3/KduVC5bJOp6PwWVSDUwzi3cECQ1Ak1En2scrfs4
 Omt/0iFTj4Fjw==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix issue of pasting very long text input
 again.
Date: Tue,  5 Jul 2022 12:10:44 +0900
Message-Id: <20220705031044.1374-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 05 Jul 2022 03:11:21 -0000

- The recent commit "Cygwin: console: Allow pasting very long text
  input." did not fix the issue enough. This patch adds fixes for
  that.
---
 winsup/cygwin/fhandler_console.cc | 87 +++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 22 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 52031fe31..47d30bc88 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -342,9 +342,9 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	{
 	  DWORD new_inrec_size = total_read + additional_space;
 	  INPUT_RECORD *new_input_rec = (INPUT_RECORD *)
-	    realloc (input_rec, new_inrec_size * sizeof (INPUT_RECORD));
+	    realloc (input_rec, m::bytes (new_inrec_size));
 	  INPUT_RECORD *new_input_tmp = (INPUT_RECORD *)
-	    realloc (input_tmp, new_inrec_size * sizeof (INPUT_RECORD));
+	    realloc (input_tmp, m::bytes (new_inrec_size));
 	  if (new_input_rec && new_input_tmp)
 	    {
 	      inrec_size = new_inrec_size;
@@ -360,6 +360,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
       switch (cygwait (p->input_handle, (DWORD) 0))
 	{
 	case WAIT_OBJECT_0:
+	  acquire_attach_mutex (mutex_timeout);
 	  total_read = 0;
 	  while (cygwait (p->input_handle, (DWORD) 0) == WAIT_OBJECT_0
 		 && total_read < inrec_size)
@@ -467,7 +468,30 @@ remove_record:
 				      min (total_read - n, inrec_size1), &len);
 		  n += len;
 		}
+	      release_attach_mutex ();
+
+	      acquire_attach_mutex (mutex_timeout);
+	      GetNumberOfConsoleInputEvents (p->input_handle, &n);
+	      release_attach_mutex ();
+	      if (n + additional_space > inrec_size)
+		{
+		  DWORD new_inrec_size = n + additional_space;
+		  INPUT_RECORD *new_input_rec = (INPUT_RECORD *)
+		    realloc (input_rec, m::bytes (new_inrec_size));
+		  INPUT_RECORD *new_input_tmp = (INPUT_RECORD *)
+		    realloc (input_tmp, m::bytes (new_inrec_size));
+		  if (new_input_rec && new_input_tmp)
+		    {
+		      inrec_size = new_inrec_size;
+		      input_rec = new_input_rec;
+		      input_tmp = new_input_tmp;
+		      if (!wincap.cons_need_small_input_record_buf ())
+			inrec_size1 = inrec_size;
+		    }
+		}
+
 	      /* Check if writeback was successfull. */
+	      acquire_attach_mutex (mutex_timeout);
 	      PeekConsoleInputW (p->input_handle, input_tmp, inrec_size1, &n);
 	      release_attach_mutex ();
 	      if (n < min (total_read, inrec_size1))
@@ -488,28 +512,47 @@ remove_record:
 		  n += len;
 		}
 	      release_attach_mutex ();
-	      for (DWORD i = 0, j = 0; j < n; j++)
-		if (i == total_read
-		    || !inrec_eq (input_rec + i, input_tmp + j, 1))
-		  {
-		    if (total_read + j - i >= n)
-		      { /* Something is wrong. Giving up. */
-			acquire_attach_mutex (mutex_timeout);
-			DWORD l = 0;
-			while (l < n)
-			  {
-			    DWORD len;
-			    WriteConsoleInputW (p->input_handle, input_tmp + l,
-					      min (n - l, inrec_size1), &len);
-			    l += len;
+	      bool fixed = false;
+	      for (DWORD ofs = n - total_read; ofs > 0; ofs--)
+		{
+		  if (inrec_eq (input_rec, input_tmp + ofs, total_read))
+		    {
+		      memcpy (input_rec + total_read, input_tmp,
+			      m::bytes (ofs));
+		      memcpy (input_rec + total_read + ofs,
+			      input_tmp + total_read + ofs,
+			      m::bytes (n - ofs - total_read));
+		      fixed = true;
+		      break;
+		    }
+		}
+	      if (!fixed)
+		{
+		  for (DWORD i = 0, j = 0; j < n; j++)
+		    if (i == total_read
+			|| !inrec_eq (input_rec + i, input_tmp + j, 1))
+		      {
+			if (total_read + j - i >= n)
+			  { /* Something is wrong. Giving up. */
+			    acquire_attach_mutex (mutex_timeout);
+			    DWORD l = 0;
+			    while (l < n)
+			      {
+				DWORD len;
+				WriteConsoleInputW (p->input_handle,
+						    input_tmp + l,
+						    min (n - l, inrec_size1),
+						    &len);
+				l += len;
+			      }
+			    release_attach_mutex ();
+			    goto skip_writeback;
 			  }
-			release_attach_mutex ();
-			goto skip_writeback;
+			input_rec[total_read + j - i] = input_tmp[j];
 		      }
-		    input_rec[total_read + j - i] = input_tmp[j];
-		  }
-		else
-		  i++;
+		    else
+		      i++;
+		}
 	      total_read = n;
 	    }
 	  while (true);
-- 
2.36.1

