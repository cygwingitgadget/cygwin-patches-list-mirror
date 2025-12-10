Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BB7264BA2E05; Wed, 10 Dec 2025 17:32:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BB7264BA2E05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765387923;
	bh=i6tJgLqnoZzwC+wkYaPD3C7QFCaOiuaGAc0DJluzdG0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n2MFbYPvx3ok9I5sGrtmTWTxP4u/1D6ki2mkfOXAZgtjyddgIZn4MrkMe7+B/E9/1
	 xxp3NIGGdrlpBMhXIIEohmBJNLts/Gaaht1Thi0NRV/ZxeqDZeTs2b37xj+XCLb1gl
	 daYfDJkS2wQTlWEQOn3gUxwDpPbOIPkkPIm8emjQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BCAD4A80CA4; Wed, 10 Dec 2025 18:32:01 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/3] Cygwin: newgrp(1): improve POSIX compatibility
Date: Wed, 10 Dec 2025 18:31:59 +0100
Message-ID: <20251210173201.193740-2-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210173201.193740-1-corinna-cygwin@cygwin.com>
References: <20251210173201.193740-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

- allow calling without argument
- allow not only - but also -l to regenerate stock environment
- allow numerical group IDs
- In usage output, advertise -l instead of - and do not advertise
  the ability to run an arbitrary command instead of just a new shell

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/utils/newgrp.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/winsup/utils/newgrp.c b/winsup/utils/newgrp.c
index 414e8cdf8edc..25cdd842da02 100644
--- a/winsup/utils/newgrp.c
+++ b/winsup/utils/newgrp.c
@@ -140,16 +140,18 @@ main (int argc, const char **argv)
 
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
+	  /* Advertise POSIX compatibility in the first place.  Do not
+	     advertise the single dash as valid option (per Linux) and
+	     do not advertise the ability to run an arbitrary command. */
+	  fprintf (stderr, "Usage: %s [-l] [group]\n",
+		   program_invocation_short_name);
+	  return 1;
+	}
       new_child_env = true;
       --argc;
       ++argv;
@@ -165,8 +167,16 @@ main (int argc, const char **argv)
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
2.52.0

