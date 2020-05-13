Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 0F851388A820
 for <cygwin-patches@cygwin.com>; Wed, 13 May 2020 08:24:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0F851388A820
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 04D8OKum090264;
 Wed, 13 May 2020 01:24:20 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdTeAbNM; Wed May 13 01:24:14 2020
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [Cygwin PATCH 3/9] tzcode resync: localtime.cc
Date: Wed, 13 May 2020 01:23:43 -0700
Message-Id: <20200513082349.831-3-mark@maxrnd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200513082349.831-1-mark@maxrnd.com>
References: <20200513082349.831-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 13 May 2020 08:24:32 -0000

Cygwin's wrapper around NetBSD's localtime.c.

---
 winsup/cygwin/tzcode/localtime.cc | 162 ++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 winsup/cygwin/tzcode/localtime.cc

diff --git a/winsup/cygwin/tzcode/localtime.cc b/winsup/cygwin/tzcode/localtime.cc
new file mode 100644
index 000000000..9ea885ece
--- /dev/null
+++ b/winsup/cygwin/tzcode/localtime.cc
@@ -0,0 +1,162 @@
+/* localtime.cc: Wrapper of NetBSD tzcode support for Cygwin. See README file.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#include "winsup.h"
+#include "sync.h"
+#include "../include/cygwin/version.h"
+#include "tz_posixrules.h"
+
+// Set these NetBSD-related option #defines appropriately for Cygwin
+//#define STD_INSPIRED	// early-include private.h below does this
+#define lint
+#define USG_COMPAT 1
+#define NO_ERROR_IN_DST_GAP
+#define state __state
+
+static NO_COPY muto tzset_guard;
+
+// Turn these NetBSD ops into the corresponding Cygwin ops
+#define rwlock_wrlock(X) tzset_guard.init ("tzset_guard")->acquire ()
+#define rwlock_unlock(X) tzset_guard.release ()
+
+// Turn a specific known kind of const parameter into non-const
+#define __UNCONST(X) ((char *) (X))
+
+// Turn off these NetBSD audit-related definitions
+#define __aconst
+#define _DIAGASSERT(X)
+
+// Get ready to enclose NetBSD's localtime.c
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+// Supply this Cygwin-specific function in advance of its use in localtime.c
+static char *
+tzgetwintz (char *wildabbr, char *outbuf)
+{
+    TIME_ZONE_INFORMATION tzi;
+    char *cp, *dst;
+    wchar_t *src;
+    div_t d;
+
+    GetTimeZoneInformation (&tzi);
+    dst = cp = outbuf;
+    for (src = tzi.StandardName; *src; src++)
+	if (*src >= L'A' && *src <= L'Z')
+	    *dst++ = *src;
+    if ((dst - cp) < 3)
+      {
+	/* In non-english Windows, converted tz.StandardName
+	   may not contain a valid standard timezone name. */
+	strcpy (cp, wildabbr);
+	cp += strlen (wildabbr);
+      }
+    else
+	cp = dst;
+    d = div (tzi.Bias + tzi.StandardBias, 60);
+    __small_sprintf (cp, "%d", d.quot);
+    if (d.rem)
+	__small_sprintf (cp = strchr (cp, 0), ":%d", abs (d.rem));
+    if (tzi.StandardDate.wMonth)
+      {
+	cp = strchr (cp, 0);
+	dst = cp;
+	for (src = tzi.DaylightName; *src; src++)
+	    if (*src >= L'A' && *src <= L'Z')
+		*dst++ = *src;
+	if ((dst - cp) < 3)
+	  {
+	    /* In non-english Windows, converted tz.DaylightName
+	       may not contain a valid daylight timezone name. */
+	    strcpy (cp, wildabbr);
+	    cp += strlen (wildabbr);
+	  }
+	else
+	    cp = dst;
+	d = div (tzi.Bias + tzi.DaylightBias, 60);
+	__small_sprintf (cp, "%d", d.quot);
+	if (d.rem)
+	    __small_sprintf (cp = strchr (cp, 0), ":%d", abs (d.rem));
+	cp = strchr (cp, 0);
+	__small_sprintf (cp = strchr (cp, 0), ",M%d.%d.%d/%d",
+			 tzi.DaylightDate.wMonth,
+			 tzi.DaylightDate.wDay,
+			 tzi.DaylightDate.wDayOfWeek,
+			 tzi.DaylightDate.wHour);
+	if (tzi.DaylightDate.wMinute || tzi.DaylightDate.wSecond)
+	    __small_sprintf (cp = strchr (cp, 0), ":%d",
+			     tzi.DaylightDate.wMinute);
+	if (tzi.DaylightDate.wSecond)
+	    __small_sprintf (cp = strchr (cp, 0), ":%d",
+			     tzi.DaylightDate.wSecond);
+	cp = strchr (cp, 0);
+	__small_sprintf (cp = strchr (cp, 0), ",M%d.%d.%d/%d",
+			 tzi.StandardDate.wMonth,
+			 tzi.StandardDate.wDay,
+			 tzi.StandardDate.wDayOfWeek,
+			 tzi.StandardDate.wHour);
+	if (tzi.StandardDate.wMinute || tzi.StandardDate.wSecond)
+	    __small_sprintf (cp = strchr (cp, 0), ":%d",
+			     tzi.StandardDate.wMinute);
+	if (tzi.StandardDate.wSecond)
+	    __small_sprintf (cp = strchr (cp, 0), ":%d",
+			     tzi.StandardDate.wSecond);
+      }
+    /* __small_printf ("TZ deduced as `%s'\n", outbuf); */
+    return outbuf;
+}
+
+// Pull these in early to catch any small issues before the real test
+#include "private.h"
+#include "tzfile.h"
+
+/* Some NetBSD differences were too difficult to work around..
+   so #include a patched copy of localtime.c rather than the NetBSD original.
+   Here is a list of the patches...
+   (1) fix an erroneous decl of tzdirslash size (flagged by g++)
+   (2) add missing casts on all results of malloc() calls (flagged by g++)
+   (3) change all malloc() calls to analogous calloc() calls
+   (4) add conditional call to Cygwin's tzgetwintz() from tzsetlcl()
+   (5) add Cygwin's historical "posixrules" support to tzloadbody()
+   (6) enable defs of daylight, timezone, and tzname
+   (7) make def of __lclptr static to avoid exporting it
+*/
+#include "localtime.c.patched"
+
+#ifdef __cplusplus
+}
+#endif
+
+// Don't forget these Cygwin-specific additions from this point to EOF
+EXPORT_ALIAS (tzset_unlocked, _tzset_unlocked)
+
+extern "C" long
+__cygwin_gettzoffset (const struct tm *tmp)
+{
+#ifdef TM_GMTOFF
+    if (CYGWIN_VERSION_CHECK_FOR_EXTRA_TM_MEMBERS)
+    	return tmp->TM_GMTOFF;
+#endif /* defined TM_GMTOFF */
+    __tzinfo_type *tz = __gettzinfo ();
+    /* The sign of this is exactly opposite the envvar TZ.  We
+       could directly use the global _timezone for tm_isdst==0,
+       but have to use __tzrule for daylight savings.  */
+    long offset = -tz->__tzrule[tmp->tm_isdst > 0].offset;
+    return offset;
+}
+
+extern "C" const char *
+__cygwin_gettzname (const struct tm *tmp)
+{
+#ifdef TM_ZONE
+    if (CYGWIN_VERSION_CHECK_FOR_EXTRA_TM_MEMBERS)
+	return tmp->TM_ZONE;
+#endif
+    return _tzname[tmp->tm_isdst > 0];
+}
-- 
2.21.0

