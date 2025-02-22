Return-Path: <SRS0=Yd2F=VN=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id 2939E3858D28
	for <cygwin-patches@cygwin.com>; Sat, 22 Feb 2025 17:49:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2939E3858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2939E3858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740246543; cv=none;
	b=MgNPHd0c4YSgU+v/+OLz5HwUZSPX1t+k47BuV/xJwIZppg0PipazbEuhlhmByalb5IKHhwASKWHMseQ/7puP0ulDg1PAZiQD49b3IMPdwfMBNQhGwfcZtSZQtry6ET1xl0oiHdESE5p7osil0U8j32fd114X5AZe9WkXWevsa2U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740246543; c=relaxed/simple;
	bh=qIaOpw2c9WsaY8AcjBrYo3TC7NkMgnRkv0XzVLltb+w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=b5KD0kRM/kXFuKGTiF9/wutII1XTMmMFaCXodn9FA5TqtiXXSRTPKp1VyizRM6omAlxHn5ni1cLXSxEFpLV8a9iwWOuwBpJayHtAG8q3olUr+5ouQbMJc5aqtZMCXfq0wH1Em85b/QvqgUf2d9MgnGRIszPRtraJDIGQEQHS9GQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2939E3858D28
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=XGeMjicp
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B6C5981947;
	Sat, 22 Feb 2025 17:49:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf16.hostedemail.com (Postfix) with ESMTPA id 40F232000E;
	Sat, 22 Feb 2025 17:49:01 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v8 2/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 new additions available
Date: Sat, 22 Feb 2025 10:48:19 -0700
Message-ID: <e4715eacc932b89d28a62351bc4301581a56e1ab.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40F232000E
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: omfw7ucryqqo6h55pj3dahkoe6rir9wj
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18dMm9ez4ec0JF7iJOr+TV0YYlhuqTIGU4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=he; bh=mRbViSllvDQ+dzEftP7pMeB3WynJK/8jPsAagdzYNAs=; b=XGeMjicpZj8K5AHenJqfnayWWU9nLemxjnjcG/GF8joxk0MuXk4DYfjTC32NC+Kn5l+kYY32YLgW/JGPGZMCsdPrxKcSaeGmwtoEPSi8DKtLTNJv0c64FzsER76ZOHJb1y7FSL6OS6xOHTX+QQjl/2x8dT2jM2h4QxUF42BOn5aV/s73VuT+OBd5yL484QzToKbBezzis1A6SdkebMYgvkNBae7d23pQ0WnTgjKI8lbJw+U6J3CgBfDRGGwNIpM4KJ3ZBhjE/L4q9TFEMTg5tUI9dkY3/1u08Q7V8UPXq+WcyQ274b6euyFdIXDy+36yIV5j4MSYYBK8bXk9jROpfg==
X-HE-Tag: 1740246541-107004
X-HE-Meta: U2FsdGVkX1+oqFMYwqoDBIqcSqS4ZES3dcwK68K62ODNitsiUKOyN2iN0/Ad3rEYsFDMToPnyDpzDl0qfLG1dNMVXXNyXXzwSRmV2FaKpntO2aUQ1hvTeB/KHua2pIkwz25Zzukt9+8bvQxqd0INV8oonLROur9fU+v5mVr61eVjZT+cxVjK5JTbucwMQNk7ojHe7uhO1WV7EFyykoty2yiRC5k7G3tDiWjCeM7tpUbWJT52F95Y2xdwvyPV0yf38x84YFtmHiIXHVtXcSXRrV0obpzeDXI/pHYkDQE7u3yBny/rvgIIsRhRr9QjKGfYPncvTRfvkeirTVtp9tmF1y5HQODVrOVP6GvZwUD+M+bloxuH8TcJWnufzoitJgD/+iwgyfLlUQrRIX38QRiRfQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Add POSIX new additions available as header macros and inline functions,
or exported by Cygwin distro DLL or library packages

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 65 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 7debfb5084b4..31dbefd1fc48 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -16,6 +16,9 @@ ISO®/IEC DIS 9945 Information technology
 - Issue 8.</para>
 
 <screen>
+    CMPLX
+    CMPLXF
+    CMPLXL
     FD_CLR
     FD_ISSET
     FD_SET
@@ -57,6 +60,7 @@ ISO®/IEC DIS 9945 Information technology
     asinhl
     asinl
     asprintf
+    assert
     at_quick_exit
     atan
     atan2
@@ -73,8 +77,41 @@ ISO®/IEC DIS 9945 Information technology
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
+    bind_textdomain_codeset
+    bindtextdomain
     bsearch
     btowc
     c16rtomb
@@ -205,6 +242,9 @@ ISO®/IEC DIS 9945 Information technology
     dbm_nextkey			(available in external "libgdbm" library)
     dbm_open			(available in external "libgdbm" library)
     dbm_store			(available in external "libgdbm" library)
+    dcgettext			(available in external "libintl" library)
+    dcngettext			(available in external "libintl" library)
+    dgettext			(available in external "libintl" library)
     difftime
     dirfd
     dirname
@@ -214,6 +254,7 @@ ISO®/IEC DIS 9945 Information technology
     dlerror
     dlopen
     dlsym
+    dngettext			(available in external "libintl" library)
     dprintf
     drand48
     dup
@@ -358,6 +399,7 @@ ISO®/IEC DIS 9945 Information technology
     getdelim
     getdomainname
     getegid
+    getentropy
     getenv
     geteuid
     getgid
@@ -371,6 +413,7 @@ ISO®/IEC DIS 9945 Information technology
     gethostname
     getitimer			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     getline
+    getlocalename_l
     getlogin
     getlogin_r
     getnameinfo
@@ -399,6 +442,7 @@ ISO®/IEC DIS 9945 Information technology
     getsockname
     getsockopt
     getsubopt
+    gettext			(available in external "libintl" library)
     gettimeofday
     getuid
     getutxent
@@ -414,6 +458,12 @@ ISO®/IEC DIS 9945 Information technology
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
@@ -431,6 +481,8 @@ ISO®/IEC DIS 9945 Information technology
     ilogbl
     imaxabs
     imaxdiv
+    in6addr_any
+    in6addr_loopback
     inet_addr
     inet_ntoa
     inet_ntop
@@ -505,6 +557,7 @@ ISO®/IEC DIS 9945 Information technology
     jn
     jrand48
     kill
+    kill_dependency
     killpg
     l64a
     labs
@@ -514,6 +567,9 @@ ISO®/IEC DIS 9945 Information technology
     ldexpf
     ldexpl
     ldiv
+    le16toh
+    le32toh
+    le64toh
     lfind
     lgamma
     lgammaf
@@ -633,6 +689,7 @@ ISO®/IEC DIS 9945 Information technology
     nexttowardf
     nexttowardl
     nftw
+    ngettext			(available in external "libintl" library)
     nice			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     nl_langinfo
     nl_langinfo_l
@@ -657,14 +714,18 @@ ISO®/IEC DIS 9945 Information technology
     pipe2
     poll
     popen
+    posix_devctl
     posix_fadvise
     posix_fallocate
+    posix_getdents
     posix_madvise
     posix_memalign
     posix_openpt
     posix_spawn
+    posix_spawn_file_actions_addchdir
     posix_spawn_file_actions_addclose
     posix_spawn_file_actions_adddup2
+    posix_spawn_file_actions_addfchdir
     posix_spawn_file_actions_addopen
     posix_spawn_file_actions_destroy
     posix_spawn_file_actions_init
@@ -719,6 +780,8 @@ ISO®/IEC DIS 9945 Information technology
     pthread_barrierattr_init
     pthread_barrierattr_setpshared
     pthread_cancel
+    pthread_cleanup_pop
+    pthread_cleanup_push
     pthread_cond_broadcast
     pthread_cond_clockwait
     pthread_cond_destroy
@@ -1046,6 +1109,7 @@ ISO®/IEC DIS 9945 Information technology
     tdelete
     telldir
     tempnam
+    textdomain			(available in external "libintl" library)
     tfind
     tgamma
     tgammaf
@@ -1065,6 +1129,7 @@ ISO®/IEC DIS 9945 Information technology
     timer_gettime
     timer_settime
     times
+    timespec_get
     timezone
     tmpfile
     tmpnam
-- 
2.45.1

