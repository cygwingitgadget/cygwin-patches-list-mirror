Return-Path: <SRS0=SYvf=UH=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 8F2CF3851AB6
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 19:43:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8F2CF3851AB6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8F2CF3851AB6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736970220; cv=none;
	b=Wu0iKW0jwmwmvkTApZyIVG/Bm9gyc/vr4rT5rkLqks03NpKN9ThYnjxjB5FsaRRvATebOY/3S+eGK741i8fDq2XvP4m4F0LkPsRBu/pbJIaXd+PNaOQGHaxTQwHY/LmSIfIQ6Frl3fn1JnK/Y1uucUWaO3fzTp1eg77GqiH8WbE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736970220; c=relaxed/simple;
	bh=Ueu6GRB4JAvf/wlyI03r8hiV2MpZ8peFhwr5HmcG6bU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=xGTaRZk9eD4TLI5gniEdbxwK58zw3nqrH3W/0S0TstP9ivX0eVLMqrrX32oad1BewDH2wpr0DFrja7iy5hk6W3tP0KttEpNmYXqV99lFpMPwcPbjOaSRvk9nGMSZXjQTY/W916WG0FiLnqm3HjqihXb9IzLGw43WB9X/V99f5zo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8F2CF3851AB6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=ASOkCT3l
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 34D2C1A01A4;
	Wed, 15 Jan 2025 19:43:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id C44742002C;
	Wed, 15 Jan 2025 19:43:33 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v6 6/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 group variants with base
Date: Wed, 15 Jan 2025 12:39:23 -0700
Message-ID: <564775aa4f134c19f62fc376e2a8f9d773bd0295.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C44742002C
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: ty9pu3tmxersnwk8khurchru3yyteiaq
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/tyHqdshKO/UEGDwsI1dr5KohqtPI3fpk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=he; bh=4+2im5kjNFcTn2a2U1bOy0uaiZX0LTwu2sTKR0bvlng=; b=ASOkCT3ls41yfbjY5I0nH5dSH5FrFWOvxLuTq4rX97S45tNPJO8xZoDlazCJJ2hGEq9NJ+p54Jk4+7PbnrZ1yKb77WD5+qogzubBnFePkNo2O9D3GzurwOCWBDBPYQ3na8I6belkBgfU7XHSosQb6zHA+Wj+kWovDINwFpv5sYVOSx4BscMtYL1CIRCPdp5i1j0lEshgkE2CH1OSUI0kB5++0YNgIc3PGeWmuuH9kf/HJcaJd0ic2KpS6xYf4R+bQ6XL4JmH2F3jCFGTztcdjtxMblDxF1pk8RHSmAR0ffa42h417fxj3qVzd+7XsQsp91fE2JE3ydMTnK+/M1yA2g==
X-HE-Tag: 1736970213-312199
X-HE-Meta: U2FsdGVkX18UQoQC0qKLVmqRqTIwR8xu0xY8lKKxrldpARtUFFJR5zICJWd9Fk+pwBB/Jn22X8y98ldwKYEkOd2LUo4HTu79R2VRSnMgXim87Dfjs7X2hcGlsn0Xja/hbTbj+i5GmK4ssATqAuCnWiIFM/EFqr9vDyDBdK1VFsbJ/WRQxm7yjqYtBw8vSB/7vB3WE5GrjEquseem12xKvpHysfAiwXrAaEzEmjJXsI0tr49uVuIWvP+W57OvwJ37m/KojIv/d1n4E38fV1KfQG1SSOoCsH7Lrw7fW6IiCr+LO0tEbem44qepdX4c+m8/om2RoTbm1ns=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Move circular Ff/Fl and similar functions before hyperbolic Fh? and
similar entries to keep base entries together with their -f -l variants.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 0c9e492d62ad..1a1becd5e5c8 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -33,10 +33,10 @@ ISO/IEC DIS 9945 Information technology
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
@@ -51,22 +51,22 @@ ISO/IEC DIS 9945 Information technology
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
@@ -116,10 +116,10 @@ ISO/IEC DIS 9945 Information technology
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
@@ -127,16 +127,16 @@ ISO/IEC DIS 9945 Information technology
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
@@ -145,10 +145,10 @@ ISO/IEC DIS 9945 Information technology
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
@@ -194,10 +194,10 @@ ISO/IEC DIS 9945 Information technology
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
@@ -211,19 +211,19 @@ ISO/IEC DIS 9945 Information technology
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
@@ -266,11 +266,11 @@ ISO/IEC DIS 9945 Information technology
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
@@ -280,11 +280,11 @@ ISO/IEC DIS 9945 Information technology
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
@@ -579,6 +579,8 @@ ISO/IEC DIS 9945 Information technology
     localtime_r
     lockf			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
     log
+    logf
+    logl
     log10
     log10f
     log10l
@@ -591,8 +593,6 @@ ISO/IEC DIS 9945 Information technology
     logb
     logbf
     logbl
-    logf
-    logl
     longjmp
     lrand48
     lrint
@@ -985,10 +985,10 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1067,10 +1067,10 @@ ISO/IEC DIS 9945 Information technology
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
@@ -1117,9 +1117,9 @@ ISO/IEC DIS 9945 Information technology
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

