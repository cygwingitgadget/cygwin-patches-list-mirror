Return-Path: <SRS0=baQu=5R=kmaps.co=evgeny@sourceware.org>
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
	by sourceware.org (Postfix) with ESMTPS id 8CB50385840E
	for <cygwin-patches@cygwin.com>; Sun,  9 Nov 2025 21:30:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8CB50385840E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=kmaps.co
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=kmaps.co
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8CB50385840E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::d35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1762723845; cv=none;
	b=VBrQVjiwg9gehxO3l0tCqgnBXB6OjshvFM0rIwJSDWn+y1OzoxVzFxdZ5aJkE0ubYm6tdioiiWETW5rB8VIhvgNDVNNjIb5BpK+Fr6MUZtTp+qzP7l4EROP4Oj0DmHTg+l8eb376JAdSMqLiIjzn+xfl/x4eerIwPJH4p5aaXs0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1762723845; c=relaxed/simple;
	bh=1YTV1CHzzdC43+I7nlKxO4EwmhhSn3gVliTkvjvMyYY=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=F7m0e5K6L5RE/HigbG6zQ+iNLProk7Q1UlOu7V/hX+fcmNdWKvTXJP6Wcty9kU6yMg0HChdc3dH45GqbPoxAIJmC1oAT0zkko1sEFsTDBuj3LiSY0CIel+SMpxDFNUWPF+oFeqAa6eQY+ZmTyl+H3JX4CA1O6p+AKWI0dEaStks=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8CB50385840E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=kmaps-co.20230601.gappssmtp.com header.i=@kmaps-co.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=a/selNZM
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-9487e2b95f1so83236639f.2
        for <cygwin-patches@cygwin.com>; Sun, 09 Nov 2025 13:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kmaps-co.20230601.gappssmtp.com; s=20230601; t=1762723844; x=1763328644; darn=cygwin.com;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1YTV1CHzzdC43+I7nlKxO4EwmhhSn3gVliTkvjvMyYY=;
        b=a/selNZMMSVs1u3I/IeOlgHHTVT9rSxELP5OdIEck9+lx0Yc0Zgx3Xr1IRWhSDoGJa
         t6SuHZaAxIKys8iQMq6M7WvTJJ23EGgVfFqxfiOkvMcZ4PnnQSDxBGTaLPOxH8V9p7e0
         84JjvPVqj8wDeeuYL7X/lIgAaOpSMy2xOuP/CigODZ4TyMkuDzsFIwiA+9g5P/ft0VLA
         OBptSY/aFzuJtNLtePXT9BGK7HXGD49GRQqX7Sy7vuY9OsoJE2BkyvtL8UUa9E0yf5sI
         KV9l7FEi7dO7QHhoIVeIEgADm+Ubd9XGflzDaaul3H4ooZg2s/kI1jWapP2xtkAOZVkM
         rTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762723844; x=1763328644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YTV1CHzzdC43+I7nlKxO4EwmhhSn3gVliTkvjvMyYY=;
        b=JQ9yqgpUhkA2DegHXQMvLtB29TbxMgCCh6bQx1/1n3THpv6S8iH1Tubvkab+t7KWAh
         bRRYOLDVdj3YCNuA/Nt4heODrOvReBHkLel5wBmv/puvnmYSNzQSSkkl7ML2TcWHF9wK
         4K2aRO0ctSseOXkHTW0AqiXSJQ/VkNobqS9gCwYZA6BJfHf1kzqeqmtV1OBDULBtwcCm
         gT6V8GPBj9LfT5xSunph94cskFCtGPUeZ9uOtHzEWMXg8dNq6DGhLuAwCYPuIgft+KKA
         Gs73nn/0XuSFCWEkggoIBY4Y+VRrALR2jERvlmZ7K+cV9m7CNkWF/yogFSZ28WBbEjNY
         VhHw==
X-Gm-Message-State: AOJu0Yxwd45gwzthk1KvPivzrMGyhQnkfvRtSw1J+i84JSPbVGywFZev
	W39437uZ3y4p9kyQwAilWovZG2WZUT63B9cT7g1BNA9DoDnpRK7mm2tITRzQaW6ZNb+G5dJXufO
	y2sE0Lh1byoe1PxHmF6BBTCGTtwS+a8rWY2zylOHlrdqotm+i2GsULhg=
X-Gm-Gg: ASbGncu7mcbBvg9Z5vyRXlkxI8nDyR7qNSXR8+DSU8zyUAw2rKxQp3fwSHlW7Ngr8Io
	gbK+NM1Dzqqgs+vJij5Rql3w6xiiBnoJ0r+OxDvNMsLOv/ZvW2VVjhTlSfAEfZPD89QbqrUb7yq
	TQOGW6rNv65PMzlNsiEUEnqHMbd6YU88vZpJy5Buc3fkz4kYKf/6t1MVoaUDlsk+tLcNjDWZ2F8
	hEdhTbrXhsjkMUyjw2xfP2aQO0esbIoFU5YM7fbXlce2ZHsD9uGxpY1YSJM/Fa58mfXrKA=
X-Google-Smtp-Source: AGHT+IENAka6k3Ek7rgBQfnf5MePCi9uM5e7UuI5X+0naR57xAOHthpsp4bM9hvcE1I/PTA5moGInoAf6Fj1kJVCw6k=
X-Received: by 2002:a05:6602:8312:b0:948:9ff9:4189 with SMTP id
 ca18e2360f4ac-9489ff9428fmr296393239f.19.1762723844110; Sun, 09 Nov 2025
 13:30:44 -0800 (PST)
MIME-Version: 1.0
References: <CABd5JDBzuSB2BN0qs4pkHCrCQw3cqLs_OOS7MkzdTBZqph1miQ@mail.gmail.com>
In-Reply-To: <CABd5JDBzuSB2BN0qs4pkHCrCQw3cqLs_OOS7MkzdTBZqph1miQ@mail.gmail.com>
From: Evgeny Karpov <evgeny@kmaps.co>
Date: Sun, 9 Nov 2025 22:30:33 +0100
X-Gm-Features: AWmQ_bmBy7immW0COI7nYOqdDziIICQYr7nUs6VQhIrgCFg5yxOt4QNkLlUBmKk
Message-ID: <CABd5JDB-_=jputGieFdYhsJCCvQvQ0sbN=BZB+UZcg8LiuWL7g@mail.gmail.com>
Subject: Re: [PATCH] Cygwin: Generalize error handling in gentls_offsets
To: cygwin-patches@cygwin.com
Cc: jon.turney@dronecode.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon Turney <jon.turney@dronecode.org.uk> wrote:
>> The patch introduces general error handling in gentls_offsets. Explicit
>> validation for the presence of gawk is no longer required. gawk has been
>> utilizing 'exit', which might lead to broken pipes in the current
>> implementation. When 'exit' is triggered, gawk finishes the process,
>> however the upstream command might still be active. This has been resolved
>> by avoiding the use of 'exit' in gawk.
>
> Hmmm... a little bit confused to what 'in the current implementation' is
> referring to here?

The current script utilizes a pattern when piping is used and gawk uses exit
to interrupt the gawk execution.

Here is a small repro case
(set -eo pipefail; (echo 1; sleep 1; echo 2) | gawk "{print $@;
exit;}"; echo Test)

'(echo 1; sleep 1; echo 2)' emulates behaviour for the compiler call
that might take some time.
${CXXCOMPILE} -E -P "${input_file}" 2> /dev/null

'gawk "{print $@; exit;}"' exits after the first line parsing and
closing the pipe.
Because 'set -eo pipefail' has been used and the upstream will try to
send another line
to the pipe, it interrupts the execution and 'echo Test' will not be called.
The issue has been fixed by avoiding exit in gawk in such a pattern.

> You previously wrote 'there is an issue with broken pipes on aarch64'
>
> Is this a general consequence of turning on pipefail?
>
> Or is there some aarch64-specific bug this is working around (in which
> case, I'm not sure this is suitable for applying, since... we'll need
> some reminder to fix it eventually :) )

It was an expectation that the issue related only to aarch64, however
it looks like that after enabling "set -eo pipefail" all architectures
should be impacted.

Regards,
Evgeny
