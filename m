Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id ACAF94BC895E; Mon, 26 Jan 2026 10:29:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ACAF94BC895E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1769423350;
	bh=mvVgyy2SiDldUhNgU7I8ZkoWJfYGO+HRp6euB3PxoZo=;
	h=From:To:Subject:Date:From;
	b=A45XIvQ47Ib+VCI4yZKrxY5Fe3id966DBUB1s7gl5J9rrVn4v9JN6EekoWVjpfRg/
	 L0n0nDoRPwAtHK6HsUi+b5EbJ2jYZVrXidq96BUnakF0giaonQ1ZnKo9MoioZd4v7W
	 ppYGVxX0YapmpdgfHYtW+qlO7NMy9nYS1IPwTifA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B9DE5A81CEE; Mon, 26 Jan 2026 11:29:08 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: setrlimit: Allow raising hard limit to admin users
Date: Mon, 26 Jan 2026 11:29:08 +0100
Message-ID: <20260126102908.382993-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/resource.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/resource.cc b/winsup/cygwin/resource.cc
index 5ec436c2cfa4..9dfe36b13e36 100644
--- a/winsup/cygwin/resource.cc
+++ b/winsup/cygwin/resource.cc
@@ -314,7 +314,8 @@ setrlimit (int resource, const struct rlimit *rlp)
 	  __leave;
 	}
 
-      if (rlp->rlim_cur > oldlimits.rlim_max)
+      if (rlp->rlim_max > oldlimits.rlim_max
+	  && !check_token_membership (well_known_admins_sid))
 	{
 	  set_errno (EPERM);
 	  __leave;
-- 
2.52.0

