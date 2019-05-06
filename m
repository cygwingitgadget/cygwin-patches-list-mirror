Return-Path: <cygwin-patches-return-9404-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66840 invoked by alias); 6 May 2019 08:31:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 66830 invoked by uid 89); 6 May 2019 08:31:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=inglis, Brian, brian, Inglis
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 06 May 2019 08:31:37 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 10:31:33 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hNZ24-0002eh-VS; Mon, 06 May 2019 10:31:33 +0200
Subject: Re: [rebase PATCH] Introduce --merge-files (-M) flag (WAS: Introduce --no-rebase flag)
To: cygwin-patches@cygwin.com
References: <20190412180302.GF4248@calimero.vinschen.de> <319c9949-6e00-2c18-f1d0-a88a7f02fdab@ssi-schaefer.com> <ae7bce9f-b1d6-440b-f6d6-fdca1040d56f@SystematicSw.ab.ca>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <6d8331f7-d3f5-53e6-5e55-863f8eb01693@ssi-schaefer.com>
Date: Mon, 06 May 2019 08:31:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ae7bce9f-b1d6-440b-f6d6-fdca1040d56f@SystematicSw.ab.ca>
Content-Type: multipart/mixed; boundary="------------FC6FB27DF2A3FC08755A4339"
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00111.txt.bz2

This is a multi-part message in MIME format.
--------------FC6FB27DF2A3FC08755A4339
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 1424


On 5/4/19 4:33 PM, Brian Inglis wrote:
> On 2019-05-03 09:32, Michael Haubenwallner wrote:
>> On 4/12/19 8:03 PM, Corinna Vinschen wrote:
>>> On Apr 12 15:52, Michael Haubenwallner wrote:
>>>> The --no-rebase flag is to update the database for new files, without
>>> Wouldn't something like --merge-files be more descriptive?
>> What about --recognize ?
> 
> "The --recognize flag is to update the database for new files, without
> performing a rebase.  The file names provided should have been rebased
> using the --oblivious flag just before."
> 
> Recognize does not mean record or update in English but see, identify, or
> acknowledge.
> 
> Your earlier suggestion of --record, the verb used in the comment quoted above
> --update, or CV's suggestion --merge-files would make sense and be more
> descriptive.

On a first thought, "merge files" does have a different meaning in the Gentoo
context already, as in "merge files from staging directory into the live file
system".
However, on a second thought, "rebase --merge-files" is performed afterwards,
but still part of that "merge files" phase, so the name does actually fit.

Patch updated.

> I use such brief comments or descriptions as a guide to pick the most obvious
> names for functions, options, etc: if the comment or description then reads as
> if redundant, the choice is good.

Agreed, thanks!  (had --update or even --update-db in mind as well)
/haubi/

--------------FC6FB27DF2A3FC08755A4339
Content-Type: text/x-patch;
 name="0001-Introduce-merge-files-M-flag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Introduce-merge-files-M-flag.patch"
Content-length: 6404

From 09ddd358a1d829470636158375fe606e6d2e506b Mon Sep 17 00:00:00 2001
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Date: Fri, 12 Apr 2019 10:26:46 +0200
Subject: [PATCH] Introduce --merge-files (-M) flag.

The --merge-files flag is to update the database for new files, without
performing a rebase.  The file names provided should have been rebased
using the --oblivious flag just before.
---
 rebase.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/rebase.c b/rebase.c
index 56537d6..a403c85 100644
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
+	 *  --oblivious or --merge-files is active, even if they are
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
+  /* While --oblivious or --merge-files is active, cannot_rebase
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
@@ -1170,6 +1181,7 @@ static struct option long_options[] = {
   {"help",	no_argument,	   NULL, 'h'},
   {"usage",	no_argument,	   NULL, 'h'},
   {"info",	no_argument,	   NULL, 'i'},
+  {"merge-files",no_argument,	   NULL, 'M'},
   {"offset",	required_argument, NULL, 'o'},
   {"oblivious",	no_argument,	   NULL, 'O'},
   {"quiet",	no_argument,	   NULL, 'q'},
@@ -1182,7 +1194,7 @@ static struct option long_options[] = {
   {NULL,	no_argument,	   NULL,  0 }
 };
 
-static const char *short_options = "48b:dhino:OqstT:vV";
+static const char *short_options = "48b:dhiMno:OqstT:vV";
 
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
+	case 'M':
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
@@ -1369,7 +1386,7 @@ usage ()
   fprintf (stderr,
 "usage: %s [-b BaseAddress] [-o Offset] [-48dOsvV]"
 " [-T [FileList | -]] Files...\n"
-"       %s -i [-48Os] [-T [FileList | -]] Files...\n"
+"       %s -i [-48MOs] [-T [FileList | -]] Files...\n"
 "       %s --help or --usage for full help text\n",
 	   progname, progname, progname);
 }
@@ -1399,11 +1416,16 @@ Rebase PE files, usually DLLs, to a specified address or address range.\n\
   -O, --oblivious         Do not change any files already in the database\n\
                           and do not record any changes to the database.\n\
                           (Implies -s).\n\
+  -M, --merge-files       Do not perform any rebase, update the database only.\n\
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


--------------FC6FB27DF2A3FC08755A4339--
