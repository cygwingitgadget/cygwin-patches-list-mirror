Return-Path: <cygwin-patches-return-1548-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 620 invoked by alias); 28 Nov 2001 07:36:47 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 481 invoked from network); 28 Nov 2001 07:36:35 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: [PATCH] (Updated) setup.exe: Stop NetIO_HTTP from treating entire stream as a header
Date: Sat, 27 Oct 2001 03:01:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKOEJNCHAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0003_01C177AD.2154AED0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-SW-Source: 2001-q4/txt/msg00080.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0003_01C177AD.2154AED0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 975

Ok, with a bit of help from Mr. Tsekov et al, this ought to do it:


2001-11-26  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>

	* nio-http.cc (NetIO_HTTP::NetIO_HTTP): Stop header parsing when
	SimpleSocket::gets() returns a zero-length string, so that we
	don't end up eating the entire stream thinking it's all header info.


Index: nio-http.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/nio-http.cc,v
retrieving revision 2.7
diff -p -u -b -r2.7 nio-http.cc
--- nio-http.cc	2001/11/13 01:49:32	2.7
+++ nio-http.cc	2001/11/28 07:24:49
@@ -180,7 +180,9 @@ retry_get:
       s = 0;
       return;
     }
-  while ((l = s->gets ()) != 0)
+    
+  // Eat the header, picking out the Content-Length in the process
+  while (((l = s->gets ()) != NULL) && (*l != '\0'))
     {
       if (_strnicmp (l, "Content-Length:", 15) == 0)
 	sscanf (l, "%*s %d", &file_size);

-- 
Gary R. Van Sickle
Brewer.  Patriot. 
------=_NextPart_000_0003_01C177AD.2154AED0
Content-Type: application/octet-stream;
	name="nio-http.cc-changelog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nio-http.cc-changelog"
Content-length: 265

2001-11-26  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>

	* nio-http.cc (NetIO_HTTP::NetIO_HTTP): Stop header parsing when
	SimpleSocket::gets() returns a zero-length string, so that we
	don't end up eating the entire stream thinking it's all header info.

------=_NextPart_000_0003_01C177AD.2154AED0
Content-Type: application/octet-stream;
	name="nio-http.cc-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nio-http.cc-patch"
Content-length: 597

Index: nio-http.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/nio-http.cc,v
retrieving revision 2.7
diff -p -u -b -r2.7 nio-http.cc
--- nio-http.cc	2001/11/13 01:49:32	2.7
+++ nio-http.cc	2001/11/28 07:24:49
@@ -180,7 +180,9 @@ retry_get:
       s = 0;
       return;
     }
-  while ((l = s->gets ()) != 0)
+    
+  // Eat the header, picking out the Content-Length in the process
+  while (((l = s->gets ()) != NULL) && (*l != '\0'))
     {
       if (_strnicmp (l, "Content-Length:", 15) == 0)
 	sscanf (l, "%*s %d", &file_size);

------=_NextPart_000_0003_01C177AD.2154AED0--
