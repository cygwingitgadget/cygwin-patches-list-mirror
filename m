Return-Path: <cygwin-patches-return-10058-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 106944 invoked by alias); 10 Feb 2020 11:43:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 106935 invoked by uid 89); 10 Feb 2020 11:43:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Prevent, reopen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Feb 2020 11:43:00 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-06.nifty.com with ESMTP id 01ABglRt029161;	Mon, 10 Feb 2020 20:42:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com 01ABglRt029161
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581334973;	bh=wuft5ztsWZcS0Zt6B15uJXnoyzSK9HlAoQouuDNe03w=;	h=From:To:Cc:Subject:Date:From;	b=IQjM497gq1t9CSFMNwhmeT2X262mWhhXCZtRJeeKU0J//jxa/lPtUd9aF4A91AcMY	 KWg1TRteKObFoo9KPg661p54M7BN/+wVRGPYQtkxANfA8/bjdibyWIt7lwzI/SiND6	 8zt7MkV4bqkxLf1j97e3VXHHnQjOHFbDkGnkxeW4xky1i4bUUIXTZblVhmvkXBxTUN	 /8jPj+e7XKnZLTYnhRrD923FTdWVclPHYcBGaymT36whIsQxL4WxcWY8zB29T6wUgR	 1IkIIjAsEmgdcy/1/FA+Z/RIChz99N0j5AT7+M75oWmgARe9cuZNcR/SjvruizO5Sq	 qKDe9Kz58Ppyg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Prevent potential errno overwriting.
Date: Mon, 10 Feb 2020 11:43:00 -0000
Message-Id: <20200210114245.1272-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00164.txt

- In push_to_pcon_screenbuffer(), open() and ioctl() are called.
  Since push_to_pcon_screenbuffer() is called in read() and write(),
  errno which is set in read() and write() code may be overwritten
  in open() or ioctl() call. This patch prevent this situation.
---
 winsup/cygwin/fhandler_tty.cc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 260776a56..cfd4b1c44 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1412,10 +1412,13 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len,
   while (!GetConsoleMode (get_output_handle (), &dwMode))
     {
       termios_printf ("GetConsoleMode failed, %E");
+      int errno_save = errno;
       /* Re-open handles */
       this->open (0, 0);
       /* Fix pseudo console window size */
       this->ioctl (TIOCSWINSZ, &get_ttyp ()->winsize);
+      if (errno != errno_save)
+	set_errno (errno_save);
       if (++retry_count > 3)
 	goto cleanup;
     }
-- 
2.21.0
