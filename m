Return-Path: <cygwin-patches-return-4670-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11178 invoked by alias); 11 Apr 2004 14:34:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11166 invoked from network); 11 Apr 2004 14:33:59 -0000
Message-ID: <01C41FE2.C3915C90.Gerd.Spalink@t-online.de>
From: Gerd.Spalink@t-online.de (Gerd Spalink)
Reply-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Attn cgf: missing closing brace in cygheap.h
Date: Sun, 11 Apr 2004 14:34:00 -0000
Organization: privat
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: TWkcTiZZoeua0MUfPQpRaAk6mSphSAE8D59jhp9ABQqwiYmsPRugs-
X-SW-Source: 2004-q2/txt/msg00022.txt.bz2

Just trying to get a snapshot from CVS that builds...

Gerd

Index: cygheap.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygheap.h,v
retrieving revision 1.81
diff -p -u -r1.81 cygheap.h
--- cygheap.h   11 Apr 2004 04:07:18 -0000      1.81
+++ cygheap.h   11 Apr 2004 14:28:41 -0000
@@ -376,3 +376,4 @@ char *__stdcall cstrdup1 (const char *)
 void __stdcall cfree_and_set (char *&, char * = NULL) __attribute__ ((regparm(2)));
 void __stdcall cygheap_init ();
 extern DWORD _cygheap_start;
+}
