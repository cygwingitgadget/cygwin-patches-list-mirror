Return-Path: <SRS0=4rNz=BS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 8BE364BB590F
	for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 13:12:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8BE364BB590F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8BE364BB590F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773839565; cv=none;
	b=kQaj9cWwrC7iA5+Mc4ucMuKXdEWfkDEE4wzmQLqRWldKZnUTsUD2hAmBVl4GyYXHs+mm5156rdX6/nnjYuOj7nKX2bMrM5vJvCZtKj3y+a+V4Atrd6IEfsDgKE5oIcTPahZ637VAZqTFqNUq9NWLe5sdeIvG7Rqh2txHxXwVnpE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773839565; c=relaxed/simple;
	bh=a/U5iu/2fBneBvBqbMNRpf7tt6naJMzqSuiV+Wq70oE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=o8VxB4GB5cUNQreNaNJc+wDvZOf1TsciaC2oio0Sux0NIkXymrZKwMk6DA7eyDG6iXs277nQrwxQkPX18dnHiB4rbF6+efcvbz+VG3Z8EfzeK0OfouUwm9CnrqWiH+/4zeGc/a3PKTC7xK7bEDctP6cJ/7MnLE0TNqJZE7xbzq4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8BE364BB590F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JOgvS9dn
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260318131242982.FSE.14880.HP-Z230@nifty.com>;
          Wed, 18 Mar 2026 22:12:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 2/6] Cygwin: pty: Add workaround for handling of backspace when pcon enabled
Date: Wed, 18 Mar 2026 22:11:51 +0900
Message-ID: <20260318131235.1412-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317122433.721-3-takashi.yano@nifty.ne.jp>
References: <20260317122433.721-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773839563;
 bh=qAPxXOjZ5n1u/3Y4f4dL+TJVe9wxb/s/FbknRnkXxLc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JOgvS9dnY9u9m2ZY6qudh1zbkxZtXRTEs+DvTiDglVQFX4qtOT2bpT0KrpkBtFfocuHZhU11
 w6v1Q9NCb8CbVu0O/i4l8VniJYrcUpk0ZqeYPpYidk5fGlxPkf4J6Cv9rW19xcAku+rY36vj+w
 ZHRgT9jL1puwA3jpIu058ej5IiNUZ8qbTdHspz2p33QXSfXdhhmgw2dCqY7XjJfhELBjjRPiZc
 k2Yd9mHBH0bWMCRLogbgy7ID1hfwhlgankUJmftkXtocXQbHLRsu2PnoFgM6b5OFBNBuJfS6Zf
 ipl+oztGHF70RzAsbv5RJAIfebSmcQfcqPkEh1n9Jd/SWeTw==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In Windows 11, pseudo console has a weird behaviour that the Ctrl-H
is translated into Ctrl-Backspace (not Backspace). Similary, Backspace
(0x7f) is translated into Ctrl-H. Due to this behaviour, inrec_eq()
in cons_master_thread() fails to compare backspace/Ctrl-H events in
the input record sequence. This patch is a workaround for the issue
that replaces Ctrl-H with backspace (0x7f), which will be translated
into Ctrl-H in pseudo console.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 371e67103..1d3f4b940 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2266,28 +2266,30 @@ fhandler_pty_master::write (const void *ptr, size_t len)
     { /* Reaches here when non-cygwin app is foreground and pseudo console
 	 is activated. */
       tmp_pathbuf tp;
-      char *buf = (char *) ptr;
+      char *buf = tp.c_get ();
       size_t nlen = len;
       if (get_ttyp ()->term_code_page != CP_UTF8)
 	{
 	  static mbstate_t mbp;
-	  buf = tp.c_get ();
 	  nlen = NT_MAX_PATH;
 	  convert_mb_str (CP_UTF8, buf, &nlen,
 			  get_ttyp ()->term_code_page, (const char *) ptr, len,
 			  &mbp);
 	}
+      else
+	memcpy (buf, ptr, nlen);
 
-      for (size_t i = 0; i < nlen; i++)
+      for (size_t i = 0, j = 0; i < nlen; i++)
 	{
 	  process_sig_state r = process_sigs (buf[i], get_ttyp (), this);
-	  if (r == done_with_debugger)
+	  if (r != done_with_debugger)
 	    {
-	      for (size_t j = i; j < nlen - 1; j++)
-		buf[j] = buf[j + 1];
-	      nlen--;
-	      i--;
+	      /* Workaround for pseudo console in Windows 11 */
+	      char c = buf[i] == '\x08' ? '\x7f' : buf[i];
+	      buf[j++] = c;
 	    }
+	  else
+	    nlen--;
 	}
 
       DWORD n;
-- 
2.51.0

