Return-Path: <SRS0=SYvf=UH=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by sourceware.org (Postfix) with ESMTPS id 60F3138515D0
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 19:43:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 60F3138515D0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 60F3138515D0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736970209; cv=none;
	b=BsW2IbzchLno2V0PYKQeq6ZGT4aQMX7D6RINS99iGB3ZGvEbQc3RhgLR/TS4zBBh/cfuV/h3aBrsdDvuDqS576bon6o278+yZQRYDJoElAbITqfpGWvD3X8c69MY+xa7qgNxW9TJ7LDXyGIiTP/ibiUkAOYKFmN0CxANHVgew4s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736970209; c=relaxed/simple;
	bh=J4kkF4HdSLy4S3SH7649IjLGvdRQ1UXgcVn8j8FqWbw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=SgwQqWK/KCb6qWzPOOuUr9+IowzZQ/lgoMHRqdbgdA4H7EL+n9fmvN9BkjpK9Ahuw1AeJBwaPbVaT/ovDRfPN66JNdQJ53S37TUvfGllw+jHW+2+DufMvv6KA8aYUWL+pgtlzSMdmx2P8XRAx5FOq6I2L1QtI5rTsF8CV1d5TaA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 60F3138515D0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=jybmFOYX
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 00603AE049;
	Wed, 15 Jan 2025 19:43:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id 8D7C92002C;
	Wed, 15 Jan 2025 19:43:27 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v6 2/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 new additions available
Date: Wed, 15 Jan 2025 12:39:19 -0700
Message-ID: <8351d131d2aae253f9172f723484f6f6ffa564d9.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8D7C92002C
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: kpws5xor7ydzukmh6389jprbyuqdy851
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX189HAcDNwOLpq8hIcz2UgZnuX1Y/aNcjCs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=he; bh=TNouSpBtOBK0oazf7NpyW0tqjFpNKspUuMppglvTTTQ=; b=jybmFOYXbqAe4THuxqRItmFtKatYhWmBKUaIdvd9XgSQ5vlAiOn/SNOjMcBIpiHMyAyMZ4pM1crG5dFKjo6PlxY7Vl5yM87Xbq4bJMHuRHNTzyGZPcQGK/uFY7Lth74wNnIDsAW+5gJ5BI1VtEng8d+wzas1ZdybQJYjLoUvoBJVIjVZpDXfG+R8iYuc2gbssF500eXtoUWk7Y0+fjfYcWjUWYh8erD4i8OGzpXPNKriUa1NUUb9zWVQj/+Syrnf/e8FELVvtjVUkFZF4+W4k30DC5JgXd0L9vM0s++b3JBWyBLL+3evDZzlvu/bYQBiAmjoCaX7WoafW5FHE/yXMw==
X-HE-Tag: 1736970207-900868
X-HE-Meta: U2FsdGVkX19GOie7MCY7jns/XvYTmE9NfgTs73cn1qpUR6/K9MZt7sgVGOiHxIdgll/kpYlMNNL2xIKYHQpm1oKGz70sA6mf5OrF/IlggTAUtE4UfBKor/PzdIthxo82PzFd9D7TCDoET35ga2GHixrnnpcDMVqVvGtUgp2ZFF0/ceOC8G5or5+MkG8v2iZWrm1JfUhRuKxmgW/IirzLxfK741fRwaEbxOgaOirICR0VSAauRpg8G2rWxlXCRsvON3kWw5yfO6J2QCAQs6h9+jwJreFcF0omoCk1SlzuEmKvYyT8H7DfQoKArf/xNibHAmkQaEvLC90=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Add POSIX new additions available as header macros and inline functions,
or exported by Cygwin distro DLL or library packages

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 949333b0c36c..0b23a2251028 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -16,6 +16,9 @@ ISO/IEC DIS 9945 Information technology
 - Issue 8.</para>
 
 <screen>
+    CMPLX			(available in "complex.h" header)
+    CMPLXF			(available in "complex.h" header)
+    CMPLXL			(available in "complex.h" header)
     FD_CLR
     FD_ISSET
     FD_SET
@@ -74,8 +77,41 @@ ISO/IEC DIS 9945 Information technology
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
@@ -206,6 +242,9 @@ ISO/IEC DIS 9945 Information technology
     dbm_nextkey			(available in external "libgdbm" library)
     dbm_open			(available in external "libgdbm" library)
     dbm_store			(available in external "libgdbm" library)
+    dcgettext			(available in external gettext "libintl" library)
+    dcngettext			(available in external gettext "libintl" library)
+    dgettext			(available in external gettext "libintl" library)
     difftime
     dirfd
     dirname
@@ -215,6 +254,7 @@ ISO/IEC DIS 9945 Information technology
     dlerror
     dlopen
     dlsym
+    dngettext			(available in external gettext "libintl" library)
     dprintf
     drand48
     dup
@@ -359,6 +399,7 @@ ISO/IEC DIS 9945 Information technology
     getdelim
     getdomainname
     getegid
+    getentropy			(Cygwin DLL)
     getenv
     geteuid
     getgid
@@ -372,6 +413,7 @@ ISO/IEC DIS 9945 Information technology
     gethostname
     getitimer			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getline
+    getlocalename_l		(Cygwin DLL)
     getlogin
     getlogin_r
     getnameinfo
@@ -400,6 +442,7 @@ ISO/IEC DIS 9945 Information technology
     getsockname
     getsockopt
     getsubopt
+    gettext			(available in external gettext "libintl" library)
     gettimeofday
     getuid
     getutxent
@@ -415,6 +458,12 @@ ISO/IEC DIS 9945 Information technology
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
@@ -432,6 +481,8 @@ ISO/IEC DIS 9945 Information technology
     ilogbl
     imaxabs
     imaxdiv
+    in6addr_any			(Cygwin DLL)
+    in6addr_loopback		(Cygwin DLL)
     inet_addr
     inet_ntoa
     inet_ntop
@@ -506,6 +557,7 @@ ISO/IEC DIS 9945 Information technology
     jn
     jrand48
     kill
+    kill_dependency		(available in GCC "stdatomic.h" header)
     killpg
     l64a
     labs
@@ -515,6 +567,9 @@ ISO/IEC DIS 9945 Information technology
     ldexpf
     ldexpl
     ldiv
+    le16toh			(available in "endian.h" header)
+    le32toh			(available in "endian.h" header)
+    le64toh			(available in "endian.h" header)
     lfind
     lgamma
     lgammaf
@@ -634,6 +689,7 @@ ISO/IEC DIS 9945 Information technology
     nexttowardf
     nexttowardl
     nftw
+    ngettext			(available in external gettext "libintl" library)
     nice			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     nl_langinfo
     nl_langinfo_l
@@ -660,6 +716,7 @@ ISO/IEC DIS 9945 Information technology
     popen
     posix_fadvise
     posix_fallocate
+    posix_getdents		(Cygwin DLL)
     posix_madvise
     posix_memalign
     posix_openpt
@@ -722,6 +779,8 @@ ISO/IEC DIS 9945 Information technology
     pthread_barrierattr_init
     pthread_barrierattr_setpshared
     pthread_cancel
+    pthread_cleanup_pop		(available in "pthread.h" header)
+    pthread_cleanup_push	(available in "pthread.h" header)
     pthread_cond_broadcast
     pthread_cond_clockwait
     pthread_cond_destroy
@@ -1047,6 +1106,7 @@ ISO/IEC DIS 9945 Information technology
     tdelete
     telldir
     tempnam
+    textdomain			(available in external gettext "libintl" library)
     tfind
     tgamma
     tgammaf
@@ -1066,6 +1126,7 @@ ISO/IEC DIS 9945 Information technology
     timer_gettime
     timer_settime
     times
+    timespec_get		(Cygwin DLL)
     timezone
     tmpfile
     tmpnam
-- 
2.45.1

