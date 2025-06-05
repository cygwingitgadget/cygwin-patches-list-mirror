Return-Path: <SRS0=JHw9=YU=gmail.com=sebastian.n.feld@sourceware.org>
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by sourceware.org (Postfix) with ESMTPS id A42E93858C42;
	Thu,  5 Jun 2025 09:28:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A42E93858C42
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A42E93858C42
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::529
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749115725; cv=none;
	b=XM60CLvP+aLeQGmxQOz2aIMgJfScGbj9FU5KdkXMGpK/pzvRs2floYZAHSgVi84hre6bIztPi43Dk28tf631kvzN2uMYMdVypkMcAY/5fSXuVR5zoYgHHt0zYoIKKqM5f6v04fQpxqj5kF5jrtOvKIxkmX7HsLQjXTjiXMO1vw4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749115725; c=relaxed/simple;
	bh=hs6yMA+PQKN+N8h++JoyQSzwd2L7pVa1jx3lygO2b8s=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=QY92FLNaKaeu7p2EZXyzjRC+By/4obBHmZ6May2hNsD46TKIKGvuRSKOD56jDvFimwYvqNAnwrQXBaLAFd4dn278PaTB7rVlEN0iCwEIahQAgsbaKDesHOcveghhJOR3CpRvtbD/sOv+OMqWRed6sM+ylMXt1zXOC4NgWRcDedk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A42E93858C42
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=P50/Taxo
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5fff52493e0so902629a12.3;
        Thu, 05 Jun 2025 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749115722; x=1749720522; darn=cygwin.com;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcbfMUzSi+n99EkCJeFfxmaB7vjoS54sMI/D+xGGwWI=;
        b=P50/TaxoH1EMiev97futDqI2QcPjP7HV0AFU2OWibqhg1gLwZW+Yt6IvblHeJvvB0h
         lqFyFTQxxvTc3jGh6awCJy1EbpJJ+cFCwAHwGE3g7jz4Os3x4sV3/D630ZDoFW0C9HZc
         oICKMIJ2/CmwqQQwQHSWnZY67aBL4C37ZxSJPBW+gXoealV0MUyMcvz9+oRX13SoMRsI
         pHthQLKW6e1QRseevR4qI3gWo7BVDN4vYZVa0RiYNdIw/mRhRlU4FTPnR7ZBxE5S1d8r
         9Oei47FaKGQDwy3zsDfyTEK2kIG/oyK3C6gMKZrq7j4zbR/sqJ0GerAPJA/7ufyj1duE
         pFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749115722; x=1749720522;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcbfMUzSi+n99EkCJeFfxmaB7vjoS54sMI/D+xGGwWI=;
        b=Wkom1yOiISBJyuvOHbecG17GBGMTINLwjdSbdB0dZuj/Qxd3Y8rbD/0chAub6hX/uD
         JcN1bllTOPHIdEERR/F8BD9WBXSf3WJtLtAEs10Ezu2ZgAjd67CkHh8V2K6/UgDaNJHs
         nr4WvxebMlSWkLdnIFESccQxNf++GM5LDHT8ejJpRJboFNVFM17jTgvn8ZZ0hTJtNLg8
         BY72TU1gvF9rGQP5yFp3hlJZgvt4Lk+M538Ws8zFbkjdplQEIUD7yLNvzyK2tG91vzKP
         voiAnFvnxcNTJxPDDj77sSWhopfmaRU7qfIoihrD73t62H7MXXZ8S7HMcp+DgpwdFSED
         d2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWTSf0cRYYYgIX/cImkKZBDbC6kewXChMvSHriN7wqPqRKeBZ81Ji4o/QfcNw8evHOCLBTzRbYC22on7s0S8g==@cygwin.com
X-Gm-Message-State: AOJu0Yy3LL1JUkxOtHVFfzghlwe3wBbKDbfMkBL29NoOpTEFH0+WhOq0
	VrDlENvQiJWLzgEYuXSCkdF73OT+GeMZJ2PXroIcOEiC65LDkCkgAsm106bGCYkRtd6/meHIbfO
	rkvQeLhs3vgi5Cpx2DQ+c5jgnBJKGfwdf+Au8
X-Gm-Gg: ASbGncvWhDGluX1HQ0Xv39Lc6bu++tBX9h08Zy6/+H4AIkqFjxHWpRj23Stns+ETTY7
	dNCYluBQeeXO8sRuae1yNCHiTWzUWvoLIxRcm/YZ5fi6aqpCVJT1e92oXsapB5PYQhDkv3As6ab
	6gUafJKV9ZRilnyO1Ght7HfNTzEU3Gaml4
X-Google-Smtp-Source: AGHT+IHzl7VE8Q85yZF6yJFEO19uYfmU4Y72pflpz59kmlX70U3X/3Cponu/AH//kXpww4M7bnE3s9/53Xt+yHHJNU0=
X-Received: by 2002:a05:6402:2344:b0:606:cef8:a028 with SMTP id
 4fb4d7f45d1cf-606ea3aff44mr5961326a12.22.1749115721445; Thu, 05 Jun 2025
 02:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHnbEGKpoM8q6bm8iB-p4rwfd_KO4Bj1iad-kmL8tyv43uZbzw@mail.gmail.com>
In-Reply-To: <CAHnbEGKpoM8q6bm8iB-p4rwfd_KO4Bj1iad-kmL8tyv43uZbzw@mail.gmail.com>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Thu, 5 Jun 2025 11:28:04 +0200
X-Gm-Features: AX0GCFuiV0KeqCjxyD-uk8G9b97prHY0VQwWWJ6rWeu4bMpaipT66wgWJzrrRe0
Message-ID: <CAHnbEGLdBE4Y+guRz_sA5hRbm9taf_ZtjsuJQSj13nUmToxz=w@mail.gmail.com>
Subject: Re: Cygwin 3.7: Increase SYMLOOP_MAX?
To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, Apr 10, 2025 at 8:14=E2=80=AFPM Sebastian Feld
<sebastian.n.feld@gmail.com> wrote:
>
> Could the maximum symlink depth in Cygwin please be increased for
> cygwin 3.7? We're regularly hitting that limit (seems to be 10).
>
> What is the maximum number of symlink recursion? Rumor is that this is
> 32, but I cannot find it in any windows header.

This would be my proposed patch:
---cut---cut---cut---
diff --git a/winsup/cygwin/include/cygwin/limits.h
b/winsup/cygwin/include/cygwin/limits.h
index 204154da9..c61466368 100644
--- a/winsup/cygwin/include/cygwin/limits.h
+++ b/winsup/cygwin/include/cygwin/limits.h
@@ -43,7 +43,13 @@ details. */
#define __SEM_VALUE_MAX 1147483648
#define __SIGQUEUE_MAX 1024
#define __STREAM_MAX 20
-#define __SYMLOOP_MAX 10
+/* __SYMLOOP_MAX
+   https://learn.microsoft.com/en-us/windows/win32/fileio/reparse-points
+   ... There is a limit of 63 reparse points on any given path.
+   NOTE: The limit can be reduced depending on the length of the
+   reparse point. For example, if your reparse point targets a fully
+   qualified path, the limit becomes 31. */
+#define __SYMLOOP_MAX 31
#define __TIMER_MAX 32
#define __TTY_NAME_MAX 32
#define __FILESIZEBITS 64
---cut---cut---cut---

How can I get this patch committed?

Sebi
--=20
Sebastian Feld - IT security consultant
