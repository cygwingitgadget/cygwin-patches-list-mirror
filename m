Return-Path: <SRS0=8byy=UD=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by sourceware.org (Postfix) with ESMTPS id EC8DC3857BA9
	for <cygwin-patches@cygwin.com>; Sat, 11 Jan 2025 00:03:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EC8DC3857BA9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EC8DC3857BA9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736553796; cv=none;
	b=EiVnXPg1ZdG45bIYBqFCY0MIMDXpHLxarifVbH/STMXGw9f8m1RgnH+gxMfq9DkNhyC6odfmm9dovmnBUfjRKp5n6/LnhNbNAe5ca9pxusMYZV2t8FarRtx8W/XxtF22o6KTZ09ecTPXRlfkyIHbnmI6UrvEuOc7erSiogyRQ5o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736553796; c=relaxed/simple;
	bh=D//zUYy8oFGGMwLfhckCS9N/4chAULEMC5PtLr7pNPo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Tp/qep/iyXQI3rk8nvd7ilSF5kDGLTEjEqgxyldlLFHnfVX7i0HFoRgeA5WDlGSCAe7A3nrQkgd4RMA/zSljVsCg+eChmudl9lo4xD6JBvoBQnqGqFsw+1dSboiF+1UKJqRMPYB+e9yQ2M9dQtqSWgHgR4PnMKHa/m2msVzV9x4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EC8DC3857BA9
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=eRaCIWQc
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 87E05C0F8E;
	Sat, 11 Jan 2025 00:03:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id 2B06320025;
	Sat, 11 Jan 2025 00:03:14 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v5 2/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 new additions available
Date: Fri, 10 Jan 2025 17:01:03 -0700
Message-ID: <1a354471c155501dd2d0abfbc195e8be3e9c0fa2.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Stat-Signature: y67kgsyjw5ok95rcip5deotnagfcwtgf
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 2B06320025
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18zvrlwyP7JYnujG/UCL/926pqzv2QwwZg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=he; bh=sSIBm46mXNNUhybTGKEap0KAaduZ/YID70zR0PzKA8A=; b=eRaCIWQc6wdLq2yem1fAZVNUrN40dJI5wzJm9IJtBHtg4cXAxhLzAjvFC43IfdMFnexSEgJoU21ZJUvEJwEmpb+iQlKRTloZiaRmgZAFsflrJzxG4cdsQB2VlfT+8rA3yvlaUvthBo/G5a6+Fn0WqtDuBzMWpWlzznjW0f1Hkvznl+nMF9zhgUJYH5WbwPU/wVqYJnFGQwPFZ1iLmQDET7efsUfIc147bNbAfQCGAaFqC0FlJFScX0Cu0qnVVZ2P39ecLgkveyzJdJoOzsx8RO8uFE9Ue32GRyqa24HSq1YH7mXHyX5e4Zi/7zgmoHQ4rkO7xDSq0xMQaYS8qBMLRg==
X-HE-Tag: 1736553794-947322
X-HE-Meta: U2FsdGVkX1/ZH+Fh67db5yJYUYIWpNuj49PC1oZEjtxCHOtVq+RABW08krK4OdJTrrP6WaFWFRzDCuPOpZufWeEu2NJIEUwUC45ItPjgJGCR1uo+Bmi5JwpD2oDo1Ia79mMGiwmW0ZsrsXD3pT1oENKQejFTGYR+CNnYyeYZdSOpIk137AmCC1lS0xDrv/WpFZUKYBH7biI+YQ+7AbBJS8Eq0tMhJ/XaGYkHQjLdcJnFTqPP6tHjGhqae9bR1MTt7HsPh74a+umrO67RxGDGZLSbeh1abJv5hRk1qw1S7HWVmYsh4Cj631MUe/YcjtwnVi2RGIFILjY=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Add POSIX new additions available with din entries
or interfaces in headers and packages.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 1b893e9e19ae..17c9ebf6f73f 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -75,8 +75,41 @@ ISO/IEC DIS 9945 Information technology
     atoi
     atol
     atoll
+    atomic_compare_exchange_strong		(available in "stdatomic.h" header)
+    atomic_compare_exchange_strong_explicit	(available in "stdatomic.h" header)
+    atomic_compare_exchange_weak		(available in "stdatomic.h" header)
+    atomic_compare_exchange_weak_explicit	(available in "stdatomic.h" header)
+    atomic_exchange		(available in "stdatomic.h" header)
+    atomic_exchange_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_add		(available in "stdatomic.h" header)
+    atomic_fetch_add_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_and		(available in "stdatomic.h" header)
+    atomic_fetch_and_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_or		(available in "stdatomic.h" header)
+    atomic_fetch_or_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_sub		(available in "stdatomic.h" header)
+    atomic_fetch_sub_explicit	(available in "stdatomic.h" header)
+    atomic_fetch_xor		(available in "stdatomic.h" header)
+    atomic_fetch_xor_explicit	(available in "stdatomic.h" header)
+    atomic_flag_clear		(available in "stdatomic.h" header)
+    atomic_flag_clear_explicit	(available in "stdatomic.h" header)
+    atomic_flag_test_and_set	(available in "stdatomic.h" header)
+    atomic_flag_test_and_set_explicit	(available in "stdatomic.h" header)
+    atomic_init			(available in "stdatomic.h" header)
+    atomic_is_lock_free		(available in "stdatomic.h" header)
+    atomic_load			(available in "stdatomic.h" header)
+    atomic_load_explicit	(available in "stdatomic.h" header)
+    atomic_signal_fence		(available in "stdatomic.h" header)
+    atomic_store		(available in "stdatomic.h" header)
+    atomic_store_explicit	(available in "stdatomic.h" header)
+    atomic_thread_fence		(available in "stdatomic.h" header)
     basename			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    be16toh			(available in "endian.h" header)
+    be32toh			(available in "endian.h" header)
+    be64toh			(available in "endian.h" header)
     bind
+    bind_textdomain_codeset	(available in external gettext "libintl" library)
+    bindtextdomain		(available in external gettext "libintl" library)
     bsearch
     btowc
     c16rtomb			(ISO C11)
@@ -207,6 +240,9 @@ ISO/IEC DIS 9945 Information technology
     dbm_nextkey			(available in external "libgdbm" library)
     dbm_open			(available in external "libgdbm" library)
     dbm_store			(available in external "libgdbm" library)
+    dcgettext			(available in external gettext "libintl" library)
+    dcngettext			(available in external gettext "libintl" library)
+    dgettext			(available in external gettext "libintl" library)
     difftime
     dirfd
     dirname
@@ -216,6 +252,7 @@ ISO/IEC DIS 9945 Information technology
     dlerror
     dlopen
     dlsym
+    dngettext			(available in external gettext "libintl" library)
     dprintf
     drand48
     dup
@@ -360,6 +397,7 @@ ISO/IEC DIS 9945 Information technology
     getdelim
     getdomainname
     getegid
+    getentropy			(din)
     getenv
     geteuid
     getgid
@@ -373,6 +411,7 @@ ISO/IEC DIS 9945 Information technology
     gethostname
     getitimer			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getline
+    getlocalename_l		(din)
     getlogin
     getlogin_r
     getnameinfo
@@ -401,6 +440,7 @@ ISO/IEC DIS 9945 Information technology
     getsockname
     getsockopt
     getsubopt
+    gettext			(available in external gettext "libintl" library)
     gettimeofday
     getuid
     getutxent
@@ -416,6 +456,12 @@ ISO/IEC DIS 9945 Information technology
     hcreate
     hdestroy
     hsearch
+    htobe16			(available in "endian.h" header)
+    htobe32			(available in "endian.h" header)
+    htobe64			(available in "endian.h" header)
+    htole16			(available in "endian.h" header)
+    htole32			(available in "endian.h" header)
+    htole64			(available in "endian.h" header)
     htonl
     htons
     hypot
@@ -433,6 +479,8 @@ ISO/IEC DIS 9945 Information technology
     ilogbl
     imaxabs
     imaxdiv
+    in6addr_any			(din)
+    in6addr_loopback		(din)
     inet_addr
     inet_ntoa
     inet_ntop
@@ -516,6 +564,9 @@ ISO/IEC DIS 9945 Information technology
     ldexpf
     ldexpl
     ldiv
+    le16toh			(available in "endian.h" header)
+    le32toh			(available in "endian.h" header)
+    le64toh			(available in "endian.h" header)
     lfind
     lgamma
     lgammaf
@@ -635,6 +686,7 @@ ISO/IEC DIS 9945 Information technology
     nexttowardf
     nexttowardl
     nftw
+    ngettext			(available in external gettext "libintl" library)
     nice			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     nl_langinfo
     nl_langinfo_l
@@ -661,6 +713,7 @@ ISO/IEC DIS 9945 Information technology
     popen
     posix_fadvise
     posix_fallocate
+    posix_getdents		(din)
     posix_madvise
     posix_memalign
     posix_openpt
@@ -723,6 +776,8 @@ ISO/IEC DIS 9945 Information technology
     pthread_barrierattr_init
     pthread_barrierattr_setpshared
     pthread_cancel
+    pthread_cleanup_pop		(available in "pthread.h" header)
+    pthread_cleanup_push	(available in "pthread.h" header)
     pthread_cond_broadcast
     pthread_cond_clockwait
     pthread_cond_destroy
@@ -1048,6 +1103,7 @@ ISO/IEC DIS 9945 Information technology
     tdelete
     telldir
     tempnam
+    textdomain			(available in external gettext "libintl" library)
     tfind
     tgamma
     tgammaf
@@ -1067,6 +1123,7 @@ ISO/IEC DIS 9945 Information technology
     timer_gettime
     timer_settime
     times
+    timespec_get		(din)
     timezone
     tmpfile
     tmpnam
-- 
2.45.1

