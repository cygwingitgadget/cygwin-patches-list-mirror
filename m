Return-Path: <cygwin-patches-return-9407-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3263 invoked by alias); 13 May 2019 14:37:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3250 invoked by uid 89); 13 May 2019 14:37:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 May 2019 14:37:19 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 16:36:24 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hQC3z-0007OI-Tk; Mon, 13 May 2019 16:36:23 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH] Cygwin: dll_list: no recursive use of nt_max_path_buf
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <e41869fa-977e-4b5e-c749-f3c4ba314c29@ssi-schaefer.com>
Date: Mon, 13 May 2019 14:37:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00114.txt.bz2

Querying the ntlength and existence of the /var/run/cygfork directory in
the very first Cygwin process should not use nt_max_path_buf, as that
one is used by dll_list::alloc already.
---
 winsup/cygwin/forkable.cc | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
index 4fbc2abb3..350a95c3e 100644
--- a/winsup/cygwin/forkable.cc
+++ b/winsup/cygwin/forkable.cc
@@ -472,17 +472,21 @@ dll_list::forkable_ntnamesize (dll_type type, PCWCHAR fullntname, PCWCHAR modnam
   if (cygwin_shared->forkable_hardlink_support == 0) /* Unknown */
     {
       /* check existence of forkables dir */
-      PWCHAR pbuf = nt_max_path_buf ();
+      /* nt_max_path_buf () is already used in dll_list::alloc.
+         But as this is run in the very first cygwin process only,
+	 using some heap is not a performance issue here. */
+      PWCHAR pbuf = (PWCHAR) cmalloc_abort (HEAP_BUF,
+					    NT_MAX_PATH * sizeof (WCHAR));
+      PWCHAR pnext = pbuf;
       for (namepart const *part = forkable_nameparts; part->text; ++part)
 	{
 	  if (part->textfunc)
-	    pbuf += part->textfunc (pbuf, -1);
+	    pnext += part->textfunc (pnext, -1);
 	  else
-	    pbuf += __small_swprintf (pbuf, L"%W", part->text);
+	    pnext += __small_swprintf (pnext, L"%W", part->text);
 	  if (part->mutex_from_dir)
 	    break; /* up to first mutex-naming dir */
 	}
-      pbuf = nt_max_path_buf ();
 
       UNICODE_STRING fn;
       RtlInitUnicodeString (&fn, pbuf);
@@ -504,6 +508,7 @@ dll_list::forkable_ntnamesize (dll_type type, PCWCHAR fullntname, PCWCHAR modnam
 	  cygwin_shared->forkable_hardlink_support = -1; /* No */
 	  debug_printf ("disabled, missing or not on NTFS %W", fn.Buffer);
 	}
+      cfree (pbuf);
     }
 
   if (!forkables_supported ())
-- 
2.19.2
