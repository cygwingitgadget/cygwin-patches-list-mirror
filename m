Return-Path: <cygwin-patches-return-1705-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26152 invoked by alias); 15 Jan 2002 14:01:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26129 invoked from network); 15 Jan 2002 14:01:24 -0000
Message-ID: <C2D7D58DBFE9D111B0480060086E96350689B7D8@mail_server.gft.com>
From: "Schaible, Jorg" <Joerg.Schaible@gft.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: RE: A few fixes to winsup/utils/cygpath.cc
Date: Tue, 15 Jan 2002 06:01:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-SW-Source: 2002-q1/txt/msg00062.txt.bz2

>That is a reversed patch either.  That should help:

<sigh>
Sorry again.

==========================
2002-01-14  Joerg Schaible <joerg.schaible@gmx.de>

	* cygpath.cc (doit): Empty file ignored using option -i
==========================
--- cygpath.cc-orig     Mon Jan 14 08:16:22 2002
+++ cygpath.cc  Mon Jan 14 08:28:04 2002
@@ -161,8 +161,13 @@ doit (char *filename)
       len = strlen (filename) + 100;
       if (len == 100)
         {
-          fprintf(stderr, "%s: can't convert empty path\n", prog_name);
-          exit (1);
+          if (!ignore_flag)
+            {
+              fprintf(stderr, "%s: can't convert empty path\n", prog_name);
+              exit (1);
+            }
+          else
+            exit (0);
         }
     }
   else
==========================

-- Jorg
