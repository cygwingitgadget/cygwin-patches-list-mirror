Return-Path: <SRS0=EjXX=5E=kmaps.co=evgeny@sourceware.org>
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
	by sourceware.org (Postfix) with ESMTPS id A89AE3858D20
	for <cygwin-patches@cygwin.com>; Mon, 27 Oct 2025 19:22:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A89AE3858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=kmaps.co
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=kmaps.co
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A89AE3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::136
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1761592952; cv=none;
	b=WOXvASb2v8IBVAD2qPWaXWJrZtLGkfcRnCJYVFMedVZSwtKPr226Lj8+zxkSpyADrgXJuoyS3yt4E1T+s9OFvflqAfJsgDXwjNqLuHJMcSpSMMOXZJbFKtSVwap2PuyRTmj9hHRx2SQVkSHkZngHg+vnncM637QcAVpHRXTXinc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761592952; c=relaxed/simple;
	bh=tgFhh+pWG5rnNbY1N/MBS+NhiWCA3PhXxuVET8qpFCQ=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=SNzKkytdDzMyjEiRnSBJftzp33AnlFrIlUoZNXzIG8JfjkKQeH8L+oTvnSmc28X5SBwhhwwagci8lPkJ3kOD4pToSIMHQ2OsAGVWWn7bn9Z37742jtVyyC4s4U4Gav0knJUxcU+UDlA6dmyBoGJ80+he8C6D8jOZY8Xf1u7WpxU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A89AE3858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=kmaps-co.20230601.gappssmtp.com header.i=@kmaps-co.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=gyGi6hTa
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-430c151ca28so22510865ab.2
        for <cygwin-patches@cygwin.com>; Mon, 27 Oct 2025 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kmaps-co.20230601.gappssmtp.com; s=20230601; t=1761592952; x=1762197752; darn=cygwin.com;
        h=cc:to:subject:message-id:date:in-reply-to:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LU+Wl/Hg6eICoMuOpHU2hSsWEYQERAds7cieLzinKvI=;
        b=gyGi6hTaLN7qJRJLXDiQA09rEIkAjTfClMXJGNAi97ecwUuEzLsgk/J/OCw5xd/XIX
         C7LqmtP6TdhvntS8Up7m6Ur0MW6MkPNZeQnnMHVyVDaYEnGWTzMHgYS6yLmSz86L35BD
         FxJFgdBuVAgzvOnxIpFja+znw6UlaMRNLLjwFf7ZQNEKjNk5Dz+l5WEv6Mh4dYRHCg7U
         A2AQm11B7N5Odzdz6oiSWnC7L+ssuZRHtPEwfXieB/1knPRnqB6td5LNpHAwDlEdmUtZ
         etRAymofsttmCDDeh6njIUeuaDvU5cLEIrELBgva8CZbYMcxasPASBc7LjuL80tqwNf/
         /BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761592952; x=1762197752;
        h=cc:to:subject:message-id:date:in-reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LU+Wl/Hg6eICoMuOpHU2hSsWEYQERAds7cieLzinKvI=;
        b=kVkvzOOP5yyXokaV6f2ItVUOlMOwvkOcqJ8n+5e2FF5tT6HyvASAWtcX2ItqS8APC/
         hFnO6tGnxMY2DunoxRo6rPe9WxT+MxidtWdqGUgotOkQDGE47q+rt80iu1qGpUCqx4xQ
         D7AGDh9pNYFsxSCmThkjwBtpm3sf1lUBp0wNEzzFe3bkFStbYiorBS1u00B1aiPU/OPj
         c9K+XvnGszyH+5WdlAordQ1QOaeIbM7Kt6nnRDa+CKQq1PxLII4zdkTPzIqmGrZYFPQc
         Q3nhxrq3oPHjLafdweuFuyLaB9OOj08KmtXk46raQQTQhuf86AcJTZbhY6YHPe5o/4LC
         ll+Q==
X-Gm-Message-State: AOJu0YyIDYazAzce5AqIxM/6hKw46T4A4n23bk1aX4qFLZKeS1zjJRKO
	RJ98FQPC7kjM/aW74EwWqwmui9+nkOoz4GCcIoZJG8Krn1DRg/0vxjm1hAzp4w7scWKvcelIYOR
	9NHmT2rsV4PZVByvAGr3xM2b9bgO45SlOGo/O694mW9Ym7Fx61qjJ
X-Gm-Gg: ASbGnctLQxkUNcImkXFCO1sinDL0NlLqbHOm1MLQLOqa2/aysIBxcm6BmBrYkOTxL/s
	6yipTBHfuR7iujrtF+lACvBHSEGkKZPZ7jKPfFK5WTFgK9EZpXVhjOX9dSuO6zdez+QaqCQXPd4
	S3QUadkuwMjT8QdB5WwrcLHeAyI0nNOOE3NcpUiQ4uIgRG03dwRpfM5MTm89hFUFHqook0QLEPG
	OLz9BZlteUeyYnyG+KTQsvejfWln4ijInmrAwBay1eISLQX14ONPgl6mu5VUD4QFOBrrA==
X-Google-Smtp-Source: AGHT+IGSwtkwjyxgUaELBoPSLb1vCHS4N0hlzIztg4QUSSQ8dGJlO8txESXTc2tvI7dJ5MBm4ga30k6IX3kESBXbH9o=
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3303:b0:430:adcb:b38d with SMTP id
 e9e14a558f8ab-4320f842c59mr16938975ab.24.1761592951626; Mon, 27 Oct 2025
 12:22:31 -0700 (PDT)
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Oct 2025 12:22:31 -0700
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Oct 2025 12:22:31 -0700
From: Evgeny Karpov <evgeny@kmaps.co>
In-Reply-To: <CABd5JDD5zgqLG7yD6_gomaKKNABWEnh8pRjobPd43X4b="cz6bw@mail.gmail.com">
Date: Mon, 27 Oct 2025 12:22:31 -0700
X-Gm-Features: AWmQ_bne4S0uUvG-vpYtP9ijz6EZwIH6yED0Vo9WVVUWg1nwWiCsq7NCEclKTLA
Message-ID: <CABd5JDA0LFcVDezz5cqRbMpLcDA1_AX+o0k2LacyjpKYqrob5Q@mail.gmail.com>
Subject: [PING][PATCH] Check if gawk is available in gentls_offsets script
To: cygwin-patches@cygwin.com
Cc: Brian.Inglis@systematicsw.ab.ca, jon.turney@dronecode.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Mon Oct 6 2025
Brian Inglis <Brian.Inglis@SystematicSW.ab.ca> wrote:
> As gawk is a Cygwin Base category package, it should be one of the first
> packages installed on all Cygwin systems, so the test should not be necessary,
> unless /usr/bin is not in the PATH: a message to that effect might be more
> useful; for example:

The issue appeared while cross-compiling on Debian.

Tue Oct 7 2025
Jon Turney <jon.turney@dronecode.org.uk> wrote:
> I wonder if it makes sense instead to check for this and other
> prerequisite tools (e.g. perl) up front in the configure script?

Generalizing error handling might be more useful. However, there is an issue
with broken pipes on aarch64. This error handling might be applied
once that issue is fixed.

Thank you for the review.

Regards,
Evgeny

diff --git a/winsup/cygwin/scripts/gentls_offsets
b/winsup/cygwin/scripts/gentls_offsets
index bf84dd0cb..67d0c02bd 100755
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
