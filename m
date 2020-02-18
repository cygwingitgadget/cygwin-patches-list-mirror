Return-Path: <cygwin-patches-return-10080-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54972 invoked by alias); 18 Feb 2020 04:05:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 54962 invoked by uid 89); 18 Feb 2020 04:05:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 18 Feb 2020 04:05:26 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-02.nifty.com with ESMTP id 01I454vQ000987;	Tue, 18 Feb 2020 13:05:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com 01I454vQ000987
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581998711;	bh=vb2Oo/n5M1/z02YyezQMsmvE2yPDnqCuJ3ZADpe3Esg=;	h=From:To:Cc:Subject:Date:From;	b=QcKHAemAxDbUMiHk39I6XzKvwr1K8fnkidMhjGGKks9N3hVtvGjIJbt5kUZxhHrF+	 Ir68iyOVdG9LJqNtwY3tp8KXems+5+JohJa0+lmSX4KBWesVig7gEjm8HIFiaqAAa8	 ODwc9DU8K5CfzTR+Bo1ovVzfYEcYzLffSSQ9zCNdUKqlu71tfoJeUkvTidpJFiX0kn	 4WHGV+rtmCjd8wKCwQiDoGSUGYwuTzIyIodZc+NlPZHj+gr3O+O/YbhJivtKAMrMbd	 N7Lttkwxb32Vg9pMHVS8FJN5MizCbckjrKqo14B5BaoJndB4MZymDGvJl9GyqYRlq3	 Ll21Ypfwjsczw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix ioctl() FIONREAD.
Date: Tue, 18 Feb 2020 04:05:00 -0000
Message-Id: <20200218040507.377-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00186.txt

- ioctl() FIONREAD for console does not return correct value since
  commit cfb517f39a8bcf2d995a732d250563917600408a. This patch fixes
  the issue.
---
 winsup/cygwin/fhandler_console.cc | 37 +++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 7cb45b4a7..28cf00176 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -1280,10 +1280,39 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	      release_output_mutex ();
 	      return -1;
 	    }
-	  while (n-- > 0)
-	    if (inp[n].EventType == KEY_EVENT && inp[n].Event.KeyEvent.bKeyDown)
-	      ++ret;
-	  *(int *) arg = ret;
+	  bool saw_eol = false;
+	  for (DWORD i=0; i<n; i++)
+	    if (inp[i].EventType == KEY_EVENT &&
+		inp[i].Event.KeyEvent.bKeyDown &&
+		inp[i].Event.KeyEvent.uChar.UnicodeChar)
+	      {
+		WCHAR wc = inp[i].Event.KeyEvent.uChar.UnicodeChar;
+		char mbs[8];
+		int len = con.con_to_str (mbs, sizeof (mbs), wc);
+		if ((get_ttyp ()->ti.c_lflag & ICANON) &&
+		    len == 1 && CCEQ (get_ttyp ()->ti.c_cc[VEOF], mbs[0]))
+		  {
+		    saw_eol = true;
+		    break;
+		  }
+		ret += len;
+		const char eols[] = {
+		  '\n',
+		  '\r',
+		  (char) get_ttyp ()->ti.c_cc[VEOL],
+		  (char) get_ttyp ()->ti.c_cc[VEOL2]
+		};
+		if ((get_ttyp ()->ti.c_lflag & ICANON) &&
+		    len == 1 && memchr (eols, mbs[0], sizeof (eols)))
+		  {
+		    saw_eol = true;
+		    break;
+		  }
+	      }
+	  if ((get_ttyp ()->ti.c_lflag & ICANON) && !saw_eol)
+	    *(int *) arg = 0;
+	  else
+	    *(int *) arg = ret;
 	  release_output_mutex ();
 	  return 0;
 	}
-- 
2.21.0
