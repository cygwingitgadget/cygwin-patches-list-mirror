Return-Path: <cygwin-patches-return-3220-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11255 invoked by alias); 22 Nov 2002 20:46:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11233 invoked from network); 22 Nov 2002 20:46:38 -0000
Date: Fri, 22 Nov 2002 12:46:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: export nl_langinfo() patch
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20021122204912.GA2236@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_YlHkQ9+qw9zcF09PIJMjQA)"
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q4/txt/msg00171.txt.bz2


--Boundary_(ID_YlHkQ9+qw9zcF09PIJMjQA)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 66

The attached patch exports newlib's nl_langinfo().

Thanks,
Jason

--Boundary_(ID_YlHkQ9+qw9zcF09PIJMjQA)
Content-type: text/plain; charset=us-ascii; NAME=nl_langinfo.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=nl_langinfo.patch
Content-length: 1272

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.68
diff -u -p -r1.68 cygwin.din
--- cygwin.din	15 Nov 2002 19:04:36 -0000	1.68
+++ cygwin.din	22 Nov 2002 20:35:24 -0000
@@ -597,6 +597,8 @@ nextafter
 _nextafter = nextafter
 nextafterf
 _nextafterf = nextafterf
+nl_langinfo
+_nl_langinfo = nl_langinfo
 open
 _open = open
 opendir
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.86
diff -u -p -r1.86 version.h
--- include/cygwin/version.h	22 Nov 2002 16:27:32 -0000	1.86
+++ include/cygwin/version.h	22 Nov 2002 20:35:24 -0000
@@ -163,12 +163,13 @@ details. */
        63: Export pututline
        64: Export fseeko, ftello
        65: Export siginterrupt
+       66: Export nl_langinfo
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 65
+#define CYGWIN_VERSION_API_MINOR 66
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--Boundary_(ID_YlHkQ9+qw9zcF09PIJMjQA)
Content-type: text/plain; charset=us-ascii; NAME=nl_langinfo.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=nl_langinfo.ChangeLog
Content-length: 137

Fri Nov 22 15:43:13 2002  <jason@tishler.net>

	* cygwin.din: Export nl_langinfo().
	* include/cygwin/version.h: Bump API minor version.

--Boundary_(ID_YlHkQ9+qw9zcF09PIJMjQA)--
