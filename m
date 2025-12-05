Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 934EA4C900C5; Fri,  5 Dec 2025 19:42:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 934EA4C900C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764963722;
	bh=hJxzc2P8j3ZGH0NK01pZZOYDOe9LPeptno3TpOAV0DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXw5RjlkWqN3hKvS+hbtkQ/2MnbqBBGoW720GNyHIO6Ugy9Q6NdbxQIj2GJcrL8wQ
	 SQ/5ghiYA0TvOk5CUKB19jU2lvBrBSvuyCUmo0zJkz08iJeJwvgnUp8Mh3VOPrBFFb
	 Dbl1hrZEcuCnm0Z6IANUgHIduPULqPGHxxoUFx94=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C811EA804D5; Fri, 05 Dec 2025 20:42:00 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Marco Atzeri <marco.atzeri@gmail.com>
Subject: [PATCH 1/3] Cygwin: newgrp(1): improve POSIX compatibility
Date: Fri,  5 Dec 2025 20:41:58 +0100
Message-ID: <20251205194200.4011206-2-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205194200.4011206-1-corinna-cygwin@cygwin.com>
References: <20251205194200.4011206-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

- allow calling without argument
- allow not only - but also -l to regenerate stock environment
- allow numerical group IDs
- do not advertise the ability to run an arbitrary command instead
  of just starting a new shell

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/utils/newgrp.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/winsup/utils/newgrp.c b/winsup/utils/newgrp.c
index 414e8cdf8edc..da54637c57d2 100644
--- a/winsup/utils/newgrp.c
+++ b/winsup/utils/newgrp.c
@@ -140,16 +140,16 @@ main (int argc, const char **argv)
 
   setlocale (LC_ALL, "");
 
-  if (argc < 2 || (argv[1][0] == '-' && argv[1][1]))
-    {
-      fprintf (stderr, "Usage: %s [-] [group] [command [args...]]\n",
-	       program_invocation_short_name);
-      return 1;
-    }
-
   /* Check if we have to regenerate a stock environment */
-  if (argv[1][0] == '-')
+  if (argc > 1 && argv[1][0] == '-')
     {
+      if (argv[1][1] != '\0' && strcmp (argv[1], "-l") != 0)
+	{
+	  /* Do not advertise the ability to run an arbitrary command. */
+	  fprintf (stderr, "Usage: %s [-] [group]\n",
+		   program_invocation_short_name);
+	  return 1;
+	}
       new_child_env = true;
       --argc;
       ++argv;
@@ -165,8 +165,16 @@ main (int argc, const char **argv)
     }
   else
     {
-      gr = getgrnam (argv[1]);
-      if (!gr)
+      char *eptr;
+
+      if ((gr = getgrnam (argv[1])) != NULL)
+	/*valid*/;
+      else if (isdigit ((int) argv[1][0])
+	       && (gid = strtoul (argv[1], &eptr, 10)) != ULONG_MAX
+	       && *eptr == '\0'
+	       && (gr = getgrgid (gid)) != NULL)
+	/*valid*/;
+      else
 	{
 	  fprintf (stderr, "%s: group '%s' does not exist\n",
 		   program_invocation_short_name, argv[1]);
-- 
2.51.1

