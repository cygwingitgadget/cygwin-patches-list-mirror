Return-Path: <cygwin-patches-return-9820-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 84224 invoked by alias); 10 Nov 2019 16:17:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 84210 invoked by uid 89); 10 Nov 2019 16:17:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.8 required=5.0 tests=AWL,BAYES_20,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=completion, Database, slash, H*RU:sk:smtp-ou
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 10 Nov 2019 16:17:12 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id TptliHqu417ZDTptmiB0a7; Sun, 10 Nov 2019 09:17:10 -0700
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH] regtool: Ignore /proc/registry{,32,64}/ prefix, with  forward or backslashes, allowing path completion
Date: Sun, 10 Nov 2019 16:17:00 -0000
Message-Id: <20191110161445.53479-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00091.txt.bz2

---
 winsup/utils/regtool.cc | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/winsup/utils/regtool.cc b/winsup/utils/regtool.cc
index a44d90768..ddb1304cd 100644
--- a/winsup/utils/regtool.cc
+++ b/winsup/utils/regtool.cc
@@ -167,7 +167,9 @@ usage (FILE *where = stderr)
       "  users    HKU   HKEY_USERS\n"
       "\n"
       "If the keyname starts with a forward slash ('/'), the forward slash is used\n"
-      "as separator and the backslash can be used as escape character.\n");
+      "as separator and the backslash can be used as escape character.\n"
+      "If the keyname starts with /proc/registry{,32,64}/, using forward or backward\n"
+      "slashes, allowing path completion, that part of the prefix is ignored.\n");
       fprintf (where, ""
       "Example:\n"
       "%s list '/machine/SOFTWARE/Classes/MIME/Database/Content Type/audio\\/wav'\n\n", prog_name);
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
