Return-Path: <SRS0=BFuG=DY=lesderid.net=les@sourceware.org>
Received: from anna.lesderid.net (anna.lesderid.net [178.62.57.241])
	by sourceware.org (Postfix) with ESMTP id B45FB3858416
	for <cygwin-patches@cygwin.com>; Mon,  7 Aug 2023 10:13:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B45FB3858416
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=lesderid.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=lesderid.net
DKIM-Signature: a=rsa-sha256; bh=tbZye0QNfvzeUMFXzS2c7GtYXKYTHqo93UrTrUbp29U=;
 c=relaxed/relaxed; d=lesderid.net;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@lesderid.net; s=default; t=1691403214; v=1; x=1691835214;
 b=c+cG8DQg5dk8D4gWpj2aSPm+hS1fCCyOTBvYxakKROrEkG75jXiq3lmeZQDwL6EzDKWuPolK
 Teo3jU4/w4x5AWueZvmOvwhp/9VRRTmJIrPiQ9p+UG4TWiPKxMifDZ0f6nui9eKWdN3/C7RzkP7
 bggdQsioUbjsaNl9U1jxXdzs70LwFKl4fqBw59eiOLmJTxkncBvJ+uSWvJp5mKIk09DCZNutA7L
 is1qEc6ZMo1DmON6nOtiNgAxYX9Yuy1UkCQpoFZCctTfXRR0tOCldzUtKDiPOqBZ0tQwg64dToB
 tCehQA5DryBo0yyh1bQWqbi483jf8Kpxz6qKPqHd2nE2w==
Received: by anna.lesderid.net (envelope-sender <les@lesderid.net>) with
 ESMTPS id c61b3c35; Mon, 07 Aug 2023 12:13:34 +0200
From: Les De Ridder <les@lesderid.net>
To: cygwin-patches@cygwin.com
Cc: Les De Ridder <les@lesderid.net>
Subject: [PATCH 2/2] Use init_reopen_attr in mmap
Date: Mon,  7 Aug 2023 03:13:15 -0700
Message-ID: <8ae84e831e6323f8d4e08b8c426b9a50dbd1cab4.1690932049.git.les@lesderid.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690932049.git.les@lesderid.net>
References: <cover.1690932049.git.les@lesderid.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-14.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Calling mmap on a file stored on a volume with buggy file re-opening
currently bugchecks. This commit solves this by using the
init_reopen_attr helper function.

Signed-off-by: Les De Ridder <les@lesderid.net>
---
 winsup/cygwin/mm/mmap.cc | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/mm/mmap.cc b/winsup/cygwin/mm/mmap.cc
index 332c015a7..23bbc3a98 100644
--- a/winsup/cygwin/mm/mmap.cc
+++ b/winsup/cygwin/mm/mmap.cc
@@ -956,11 +956,10 @@ mmap (void *addr, size_t len, int prot, int flags, int fd, off_t off)
       HANDLE h;
       IO_STATUS_BLOCK io;
 
-      InitializeObjectAttributes (&attr, &ro_u_empty, fh->pc.objcaseinsensitive (),
-				  fh->get_handle (), NULL);
       status = NtOpenFile (&h,
 			   fh->get_access () | GENERIC_EXECUTE | SYNCHRONIZE,
-			   &attr, &io, FILE_SHARE_VALID_FLAGS,
+			   fh->pc.init_reopen_attr (attr, h), &io,
+			   FILE_SHARE_VALID_FLAGS,
 			   FILE_SYNCHRONOUS_IO_NONALERT
 			   | FILE_OPEN_FOR_BACKUP_INTENT);
       if (NT_SUCCESS (status))
-- 
2.41.0

