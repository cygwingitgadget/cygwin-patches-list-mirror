Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 64E363858C1F; Wed, 12 Jul 2023 12:08:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 64E363858C1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689163686;
	bh=yjr9XDahzq706OOYDC1mcP/v6PIIQUQrhagL7Fm66ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oWDRtZ+1a3t26DSbumHEPv9j0S4AXptb/4cUBT5U43D3810hQ37SnRuvguutAJ1he
	 1wwTOM2z2zBmjzRDIDh33RUW8B+HOGrolt5U7TFAkijgwkpjsnL6TdXxy8a5PNZLH6
	 zfhRhKgSDIuUmyJ/2RUdm0JVZPM/dziKg1HxV6Uo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 969C6A8045C; Wed, 12 Jul 2023 14:08:04 +0200 (CEST)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/5] Cygwin: gen_full_path_at: drop never reached code
Date: Wed, 12 Jul 2023 14:08:00 +0200
Message-Id: <20230712120804.2992142-2-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
References: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

The check if the local variable p is NULL is useless.  The preceeding
code always sets p to a valid pointer, or it crashes if path_ret is
invalid (which would be a bug in Cygwin).

Fixes:c57b57e5c43a ("* cygwin.din: Sort.")
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/syscalls.cc | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 73343ecc1f07..f0ef8955cee8 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4447,11 +4447,6 @@ gen_full_path_at (char *path_ret, int dirfd, const char *pathname,
 	    }
 	  p = stpcpy (path_ret, cfd->get_name ());
 	}
-      if (!p)
-	{
-	  set_errno (ENOTDIR);
-	  return -1;
-	}
       if (pathname)
 	{
 	  if (!*pathname)
-- 
2.40.1

