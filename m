Return-Path: <SRS0=IVSM=UJ=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id E9AEB383FB8D
	for <cygwin-patches@cygwin.com>; Fri, 17 Jan 2025 17:03:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E9AEB383FB8D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E9AEB383FB8D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737133422; cv=none;
	b=iaibDxdj9+BQcBza+W49bvlzj2cpKrvMCD7LEX7CSIFhL71ajNLwc7izbM0PjGcIqVbI+QrmSNFH5HopU8emG2uJWkdqoe6jPbXlqhId8iQFESfjqb+jIug2Ki6L0Gh+uf36pYctXnWgI6+PNtHe5Gle1Xcq6qfk/pn8aRwO/lA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737133422; c=relaxed/simple;
	bh=iQaKlCrJ4syGsQdgoEvP+7QZB3yenPTggSCaeptHK4c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=BpZ14lfsteF+y7UVs7o4ySEYyLxv0U0LIRrt8gRWzAfumxz0K43sVcJWUX2FExkVM+P1PQ3I9hzvI8ic/sT+bWh+fJpRnlk2KTS99QFynrNe/+dNUq7adVXDZX1UUFBD/YCv3Uq8il38+Ks9tbwcpOIWhunFsAbsV03fqFEb89A=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E9AEB383FB8D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=Kmvi5T13
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 52A3EC0565;
	Fri, 17 Jan 2025 17:03:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf17.hostedemail.com (Postfix) with ESMTPA id E0E6C1B;
	Fri, 17 Jan 2025 17:03:39 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v7 2/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 new additions available
Date: Fri, 17 Jan 2025 10:01:05 -0700
Message-ID: <9f97cea6825d2d3ebaf920f057387c0a9f7f7084.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E0E6C1B
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: xa3japb7znjdngtk385zg7bkccmdsgo6
X-Rspamd-Server: rspamout03
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/VaQQwzfBoyzuBVLZ/eoUKq3CVT3LFOQc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=he; bh=RWkaSUKoC5Ou6YqHH57E6+B0pdbxmceY/XkYq0FEyL0=; b=Kmvi5T130mOezxuwfsNDZHxzerHU8qFNXeE0KkNKArykcq+yV49eL0dSvgoNQVojqLctdKJAzAIRIUE45YPq4Oif3ixX3qlRFHsMqpMtvI53t6st3HOSqmiPAJ0s0WQfOt60AQTz/69tRJ7eFZJIV8f4Kjq+6jf6k2X03lx/UN0vYb3KEme1oyTYQHbNyWA5EnY2H7LyvhDfJiDNw7Y0FiaFwH1pvNFR2lSsrH/5zoSX7vzp8NMe3qbnJAaX4HelGoDjJKaaLP2peGAqbRyWWkDPRkNW07pUSPL1gdksyqojFCY5UERi8DgRKiQxrHzXDie6StdoQLcLUbOq1z2aKA==
X-HE-Tag: 1737133419-312230
X-HE-Meta: U2FsdGVkX1+3oxi4WFIN7XcFLjRQe5+HfjTfzvdsX9jd9l+emYahWunvRLI2NqTiVFiPyUHqvSYUv8p+RN85CBYwv74a7bhg2z2W4bVw+AnEMAjTpUSmPH2Tu812qU1vE9MCHxVR8zuxC16HKf0DGtboKk1UEpikTskHFXqyDb+oSRFCWRtdtjpYXwVjEkK1+Vh957Ybf2/UJW2T105p5oNnfJRi/rZVUyipWxYwkPwDhEaZaFgna/nEIC/tZm53UlXs6GXgNYeZmiyua1Lx3EFI/STievGbMWTHZaP/HQqDP2sJy2Upq/w0GACr99ZnwZsuYRBp9p0=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Add POSIX new additions available as header macros and inline functions,
or exported by Cygwin distro DLL or library packages

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 9a8890936875..ac05657d2246 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -74,8 +74,41 @@ ISO/IEC DIS 9945 Information technology
     atoi
     atol
     atoll
+    atomic_compare_exchange_strong
+    atomic_compare_exchange_strong_explicit
+    atomic_compare_exchange_weak
+    atomic_compare_exchange_weak_explicit
+    atomic_exchange
+    atomic_exchange_explicit
+    atomic_fetch_add
+    atomic_fetch_add_explicit
+    atomic_fetch_and
+    atomic_fetch_and_explicit
+    atomic_fetch_or
+    atomic_fetch_or_explicit
+    atomic_fetch_sub
+    atomic_fetch_sub_explicit
+    atomic_fetch_xor
+    atomic_fetch_xor_explicit
+    atomic_flag_clear
+    atomic_flag_clear_explicit
+    atomic_flag_test_and_set
+    atomic_flag_test_and_set_explicit
+    atomic_init
+    atomic_is_lock_free
+    atomic_load
+    atomic_load_explicit
+    atomic_signal_fence
+    atomic_store
+    atomic_store_explicit
+    atomic_thread_fence
     basename			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
+    be16toh
+    be32toh
+    be64toh
     bind
+    bind_textdomain_codeset	(available in external "libintl" library)
+    bindtextdomain		(available in external "libintl" library)
     bsearch
     btowc
     c16rtomb
@@ -206,6 +239,9 @@ ISO/IEC DIS 9945 Information technology
     dbm_nextkey			(available in external "libgdbm" library)
     dbm_open			(available in external "libgdbm" library)
     dbm_store			(available in external "libgdbm" library)
+    dcgettext			(available in external "libintl" library)
+    dcngettext			(available in external "libintl" library)
+    dgettext			(available in external "libintl" library)
     difftime
     dirfd
     dirname
@@ -215,6 +251,7 @@ ISO/IEC DIS 9945 Information technology
     dlerror
     dlopen
     dlsym
+    dngettext			(available in external "libintl" library)
     dprintf
     drand48
     dup
@@ -359,6 +396,7 @@ ISO/IEC DIS 9945 Information technology
     getdelim
     getdomainname
     getegid
+    getentropy
     getenv
     geteuid
     getgid
@@ -372,6 +410,7 @@ ISO/IEC DIS 9945 Information technology
     gethostname
     getitimer			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getline
+    getlocalename_l
     getlogin
     getlogin_r
     getnameinfo
@@ -400,6 +439,7 @@ ISO/IEC DIS 9945 Information technology
     getsockname
     getsockopt
     getsubopt
+    gettext			(available in external "libintl" library)
     gettimeofday
     getuid
     getutxent
@@ -415,6 +455,12 @@ ISO/IEC DIS 9945 Information technology
     hcreate
     hdestroy
     hsearch
+    htobe16
+    htobe32
+    htobe64
+    htole16
+    htole32
+    htole64
     htonl
     htons
     hypot
@@ -432,6 +478,8 @@ ISO/IEC DIS 9945 Information technology
     ilogbl
     imaxabs
     imaxdiv
+    in6addr_any
+    in6addr_loopback
     inet_addr
     inet_ntoa
     inet_ntop
@@ -515,6 +563,9 @@ ISO/IEC DIS 9945 Information technology
     ldexpf
     ldexpl
     ldiv
+    le16toh
+    le32toh
+    le64toh
     lfind
     lgamma
     lgammaf
@@ -634,6 +685,7 @@ ISO/IEC DIS 9945 Information technology
     nexttowardf
     nexttowardl
     nftw
+    ngettext			(available in external "libintl" library)
     nice			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     nl_langinfo
     nl_langinfo_l
@@ -660,6 +712,7 @@ ISO/IEC DIS 9945 Information technology
     popen
     posix_fadvise
     posix_fallocate
+    posix_getdents
     posix_madvise
     posix_memalign
     posix_openpt
@@ -722,6 +775,8 @@ ISO/IEC DIS 9945 Information technology
     pthread_barrierattr_init
     pthread_barrierattr_setpshared
     pthread_cancel
+    pthread_cleanup_pop
+    pthread_cleanup_push
     pthread_cond_broadcast
     pthread_cond_clockwait
     pthread_cond_destroy
@@ -1047,6 +1102,7 @@ ISO/IEC DIS 9945 Information technology
     tdelete
     telldir
     tempnam
+    textdomain			(available in external "libintl" library)
     tfind
     tgamma
     tgammaf
@@ -1066,6 +1122,7 @@ ISO/IEC DIS 9945 Information technology
     timer_gettime
     timer_settime
     times
+    timespec_get
     timezone
     tmpfile
     tmpnam
-- 
2.45.1

