Return-Path: <cygwin-patches-return-9185-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113407 invoked by alias); 28 Oct 2018 19:23:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113270 invoked by uid 89); 28 Oct 2018 19:23:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=reset, destructor, HContent-Transfer-Encoding:8bit
X-HELO: mail-qt1-f196.google.com
Received: from mail-qt1-f196.google.com (HELO mail-qt1-f196.google.com) (209.85.160.196) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 28 Oct 2018 19:23:13 +0000
Received: by mail-qt1-f196.google.com with SMTP id z2-v6so6928930qts.1        for <cygwin-patches@cygwin.com>; Sun, 28 Oct 2018 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com; s=20161025;        h=from:to:cc:subject:date:message-id:in-reply-to:references         :mime-version:content-transfer-encoding;        bh=6TKEL98mu7Lek9YaSINPqbQV210aP/EXJwhGil3Hi4g=;        b=IjOAZx2wGJX92uWDrab/pPDLbIbEjCWYkHVNqbVDmvfQV0IxbGC17vVIi2CkR0n9cn         AOJf/nbXMddVRUdZ5MKD7On8Tg8UQ3wL2jz05tQCMo2iKf2DbNx8mDlVKL8PzC3e8Iol         UftPQT7tBeHPV9zDRAgKMrzJ1geToHLBAkULJtMUw1D0fzIeXr0Ct/0ovib03kq0ACOH         eoA8JeUt0ui9DsoKMavHeaeG0XLbiXeclTJEBfufR+0GjBbvkoir6ceyAhX9ZxlVufNJ         fdH+rhOUF8KCPfPjOiNU0N+oHTGPFtSiG6f9sIiruvRQBEvPS/Wvd79vmevTFO1GT1It         tfMg==
Return-Path: <corngood@gmail.com>
Received: from localhost.localdomain ([134.41.199.109])        by smtp.gmail.com with ESMTPSA id c21-v6sm9485363qtn.82.2018.10.28.12.23.11        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Sun, 28 Oct 2018 12:23:11 -0700 (PDT)
From: David McFarland <corngood@gmail.com>
To: cygwin-patches@cygwin.com
Cc: David McFarland <corngood@gmail.com>
Subject: [PATCH 1/1] Cygwin: Fix cygheap corruption caused by cloned atomic buffer
Date: Sun, 28 Oct 2018 19:23:00 -0000
Message-Id: <20181028192244.4750-2-corngood@gmail.com>
In-Reply-To: <20181028192244.4750-1-corngood@gmail.com>
References: <20181028192244.4750-1-corngood@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SW-Source: 2018-q4/txt/msg00001.txt.bz2

The fhandler_base_overlapped::copyto clears atomic_write_buf on the
clone, but none of the derived classes were doing this.  This allowed
the destructor to double-free the buffer and corrupt cygheap.
Clear atomic_write_buf in copyto of all derived classes.
---
 winsup/cygwin/fhandler.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 2cc99d713..9e63867ab 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1216,6 +1216,7 @@ public:
   {
     x->pc.free_strings ();
     *reinterpret_cast<fhandler_pipe *> (x) = *this;
+    reinterpret_cast<fhandler_pipe *> (x)->atomic_write_buf = NULL;
     x->reset (this);
   }
 
@@ -1256,6 +1257,7 @@ public:
   {
     x->pc.free_strings ();
     *reinterpret_cast<fhandler_fifo *> (x) = *this;
+    reinterpret_cast<fhandler_fifo *> (x)->atomic_write_buf = NULL;
     x->reset (this);
   }
 
-- 
2.19.1
