Return-Path: <cygwin-patches-return-4456-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23720 invoked by alias); 1 Dec 2003 09:08:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23711 invoked from network); 1 Dec 2003 09:08:03 -0000
To: cygwin-patches@cygwin.com
Subject: [PATCH] localtime.cc: Point TZDIR to the /usr/share/zoneinfo
From: "Dr. Volker Zell" <Dr.Volker.Zell@oracle.com>
Date: Mon, 01 Dec 2003 09:08:00 -0000
Message-ID: <87ad6cgb3m.fsf@vzell-de.de.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-SW-Source: 2003-q4/txt/msg00175.txt.bz2

--=-=-=
Content-length: 381

Hi

As discussed in cygwin-apps here's a small patch to point cygwin to an existing
time zone datasbase when the tzcode/data package is installed.


2003-12-01  Dr. Volker Zell  <Dr.Volker.Zell@oracle.com>

	* include/tzfile.h: Remove duplicate definition of TM_SUNDAY.
	* localtime.cc: Point TZDIR to the /usr/share/zoneinfo directory used
	by the tzcode package.

Ciao
  Volker


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=timzone.patch
Content-length: 1206

diff -u -p /usr/local/src/cygwin-snapshot-20031128-1/winsup/cygwin/localtime.cc /usr/local/src/cygwin-snapshot-20031128-1/winsup/cygwin/localtime.cc.orig
--- /usr/local/src/cygwin-snapshot-20031128-1/winsup/cygwin/localtime.cc	2003-12-01 09:51:54.630732800 +0100
+++ /usr/local/src/cygwin-snapshot-20031128-1/winsup/cygwin/localtime.cc.orig	2003-12-01 09:51:54.720862400 +0100
@@ -303,7 +303,7 @@ static char	tzfilehid[] = "@(#)tzfile.h	
 */
 
 #ifndef TZDIR
-#define TZDIR	"/usr/share/zoneinfo" /* Time zone object file directory */
+#define TZDIR	"/usr/local/etc/zoneinfo" /* Time zone object file directory */
 #endif /* !defined TZDIR */
 
 #ifndef TZDEFAULT
diff -u -p /usr/local/src/cygwin-snapshot-20031128-1/winsup/cygwin/include/tzfile.h.orig /usr/local/src/cygwin-snapshot-20031128-1/winsup/cygwin/include/tzfile.h
--- /usr/local/src/cygwin-snapshot-20031128-1/winsup/cygwin/include/tzfile.h.orig	2003-12-01 09:53:44.528758400 +0100
+++ /usr/local/src/cygwin-snapshot-20031128-1/winsup/cygwin/include/tzfile.h	2003-12-01 09:53:44.588844800 +0100
@@ -41,7 +41,6 @@ details. */
 #define TM_OCTOBER	9
 #define TM_NOVEMBER	10
 #define TM_DECEMBER	11
-#define TM_SUNDAY	0
 
 #define TM_YEAR_BASE	1900

--=-=-=--
