Return-Path: <cygwin-patches-return-1702-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28310 invoked by alias); 15 Jan 2002 12:59:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28293 invoked from network); 15 Jan 2002 12:59:06 -0000
Message-ID: <C2D7D58DBFE9D111B0480060086E96350689B7D0@mail_server.gft.com>
From: "Schaible, Jorg" <Joerg.Schaible@gft.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: RE: A few fixes to winsup/utils/cygpath.cc
Date: Tue, 15 Jan 2002 04:59:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-SW-Source: 2002-q1/txt/msg00059.txt.bz2

Hi Corinna (possibly I should not perosnalize this mail, since it will be
sent to the list again),

>> Hi Chris,
>
>Sorry but you're sending that stuff to cygwin-patches,
>not to a single person.  Please don't personalize your patches.

I thought, it is normal within a thread. I anwered to a posting of Chris.

>It could happen that nobody takes a look.

Therefore I sent the last message to cygwin-apps as I recognized, that
another change for cygpath is in the pipeline.

>Your attached patch look like a reverse patch.  And it's using
>the wrong format.  Please send patches using diff -u format.

Uuups. Right. Sorry. Here it comes again.

============================
--- cygpath.cc  Mon Jan 14 08:28:04 2002
+++ cygpath.cc-orig     Mon Jan 14 08:16:22 2002
@@ -161,13 +161,8 @@
       len = strlen (filename) + 100;
       if (len == 100)
         {
-          if (!ignore_flag)
-          {
-            fprintf(stderr, "%s: can't convert empty path\n", prog_name);
-            exit (1);
-          }
-          else
-            exit (0);
+          fprintf(stderr, "%s: can't convert empty path\n", prog_name);
+          exit (1);
         }
     }
   else
============================

Regards,
Jorg
