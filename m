Return-Path: <cygwin-patches-return-3351-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8171 invoked by alias); 2 Jan 2003 04:56:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8161 invoked from network); 2 Jan 2003 04:56:26 -0000
Message-ID: <3E13C60B.4000904@ece.gatech.edu>
Date: Thu, 02 Jan 2003 04:56:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: [PATCH] export asprintf and friends
Content-Type: multipart/mixed;
 boundary="------------020703000100030002070302"
X-SW-Source: 2003-q1/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------020703000100030002070302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 429

This patch assumes that the asprintf.c change I submitted to newlib is 
also applied.  (And no, it doesn't fix the problem I was having with 
glib and the printf functions, but I noticed this oversight -- and the 
newlib typo -- while doing that investigation)

2003-01-01  Charles Wilson  <cwilson@ece.gatech.edu>

	* cygwin.din: add asprintf and vasprintf, as
	well as the reentrant versions and underscore
	variants.

--Chuck

--------------020703000100030002070302
Content-Type: text/plain;
 name="asprintf.cygwin"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asprintf.cygwin"
Content-length: 613

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.72
diff -u -r1.72 cygwin.din
--- cygwin.din	6 Dec 2002 19:48:03 -0000	1.72
+++ cygwin.din	2 Jan 2003 02:40:17 -0000
@@ -50,6 +50,10 @@
 _asinh = asinh
 asinhf
 _asinhf = asinhf
+asprintf
+_asprintf = asprintf
+_asprintf_r
+asprintf_r = _asprintf_r
 atan
 _atan = atan
 atan2
@@ -943,6 +947,10 @@
 utmpname
 _utmpname = utmpname
 valloc
+vasprintf
+_vasprintf = vasprintf
+_vasprintf_r
+vasprintf_r = _vasprintf_r
 vfiprintf
 _vfiprintf = vfiprintf
 vfork

--------------020703000100030002070302--
