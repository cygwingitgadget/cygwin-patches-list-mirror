Return-Path: <SRS0=xrNc=BU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 884AC4B358A4
	for <cygwin-patches@cygwin.com>; Fri, 20 Mar 2026 14:29:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 884AC4B358A4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 884AC4B358A4
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774016997; cv=none;
	b=CGgvR+ENlAYU9P5UtZ0rwOvTrGOEMzVFF8foUQte/NS5MoOpC+OZMA38T7jUQZTwHjz4w3cidJesqdb92t6+MR4XoqUbfJ8udCklLh45vtAW64BDKWFIh+BtW5xe0XwWhK3/tb/S68OwnhemCIK39r606pklZunbROBOG3sDUuQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774016997; c=relaxed/simple;
	bh=0QeW94utxYmjniCkbhDpsYtR0LytaduysVLoH/2xTxw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Oq68jgLHwq94onq/7Go3lpbfC48VhrY3cs1Kdpis6d5dzSua4c1gHkLNzu4FFxd4bhpyv/QdhzS6uBHD54B6Oqt9YD0slefQmWIsglfblzGUl4HON1eym4v/oCNc3OKeOh0p6gLj05eVBalY7I2fgqPabwWdk5llfoS0FCfmaMY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 884AC4B358A4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Ubc6sBuW
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260320142949682.CYYV.19957.HP-Z230@nifty.com>;
          Fri, 20 Mar 2026 23:29:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 1/6] Cygwin: console: Fix master thread
Date: Fri, 20 Mar 2026 23:28:50 +0900
Message-ID: <20260320142925.8779-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320142925.8779-1-takashi.yano@nifty.ne.jp>
References: <20260319105608.597-1-takashi.yano@nifty.ne.jp>
 <20260320142925.8779-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774016989;
 bh=T2AyhqcZ/JLc1wWA1NOhM40KImb3KKk9zzyYq52/z0c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ubc6sBuW3ArGXnHW6ouSKpqV7J6M8Qo9Mu7KwjSKO6xHyOamybbMRvglpsKBwsO0briyJ7m6
 KG/Y9EiXnOOpG0hLmpgwT3oVOS/aqxJFxyesFOmbrkqi41pM5Lwhu1TXzMMJFxyM/qaDh3R5Xs
 1XXjIEJNkN8zLeCXqHn9jEFYQuiy8F9otnGStn8lc+l5lRSsC044wPDxORMpdoOt2ugRekeaM/
 10xywe8FWHAqLzKV7Q7BGFMBriidoY7Bp8D889arccrPudqv5wm3RIX47eQOmj0MSMT3Gt6yw+
 /l5ws4BdneCssOyhv8Y3UcNvNHIvkzDXaXqRi9EQhz2UAJJA==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In Windows 11, key event with wRepeatCount == 0 is fixed-up to
wRepeatCount == 1 in conhost.exe. Due to this behaviour, inreq_eq()
returns false even though the two event records are the same. This
patch add workaround for this behaviour in inrec_eq().

In addition, current master thread code has two set of code for
reordering (fixing) key events, but only the second one is enough
for any cases. This patch drops the first one.

Addresses: https://github.com/git-for-windows/git/issues/5632
Fixes: ff4440fcf768 ("Cygwin: console: Introduce new thread which handles input signal.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc | 70 +++++++++++++------------------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 9fd3ff506..cab461d38 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -318,9 +318,16 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
 	     written event. Therefore they are ignored. */
 	  const KEY_EVENT_RECORD *ak = &a[i].Event.KeyEvent;
 	  const KEY_EVENT_RECORD *bk = &b[i].Event.KeyEvent;
+	  /* Fixup repeat count */
+	  WORD r1 = ak->wRepeatCount;
+	  WORD r2 = bk->wRepeatCount;
+	  if (r1 == 0)
+	    r1 = 1;
+	  if (r2 == 0)
+	    r2 = 1;
 	  if (ak->bKeyDown != bk->bKeyDown
 	      || ak->uChar.UnicodeChar != bk->uChar.UnicodeChar
-	      || ak->wRepeatCount != bk->wRepeatCount)
+	      || r1 != r2)
 	    return false;
 	}
       else if (a[i].EventType == MOUSE_EVENT)
@@ -602,47 +609,30 @@ remove_record:
 		  n += len;
 		}
 	      release_attach_mutex ();
-	      bool fixed = false;
-	      for (DWORD ofs = n - total_read; ofs > 0; ofs--)
-		{
-		  if (inrec_eq (input_rec, input_tmp + ofs, total_read))
-		    {
-		      memcpy (input_rec + total_read, input_tmp,
-			      m::bytes (ofs));
-		      memcpy (input_rec + total_read + ofs,
-			      input_tmp + total_read + ofs,
-			      m::bytes (n - ofs - total_read));
-		      fixed = true;
-		      break;
-		    }
-		}
-	      if (!fixed)
-		{
-		  for (DWORD i = 0, j = 0; j < n; j++)
-		    if (i == total_read
-			|| !inrec_eq (input_rec + i, input_tmp + j, 1))
-		      {
-			if (total_read + j - i >= n)
-			  { /* Something is wrong. Giving up. */
-			    acquire_attach_mutex (mutex_timeout);
-			    DWORD l = 0;
-			    while (l < n)
-			      {
-				DWORD len;
-				WriteConsoleInputW (p->input_handle,
-						    input_tmp + l,
-						    min (n - l, inrec_size),
-						    &len);
-				l += len;
-			      }
-			    release_attach_mutex ();
-			    goto skip_writeback;
+	      for (DWORD i = 0, j = 0; j < n; j++)
+		if (i == total_read
+		    || !inrec_eq (input_rec + i, input_tmp + j, 1))
+		  {
+		    if (total_read + j - i >= n)
+		      { /* Something is wrong. Giving up. */
+			acquire_attach_mutex (mutex_timeout);
+			DWORD l = 0;
+			while (l < n)
+			  {
+			    DWORD len;
+			    WriteConsoleInputW (p->input_handle,
+						input_tmp + l,
+						min (n - l, inrec_size),
+						&len);
+			    l += len;
 			  }
-			input_rec[total_read + j - i] = input_tmp[j];
+			release_attach_mutex ();
+			goto skip_writeback;
 		      }
-		    else
-		      i++;
-		}
+		    input_rec[total_read + j - i] = input_tmp[j];
+		  }
+		else
+		  i++;
 	      total_read = n;
 	    }
 	  while (true);
-- 
2.51.0

