Return-Path: <cygwin-patches-return-9401-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121192 invoked by alias); 3 May 2019 15:32:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 121182 invoked by uid 89); 3 May 2019 15:32:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=touched, Rather, considering
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 May 2019 15:32:29 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 17:32:27 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hMaAk-0003Bw-Pp; Fri, 03 May 2019 17:32:26 +0200
Subject: Re: [rebase PATCH] Introduce --recognize flag (WAS: Introduce --no-rebase flag)
To: cygwin-patches@cygwin.com
References: <20190412180302.GF4248@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <319c9949-6e00-2c18-f1d0-a88a7f02fdab@ssi-schaefer.com>
Date: Fri, 03 May 2019 15:32:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412180302.GF4248@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------2A38CC758DDBB37BCE4F070E"
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00108.txt.bz2

This is a multi-part message in MIME format.
--------------2A38CC758DDBB37BCE4F070E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 270


On 4/12/19 8:03 PM, Corinna Vinschen wrote:
> On Apr 12 15:52, Michael Haubenwallner wrote:
>> The --no-rebase flag is to update the database for new files, without
> Wouldn't something like --merge-files be more descriptive?

What about --recognize ?

Thanks!
/haubi/

--------------2A38CC758DDBB37BCE4F070E
Content-Type: text/x-patch;
 name="0001-Introduce-recognize-flag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Introduce-recognize-flag.patch"
Content-length: 6057

From 5e9a2331143ac666e068a358187cd7a59c4a562d Mon Sep 17 00:00:00 2001
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Date: Fri, 12 Apr 2019 10:26:46 +0200
Subject: [PATCH] Introduce --recognize flag.

The --recognize flag is to update the database for new files, without
performing a rebase.  The file names provided should have been rebased
using the --oblivious flag just before.
---
 rebase.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/rebase.c b/rebase.c
index 56537d6..e1c6b80 100644
--- a/rebase.c
+++ b/rebase.c
@@ -72,6 +72,7 @@ BOOL down_flag = FALSE;
 BOOL image_info_flag = FALSE;
 BOOL image_storage_flag = FALSE;
 BOOL image_oblivious_flag = FALSE;
+BOOL perform_rebase_flag = TRUE;
 BOOL force_rebase_flag = FALSE;
 ULONG offset = 0;
 int args_index = 0;
@@ -533,9 +534,9 @@ load_image_info ()
       {
 	img_info_list[i].name = NULL;
 	/* Ensure that existing database entries are not touched when
-	 *  --oblivious is active, even if they are out-of sync with
-	 *  reality. */
-	if (image_oblivious_flag)
+	 *  --oblivious or --recognize is active, even if they are
+	 *  out-of sync with reality. */
+	if (image_oblivious_flag || !perform_rebase_flag)
 	  img_info_list[i].flag.cannot_rebase = 2;
       }
   /* Eventually read the strings. */
@@ -584,8 +585,8 @@ load_image_info ()
 static BOOL
 set_cannot_rebase (img_info_t *img)
 {
-  /* While --oblivious is active, cannot_rebase is set to 2 on loading
-   * the database entries */
+  /* While --oblivious or --recognize is active, cannot_rebase
+   * is set to 2 on loading the database entries */
   if (img->flag.cannot_rebase <= 1 )
     {
       int fd = open (img->name, O_WRONLY);
@@ -878,7 +879,7 @@ collect_image_info (const char *pathname)
 
   /* Skip if not rebaseable, but only if we're collecting for rebasing,
      not if we're collecting for printing only. */
-  if (!image_info_flag && !is_rebaseable (pathname))
+  if (perform_rebase_flag && !is_rebaseable (pathname))
     {
       if (!quiet)
 	fprintf (stderr, "%s: skipped because not rebaseable\n", pathname);
@@ -928,8 +929,16 @@ collect_image_info (const char *pathname)
     }
   img_info_list[img_info_size].slot_size
     = roundup2 (img_info_list[img_info_size].size, ALLOCATION_SLOT);
-  img_info_list[img_info_size].flag.needs_rebasing = 1;
-  img_info_list[img_info_size].flag.cannot_rebase = 0;
+  if (perform_rebase_flag)
+    {
+      img_info_list[img_info_size].flag.needs_rebasing = 1;
+      img_info_list[img_info_size].flag.cannot_rebase = 0;
+    }
+  else
+    {
+      img_info_list[img_info_size].flag.needs_rebasing = 0;
+      img_info_list[img_info_size].flag.cannot_rebase = 2;
+    }
   /* This back and forth from POSIX to Win32 is a way to get a full path
      more thoroughly.  For instance, the difference between /bin and
      /usr/bin will be eliminated. */
@@ -970,7 +979,9 @@ collect_image_info (const char *pathname)
   }
 #endif
   if (verbose)
-    fprintf (stderr, "rebasing %s because filename given on command line\n", img_info_list[img_info_size].name);
+    fprintf (stderr, "%s %s because filename given on command line\n",
+	     perform_rebase_flag ? "rebasing" : "considering",
+	     img_info_list[img_info_size].name);
   ++img_info_size;
   return TRUE;
 }
@@ -1173,6 +1184,7 @@ static struct option long_options[] = {
   {"offset",	required_argument, NULL, 'o'},
   {"oblivious",	no_argument,	   NULL, 'O'},
   {"quiet",	no_argument,	   NULL, 'q'},
+  {"recognize",	no_argument,	   NULL, 'R'},
   {"database",	no_argument,	   NULL, 's'},
   {"touch",	no_argument,	   NULL, 't'},
   {"filelist",	required_argument, NULL, 'T'},
@@ -1182,7 +1194,7 @@ static struct option long_options[] = {
   {NULL,	no_argument,	   NULL,  0 }
 };
 
-static const char *short_options = "48b:dhino:OqstT:vV";
+static const char *short_options = "48b:dhino:OqRstT:vV";
 
 void
 parse_args (int argc, char *argv[])
@@ -1212,6 +1224,7 @@ parse_args (int argc, char *argv[])
 	  break;
 	case 'i':
 	  image_info_flag = TRUE;
+	  perform_rebase_flag = FALSE;
 	  break;
 	case 'o':
 	  offset = string_to_ulonglong (optarg);
@@ -1220,6 +1233,10 @@ parse_args (int argc, char *argv[])
 	case 'q':
 	  quiet = TRUE;
 	  break;
+	case 'R':
+	  perform_rebase_flag = FALSE;
+	  image_storage_flag = TRUE;
+	  break;
 	case 'O':
 	  image_oblivious_flag = TRUE;
 	  /* -O implies -s, which in turn implies -d, so intentionally
@@ -1264,8 +1281,8 @@ parse_args (int argc, char *argv[])
 	}
     }
 
-  if ((image_base == 0 && !image_info_flag && !image_storage_flag)
-      || (image_base && image_info_flag))
+  if ((image_base == 0 && perform_rebase_flag && !image_storage_flag)
+      || (force_rebase_flag && !perform_rebase_flag))
     {
       usage ();
       exit (1);
@@ -1399,11 +1416,16 @@ Rebase PE files, usually DLLs, to a specified address or address range.\n\
   -O, --oblivious         Do not change any files already in the database\n\
                           and do not record any changes to the database.\n\
                           (Implies -s).\n\
+  -R, --recognize         Do not perform any rebase, update the database only.\n\
+                          Implies -s, incompatible with -b and -o.\n\
+                          The files listed should have been rebased just before\n\
+                          using the -O flag (maybe in some staging directory).\n\
   -i, --info              Rather then rebasing, just print the current base\n\
                           address and size of the files.  With -s, use the\n\
                           database.  The files are ordered by base address.\n\
                           A '*' at the end of the line is printed if a\n\
                           collisions with an adjacent file is detected.\n\
+                          Incompatible with -b and -o.\n\
 \n\
   One of the options -b, -s or -i is mandatory.  If no rebase database exists\n\
   yet, -b is required together with -s.\n\
-- 
2.19.2


--------------2A38CC758DDBB37BCE4F070E--
