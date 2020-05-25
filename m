Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 1DE98388A824
 for <cygwin-patches@cygwin.com>; Mon, 25 May 2020 15:49:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1DE98388A824
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mj831-1j99r24AEf-00fCT8; Mon, 25 May 2020 17:49:06 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CBFABA80FF8; Mon, 25 May 2020 17:49:01 +0200 (CEST)
Date: Mon, 25 May 2020 17:49:01 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3 v3] Cygwin: tzcode resync: basics
Message-ID: <20200525154901.GG6801@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, Mark Geisert <mark@maxrnd.com>
References: <20200522093253.995-1-mark@maxrnd.com>
 <20200522093253.995-2-mark@maxrnd.com>
 <20200525120634.GD6801@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <20200525120634.GD6801@calimero.vinschen.de>
X-Provags-ID: V03:K1:QaedXFWEQKr5SmndqmxTMFrhZ+m1iy0HCMsEFQthJwieyd1bnBW
 kW4FjNVeA5a+WDnCWRQEVdFcqehJMsyecOen5FaYSroYoEIq07VVwYsxBlKucfq5OP2Voaa
 Ap/pPYJZUqazk/c65R/x8fxfxhA0R31mS23WUNJmPhMO9tBmQEvZQuhywpjOBdW9efzQ/Ry
 dOuuN+BfbaxysOmCk1ajA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VI4IJd/ZDng=:+McDhox8EGX8+T/NqkiiCD
 S6syrOYuGvpiQ2PpnNbRPyCm+YLcHN1oXf2dkJfJGSn/9p1ejOzHTIouWUDjIieYdWTNff4Yj
 L+GVup5idNYUzag1ajLdITG0SzCziBNmIky7baC7TUPdJ9w3ny5mQdavXBrRs1CMQSYBerAVu
 WfoTV1vV1HB91geQY31RkX2n6S1kDMOSnby31DHfUV1aarLLoYzbeS4psSKVRp8vjcc3mg6J1
 6zjKUbBcUTtNCbvljntIyYpaJmwR7MPK5En6Da0WfPVaCVLtkygg0b7wPV7e/Vz41CYobiCMG
 mWvJpujl2gbpkbVoGUbZmlY+XyrtJMSu4KtvHihyulrVlkNy8Qh1/RZZBjTuNUDVMgNE5K6Rp
 7npcRDFBNU3NNLNUg0fd2y1oRp8P5sqEInC6GFO7qAIfJ0iAA+kZ+laM5lYO+/8KGtUXyLuEw
 PX3U8qaIs/A+jA84yecZZi7Mo5CyXREQsfxU/WImfbdNNGhX/yRVFLZWanNb8J9P9GRSnAzYh
 xkXogD8IhiX9XtEUeF8tgvDutNraJu58K6Q8yqlu9uChb3KDghcEn+GzwJO3YvCiJRQuLp06y
 4LI3xKj+YJPgfl3hoOYyj2FH3Y2fPA59GX4MJZFnxaHiAAyi6SnlokmNHIt00SgN3wfmJ31ne
 qJ1BZlEJmh7NQ4BH1S+IhW9t8gxUX4+v6zenHBsIa1MPLLLwfaeLyu5MCqTepE0GnjfOKGQGq
 OpnbSTPAuwG/KtsPjuwXGZ6jpEDfis29sZMzaNO67t2ysgkruQOkbu2m/EBvL+Ki9BX6UBjR+
 PO/78hqIMOhcKKgfEgK93jjZ82FHaiJr5wJHVkTsK86jt1cqgMx3Wm9YQmQedFP+Eci2iMp
X-Spam-Status: No, score=-103.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 25 May 2020 15:49:55 -0000


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Mark,

> On May 22 02:32, Mark Geisert wrote:
On May 25 14:06, Corinna Vinschen wrote:
> > Modifies winsup/cygwin/Makefile.in to build localtime.o from items in
> > new winsup/cygwin/tzcode subdirectory.  Compiler option "-fpermissive"
> > is used to accept warnings about missing casts on the return values of
> > malloc() calls.  This patch also removes existing localtime.cc and
> > tz_posixrules.h from winsup/cygwin as they are superseded by the
> > subsequent patches in this set.
> > [...]
> > @@ -246,6 +246,15 @@ MATH_OFILES:= \
> >  	tgammal.o \
> >  	truncl.o
> >  
> > +TZCODE_OFILES:=localtime.o
> > +
> > +localtime.o: $(srcdir)/tzcode/localtime.cc $(srcdir)/tzcode/localtime.c.patch
> > +	(cd $(srcdir)/tzcode && \
> > +		patch -u -o localtime.c.patched localtime.c localtime.c.patch)
> > +	$(CXX) ${CXXFLAGS} ${localtime_CFLAGS} \
> > +		-I$(target_builddir)/winsup/cygwin \
> > +		-I$(srcdir) -I$(srcdir)/tzcode -c -o $@ $<
> > +
> 
> This doesn't work well for me.  That rule is the top rule in Makefile.in
> now, so just calling `make' doesn't build the DLL anymore, only
> localtime.o.  The rule should get moved way down Makefile.in.
> 
> What still bugs me is that we get these -fpermissive warnings (albeit
> non-fatal) and the fact that we don't get a dependencies file.  On
> second thought, there's no good reason to keep localtime.cc a C++ file.
> Converting this file to a plain C wrapper drops the C++-specific warning
> and thus allows to revert the localtime.o build rule to use ${COMMON_CFLAGS}.
> 
> So I took the liberty to tweak your patch a bit.  I created a followup
> patchset, which I'd like you to take a look at.
> 
> I attached the followup patches to this mail.  Please scrutinize it and
> don't hesitate to discuss the changes.  For a start:
> 
> - I do not exactly like the name "localtime_wrapper.c" but I don't
>   have a better idea.
> 
> - muto's are C++-only, so I changed rwlock_wrlock/rwlock_unlock to use
>   Windows SRWLocks.  I think this is a good thing and I'm inclined
>   to drop the muto datatype entirely in favor of using SRWLocks since
>   they are cleaner and langauge-agnostic.

Two changes in my patchset:

- I didn't initialize the SRWLOCK following the books.  Fixed that.

- Rather than creating the patched file in the source dir, I changed
  the Makefile.in rule so that the patched file is created in the build
  dir.  This drops the requirement to tweak .gitignore.  It's also
  cleaner.

- Splitting the build rule for localtime.c.patched from the build rule
  for localtime.o makes sure that the patched file is not regenerated
  every time we build localtime.o.

I attached my patchset again, but only patch 3 and 4 actually changed.


Thanks,
Corinna

--NKoe5XOeduwbEQHU
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


--NKoe5XOeduwbEQHU
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


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0003-Cygwin-convert-localtime_wrapper.c-to-plain-C-source.patch"

From 6735981b78820c8d244e7fc0bb0ec4b56e88ef03 Mon Sep 17 00:00:00 2001
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
index c903bf3b9d6d..c7c0bf333aae 100644
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
+static NO_COPY SRWLOCK tzset_guard = SRWLOCK_INIT;
 
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


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0004-Cygwin-revamp-localtime.o-build-rule.patch"

From 1ca2a88ec9116d3384e76284eb3382f7f706d836 Mon Sep 17 00:00:00 2001
From: Corinna Vinschen <corinna@vinschen.de>
Date: Mon, 25 May 2020 17:40:27 +0200
Subject: [PATCH 4/4] Cygwin: revamp localtime.o build rule

Create the generated file localtime.c.patched in the build dir
rather than in the source dir.  Decouple build rule for creating
localtime.c.patched from the rule to build localtime.o, so we
don't have to rebuild the patched source file all the time.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/Makefile.in | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 1801b1a114eb..6bd38b22ea93 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -734,9 +734,12 @@ dcrt0.o sigproc.o: child_info_magic.h
 
 shared.o: shared_info_magic.h
 
-localtime.o: $(srcdir)/tzcode/localtime_wrapper.c $(srcdir)/tzcode/localtime.c.patch
-	(cd $(srcdir)/tzcode && \
-		patch -u -o localtime.c.patched localtime.c localtime.c.patch)
+localtime.c.patched: tzcode/localtime.c tzcode/localtime.c.patch
+	patch -u -o localtime.c.patched \
+		    $(srcdir)/tzcode/localtime.c \
+		    $(srcdir)/tzcode/localtime.c.patch
+
+localtime.o: tzcode/localtime_wrapper.c localtime.c.patched
 	$(CC) ${COMMON_CFLAGS} ${localtime_CFLAGS} \
 		-I$(target_builddir)/winsup/cygwin \
 		-I$(srcdir) -I$(srcdir)/tzcode -c -o $@ $<
-- 
2.25.4


--NKoe5XOeduwbEQHU--
