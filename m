Return-Path: <cygwin-patches-return-2094-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11069 invoked by alias); 22 Apr 2002 21:24:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11013 invoked from network); 22 Apr 2002 21:24:39 -0000
Date: Mon, 22 Apr 2002 14:24:00 -0000
From: Michael A Chase <mchase@ix.netcom.com>
Subject:  [PATCH]setup.exe version.cc call to delete[] with changed pointer
To: cygwin-patches <cygwin-patches@cygwin.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="15549769-8482-1019510635=:3052"
Reply-To: Michael A Chase <mchase@ix.netcom.com>
Message-Id: <E16zlIQ-0008PU-00@smtp6.mindspring.com>
X-SW-Source: 2002-q2/txt/msg00078.txt.bz2

--15549769-8482-1019510635=:3052
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
Content-length: 741

The current version of canonicalize_version() calls delete[] with a pointer
that has been changed.  It also uses a rotating set of fixed buffers that are no
longer needed since it has been converted to return a String instead of a char*.

The attached patch removes several unneeded #includes, the old set of rotating
buffers, and the invalid delete[].
--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.htm
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

ChangeLog:

2002-04-22  Michael A Chase <mchase@ix.netcom.com>

    * version.cc (canonicalize_version): Simplify and remove bad delete[].

--15549769-8482-1019510635=:3052
Content-Type: TEXT/PLAIN; NAME="cinstall-mac-020422-1.patch"; CHARSET=US-ASCII
Content-Disposition: INLINE; FILENAME="cinstall-mac-020422-1.patch"
Content-length: 1124

--- version.cc-1	Mon Feb 18 11:19:26 2002
+++ version.cc	Mon Apr 22 12:55:37 2002
@@ -18,29 +18,23 @@ static const char *cvsid =
   "\n%%% $Id: version.cc,v 2.2 2002/02/18 12:35:23 rbcollins Exp $\n";
 #endif
 
-#include "win32.h"
-
-#include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
 #include <ctype.h>
 
-#include "port.h"
 #include "version.h"
-  
-String 
+
+// Expand digit strings in version so they sort correctly
+// For example: 2 (000000000002) < 10 (000000000010)
+String
 canonicalize_version (String const &aString)
 {
-  char *v =aString.cstr();
-  static char nv[3][100];
-  static int idx = 0;
-  char *np;
-  const char *dp;
+  char plain_version[aString.size () + 1];
+  const char *v = plain_version, *dp;
+  char canon_version[aString.size () * 12 + 1];
+  char *np = canon_version;
   int i;
 
-  idx = (idx + 1) % 3;
-  np = nv[idx];
-
+  strcpy (plain_version, aString.cstr_oneuse ());
   while (*v)
     {
       if (isdigit (*v))
@@ -55,6 +49,5 @@ canonicalize_version (String const &aStr
 	*np++ = *v++;
     }
   *np++ = 0;
-  delete[] v;
-  return nv[idx];
+  return canon_version;
 }

--15549769-8482-1019510635=:3052--
