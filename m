Return-Path: <cygwin-patches-return-9827-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26354 invoked by alias); 11 Nov 2019 17:31:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26343 invoked by uid 89); 11 Nov 2019 17:31:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 11 Nov 2019 17:31:52 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id UDXZiQ4RG17ZDUDXaiDnR4; Mon, 11 Nov 2019 10:31:50 -0700
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH] regtool: allow /proc/registry{,32,64}/ registry path prefix
Date: Mon, 11 Nov 2019 17:31:00 -0000
Message-Id: <20191111172859.39062-1-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20191110161445.53479-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20191110161445.53479-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00098.txt.bz2

The user can supply the registry path prefix /proc/registry{,32,64}/ to
use path completion.
---
 winsup/doc/utils.xml    |  7 +++++--
 winsup/utils/regtool.cc | 17 ++++++++++++++---
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 043ed7358..5f266bcb1 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -1976,8 +1976,11 @@ remote host in either \\hostname or hostname: format and prefix is any of:
   users    HKU   HKEY_USERS
 
 You can use forward slash ('/') as a separator instead of backslash, in
-that case backslash is treated as escape character
-Example: regtool get '\user\software\Microsoft\Clock\iFormat'
+that case backslash is treated as an escape character.
+You can also supply the registry path prefix /proc/registry{,32,64}/ to
+use path completion.
+Example:
+  regtool list '/HKLM/SOFTWARE/Classes/MIME/Database/Content Type/audio\\/wav'
 </screen>
     </refsect1>
 
diff --git a/winsup/utils/regtool.cc b/winsup/utils/regtool.cc
index a44d90768..f91e61d00 100644
--- a/winsup/utils/regtool.cc
+++ b/winsup/utils/regtool.cc
@@ -166,11 +166,13 @@ usage (FILE *where = stderr)
       "  machine  HKLM  HKEY_LOCAL_MACHINE\n"
       "  users    HKU   HKEY_USERS\n"
       "\n"
-      "If the keyname starts with a forward slash ('/'), the forward slash is used\n"
-      "as separator and the backslash can be used as escape character.\n");
+      "You can use forward slash ('/') as a separator instead of backslash, in\n"
+      "that case backslash is treated as an escape character.\n"
+      "You can also supply the registry path prefix /proc/registry{,32,64}/ to\n"
+      "use path completion.\n");
       fprintf (where, ""
       "Example:\n"
-      "%s list '/machine/SOFTWARE/Classes/MIME/Database/Content Type/audio\\/wav'\n\n", prog_name);
+      "%s list '/HKLM/SOFTWARE/Classes/MIME/Database/Content Type/audio\\/wav'\n\n", prog_name);
     }
   if (where == stderr)
     fprintf (where,
@@ -350,6 +352,15 @@ find_key (int howmanyparts, REGSAM access, int option = 0)
       *h = 0;
       n = e;
     }
+  else if (strncmp ("\\proc\\registry", n, strlen ("\\proc\\registry")) == 0)
+    {
+      /* skip /proc/registry{,32,64}/ prefix */
+      n += strlen ("\\proc\\registry");
+      if (strncmp ("64", n, strlen ("64")) == 0)
+        n += strlen ("64");
+      else if (strncmp ("32", n, strlen ("32")) == 0)
+        n += strlen ("32");
+    }
   while (*n != '\\')
     n++;
   *n++ = 0;
-- 
2.21.0
