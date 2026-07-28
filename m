Return-Path: <SRS0=o0Gb=FW=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by sourceware.org (Postfix) with ESMTPS id B72114B9DB5E
	for <cygwin-patches@cygwin.com>; Tue, 28 Jul 2026 10:39:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B72114B9DB5E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B72114B9DB5E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::831
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785235177; cv=none;
	b=uA14FfhoQv4E68mwvJ0TN0H4KlaKApiCkhn2VKMZhM1jrL8aYcX6m//cycH1KjGQCxa8zxX/D6ylEC8CPxRap48iRHf7Cr3ec1fI/bsn+L7dftFFD8DdMrysCGz2/6r7KPemoUXZU3hQ0+nGpbnbbi1jrX4irCB4EH9SouX9CU8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785235177; c=relaxed/simple;
	bh=EQ02onDuIznR15hDBSD0nHgk4X+3j9r3rHfujl5nfG8=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=BTyGlWj5BSpLigw02qgdypqg4v/LfPJytQT4NAR590VO4Xq/hKZPmmta1D9Ua64JEavqVS1LEzVYUg8B3x/OHUv9XdFw3DyT3HvvKZiGfBDJWmjuz5lrL1v8QDUeQF20/wVfVTF0tnQ/f4pwq0i/BtzUHAlpldWzAxplyeIux1c=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I6o07QLq
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B72114B9DB5E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I6o07QLq
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-5283e3eff60so25144211cf.2
        for <cygwin-patches@cygwin.com>; Tue, 28 Jul 2026 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785235176; x=1785839976; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PfJVbGZPV2wjeS5a5fbadwTQzgg3rtseSfHkCPBddMs=;
        b=I6o07QLqyWyES666m0VGDQ6z03P6XNDzDCVonOWi3ppG0JqDM9Uq691HabsiGcVkUn
         YmEO/fsPgLy274Dy3QlCn0VO7zLKlHqD30qHpiM+5B0BHBn+iGOFXCcdKS7Tdza23uSy
         cEIXmJwbCdZPQxQzgi8lJrHdU/e7zoyI+FF672dLKX5RAWtOo5RHq2RSaKm9BjOBL+p/
         N9TeHZZrjiggAo00WythcEMYlRoS7AWbHeHpuC3xG0VrP4b0BSyspiAlUM2sRQoAa8y2
         VYAmvjrxpbinilGAc9ZIVpPGCEqkz9sEqHoA4IQBqDZEmfzbIFkVkPJG8Anz+aN3ympJ
         R9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785235176; x=1785839976;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PfJVbGZPV2wjeS5a5fbadwTQzgg3rtseSfHkCPBddMs=;
        b=Q1zCj6xjGb104gRaKfolTo96Oemuto5kSNhKUFzBUmV+1l92LTNRjgUpfb6f7i/72G
         +EREXH6wIsI37+7w76324ZDwip1lzlrw/lzqA9J4nKdtiSpYlnEasKX27NTF4q5wXoFw
         aKoNGeD1VfFdUMhICMuHN7cn2TZ1QL8nNxUJXh6T03KLKi73+ph3nI4Clljn6J/pOysC
         NT+XF7sPqd6bq8D55fApUWJS6m/trOfehVxPOPEi8vvBm6jJtZGR7rGWzkRqt+IeF8bm
         gttyZW3YNszgnZpl7qWfmhiz5rGoFCV/WU2UK9xZkZd0cXf7HpZmQLTLkyTZ7io+GuSx
         R3pA==
X-Gm-Message-State: AOJu0YwgUJjf8bAVgLIJ0CIVO3uEenCnk/J75e4/+wQUz39/wrQricSU
	LE+yC1CF5B/jfPIzd7UsAmtJeOrVYKS45ssPHHDaB0lzVqHCWoZ/6rmr7ARRe8iS
X-Gm-Gg: AR+sD1284xN+AUhfJKBq2Y1k7GFD+2V7BLJCP0PRECZkNpUZrwAmg1s0xKd58wqYBY7
	dBeZpX7LkRNieoBBDvwM0rYInxphfzY61NBuTHVb4FCr7fR82M6oq56QhS5KwLyk6Yk4Ot5edXb
	6UJhE8lz/s1JeNryV6BWI7fyp0sq6wpteHvFACi4BOuFF+PQ7Ni1CEMftGMkRnTqTD5mmgxyzKk
	XNVu3WaKOmEZxnAjcs3SKPoNEjRQEittVDQi7q62zaUhMwRwkb7jgOG2Tg4Ftjp77CtttpRB6KJ
	ehT+vy8w9MbqZQo/xTvYuASuWbkJO1vW+YiZHfuit9MB18fxL/DFiJrkVEjBb7WD8D2x+OIV5+6
	8FQpVbrCKfHhgnv5VwJlJr5r9NjsuaSuIElH7BmUTx5yT9AzytiFRMtUo5fVpXiwSg+kNQrQ69f
	NSf8SoDA==
X-Received: by 2002:a05:622a:4d43:b0:519:dfd7:70cd with SMTP id d75a77b69052e-529d70e31cdmr13443391cf.49.1785235176454;
        Tue, 28 Jul 2026 03:39:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.125.176.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a29ff66fsm71345631cf.25.2026.07.28.03.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 03:39:35 -0700 (PDT)
Message-Id: <pull.9.cygwin.1785235174913.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Jul 2026 10:39:34 +0000
Subject: [PATCH] dumper: allow compiling with binutils 2.47
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the latest version, binutils' BFD no longer declares a `bfd_boolean`,
and the `bfd_record_phdr()` function accepts plain `bool` parameters
instead.

Let's accommodate for that to avoid these build failures:

  .../winsup/utils/dumper.cc: In member function 'int dumper::prepare_core_dump()':
  .../winsup/utils/dumper.cc:830:7: error: 'bfd_boolean' was not declared in this scope; did you mean 'boolean'?
    830 |       bfd_boolean filehdr = 0;
        |       ^~~~~~~~~~~
        |       boolean
  .../winsup/utils/dumper.cc:831:18: error: expected ';' before 'phdrs'
    831 |       bfd_boolean phdrs = 0;
        |                  ^~~~~~
        |                  ;
  [...]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    dumper: allow compiling with binutils 2.47
    
    MSYS2 just updated to this version, and I tried to deploy a new MSYS2
    runtime... oops ;-)

Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-9%2Fdscho%2Faccommodate-for-binutils-2.47-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-9/dscho/accommodate-for-binutils-2.47-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/9

 winsup/utils/dumper.cc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index 994f9b683..ac261d03c 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -827,14 +827,14 @@ dumper::prepare_core_dump ()
       p->section = new_section;
       int section_count = 1;
 
-      bfd_boolean filehdr = 0;
-      bfd_boolean phdrs = 0;
+      bool filehdr = false;
+      bool phdrs = false;
 
       bfd_vma at = 0;
-      bfd_boolean valid_at = 0;
+      bool valid_at = false;
 
       flagword flags = 0;
-      bfd_boolean valid_flags = 1;
+      bool valid_flags = true;
 
       if (p->type == pr_ent_memory)
 	{

base-commit: 273e66172494aa276f08155c12e6934f80abb10b
-- 
cygwingitgadget
