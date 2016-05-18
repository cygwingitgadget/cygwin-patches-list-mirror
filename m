Return-Path: <cygwin-patches-return-8562-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 110039 invoked by alias); 18 May 2016 23:14:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109913 invoked by uid 89); 18 May 2016 23:14:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,SPF_PASS,TVD_RCVD_IP autolearn=ham version=3.3.2 spammy=discarded, HTo:U*cygwin-patches
X-HELO: glup.org
Received: from 216-15-121-172.c3-0.smr-ubr2.sbo-smr.ma.static.cable.rcn.com (HELO glup.org) (216.15.121.172) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 18 May 2016 23:14:29 +0000
Received: from minipixel.i.glup.org (unknown [198.206.215.41])	by glup.org (Postfix) with ESMTP id 37B21854D2;	Wed, 18 May 2016 19:14:26 -0400 (EDT)
Authentication-Results: glup.org; dmarc=none header.from=glup.org
Authentication-Results: glup.org; dkim=none (no signature)	header.i=unknown; x-dkim-adsp=fail
From: cgull@glup.org
To: cygwin-patches@cygwin.com
Cc: John Hood <cgull@glup.org>
Subject: [PATCH 3/4] Debug printfs.
Date: Wed, 18 May 2016 23:14:00 -0000
Message-Id: <1463613259-2899-3-git-send-email-cgull@glup.org>
In-Reply-To: <1463613259-2899-1-git-send-email-cgull@glup.org>
References: <1463613259-2899-1-git-send-email-cgull@glup.org>
X-SW-Source: 2016-q2/txt/msg00036.txt.bz2

From: John Hood <cgull@glup.org>

	* fhandler.cc (fhandler_base::get_readahead): Add debug code.
	* fhandler_console.cc (fhandler_console::read): Add debug code.
	* select.cc (pselect): Add debug code.
	(peek_console): Add debug code.
---
 winsup/cygwin/fhandler.cc         |  1 +
 winsup/cygwin/fhandler_console.cc | 10 +++++++++-
 winsup/cygwin/select.cc           | 12 +++++++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index 33743d4..86f77c3 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -90,6 +90,7 @@ fhandler_base::get_readahead ()
   /* FIXME - not thread safe */
   if (raixget >= ralen)
     raixget = raixput = ralen = 0;
+  debug_printf("available: %d", chret > -1);
   return chret;
 }
 
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index c510d70..e0e2813 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -309,6 +309,8 @@ fhandler_console::read (void *pv, size_t& buflen)
   int ch;
   set_input_state ();
 
+  debug_printf("requested buflen %d", buflen);
+
   /* Check console read-ahead buffer filled from terminal requests */
   if (con.cons_rapoi && *con.cons_rapoi)
     {
@@ -318,6 +320,7 @@ fhandler_console::read (void *pv, size_t& buflen)
     }
 
   int copied_chars = get_readahead_into_buffer (buf, buflen);
+  debug_printf("copied_chars %d", copied_chars);
 
   if (copied_chars)
     {
@@ -695,9 +698,11 @@ fhandler_console::read (void *pv, size_t& buflen)
 	  continue;
 	}
 
+      debug_printf("toadd = %p, nread = %d", toadd, nread);
       if (toadd)
 	{
-	  line_edit_status res = line_edit (toadd, nread, ti);
+	  ssize_t bytes_read;
+	  line_edit_status res = line_edit (toadd, nread, ti, &bytes_read);
 	  if (res == line_edit_signalled)
 	    goto sig_exit;
 	  else if (res == line_edit_input_done)
@@ -705,6 +710,8 @@ fhandler_console::read (void *pv, size_t& buflen)
 	}
     }
 
+  debug_printf("ralen = %d, bytes = %d", ralen, ralen - raixget);
+
   while (buflen)
     if ((ch = get_readahead ()) < 0)
       break;
@@ -716,6 +723,7 @@ fhandler_console::read (void *pv, size_t& buflen)
 #undef buf
 
   buflen = copied_chars;
+  debug_printf("buflen set to %d", buflen);
   return;
 
 err:
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index c0f52ec..9aa2833 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -892,18 +892,28 @@ peek_console (select_record *me, bool)
 	    if (irec.Event.KeyEvent.bKeyDown
 		&& (irec.Event.KeyEvent.uChar.AsciiChar
 		    || fhandler_console::get_nonascii_key (irec, tmpbuf)))
-	      return me->read_ready = true;
+	      {
+		debug_printf ("peeked KEY_EVENT");
+		return me->read_ready = true;
+	      }
 	  }
 	else
 	  {
 	    if (irec.EventType == MOUSE_EVENT
 		&& fh->mouse_aware (irec.Event.MouseEvent))
+	      {
+		debug_printf ("peeked MOUSE_EVENT");
 		return me->read_ready = true;
+	      }
 	    if (irec.EventType == FOCUS_EVENT && fh->focus_aware ())
+	      {
+		debug_printf ("peeked FOCUS_EVENT");
 		return me->read_ready = true;
+	      }
 	  }
 
 	/* Read and discard the event */
+	debug_printf ("discarded other event");
 	ReadConsoleInput (h, &irec, 1, &events_read);
       }
 
-- 
2.8.2
