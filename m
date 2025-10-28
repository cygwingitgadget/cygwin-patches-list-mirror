Return-Path: <SRS0=DBc0=5F=kmaps.co=evgeny@sourceware.org>
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
	by sourceware.org (Postfix) with ESMTPS id 42CD03858D1E
	for <cygwin-patches@cygwin.com>; Tue, 28 Oct 2025 13:17:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 42CD03858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=kmaps.co
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=kmaps.co
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 42CD03858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::d34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1761657426; cv=none;
	b=AAOdjcWfJ/a1CFhKt7//aPWjNHzDHLL18putzdVb72bnBFNFhsIleC/vjrSowM2nKREevTkESYwUEMf4lVu4B2oKPdTEkz2XB5VgBIkVI2nqwmcMOUSaaeR14TkZJ3DF2p30/gdyhzd6OXkYZ0/TpPLDpUyeJ9nI/NfNmkT83WQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761657426; c=relaxed/simple;
	bh=hcN+5zJd+Hxlpo/lbj0doKi/MO4xJGMb91PFPW0OYgs=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=fz6dMrRzkWz5w5KN2eNwMCYH909wKQQ9E1ImlG/RD9/n5MPkGkQIPBO1hmGID2uS+O1UsmgG4g0uCCOqE4jpLc4dwg3icq3f0uF0x2cpcwp9Y78AQj3jix0T/Tl2I+8hfmW3+7vJdPg91YBcaLVMbHX4rtEjqygAA99Zk18aUC4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 42CD03858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=kmaps-co.20230601.gappssmtp.com header.i=@kmaps-co.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=N8QcGi/0
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-945a4bfd8c6so258259439f.0
        for <cygwin-patches@cygwin.com>; Tue, 28 Oct 2025 06:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kmaps-co.20230601.gappssmtp.com; s=20230601; t=1761657425; x=1762262225; darn=cygwin.com;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vrcy8kiYqKZk9qrBF/UlXEvvT3HDhK5KXrm9Loc8me0=;
        b=N8QcGi/0ezLEIbTDv5m7OmKFzbkgN1EQga/zlWZoBnWG48uGvXbFZVH7orosQhdrw4
         PesaV4agh8pe3BOiIgColqJxOIsT/Wb27Iu0B7YvV4FIFiaskVyIQPR4J2EW9KxqdK0D
         kX6OyedVk7ua9dzZpOWrv2jrO2XjA8KJRH6JsEKqi4gXG45zIcETjasoTjkB+aOijHKE
         bRr3/Ucz8Y4Nn/LVcGlcrmNte2uEzOUg+jRhus6B6zStzfWgcWGjQY9FJ1keqDVfPZEm
         GIk8TnHrt5tGWB6mmMFagtelseN/E1k8L+G6lHwM+Nda9YXU5QIJZE7TX/kFyV+e5/X1
         xduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761657425; x=1762262225;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrcy8kiYqKZk9qrBF/UlXEvvT3HDhK5KXrm9Loc8me0=;
        b=NRnEWapgjjtBWZ4O0a9WIFDhjcPXPSLWk1I6D3fswJe3BbuXKQD2aio1p01xdfu6Gw
         2PlLmgsOetjrbolsSHwIpuQnLcTdkFItFHvzL5qK3nx8QiTyauqnCj8k147jAWYIe8fD
         YQ3sQTqDVrPXTEwF9u0L1TCRhK+hYtAsdch1MhBoh71hzx2MciJCGk8D7eOKH7nPUjTc
         aRdAe2GhlybF863BA/8fiy3gOVCNspgIYkP4bvQpBcsLLcGXEOp64KfzCyUzEQPGeBYM
         71twYzNV9cIpsvJcJtm6PzvCZ/z49RlCSsMSI6tlh264krCCu7eIHIcP6pdpSnWRiQuB
         dNhw==
X-Gm-Message-State: AOJu0YwqvGbTow6YYPpjD8auN0O4p1xddbg8sRP2iyf120DREnBdelVK
	RpRvb4bKYe2028L3dA2zulUC0aRJ/ro9EMK+GGUwGZL3Ul85wq8Mvz0MGM0O+0iShoRKYb4lqh+
	dzB+v/CwDq+lSvcoXdvWcBELoIUqd+JQF4/It7Tmgp9YO4Iao0Epdm4Q=
X-Gm-Gg: ASbGncs2rX9ruu9q/TPrAmZnc5xML/p2bBHtK4673xyJuXPQfCl5pf35w/JZ8OsGsxW
	gNhJwvY1OverT/xUCLzCqwNSNMKFJLh9kLE1fLJQnFLE4JYGiIo+wJfMPFOP3qDYN2Cdetw2SDf
	tfUxjkVpNGQrWaEC7coEEtT0fm2wSz0Lss5sJPc2s3lLzLW8NBmiFV6GUaKWWE2dNTJ8m3953KC
	qzHJ3HjTV5nOoZKNS3LxLlfwWNlS1XP2inGIVCrj60UH+gveNg+Hj7QMVdhcA==
X-Google-Smtp-Source: AGHT+IHqqIOJa9vs+Rl+p7CdmBqVBq1aEk0o1+zJSC/D0xlK31n0H2/jRdsNV8U9hKiRFpXWulmShSxT5SKJeCNSTl4=
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0a:b0:430:d67c:46b8 with SMTP id
 e9e14a558f8ab-4320f844f57mr43700605ab.26.1761657425179; Tue, 28 Oct 2025
 06:17:05 -0700 (PDT)
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Oct 2025 06:17:04 -0700
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Oct 2025 06:17:04 -0700
From: Evgeny Karpov <evgeny@kmaps.co>
Date: Tue, 28 Oct 2025 06:17:04 -0700
X-Gm-Features: AWmQ_bnQU_rxbBNdtv32qRUy9wU6_1MLjWfQE6yKTdlFubE8DvsEUUv9jbgnjDo
Message-ID: <CABd5JDBzuSB2BN0qs4pkHCrCQw3cqLs_OOS7MkzdTBZqph1miQ@mail.gmail.com>
Subject: [PATCH] Cygwin: Generalize error handling in gentls_offsets
To: cygwin-patches@cygwin.com
Cc: jon.turney@dronecode.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The patch introduces general error handling in gentls_offsets. Explicit
validation for the presence of gawk is no longer required. gawk has been
utilizing 'exit', which might lead to broken pipes in the current
implementation. When 'exit' is triggered, gawk finishes the process,
however the upstream command might still be active. This has been resolved
by avoiding the use of 'exit' in gawk.

---
 winsup/cygwin/scripts/gentls_offsets | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/scripts/gentls_offsets
b/winsup/cygwin/scripts/gentls_offsets
index bf84dd0cb..a364ea57a 100755
--- a/winsup/cygwin/scripts/gentls_offsets
+++ b/winsup/cygwin/scripts/gentls_offsets
@@ -4,14 +4,9 @@ input_file=$1
 output_file=$2
 tmp_file=/tmp/${output_file}.$$

+set -eo pipefail # fail if any command or pipeline fails
 trap "rm -f ${tmp_file}" 0 1 2 15

-# Check if gawk is available
-if ! command -v gawk &> /dev/null; then
-    echo "$0: gawk not found." >&2
-    exit 1
-fi
-
 # Preprocess cygtls.h and filter out only the member lines from
 # class _cygtls to generate an input file for the cross compiler
 # to generate the member offsets for tlsoffsets-$(target_cpu).h.
@@ -29,14 +24,13 @@ gawk '
   }
   /^class _cygtls$/ {
     # Ok, bump marker, next we are expecting a "public:" line
-    marker=1;
+    if (marker == 0) marker=1;
   }
   /^public:/ {
     # We are only interested in the lines between the first (marker == 2)
     # and the second (marker == 3) "public:" line in class _cygtls.  These
     # are where the members are defined.
     if (marker > 0) ++marker;
-    if (marker > 2) exit;
   }
   {
     if (marker == 2 && $1 != "public:") {
-- 
2.39.5
