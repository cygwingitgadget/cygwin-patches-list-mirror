Return-Path: <cygwin-patches-return-3354-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4667 invoked by alias); 7 Jan 2003 17:37:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4647 invoked from network); 7 Jan 2003 17:37:50 -0000
Message-ID: <3E1B0FF7.2040809@ece.gatech.edu>
Date: Tue, 07 Jan 2003 17:37:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [PATCH] export asprintf and friends
References: <3E13C60B.4000904@ece.gatech.edu> <3E19EE90.7030502@ece.gatech.edu> <3E1A24A3.9040807@ece.gatech.edu>
Content-Type: multipart/mixed;
 boundary="------------040002060200010408040607"
X-SW-Source: 2003-q1/txt/msg00003.txt.bz2

This is a multi-part message in MIME format.
--------------040002060200010408040607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 421

Okay, since newlib has accepted the Makefile patch, NOW it's okay to 
apply this change to cygwin.  But, I've updated it to also fix 
version.h.  Tested and everything. <g>

2003-01-01  Charles Wilson  <cwilson@ece.gatech.edu>

	* winsup/cygwin/cygwin.din: add asprintf and
	vasprintf, as well as the reentrant versions and
	underscore variants.
	* winsup/cygwin/include/cygwin/version.h: bump
	CYGWIN_VERSION_API_MINOR


--------------040002060200010408040607
Content-Type: text/plain;
 name="asprintf.cygwin"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asprintf.cygwin"
Content-length: 1422

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
Index: version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.93
diff -u -r1.93 version.h
--- version.h	25 Dec 2002 23:39:04 -0000	1.93
+++ version.h	7 Jan 2003 03:28:59 -0000
@@ -167,12 +167,13 @@
        67: Export pthread_getsequence_np
        68: Export netdb stuff
        69: Export strtof
+       70: Export asprintf, _asprintf_r, vasprintf, _vasprintf_r
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 69
+#define CYGWIN_VERSION_API_MINOR 70
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--------------040002060200010408040607--
