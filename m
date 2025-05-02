Return-Path: <SRS0=vR1J=XS=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 5028A3858D20
	for <cygwin-patches@cygwin.com>; Fri,  2 May 2025 04:57:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5028A3858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5028A3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746161827; cv=none;
	b=kiGy/wHk4O50BtiLdyYV/ZZAr1fvhaj9/f7S7Gu7E9ht6Ut6nV+ZI8Pa2i4Li8XtWdDjJ5Ej/k8mP8ZxRsPM9RSZ7mXy2j1t9YP3gh3l7Ekd0I4EqmNpH5pNaoWtHFeo+tHwe3ZkDJdeOYu2pOa2TcEl30ryT8/AWWfOTmV5Ah4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746161827; c=relaxed/simple;
	bh=YKF82X1BC8CiP7EnfblfnxcbKUdoZ28zf+7KDM7NDTE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Kev9Z426mSb5cD3q1nFk5EMKw9vYta6llSzHNdIapQ8R0ovzGs3Vcu9oPcyOSq2oCB9M27wZ/K9+atVhUpRT106gmLWensRFEmb6z+0MQxxpgLdhhFoYBPDJ8nf+vaowDTg8uosFB3JyirIzpojONs57Wo7RXPznKZqTwnVkLRk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5028A3858D20
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 54251r9f097820;
	Thu, 1 May 2025 22:01:53 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdAKsqqt; Thu May  1 22:01:46 2025
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>, Collin Funk <collin.funk1@gmail.com>
Subject: [PATCH] Cygwin: Update search.h functions for POSIX.1-2024
Date: Thu,  1 May 2025 21:56:48 -0700
Message-ID: <20250502045656.833-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Add type posix_tnode.  Change certain uses of "void" to "posix_tnode" in
both the prototypes and definitions of functions associated with <search.h>.

(Necessary changes to Newlib's /libc/include/search.h have already been
submitted in a patch sent to newlib@sourceware.org.)

Reported-by: Collin Funk <collin.funk1@gmail.com>
Addresses: https://cygwin.com/pipermail/cygwin/2025-April/258032.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: ec98d19a08c2 "* wininfo.h (wininfo::timer_active): Delete."

---
 winsup/cygwin/include/search.h | 10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/include/search.h b/winsup/cygwin/include/search.h
index f532eae55..7c6d7b4cf 100644
--- a/winsup/cygwin/include/search.h
+++ b/winsup/cygwin/include/search.h
@@ -39,6 +39,8 @@ typedef	struct node
 } node_t;
 #endif
 
+typedef void posix_tnode;
+
 struct hsearch_data
 {
   struct internal_head *htable;
@@ -58,13 +60,13 @@ ENTRY *hsearch (ENTRY, ACTION);
 int hcreate_r (size_t, struct hsearch_data *);
 void hdestroy_r (struct hsearch_data *);
 int hsearch_r (ENTRY, ACTION, ENTRY **, struct hsearch_data *);
-void *tdelete (const void * __restrict, void ** __restrict,
+void *tdelete (const void * __restrict, posix_tnode ** __restrict,
 	       int (*) (const void *, const void *));
 void tdestroy (void *, void (*)(void *));
-void *tfind (const void *, void **,
+posix_tnode *tfind (const void *, posix_tnode *const *,
 	     int (*) (const void *, const void *));
-void *tsearch (const void *, void **, int (*) (const void *, const void *));
-void  twalk (const void *, void (*) (const void *, VISIT, int));
+posix_tnode *tsearch (const void *, posix_tnode **, int (*) (const void *, const void *));
+void  twalk (const posix_tnode *, void (*) (const posix_tnode *, VISIT, int));
 void *lfind (const void *, const void *, size_t *, size_t,
 	     int (*) (const void *, const void *));
 void *lsearch (const void *, void *, size_t *, size_t,
-- 
2.45.1

