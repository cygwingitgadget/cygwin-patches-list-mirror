Return-Path: <cygwin-patches-return-9647-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10578 invoked by alias); 6 Sep 2019 13:01:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10559 invoked by uid 89); 6 Sep 2019 13:01:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 06 Sep 2019 13:01:53 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x86D1S7r006600;	Fri, 6 Sep 2019 22:01:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x86D1S7r006600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567774895;	bh=KHlva9MP1q+SRPwO/8gN4YhxiBZH19pjhvHQ6ytZojc=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=wGcfYn00T440TlblwTzmuMZqsbTH1oNc7zgVlOtLsbUx8hPA9qmGMz4dPq4ScYB10	 YZ4ZyXgWHNT/Q2UPGj23YrbyTZfWZhuDw7EK8bf2yUkQz8GfdtxhycrDRCzfw2fR5S	 1vDZe9ROWtG+5PwLOQjjGBknmzEpksJz3TujR+2I83h/FtOZdOvnaTUJhM9z45umzO	 nJnEvNCJBteIYzeuKxGCKbSVXqCubL+WcFmTN/PjlKhdClQUvA9JbgL1ria+FaeY1e	 7TdIXXJPGrhGsmyQ87aVgHYVMWLBXItQEhJVDaCRszOJuUQptAEI7VXETl5W9xyM4N	 BE560ANAyQWrA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/1] Cygwin: pty: Make SetConsoleCursorPosition() to be hooked.
Date: Fri, 06 Sep 2019 13:01:00 -0000
Message-Id: <20190906130127.1928-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190906130127.1928-1-takashi.yano@nifty.ne.jp>
References: <20190906130127.1928-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00167.txt.bz2

- Win32 API SetConsoleCursorPosition() injects ANSI escape sequence
  to pseudo console. Therefore, it should be added to the API list
  to be hooked.
---
 winsup/cygwin/fhandler_tty.cc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 150530c5e..de1c1ae6f 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -156,6 +156,7 @@ DEF_HOOK (WriteConsoleOutputW);
 DEF_HOOK (WriteConsoleOutputCharacterA);
 DEF_HOOK (WriteConsoleOutputCharacterW);
 DEF_HOOK (WriteConsoleOutputAttribute);
+DEF_HOOK (SetConsoleCursorPosition);
 DEF_HOOK (SetConsoleTextAttribute);
 DEF_HOOK (WriteConsoleInputA);
 DEF_HOOK (WriteConsoleInputW);
@@ -242,6 +243,13 @@ WriteConsoleOutputAttribute_Hooked
   return WriteConsoleOutputAttribute_Orig (h, a, l, c, n);
 }
 static BOOL WINAPI
+SetConsoleCursorPosition_Hooked
+     (HANDLE h, COORD c)
+{
+  set_ishybrid_and_switch_to_pcon (h);
+  return SetConsoleCursorPosition_Orig (h, c);
+}
+static BOOL WINAPI
 SetConsoleTextAttribute_Hooked
      (HANDLE h, WORD a)
 {
@@ -2960,6 +2968,7 @@ fhandler_pty_slave::fixup_after_exec ()
       DO_HOOK (NULL, WriteConsoleOutputCharacterA);
       DO_HOOK (NULL, WriteConsoleOutputCharacterW);
       DO_HOOK (NULL, WriteConsoleOutputAttribute);
+      DO_HOOK (NULL, SetConsoleCursorPosition);
       DO_HOOK (NULL, SetConsoleTextAttribute);
       DO_HOOK (NULL, WriteConsoleInputA);
       DO_HOOK (NULL, WriteConsoleInputW);
-- 
2.21.0
