Return-Path: <cygwin-patches-return-9701-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92906 invoked by alias); 18 Sep 2019 20:50:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92879 invoked by uid 89); 18 Sep 2019 20:50:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=43,6, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Sep 2019 20:50:27 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-02.nifty.com with ESMTP id x8IKo3NO004996;	Thu, 19 Sep 2019 05:50:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com x8IKo3NO004996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568839824;	bh=9JjA8iooN2UIu5UQ4/acHgkVNLE+EWJ+o2VNt/Gdrhw=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=Mfd/38F6PEbPUr6ohbA9tK8J3TwLi14MROm7qqqtatpFAfHrpgNYb1u3nxNbl8MS0	 JEpr7O4XvfMCt3CQKtNiB6wz5bNdwriLxfKuNc22tKl1k6Z1QqRmxv+QpUXkP5ROsT	 YuBhcdLy/fLsOxTDPO7x5KQGegXuMZIqBaxqhr/qqHa1kaGnRgTdYTQLjHLBWny2A9	 SJ08/wBHtQXk4e4m91Yhm34/joONtNYmnNKBANvd9aZFdrjnT4D6DAKJTfE4OaZrnf	 fHqBaurtQUnbkucr4wLapDYdrgNcY/Gi/Mb/RpU48VIExGL0MdKe10+hpxy/O1SfR/	 mD7k10iyGGClA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 1/1] Cygwin: console: Revive Win7 compatibility.
Date: Wed, 18 Sep 2019 20:50:00 -0000
Message-Id: <20190918204955.2131-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190918204955.2131-1-takashi.yano@nifty.ne.jp>
References: <20190918204955.2131-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00221.txt.bz2

- The commit fca4cda7a420d7b15ac217d008527e029d05758e broke Win7
  compatibility. This patch fixes the issue.
---
 winsup/cygwin/fhandler.h          | 6 ++++++
 winsup/cygwin/fhandler_console.cc | 6 ------
 winsup/cygwin/select.cc           | 1 -
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 4efb6a4f2..94b0e520b 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -43,6 +43,12 @@ details. */
 
 #define O_TMPFILE_FILE_ATTRS (FILE_ATTRIBUTE_TEMPORARY | FILE_ATTRIBUTE_HIDDEN)
 
+/* Buffer size for ReadConsoleInput() and PeakConsoleInput(). */
+/* Per MSDN, max size of buffer required is below 64K. */
+/* (65536 / sizeof (INPUT_RECORD)) is 3276, however,
+   ERROR_NOT_ENOUGH_MEMORY occurs in win7 if this value is used. */
+#define INREC_SIZE 2048
+
 extern const char *windows_device_names[];
 extern struct __cygwin_perfile *perfile_table;
 #define __fmode (*(user_data->fmode_ptr))
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 709b8255d..86c39db25 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -499,9 +499,6 @@ fhandler_console::process_input_message (void)
 
   termios *ti = &(get_ttyp ()->ti);
 
-	  /* Per MSDN, max size of buffer required is below 64K. */
-#define	  INREC_SIZE	(65536 / sizeof (INPUT_RECORD))
-
   fhandler_console::input_states stat = input_processing;
   DWORD total_read, i;
   INPUT_RECORD input_rec[INREC_SIZE];
@@ -1165,9 +1162,6 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	return -1;
       case FIONREAD:
 	{
-	  /* Per MSDN, max size of buffer required is below 64K. */
-#define	  INREC_SIZE	(65536 / sizeof (INPUT_RECORD))
-
 	  DWORD n;
 	  int ret = 0;
 	  INPUT_RECORD inp[INREC_SIZE];
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index ed8c98d1c..e7014422b 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1209,7 +1209,6 @@ peek_pty_slave (select_record *s, bool from_select)
 	{
 	  if (ptys->is_line_input ())
 	    {
-#define INREC_SIZE (65536 / sizeof (INPUT_RECORD))
 	      INPUT_RECORD inp[INREC_SIZE];
 	      DWORD n;
 	      PeekConsoleInput (ptys->get_handle (), inp, INREC_SIZE, &n);
-- 
2.21.0
