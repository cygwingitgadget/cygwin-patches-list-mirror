Return-Path: <cygwin-patches-return-1842-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20878 invoked by alias); 5 Feb 2002 19:33:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20833 invoked from network); 5 Feb 2002 19:33:05 -0000
Date: Wed, 06 Feb 2002 10:03:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: setup.exe won't install last package patch
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Message-id: <20020205193627.GA816@dothill.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_Khu6bxIJwvfcxMS+hSrF6g)"
User-Agent: Mutt/1.3.24i
X-SW-Source: 2002-q1/txt/msg00199.txt.bz2


--Boundary_(ID_Khu6bxIJwvfcxMS+hSrF6g)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 151

The attached patch fixes an off-by-one error that prevents the last
package (i.e., zlib) from being installed by the latest setup.exe
(in CVS).

Jason

--Boundary_(ID_Khu6bxIJwvfcxMS+hSrF6g)
Content-type: text/plain; charset=us-ascii; NAME=download.cc.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=download.cc.diff
Content-length: 1049

Index: download.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/download.cc,v
retrieving revision 2.19
diff -u -p -r2.19 download.cc
--- download.cc	2001/12/23 12:13:28	2.19
+++ download.cc	2002/02/05 19:16:05
@@ -160,7 +160,7 @@ do_download_thread (HINSTANCE h, HWND ow
 
   packagedb db;
   /* calculate the amount needed */
-  for (size_t n = 1; n < db.packages.number (); n++)
+  for (size_t n = 1; n <= db.packages.number (); n++)
     {
       packagemeta & pkg = *db.packages[n];
       if (pkg.desired && (pkg.desired->srcpicked || pkg.desired->binpicked))
@@ -180,7 +180,7 @@ do_download_thread (HINSTANCE h, HWND ow
   /* and do the download. FIXME: This here we assign a new name for the cached version
    * and check that above.
    */
-  for (size_t n = 1; n < db.packages.number (); n++)
+  for (size_t n = 1; n <= db.packages.number (); n++)
     {
       packagemeta & pkg = *db.packages[n];
       if (pkg.desired && (pkg.desired->srcpicked || pkg.desired->binpicked))

--Boundary_(ID_Khu6bxIJwvfcxMS+hSrF6g)
Content-type: text/plain; charset=us-ascii; NAME=download.cc.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=download.cc.ChangeLog
Content-length: 107

2002-02-05  Jason Tishler  <jason@tishler.net>

	* download.cc (do_download_thread): Fix off-by-one error.

--Boundary_(ID_Khu6bxIJwvfcxMS+hSrF6g)--
