Return-Path: <cygwin-patches-return-3219-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21141 invoked by alias); 22 Nov 2002 16:15:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21132 invoked from network); 22 Nov 2002 16:15:41 -0000
Date: Fri, 22 Nov 2002 08:15:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: version.h yank and put patch
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20021122162119.GC1584@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_PwhbjCKjih1pC9ptdDJOkA)"
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q4/txt/msg00170.txt.bz2


--Boundary_(ID_PwhbjCKjih1pC9ptdDJOkA)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 166

See attached.

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6

--Boundary_(ID_PwhbjCKjih1pC9ptdDJOkA)
Content-type: text/plain; charset=us-ascii; NAME=version.h.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=version.h.diff
Content-length: 572

Index: version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.85
diff -u -p -r1.85 version.h
--- version.h	15 Nov 2002 19:04:36 -0000	1.85
+++ version.h	22 Nov 2002 16:12:16 -0000
@@ -162,7 +162,7 @@ details. */
        62: Erroneously bumped.
        63: Export pututline.
        64: Export fseeko, ftello
-       65: Export fseeko, ftello
+       65: Export siginterrupt
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */

--Boundary_(ID_PwhbjCKjih1pC9ptdDJOkA)--
