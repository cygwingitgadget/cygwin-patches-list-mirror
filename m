Return-Path: <cygwin-patches-return-4879-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21240 invoked by alias); 25 Jul 2004 15:08:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21228 invoked from network); 25 Jul 2004 15:08:38 -0000
Message-Id: <3.0.5.32.20040725110452.00808100@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 25 Jul 2004 15:08:00 -0000
To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>,
 <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: RE: Fix dup for /dev/dsp
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00031.txt.bz2

Gert,

As a proof of concept, here is a patch that fixes "dup" and
"cat xxx.wav > /dev/dsp", under sh and bash (they use different
mechanisms). There is no linked list and no archetype, so some parameters
are still not shared between duped handles in the same process.

The fixes are as discussed yesterday. Note that "new" cannot be used
in fixup-after-exec. Thus it's called on demand in ::write and 
::read.  ::ioctl remains to be fixed in a similar fashion, and 
the (now useless) allocation of audio_X_ can be removed from ::open.

Pierre

Index: fhandler_dsp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_dsp.cc,v
retrieving revision 1.38
diff -u -p -r1.38 fhandler_dsp.cc
--- fhandler_dsp.cc     19 Jul 2004 13:13:48 -0000      1.38
+++ fhandler_dsp.cc     25 Jul 2004 15:00:00 -0000
@@ -1105,7 +1105,7 @@ fhandler_dev_dsp::open (int flags, mode_
       rc = 1;
       set_open_status ();
       need_fork_fixup (true);
-      close_on_exec (true);
+      nohandle (true);
     }
   else
     { /* One of the tried query () failed */
@@ -1123,6 +1123,8 @@ fhandler_dev_dsp::open (int flags, mode_
       set_errno (EBUSY);\
       return -1;\
     }
+#define IS_WRITE() ((get_flags() & O_ACCMODE) != O_RDONLY)
+#define IS_READ() ((get_flags() & O_ACCMODE) != O_WRONLY)
 
 int
 fhandler_dev_dsp::write (const void *ptr, size_t len)
@@ -1132,10 +1134,18 @@ fhandler_dev_dsp::write (const void *ptr
 
   debug_printf ("ptr=%08x len=%d", ptr, len);
   if (!audio_out_)
-    {
-      set_errno (EACCES); // device was opened for read?
-      return -1;
-    }
+    if (IS_WRITE ())
+      {
+       debug_printf ("Reallocating");
+       if (!(audio_out_ = new Audio_out))
+         return -1;
+      }
+    else
+      {
+       set_errno (EACCES); // device was opened for read?
+       return -1;
+      }
+
   RETURN_ERROR_WHEN_BUSY (audio_out_);
   if (audio_out_->getOwner () == 0L)
     { // No owner yet, lets do it
@@ -1164,11 +1174,22 @@ fhandler_dev_dsp::read (void *ptr, size_
 {
   debug_printf ("ptr=%08x len=%d", ptr, len);
   if (!audio_in_)
-    {
-      len = (size_t)-1;
-      set_errno (EACCES); // device was opened for write?
-      return;
-    }
+    if (IS_READ ())
+      {
+       debug_printf ("Reallocating");
+       if (!(audio_in_ = new Audio_in))
+         {
+           len = (size_t)-1;
+           return;
+         }
+      }
+    else
+      {
+       len = (size_t)-1;
+       set_errno (EACCES); // device was opened for write?
+       return;
+      }
+
   if (audio_in_->denyAccess ())
     {
       len = (size_t)-1;
@@ -1231,6 +1252,10 @@ fhandler_dev_dsp::dup (fhandler_base * c
   fhc->audiobits_ = audiobits_;
   fhc->audiofreq_ = audiofreq_;
   fhc->audioformat_ = audioformat_;
+  if (audio_out_)
+    fhc->audio_out_ = new Audio_out;
+  if (audio_in_)
+    fhc->audio_in_ = new Audio_in;
   return 0;
 }
 
@@ -1527,6 +1552,10 @@ fhandler_dev_dsp::fixup_after_exec ()
 {
   debug_printf ("audio_in=%08x audio_out=%08x",
                (int)audio_in_, (int)audio_out_);
+  /* Temporarily set audio_X_ to NULL.
+     "new" does not work yet */
+  audio_in_ = NULL;
+  audio_out_ = NULL;
 }
 
 
