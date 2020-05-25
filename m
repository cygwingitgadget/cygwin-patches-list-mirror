Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 2ABAF3840C1E
 for <cygwin-patches@cygwin.com>; Mon, 25 May 2020 12:06:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2ABAF3840C1E
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MmlCY-1jDASq3PHy-00jrwQ for <cygwin-patches@cygwin.com>; Mon, 25 May 2020
 14:06:34 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 465FFA80FF6; Mon, 25 May 2020 14:06:34 +0200 (CEST)
Date: Mon, 25 May 2020 14:06:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3 v3] Cygwin: tzcode resync: basics
Message-ID: <20200525120634.GD6801@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200522093253.995-1-mark@maxrnd.com>
 <20200522093253.995-2-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20200522093253.995-2-mark@maxrnd.com>
X-Provags-ID: V03:K1:EaQHseDGm80WzJp02Jgv5eFMsP42Pn57FHA8l4atVZxFS7jEHKM
 YDnQCP40X88Jj3ue2aexqYJ21Zvqdtt/QotQysfHtvjJlLqCkRsib2g4aQuaxOULZHY6Y8R
 VkzhijukR1NgCSBm2oKoP2mTBt3G8s0MxaaYg+/EWbx0YWbFmsU/+ZfH2Xk/MxvvdusA/vz
 AlL1v+3dhdl03GnAYcGlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bmMJyW49OoM=:MLXSpS3pcsfKRjDnmAQ98g
 UTNIf23DTrfXmo4DZWJFlkcMJQdZKqzVB4YGEZ3V7WlOP5Pw1E7ckCWj0HHAnmzGCbAOzQ+/0
 fEIAtb7QzmwlLY0F2QI9MI9EaXA4l9KTtuG+qu56pvKhYOk1Y//730dpfk8zqiNWfw5t5Si8k
 kNFyQE0ri7NA35rAI95fDqYSJQOFkpQFEmpcQZtEvO/0af8RVcSvcuO0KFOIaMtMN0wq8Q8j1
 yv6eufBOK9E/UDjpih+JEGXXnz7BmQZGpss9guFlfFcmbNEvULNPXYZ3/L/pV0/tb7S0Mx97c
 b1v38j/E2I1WDrtzmGZ9Ca9ES1vNJB8vKx9oPG+aAecg5g0a53VtgZe6nfT0Cefam6NkuPKBJ
 1r2YKCohPzhzLY4rDMLWAQH3nMmB7Hx6+D4OWIODkz9b+Av3NaFAH9OV84KtbGdC/FGq+HHZb
 jOUK/n4KKqnJYGGXVJhM4B/5gK5B/6R/jc1dk8ezlWNtrrRSn8c3qw1wmqdf7Gtrk/727fELw
 EAY6hUWiL7cq8bWkI1b52xcAYYr2LnyoUAuoxlBO028q2dWS5LKjtVYozK+PaW4Hh/8kcPsCE
 7z9zLeH9rP6GsNUYwxQtve8KhOVd+y09pX0wl085vaqZJGs/TnXMbx4fUCBNFas256XaH960g
 M9a77MdW6kDblB1LmrDrR9HTmm36tb3JrZpSGPvLa98Q4VNPv0RBgpiC/Y0Tep9q0FlHmbHuc
 T3SbVLzs+FpGUeDEnHgg1+DpwU1C+5DyE6jWdsjNM3bGrhSAdmcXz20101e8jmRmCv3oWwjHc
 jVvGGeGFkr2VCMW9iSc3lEf4HAy3+3hHmMzX8rW695o0eJ0DnLl3mbj2ZeXhRdPqxCOoAQH
X-Spam-Status: No, score=-103.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 25 May 2020 12:06:46 -0000


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Mark,

On May 22 02:32, Mark Geisert wrote:
> Modifies winsup/cygwin/Makefile.in to build localtime.o from items in
> new winsup/cygwin/tzcode subdirectory.  Compiler option "-fpermissive"
> is used to accept warnings about missing casts on the return values of
> malloc() calls.  This patch also removes existing localtime.cc and
> tz_posixrules.h from winsup/cygwin as they are superseded by the
> subsequent patches in this set.
> [...]
> @@ -246,6 +246,15 @@ MATH_OFILES:= \
>  	tgammal.o \
>  	truncl.o
>  
> +TZCODE_OFILES:=localtime.o
> +
> +localtime.o: $(srcdir)/tzcode/localtime.cc $(srcdir)/tzcode/localtime.c.patch
> +	(cd $(srcdir)/tzcode && \
> +		patch -u -o localtime.c.patched localtime.c localtime.c.patch)
> +	$(CXX) ${CXXFLAGS} ${localtime_CFLAGS} \
> +		-I$(target_builddir)/winsup/cygwin \
> +		-I$(srcdir) -I$(srcdir)/tzcode -c -o $@ $<
> +

This doesn't work well for me.  That rule is the top rule in Makefile.in
now, so just calling `make' doesn't build the DLL anymore, only
localtime.o.  The rule should get moved way down Makefile.in.

What still bugs me is that we get these -fpermissive warnings (albeit
non-fatal) and the fact that we don't get a dependencies file.  On
second thought, there's no good reason to keep localtime.cc a C++ file.
Converting this file to a plain C wrapper drops the C++-specific warning
and thus allows to revert the localtime.o build rule to use ${COMMON_CFLAGS}.

So I took the liberty to tweak your patch a bit.  I created a followup
patchset, which I'd like you to take a look at.

I attached the followup patches to this mail.  Please scrutinize it and
don't hesitate to discuss the changes.  For a start:

- I do not exactly like the name "localtime_wrapper.c" but I don't
  have a better idea.

- muto's are C++-only, so I changed rwlock_wrlock/rwlock_unlock to use
  Windows SRWLocks.  I think this is a good thing and I'm inclined
  to drop the muto datatype entirely in favor of using SRWLocks since
  they are cleaner and langauge-agnostic.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-Cygwin-move-localtime.o-build-rule-to-end-of-file.patch"

From 2ce569ec924b75894492f1a103f42900610fe00f Mon Sep 17 00:00:00 2001
From: Corinna Vinschen <corinna@vinschen.de>
Date: Mon, 25 May 2020 13:45:17 +0200
Subject: [PATCH 1/4] Cygwin: move localtime.o build rule to end of file

otherwise a simple `make' in the cygwin dir won't build
the DLL anymore.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/Makefile.in | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 2ac8bcbd89ff..2e8c274a36b3 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -248,13 +248,6 @@ MATH_OFILES:= \
 
 TZCODE_OFILES:=localtime.o
 
-localtime.o: $(srcdir)/tzcode/localtime.cc $(srcdir)/tzcode/localtime.c.patch
-	(cd $(srcdir)/tzcode && \
-		patch -u -o localtime.c.patched localtime.c localtime.c.patch)
-	$(CXX) ${CXXFLAGS} ${localtime_CFLAGS} \
-		-I$(target_builddir)/winsup/cygwin \
-		-I$(srcdir) -I$(srcdir)/tzcode -c -o $@ $<
-
 DLL_OFILES:= \
 	advapi32.o \
 	aio.o \
@@ -741,6 +734,13 @@ dcrt0.o sigproc.o: child_info_magic.h
 
 shared.o: shared_info_magic.h
 
+localtime.o: $(srcdir)/tzcode/localtime.cc $(srcdir)/tzcode/localtime.c.patch
+	(cd $(srcdir)/tzcode && \
+		patch -u -o localtime.c.patched localtime.c localtime.c.patch)
+	$(CXX) ${CXXFLAGS} ${localtime_CFLAGS} \
+		-I$(target_builddir)/winsup/cygwin \
+		-I$(srcdir) -I$(srcdir)/tzcode -c -o $@ $<
+
 $(srcdir)/devices.cc: gendevices devices.in devices.h
 	${wordlist 1,2,$^} $@
 
-- 
2.25.4


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0002-Cygwin-rename-localtime.cc-to-localtime_wrapper.c.patch"

From 57625ac256299c1472f371f6d39b23c59f55d72e Mon Sep 17 00:00:00 2001
From: Corinna Vinschen <corinna@vinschen.de>
Date: Mon, 25 May 2020 13:46:24 +0200
Subject: [PATCH 2/4] Cygwin: rename localtime.cc to localtime_wrapper.c

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/Makefile.in                                  | 2 +-
 winsup/cygwin/tzcode/{localtime.cc => localtime_wrapper.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename winsup/cygwin/tzcode/{localtime.cc => localtime_wrapper.c} (100%)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 2e8c274a36b3..1e1342ab7849 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -734,7 +734,7 @@ dcrt0.o sigproc.o: child_info_magic.h
 
 shared.o: shared_info_magic.h
 
-localtime.o: $(srcdir)/tzcode/localtime.cc $(srcdir)/tzcode/localtime.c.patch
+localtime.o: $(srcdir)/tzcode/localtime_wrapper.c $(srcdir)/tzcode/localtime.c.patch
 	(cd $(srcdir)/tzcode && \
 		patch -u -o localtime.c.patched localtime.c localtime.c.patch)
 	$(CXX) ${CXXFLAGS} ${localtime_CFLAGS} \
diff --git a/winsup/cygwin/tzcode/localtime.cc b/winsup/cygwin/tzcode/localtime_wrapper.c
similarity index 100%
rename from winsup/cygwin/tzcode/localtime.cc
rename to winsup/cygwin/tzcode/localtime_wrapper.c
-- 
2.25.4


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0003-Cygwin-convert-localtime_wrapper.c-to-plain-C-source.patch"

From b4fdc99de23da851791b9976a8ae4e6e7a9a04f5 Mon Sep 17 00:00:00 2001
From: Corinna Vinschen <corinna@vinschen.de>
Date: Mon, 25 May 2020 13:50:36 +0200
Subject: [PATCH 3/4] Cygwin: convert localtime_wrapper.c to plain C source

That also requires a small tweak to localtime.c.patch, otherwise
GCC complains about the position of the 'trydefrules' label.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/Makefile.in                |  4 ++--
 winsup/cygwin/tzcode/localtime.c.patch   |  8 +++++---
 winsup/cygwin/tzcode/localtime_wrapper.c | 24 +++++++++---------------
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 1e1342ab7849..1801b1a114eb 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -561,7 +561,7 @@ TARGET_LIBS:=$(LIB_NAME) $(CYGWIN_START) $(GMON_START) $(LIBGMON_A) $(SUBLIBS) $
 
 ifneq "${filter -O%,$(CFLAGS)}" ""
 dtable_CFLAGS:=-fcheck-new
-localtime_CFLAGS:=-fwrapv -fpermissive
+localtime_CFLAGS:=-fwrapv
 malloc_CFLAGS:=-O3
 sync_CFLAGS:=-O3
 ifeq ($(target_cpu),i686)
@@ -737,7 +737,7 @@ shared.o: shared_info_magic.h
 localtime.o: $(srcdir)/tzcode/localtime_wrapper.c $(srcdir)/tzcode/localtime.c.patch
 	(cd $(srcdir)/tzcode && \
 		patch -u -o localtime.c.patched localtime.c localtime.c.patch)
-	$(CXX) ${CXXFLAGS} ${localtime_CFLAGS} \
+	$(CC) ${COMMON_CFLAGS} ${localtime_CFLAGS} \
 		-I$(target_builddir)/winsup/cygwin \
 		-I$(srcdir) -I$(srcdir)/tzcode -c -o $@ $<
 
diff --git a/winsup/cygwin/tzcode/localtime.c.patch b/winsup/cygwin/tzcode/localtime.c.patch
index e19a2cd0254f..0587b5ea7626 100644
--- a/winsup/cygwin/tzcode/localtime.c.patch
+++ b/winsup/cygwin/tzcode/localtime.c.patch
@@ -32,13 +32,15 @@
  	nread = read(fid, up->buf, sizeof up->buf);
  	if (nread < (ssize_t)tzheadsize) {
  		int err = nread < 0 ? errno : EINVAL;
-@@ -501,6 +501,15 @@
+@@ -501,6 +501,17 @@
  	}
  	if (close(fid) < 0)
  		return errno;
 +	if (0) {
++		const char *base;
 +trydefrules:
-+		const char *base = strrchr(name, '/');
++
++		base = strrchr(name, '/');
 +		base = base ? base + 1 : name;
 +		if (strcmp(base, TZDEFRULES))
 +		    return errno;
@@ -48,7 +50,7 @@
  	for (stored = 4; stored <= 8; stored *= 2) {
  		int_fast32_t ttisstdcnt = detzcode(up->tzhead.tzh_ttisstdcnt);
  		int_fast32_t ttisutcnt = detzcode(up->tzhead.tzh_ttisutcnt);
-@@ -1417,6 +1426,8 @@
+@@ -1417,6 +1428,8 @@
  tzsetlcl(char const *name)
  {
  	struct state *sp = __lclptr;
diff --git a/winsup/cygwin/tzcode/localtime_wrapper.c b/winsup/cygwin/tzcode/localtime_wrapper.c
index c903bf3b9d6d..fce3e36cbbef 100644
--- a/winsup/cygwin/tzcode/localtime_wrapper.c
+++ b/winsup/cygwin/tzcode/localtime_wrapper.c
@@ -7,15 +7,16 @@ Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
 #include "../winsup.h"
-#include "../sync.h"
+#include "../perprocess.h"
 #include "../include/cygwin/version.h"
 #include "tz_posixrules.h"
+#include <stdlib.h>
 
-static NO_COPY muto tzset_guard;
+static SRWLOCK tzset_guard;
 
-// Convert these NetBSD rwlock ops into Cygwin muto ops
-#define rwlock_wrlock(X) tzset_guard.init("tzset_guard")->acquire()
-#define rwlock_unlock(X) tzset_guard.release()
+// Convert these NetBSD rwlock ops into SRWLocks
+#define rwlock_wrlock(X) AcquireSRWLockExclusive(&tzset_guard)
+#define rwlock_unlock(X) ReleaseSRWLockExclusive(&tzset_guard)
 
 // Set these NetBSD-related option #defines appropriately for Cygwin
 //#define STD_INSPIRED	// early-include private.h below does this
@@ -109,9 +110,6 @@ tzgetwintzi (char *wildabbr, char *outbuf)
 }
 
 // Get ready to wrap NetBSD's localtime.c
-#ifdef __cplusplus
-extern "C" {
-#endif
 
 // Pull these in early to catch any small issues before the real test
 #include "private.h"
@@ -126,19 +124,15 @@ extern "C" {
 */
 #include "localtime.c.patched"
 
-#ifdef __cplusplus
-}
-#endif
-
 // Don't forget these Cygwin-specific additions from this point to EOF
 EXPORT_ALIAS (tzset_unlocked, _tzset_unlocked)
 
-extern "C" long
+long
 __cygwin_gettzoffset (const struct tm *tmp)
 {
 #ifdef TM_GMTOFF
     if (CYGWIN_VERSION_CHECK_FOR_EXTRA_TM_MEMBERS)
-    	return tmp->TM_GMTOFF;
+	return tmp->TM_GMTOFF;
 #endif /* defined TM_GMTOFF */
     __tzinfo_type *tz = __gettzinfo ();
     /* The sign of this is exactly opposite the envvar TZ.  We
@@ -148,7 +142,7 @@ __cygwin_gettzoffset (const struct tm *tmp)
     return offset;
 }
 
-extern "C" const char *
+const char *
 __cygwin_gettzname (const struct tm *tmp)
 {
 #ifdef TM_ZONE
-- 
2.25.4


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0004-.gitignore-add-.patched-to-support-Cygwin-s-new-loca.patch"

From 48c341531c6e1117405d1f163bdf9cc02117d45c Mon Sep 17 00:00:00 2001
From: Corinna Vinschen <corinna@vinschen.de>
Date: Mon, 25 May 2020 13:51:35 +0200
Subject: [PATCH 4/4] .gitignore: add *.patched to support Cygwin's new
 localtime build rules

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 13a554aa0986..578d9d8fdc01 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,6 @@
 *.diff
 *.patch
+*.patched
 *.orig
 *.rej
 
-- 
2.25.4


--AqsLC8rIMeq19msA--
