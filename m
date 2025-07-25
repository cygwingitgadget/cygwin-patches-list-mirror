Return-Path: <SRS0=bRWV=2G=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 5BFFD3858D33
	for <cygwin-patches@cygwin.com>; Fri, 25 Jul 2025 23:10:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5BFFD3858D33
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5BFFD3858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753485033; cv=none;
	b=pJJMOEqyZZvd4iGqApCYtoUk2KL9cv1S/VPxqh52sRtlw5dhaB5sxSJ1pWYaQ8L1lgn6x5bXtsiHm4fqioC7Spvhqn/ex94CGhf0Yj+CQZ7ylD6PCKKU99jNHLfUaCzwmPzWawfDCQHrT9YuB7MTVMv/tpVYplfbmdSWlBx1gbI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753485033; c=relaxed/simple;
	bh=d1Ae2yrTbsz8HlB4JSp3/xTzk6AZekyXD5O/9nZFs7I=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=vb9iXVbnr2rbBWgQltZMZ/pqVD23/PE2n0Vqg7qQ3PtSEoHcp1Ze7QBrFvmhA4QautYuWSghCJhQi7F5wHH+u3P/26lB5rWdj6Fm3TA0XT1ihQ5zzkDnDHl2DkkPpqmqXBX1imxN4TubfGffQ+xMrEEFJJyjmX74dqPeYbDWMqQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5BFFD3858D33
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=hjA+Nk8Q
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id F397645CD2
	for <cygwin-patches@cygwin.com>; Fri, 25 Jul 2025 19:10:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=WzOER
	RzDOFsgFQek6npujp3AimI=; b=hjA+Nk8QcnEfWQ9/XI13v5iIdy1g0nM671LlX
	vK5NPLfFdxwi1DejKeHmDqVmROUWdfaBNDi0Pl+Jo7Zoezzxrre5FKmLzkyqU4zE
	OjOdzrk1A/9Xazosa2g6xaozeb9eMG6GLSkBA1AnJlhqJbXg+VbgMBsmu2H5Dq5y
	gyTvMs=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id D929245CC6
	for <cygwin-patches@cygwin.com>; Fri, 25 Jul 2025 19:10:32 -0400 (EDT)
Date: Fri, 25 Jul 2025 16:10:32 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: add wrappers for newer new/delete overloads
Message-ID: <778f2295-5ae5-b0b3-08f7-8623ed05e5b0@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_SHORT,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

A sized delete (with a std::size_t parameter) was added in C++14 (but
doesn't combine with nothrow_t)

An aligned new/delete (with a std::align_val_t parameter) was added in
C++17, and combinations with the sized delete and nothrow_t variants.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
I added #pragma GCC diagnostic ignored "-Wc++17-compat" preemptively to
cxx.cc to match what was done with c++14-compat with the one sized delete
that was already present (presumably because it broke things when GCC
started to emit that instead of the non-sized delete).

The default new implementation uses calloc, so I'm not sure if it's
expected that the aligned new call memset to zero the returned memory.
It'd be easy enough to add if necessary.

GCC will need to be updated circa
https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/config/i386/cygwin-w64.h;h=160a290a03d00f6408252f5d8751fea7cd44e1be;hb=HEAD#l27
but only after this change is stable because it will cause linker errors
if the new __wrap symbols are not exported.

Does there need to be a version bump somewhere to make sure a module
linked against a new libcygwin.a doesn't run against an old cygwin1.dll,
resulting in _cygwin_crt0_common.cc writing too much data to
default_cygwin_cxx_malloc?

 winsup/cygwin/cxx.cc                      | 120 +++++++++++++++++++++-
 winsup/cygwin/cygwin.din                  |  12 +++
 winsup/cygwin/lib/_cygwin_crt0_common.cc  |  59 +++++++++++
 winsup/cygwin/libstdcxx_wrapper.cc        |  99 ++++++++++++++++++
 winsup/cygwin/local_includes/cygwin-cxx.h |  14 +++
 5 files changed, 299 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/cxx.cc b/winsup/cygwin/cxx.cc
index b69524acad..a14aab8726 100644
--- a/winsup/cygwin/cxx.cc
+++ b/winsup/cygwin/cxx.cc
@@ -28,27 +28,75 @@ operator delete (void *p)
   free (p);
 }

+void *
+operator new[] (std::size_t s)
+{
+  return ::operator new (s);
+}
+
+void
+operator delete[] (void *p)
+{
+  ::operator delete (p);
+}
+
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wc++14-compat"
 void
 operator delete (void *p, size_t)
 {
-  ::operator delete(p);
+  ::operator delete (p);
+}
+
+void
+operator delete[] (void *p, size_t)
+{
+  ::operator delete (p);
 }
 #pragma GCC diagnostic pop

+/* Aligned versions, provided only for completeness in the fallback array. */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wc++17-compat"
 void *
-operator new[] (std::size_t s)
+operator new (std::size_t sz, std::align_val_t al)
 {
-  return ::operator new (s);
+  void *ret;
+  /* is memset needed here, since the non-aligned version uses calloc? */
+  if (!posix_memalign (&ret, static_cast <std::size_t> (al), sz))
+    return ret;
+  return NULL;
+}
+
+void *
+operator new[] (std::size_t sz, std::align_val_t al)
+{
+  return ::operator new (sz, al);
 }

 void
-operator delete[] (void *p)
+operator delete (void *p, std::align_val_t)
 {
-  ::operator delete (p);
+  free (p);
+}
+void
+operator delete[] (void *p, std::align_val_t al)
+{
+  ::operator delete (p, al);
 }

+void
+operator delete (void *p, std::size_t, std::align_val_t al)
+{
+  ::operator delete (p, al);
+}
+
+void operator delete[] (void *p, std::size_t, std::align_val_t al)
+{
+  ::operator delete (p, al);
+}
+#pragma GCC diagnostic pop
+
 /* Nothrow versions, provided only for completeness in the fallback array.  */

 void *
@@ -76,6 +124,51 @@ operator delete[] (void *p, const std::nothrow_t &nt)
   ::operator delete (p, nt);
 }

+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wc++14-compat"
+void
+operator delete (void *p, size_t, const std::nothrow_t &nt)
+{
+  ::operator delete (p, nt);
+}
+
+void
+operator delete[] (void *p, size_t, const std::nothrow_t &nt)
+{
+  ::operator delete (p, nt);
+}
+#pragma GCC diagnostic pop
+
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wc++17-compat"
+void *
+operator new (std::size_t sz, std::align_val_t al, const std::nothrow_t &)
+{
+
+  void *ret;
+  /* is memset needed here, since the non-aligned version uses calloc? */
+  if (!posix_memalign (&ret, static_cast <std::size_t> (al), sz))
+    return ret;
+  return NULL;
+}
+
+void *
+operator new[] (std::size_t sz, std::align_val_t al, const std::nothrow_t &nt)
+{
+  return ::operator new (sz, al, nt);
+}
+
+void
+operator delete (void *p, std::align_val_t, const std::nothrow_t &nt)
+{
+  ::operator delete (p, nt);
+}
+
+void operator delete[] (void *p, std::align_val_t, const std::nothrow_t &nt)
+{
+  ::operator delete (p, nt);
+}
+#pragma GCC diagnostic pop

 extern "C" void
 __cxa_pure_virtual (void)
@@ -95,10 +188,27 @@ struct per_process_cxx_malloc default_cygwin_cxx_malloc =
   &(operator new[]),
   &(operator delete),
   &(operator delete[]),
+  /* nothrow new/delete */
+  &(operator new),
+  &(operator new[]),
+  &(operator delete),
+  &(operator delete[]),
+  /* C++14 sized delete */
+  &(operator delete),
+  &(operator delete[]),
+  /* C++17 aligned new/delete */
   &(operator new),
   &(operator new[]),
   &(operator delete),
   &(operator delete[]),
+  /* aligned + sized delete */
+  &(operator delete),
+  &(operator delete[]),
+  /* aligned + nothrow new/delete */
+  &(operator new),
+  &(operator new[]),
+  &(operator delete),
+  &(operator delete[])
 };


diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
index d7a17b234a..cd71da2746 100644
--- a/winsup/cygwin/cygwin.din
+++ b/winsup/cygwin/cygwin.din
@@ -124,13 +124,25 @@ __swbuf_r SIGFE
 __vsnprintf_chk SIGFE
 __vsprintf_chk SIGFE
 __wrap__ZdaPv NOSIGFE               # void operator delete[](void *p) throw()
+__wrap__ZdaPvm NOSIGFE              # void operator delete[](void *p, std::size_t sz) throw()
+__wrap__ZdaPvmSt11align_val_t NOSIGFE # void operator delete[](void *p, std::size_t sz, std::align_val_t al) throw()
 __wrap__ZdaPvRKSt9nothrow_t NOSIGFE # void operator delete[](void *p, const std::nothrow_t &nt) throw()
+__wrap__ZdaPvSt11align_val_t NOSIGFE # void operator delete[](void *p, std::align_val_t al) throw()
+__wrap__ZdaPvSt11align_val_tRKSt9nothrow_t NOSIGFE # void operator delete[](void *p, std::align_val_t al, const std::nothrow_t &nt) throw()
 __wrap__ZdlPv NOSIGFE               # void operator delete(void *p) throw()
+__wrap__ZdlPvm NOSIGFE              # void operator delete(void *p, std::size_t sz) throw()
+__wrap__ZdlPvmSt11align_val_t NOSIGFE # void operator delete(void *p, std::size_t sz, std::align_val_t al) throw()
 __wrap__ZdlPvRKSt9nothrow_t NOSIGFE # void operator delete(void *p, const std::nothrow_t &nt) throw()
+__wrap__ZdlPvSt11align_val_t NOSIGFE # void operator delete(void *p, std::align_val_t al) throw()
+__wrap__ZdlPvSt11align_val_tRKSt9nothrow_t NOSIGFE # void operator delete(void *p, std::align_val_t al, const std::nothrow_t &nt) throw()
 __wrap__Znam NOSIGFE                # void *operator new[](std::size_t sz) throw (std::bad_alloc)
 __wrap__ZnamRKSt9nothrow_t NOSIGFE  # void *operator new[](std::size_t sz, const std::nothrow_t &nt) throw()
+__wrap__ZnamSt11align_val_t NOSIGFE # void *operator new[](std::size_t sz, std::align_val_t al) throw (std::bad_alloc)
+__wrap__ZnamSt11align_val_tRKSt9nothrow_t NOSIGFE # void *operator new[](std::size_t sz, std::align_val_t al, const std::nothrow_t &nt) throw()
 __wrap__Znwm NOSIGFE                # void *operator new(std::size_t sz) throw (std::bad_alloc)
 __wrap__ZnwmRKSt9nothrow_t NOSIGFE  # void *operator new(std::size_t sz, const std::nothrow_t &nt) throw()
+__wrap__ZnwmSt11align_val_t NOSIGFE # void *operator new(std::size_t sz, std::align_val_t al) throw (std::bad_alloc)
+__wrap__ZnwmSt11align_val_tRKSt9nothrow_t NOSIGFE # void *operator new(std::size_t sz, std::align_val al, const std::nothrow_t &nt) throw()
 __xdrrec_getrec SIGFE
 __xdrrec_setnonblock SIGFE
 __xpg_sigpause SIGFE
diff --git a/winsup/cygwin/lib/_cygwin_crt0_common.cc b/winsup/cygwin/lib/_cygwin_crt0_common.cc
index d356a50fba..5900e6315d 100644
--- a/winsup/cygwin/lib/_cygwin_crt0_common.cc
+++ b/winsup/cygwin/lib/_cygwin_crt0_common.cc
@@ -22,6 +22,18 @@ details. */
 #define REAL_ZDAPV		_SYMSTR (__real__ZdaPv)
 #define REAL_ZDLPV_NOTHROW_T	_SYMSTR (__real__ZdlPvRKSt9nothrow_t)
 #define REAL_ZDAPV_NOTHROW_T	_SYMSTR (__real__ZdaPvRKSt9nothrow_t)
+#define REAL_ZDLPVM		_SYMSTR (__real__ZdlPvm)
+#define REAL_ZDAPVM		_SYMSTR (__real__ZdaPvm)
+#define REAL_ZNWX_ALIGN_VAL_T	"__real__ZnwmSt11align_val_t"
+#define REAL_ZNAX_ALIGN_VAL_T	"__real__ZnamSt11align_val_t"
+#define REAL_ZDLPV_ALIGN_VAL_T	_SYMSTR (__real__ZdlPvSt11align_val_t)
+#define REAL_ZDAPV_ALIGN_VAL_T	_SYMSTR (__real__ZdaPvSt11align_val_t)
+#define REAL_ZDLPVM_ALIGN_VAL_T	_SYMSTR (__real__ZdlPvmSt11align_val_t)
+#define REAL_ZDAPVM_ALIGN_VAL_T	_SYMSTR (__real__ZdaPvmSt11align_val_t)
+#define REAL_ZNWX_ALIGN_VAL_T_NOTHROW_T	"__real__ZnwmSt11align_val_tRKSt9nothrow_t"
+#define REAL_ZNAX_ALIGN_VAL_T_NOTHROW_T	"__real__ZnamSt11align_val_tRKSt9nothrow_t"
+#define REAL_ZDLPV_ALIGN_VAL_T_NOTHROW_T	_SYMSTR (__real__ZdlPvSt11align_val_tRKSt9nothrow_t)
+#define REAL_ZDAPV_ALIGN_VAL_T_NOTHROW_T	_SYMSTR (__real__ZdaPvSt11align_val_tRKSt9nothrow_t)

 /* Use asm names to bypass the --wrap that is being applied to redirect all other
    references to these operators toward the redirectors in the Cygwin DLL; this
@@ -43,6 +55,30 @@ extern WEAK void operator delete(void *p, const std::nothrow_t &nt) noexcept (tr
 			__asm__ (REAL_ZDLPV_NOTHROW_T);
 extern WEAK void operator delete[](void *p, const std::nothrow_t &nt) noexcept (true)
 			__asm__ (REAL_ZDAPV_NOTHROW_T);
+extern WEAK void operator delete(void *p, std::size_t sz) noexcept (true)
+			__asm__ (REAL_ZDLPVM);
+extern WEAK void operator delete[](void *p, std::size_t sz) noexcept (true)
+			__asm__ (REAL_ZDAPVM);
+extern WEAK void *operator new(std::size_t sz, std::align_val_t al) noexcept (false)
+			__asm__ (REAL_ZNWX_ALIGN_VAL_T);
+extern WEAK void *operator new[](std::size_t sz, std::align_val_t al) noexcept (false)
+			__asm__ (REAL_ZNAX_ALIGN_VAL_T);
+extern WEAK void operator delete(void *p, std::align_val_t al) noexcept (true)
+			__asm__ (REAL_ZDLPV_ALIGN_VAL_T);
+extern WEAK void operator delete[](void *p, std::align_val_t al) noexcept (true)
+			__asm__ (REAL_ZDAPV_ALIGN_VAL_T);
+extern WEAK void operator delete(void *p, std::size_t sz, std::align_val_t al) noexcept (true)
+			__asm__ (REAL_ZDLPVM_ALIGN_VAL_T);
+extern WEAK void operator delete[](void *p, std::size_t sz, std::align_val_t al) noexcept (true)
+			__asm__ (REAL_ZDAPVM_ALIGN_VAL_T);
+extern WEAK void *operator new(std::size_t sz, std::align_val_t al, const std::nothrow_t &nt) noexcept (true)
+			__asm__ (REAL_ZNWX_ALIGN_VAL_T_NOTHROW_T);
+extern WEAK void *operator new[](std::size_t sz, std::align_val_t al, const std::nothrow_t &nt) noexcept (true)
+			__asm__ (REAL_ZNAX_ALIGN_VAL_T_NOTHROW_T);
+extern WEAK void operator delete(void *p, std::align_val_t al, const std::nothrow_t &nt) noexcept (true)
+			__asm__ (REAL_ZDLPV_ALIGN_VAL_T_NOTHROW_T);
+extern WEAK void operator delete[](void *p, std::align_val_t al, const std::nothrow_t &nt) noexcept (true)
+			__asm__ (REAL_ZDAPV_ALIGN_VAL_T_NOTHROW_T);

 /* Avoid an info message from linker when linking applications.  */
 extern __declspec(dllimport) struct _reent *_impure_ptr;
@@ -65,6 +101,17 @@ struct per_process_cxx_malloc __cygwin_cxx_malloc =
 {
   &(operator new), &(operator new[]),
   &(operator delete), &(operator delete[]),
+  /* nothrow new/delete */
+  &(operator new), &(operator new[]),
+  &(operator delete), &(operator delete[]),
+  /* C++14 sized delete */
+  &(operator delete), &(operator delete[]),
+  /* C++17 aligned new/delete */
+  &(operator new), &(operator new[]),
+  &(operator delete), &(operator delete[]),
+  /* aligned + sized delete */
+  &(operator delete), &(operator delete[]),
+  /* aligned + nothrow new/delete */
   &(operator new), &(operator new[]),
   &(operator delete), &(operator delete[])
 };
@@ -143,6 +190,18 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
       CONDITIONALLY_OVERRIDE(oper_new___nt);
       CONDITIONALLY_OVERRIDE(oper_delete_nt);
       CONDITIONALLY_OVERRIDE(oper_delete___nt);
+      CONDITIONALLY_OVERRIDE(oper_delete_sz);
+      CONDITIONALLY_OVERRIDE(oper_delete___sz);
+      CONDITIONALLY_OVERRIDE(oper_new_al);
+      CONDITIONALLY_OVERRIDE(oper_new___al);
+      CONDITIONALLY_OVERRIDE(oper_delete_al);
+      CONDITIONALLY_OVERRIDE(oper_delete___al);
+      CONDITIONALLY_OVERRIDE(oper_delete_sz_al);
+      CONDITIONALLY_OVERRIDE(oper_delete___sz_al);
+      CONDITIONALLY_OVERRIDE(oper_new_al_nt);
+      CONDITIONALLY_OVERRIDE(oper_new___al_nt);
+      CONDITIONALLY_OVERRIDE(oper_delete_al_nt);
+      CONDITIONALLY_OVERRIDE(oper_delete___al_nt);
       /* Now update the resulting set into the global redirectors.  */
       *newu->cxx_malloc = __cygwin_cxx_malloc;
     }
diff --git a/winsup/cygwin/libstdcxx_wrapper.cc b/winsup/cygwin/libstdcxx_wrapper.cc
index 34911d0e11..fa13fddc9d 100644
--- a/winsup/cygwin/libstdcxx_wrapper.cc
+++ b/winsup/cygwin/libstdcxx_wrapper.cc
@@ -24,6 +24,10 @@ details.  */
 #define MANGLED_ZNAX			"__wrap__Znam"
 #define MANGLED_ZNWX_NOTHROW_T		"__wrap__ZnwmRKSt9nothrow_t"
 #define MANGLED_ZNAX_NOTHROW_T		"__wrap__ZnamRKSt9nothrow_t"
+#define MANGLED_ZNWX_ALIGN_VAL_T	"__wrap__ZnwmSt11align_val_t"
+#define MANGLED_ZNAX_ALIGN_VAL_T	"__wrap__ZnamSt11align_val_t"
+#define MANGLED_ZNWX_ALIGN_VAL_T_NOTHROW_T	"__wrap__ZnwmSt11align_val_tRKSt9nothrow_t"
+#define MANGLED_ZNAX_ALIGN_VAL_T_NOTHROW_T	"__wrap__ZnamSt11align_val_tRKSt9nothrow_t"

 extern void *operator new(std::size_t sz) noexcept (false)
 			__asm__ (MANGLED_ZNWX);
@@ -41,6 +45,30 @@ extern void operator delete(void *p, const std::nothrow_t &nt) noexcept (true)
 			__asm__ (_SYMSTR (__wrap__ZdlPvRKSt9nothrow_t));
 extern void operator delete[](void *p, const std::nothrow_t &nt) noexcept (true)
 			__asm__ (_SYMSTR (__wrap__ZdaPvRKSt9nothrow_t));
+extern void operator delete(void *p, std::size_t sz) noexcept (true)
+			__asm__ (_SYMSTR (__wrap__ZdlPvm));
+extern void operator delete[](void *p, std::size_t sz) noexcept (true)
+			__asm__ (_SYMSTR (__wrap__ZdaPvm));
+extern void *operator new(std::size_t sz, std::align_val_t al) noexcept (false)
+			__asm__ (MANGLED_ZNWX_ALIGN_VAL_T);
+extern void *operator new[](std::size_t sz, std::align_val_t al) noexcept (false)
+			__asm__ (MANGLED_ZNAX_ALIGN_VAL_T);
+extern void operator delete(void *p, std::align_val_t al) noexcept (true)
+			__asm__ (_SYMSTR (__wrap__ZdlPvSt11align_val_t));
+extern void operator delete[](void *p, std::align_val_t al) noexcept (true)
+			__asm__ (_SYMSTR (__wrap__ZdaPvSt11align_val_t));
+extern void operator delete(void *p, std::size_t sz, std::align_val_t al) noexcept (true)
+			__asm__ (_SYMSTR (__wrap__ZdlPvmSt11align_val_t));
+extern void operator delete[](void *p, std::size_t sz, std::align_val_t al) noexcept (true)
+			__asm__ (_SYMSTR (__wrap__ZdaPvmSt11align_val_t));
+extern void *operator new(std::size_t sz, std::align_val_t al, const std::nothrow_t &nt) noexcept (true)
+			__asm__ (MANGLED_ZNWX_ALIGN_VAL_T_NOTHROW_T);
+extern void *operator new[](std::size_t sz, std::align_val_t al, const std::nothrow_t &nt) noexcept (true)
+			__asm__ (MANGLED_ZNAX_ALIGN_VAL_T_NOTHROW_T);
+extern void operator delete(void *p, std::align_val_t al, const std::nothrow_t &nt) noexcept (true)
+			__asm__ (_SYMSTR (__wrap__ZdlPvSt11align_val_tRKSt9nothrow_t));
+extern void operator delete[](void *p, std::align_val_t al, const std::nothrow_t &nt) noexcept (true)
+			__asm__ (_SYMSTR (__wrap__ZdaPvSt11align_val_tRKSt9nothrow_t));

 extern void *
 operator new(std::size_t sz) noexcept (false)
@@ -66,6 +94,54 @@ operator delete[](void *p) noexcept (true)
   (*user_data->cxx_malloc->oper_delete__) (p);
 }

+extern void
+operator delete(void *p, std::size_t sz) noexcept (true)
+{
+  (*user_data->cxx_malloc->oper_delete_sz) (p, sz);
+}
+
+extern void
+operator delete[](void *p, std::size_t sz) noexcept (true)
+{
+  (*user_data->cxx_malloc->oper_delete___sz) (p, sz);
+}
+
+extern void *
+operator new(std::size_t sz, std::align_val_t al) noexcept (false)
+{
+  return (*user_data->cxx_malloc->oper_new_al) (sz, al);
+}
+
+extern void *
+operator new[](std::size_t sz, std::align_val_t al) noexcept (false)
+{
+  return (*user_data->cxx_malloc->oper_new___al) (sz, al);
+}
+
+extern void
+operator delete(void *p, std::align_val_t al) noexcept (true)
+{
+  (*user_data->cxx_malloc->oper_delete_al) (p, al);
+}
+
+extern void
+operator delete[](void *p, std::align_val_t al) noexcept (true)
+{
+  (*user_data->cxx_malloc->oper_delete___al) (p, al);
+}
+
+extern void
+operator delete(void *p, std::size_t sz, std::align_val_t al) noexcept (true)
+{
+  (*user_data->cxx_malloc->oper_delete_sz_al) (p, sz, al);
+}
+
+extern void
+operator delete[](void *p, std::size_t sz, std::align_val_t al) noexcept (true)
+{
+  (*user_data->cxx_malloc->oper_delete___sz_al) (p, sz, al);
+}
+
 extern void *
 operator new(std::size_t sz, const std::nothrow_t &nt) noexcept (true)
 {
@@ -89,4 +165,27 @@ operator delete[](void *p, const std::nothrow_t &nt) noexcept (true)
 {
   (*user_data->cxx_malloc->oper_delete___nt) (p, nt);
 }
+extern void *
+operator new(std::size_t sz, std::align_val_t al, const std::nothrow_t &nt) noexcept (true)
+{
+  return (*user_data->cxx_malloc->oper_new_al_nt) (sz, al, nt);
+}
+
+extern void *
+operator new[](std::size_t sz, std::align_val_t al, const std::nothrow_t &nt) noexcept (true)
+{
+  return (*user_data->cxx_malloc->oper_new___al_nt) (sz, al, nt);
+}
+
+extern void
+operator delete(void *p, std::align_val_t al, const std::nothrow_t &nt) noexcept (true)
+{
+  (*user_data->cxx_malloc->oper_delete_al_nt) (p, al, nt);
+}
+
+extern void
+operator delete[](void *p, std::align_val_t al, const std::nothrow_t &nt) noexcept (true)
+{
+  (*user_data->cxx_malloc->oper_delete___al_nt) (p, al, nt);
+}

diff --git a/winsup/cygwin/local_includes/cygwin-cxx.h b/winsup/cygwin/local_includes/cygwin-cxx.h
index ccfaa26a0e..13db01d0b1 100644
--- a/winsup/cygwin/local_includes/cygwin-cxx.h
+++ b/winsup/cygwin/local_includes/cygwin-cxx.h
@@ -27,6 +27,20 @@ struct per_process_cxx_malloc
   void *(*oper_new___nt) (std::size_t, const std::nothrow_t &);
   void (*oper_delete_nt) (void *, const std::nothrow_t &);
   void (*oper_delete___nt) (void *, const std::nothrow_t &);
+  /* New in C++14: sized delete */
+  void (*oper_delete_sz) (void *, std::size_t);
+  void (*oper_delete___sz) (void *, std::size_t);
+  /* New in C++17: aligned new/delete, and combinations with size and nothrow */
+  void *(*oper_new_al) (std::size_t, std::align_val_t);
+  void *(*oper_new___al) (std::size_t, std::align_val_t);
+  void (*oper_delete_al) (void *, std::align_val_t);
+  void (*oper_delete___al) (void *, std::align_val_t);
+  void (*oper_delete_sz_al) (void *, std::size_t, std::align_val_t);
+  void (*oper_delete___sz_al) (void *, std::size_t, std::align_val_t);
+  void *(*oper_new_al_nt) (std::size_t, std::align_val_t, const std::nothrow_t &);
+  void *(*oper_new___al_nt) (std::size_t, std::align_val_t, const std::nothrow_t &);
+  void (*oper_delete_al_nt) (void *, std::align_val_t, const std::nothrow_t &);
+  void (*oper_delete___al_nt) (void *, std::align_val_t, const std::nothrow_t &);
 };

 /* Defined in cxx.cc  */
-- 
2.50.1.windows.1

