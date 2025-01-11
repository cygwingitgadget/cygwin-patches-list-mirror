Return-Path: <SRS0=8byy=UD=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id F29E53857C6C
	for <cygwin-patches@cygwin.com>; Sat, 11 Jan 2025 00:03:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F29E53857C6C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F29E53857C6C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736553802; cv=none;
	b=VHqwvqxKcedDKcwQlDQmVOJXJeVHkm+3qE1Xpk2yhiQz595maIDMP+ZzzM9t7KElurZWFKb7mcuaZWTXxVh/0C3V3DfKNIOfB6LmPqpLnytywu+NwPaqrkLhJ16rDksMlOLXpvTt5qY1HVSeTpp0I2xhWlaz8+el0ooGDaWVvaI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736553802; c=relaxed/simple;
	bh=+yQs90Fuhjp52PZDAWEXjHsULfyZTcApMykSa+NTRTg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=vDmN0Wd4JOYV103MT2jcDZdVbhXMW3DvBFpu8AfAuotJQnU4C3+thRd2TY487c8FB3Z9KuSP+2cFnvpUdlyH2X0cfQoCwx0aAYuYn8Tz838QRZerqCqL+npiK2/m9IWJdJE/vjuOOyTR3OKMUsUJVU2MfxocqHXR+fx2QAr1y4w=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F29E53857C6C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=KcqvbR2A
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 88C9E1A0F5B;
	Sat, 11 Jan 2025 00:03:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id 2B0FC2003B;
	Sat, 11 Jan 2025 00:03:20 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v5 6/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 group variants with base
Date: Fri, 10 Jan 2025 17:01:07 -0700
Message-ID: <76ec9f45a016f163efebca0ae7aa143682349a42.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Stat-Signature: xn1gi54y6ep4qi6eh9omkuo9qfam7fch
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 2B0FC2003B
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/YjdyBPKVlyaFn8Yv9aZMJYJksGKMJEvU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=he; bh=qtJe4xGj+Uo/1hSDqCsRG8W0sY8nMM9E0ffFzADUp4s=; b=KcqvbR2AfXVK10BS+LJ6zq35Ua0r4rTbv3wtRMOoBArgPlylUqTzsA68EY3hU+gcyiB5BalNfwLAKPxfS/OEsCHHQyyboHKtvgLNp/4aSyURGEcC6n38Fc7xf0ReauHJZtK6ghMZEKl5RG+edZ3jgKVu2HWHgnpPoee6zn/rzQzwF0cGIakPETOH5kLQP1wHvhAcmYeZAvttEgAFSQbDOE82slVBxBHSuD2Eznzg9iJPZPr0yVs6vXevYVd9p4F1YNYgUMGIT9QWv099ESl/hT8TapQcT92by/nIoeTZIxK9ud+InLGzkX1FxZsiPneHCBJ9+V88kFvhcj/ysvPvsw==
X-HE-Tag: 1736553800-918889
X-HE-Meta: U2FsdGVkX1+uvTi3NplJ8+3LhCFEOes8CMoWkyeJiJl9lUZeKdE/3yGX7KzF9AU1Snw8i4PxJJJP7PKRxZWCd+dpCMpZ+4dmTm8HFBKCPwZiVitd/wzxLaoSlDI4BDr83nl1ocufIzN+lKbflWOu6C/fFgyqkDWl5skzhzBOvQzZ+uxHEFVe5zymDElaUNSomTbT7MQ7GyDOZuxrIsPBoh4JHQAaZDLMRCOL6mhs7OvUq9n1CCXb4bh78IjAmtth5vuYSPHP6FFfGFcGlPQEVGtIwdGF1OKYkCQCb3g4K/30DeZfo4aWZkyqul910DIn9bp2/FCQlCY=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Move circular Ff/Fl and similar functions before hyperbolic Fh? and
similar entries to keep base entries together with their -f -l variants.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 17a051b4461c..2ec7016e4308 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -31,10 +31,10 @@ ISO/IEC DIS 9945 Information technology
     access
     acos
     acosf
+    acosl
     acosh
     acoshf
     acoshl
-    acosl
     aio_cancel
     aio_error
     aio_fsync
@@ -49,22 +49,22 @@ ISO/IEC DIS 9945 Information technology
     asctime_r
     asin
     asinf
+    asinl
     asinh
     asinhf
     asinhl
-    asinl
     asprintf
     assert			(SVID - available in "assert.h" header)
     at_quick_exit		(ISO C11)
     atan
+    atanf
+    atanl
     atan2
     atan2f
     atan2l
-    atanf
     atanh
     atanhf
     atanhl
-    atanl
     atexit
     atof
     atoi
@@ -114,10 +114,10 @@ ISO/IEC DIS 9945 Information technology
     cabsl
     cacos
     cacosf
+    cacosl
     cacosh
     cacoshf
     cacoshl
-    cacosl
     call_once			(ISO C11)
     calloc
     carg
@@ -125,16 +125,16 @@ ISO/IEC DIS 9945 Information technology
     cargl
     casin
     casinf
+    casinl
     casinh
     casinhf
     casinhl
-    casinl
     catan
     catanf
+    catanl
     catanh
     catanhf
     catanhl
-    catanl
     catclose
     catgets
     catopen
@@ -143,10 +143,10 @@ ISO/IEC DIS 9945 Information technology
     cbrtl
     ccos
     ccosf
+    ccosl
     ccosh
     ccoshf
     ccoshl
-    ccosl
     ceil
     ceilf
     ceill
@@ -192,10 +192,10 @@ ISO/IEC DIS 9945 Information technology
     copysignl
     cos
     cosf
+    cosl
     cosh
     coshf
     coshl
-    cosl
     cpow
     cpowf
     cpowl
@@ -209,19 +209,19 @@ ISO/IEC DIS 9945 Information technology
     crypt			(available in external "crypt" library)
     csin
     csinf
+    csinl
     csinh
     csinhf
     csinhl
-    csinl
     csqrt
     csqrtf
     csqrtl
     ctan
     ctanf
+    ctanl
     ctanh
     ctanhf
     ctanhl
-    ctanl
     ctermid
     ctime
     ctime_r
@@ -264,11 +264,11 @@ ISO/IEC DIS 9945 Information technology
     environ
     erand48
     erf
+    erff
+    erfl
     erfc
     erfcf
     erfcl
-    erff
-    erfl
     errno
     execl
     execle
@@ -278,11 +278,11 @@ ISO/IEC DIS 9945 Information technology
     execvp
     exit
     exp
+    expf
+    expl
     exp2
     exp2f
     exp2l
-    expf
-    expl
     expm1
     expm1f
     expm1l
@@ -576,6 +576,8 @@ ISO/IEC DIS 9945 Information technology
     localtime_r
     lockf			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     log
+    logf
+    logl
     log10
     log10f
     log10l
@@ -588,8 +590,6 @@ ISO/IEC DIS 9945 Information technology
     logb
     logbf
     logbl
-    logf
-    logl
     longjmp
     lrand48
     lrint
@@ -982,10 +982,10 @@ ISO/IEC DIS 9945 Information technology
     sigwaitinfo
     sin
     sinf
+    sinl
     sinh
     sinhf
     sinhl
-    sinl
     sleep
     snprintf
     sockatmark
@@ -1064,10 +1064,10 @@ ISO/IEC DIS 9945 Information technology
     system
     tan
     tanf
+    tanl
     tanh
     tanhf
     tanhl
-    tanl
     tcdrain
     tcflow
     tcflush
@@ -1114,9 +1114,9 @@ ISO/IEC DIS 9945 Information technology
     towupper
     towupper_l
     trunc
-    truncate
     truncf
     truncl
+    truncate
     tsearch
     tss_create			(ISO C11)
     tss_delete			(ISO C11)
-- 
2.45.1

