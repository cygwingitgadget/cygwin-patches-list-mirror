Return-Path: <SRS0=C3e4=6V=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	by sourceware.org (Postfix) with ESMTPS id 74B0B4BA2E1D
	for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 17:06:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 74B0B4BA2E1D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 74B0B4BA2E1D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765818398; cv=none;
	b=V3qOay79uMa6wNq+D5Uk1dwr0XRR96ScWtIZdJeQR1U2Q8nTf40U7v8vD9c+2kPAr8j2xiT7P9gSQWj49CEpQ4FEuKGablRn9WdL3juzImp5nx+5K0Bcbb3h+t5d/iAfN35d404GfUCtNDj/wfHPIOSq+7h8uzayRqayUrkbHBQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765818398; c=relaxed/simple;
	bh=A8HJy0qxwnblH+/oxx9wEFgVUXsxxl3FITOR3DQ0rIM=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=frfIf9bOU4fociIfqJ8Q3iof45OFtxGSmTGQOAoVHKE7fthb9g4JxYdF1NklEJedYAJu/AWsQ1vkIg3JDRHpMKsD33q2LnfD1n4iguhSLzktjNr77xjRK4NdOTg9h5E7utbbw+zHb4bRYeRCFEN3YK4o5xX6/gN5RC8C9E/aCOE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 74B0B4BA2E1D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VINcXOx3
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a1022dda33so10195375ad.2
        for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765818397; x=1766423197; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2+NgoIB2hZzf/QR/fwqeJa8cTQ7LHQKarBS8lvZ8Vk=;
        b=VINcXOx3xJe5Ajy9ApLe5W/Q2aKKgCcbzaJqhL9tM/o07HZ8V3DEAjc5hYMut2MYqg
         GfyNxSBOySYf4+7Lt4JCe/cn4tpzGJ8o8F5DExQ9896BN8ePM/Af4Wk3U1ejyew9sIwA
         2+8Fxion0xaKsFS31YeR1D9ErCROS53/OG3pf6RAY5pPVGyIiSjIfV+aDEaSdArDXkjj
         sjaeE1jhIoe/va/6OL7TKkK5tqEIxie5YC/fgrKm3E1Phrvu1b9omKUiBNgSAr38dgGA
         bCG7pl6r8wz0NhfTqvBNbTOPNX4JHv+/OWnmUBVgK0nFfJ9jVS5eAqpz23Ym9Rdt9yPP
         GNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765818397; x=1766423197;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g2+NgoIB2hZzf/QR/fwqeJa8cTQ7LHQKarBS8lvZ8Vk=;
        b=dJByN4n/mUpxTiL37b/tgl5/3b86ISQCM9vhbb9GgcgPbQLzJOaAN2gNRQ6Z24fXjw
         y5KT3Z2rqV4BA5JZaNvVzj4FWm+IuMAd4AhG8f9R+9TzDryDBSCiaL86vrlZb8L+IO0j
         PnsGBnifT0xkkHF1gar6xbMuQFfk2whkHuS288CQESPD5nPYHyysotFz/sE7N4uozoz/
         WnMjxuzbOH5XxGN9KkYWxT9ZO8hBzAjBfj+NGC5FfnblY1OL+cvmNbzIIlK6w5vrNUjf
         D4OP9v6gM7qVz+4dOSl9J6tdpfX0tjWXZseQ2PQ3evXGRnKDvVQTTlfYy7H5lqIp2eHt
         INSg==
X-Gm-Message-State: AOJu0YwaLbxhn+x9ys1NujFs8xqwh9gHOZMOgfAyQv1WtfhEK6zSlhm1
	TWJiN6g2paui0Fq/wte8HUs1YVoz/CACGgTyHJExQpiiSjts6UXbrfC6fv4KlA==
X-Gm-Gg: AY/fxX6zxmKhZ8fmkX/EbPGsaX4Ibc7Ec5hw4s7/RZ5SkpBhp3ORB3H69/wn1cia3fb
	CUn1R9Quuxg9bM5vRKvdrpR54A0pOmUhJo5BeAPBRxJbMnZ6dYB/EBhnkS19WrVB2gnVWzPkTep
	gNxIv7iKOo/N4jmzt1S/l2IZKBm6Vi5alHu35FScYm049D5L20XFy5D89gixx2yxFOOPUyo+5Ry
	o2kXYjdLgfGhBFT+vPt6GpvOovoTDjJbYxZ9+9rAISi30FG/QU9UMpFm9Hq0g5qLwzJsGn4CqoA
	v19vCvZKV+Ep8fkGlSDs5+I6a9qwmPmtI9lgjN42TWb92kblfosPUROcFMpHgzJMe0dJitQ3yD+
	F8FWj9CtBDALTKD++NTYvwZQKr57rgESELxfhrQcHH3ZdzPfOUOYC+QKUwE1k45j1/qHmSL1+0A
	C1bnERI0jeud8=
X-Google-Smtp-Source: AGHT+IGGvQMtDA+wL6R3WIlfaTYOSYsBBEO6THfBtK7QNsnnQ4+K5wXLJ3OzTehc6CCEDNxtEJP9yQ==
X-Received: by 2002:a17:902:c403:b0:29e:38de:6140 with SMTP id d9443c01a7336-29f23e1d4d0mr105896265ad.13.1765818396660;
        Mon, 15 Dec 2025 09:06:36 -0800 (PST)
Received: from [127.0.0.1] ([52.225.25.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea03fcd8sm139531295ad.74.2025.12.15.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 09:06:36 -0800 (PST)
Message-Id: <pull.5.v2.cygwin.1765818395.gitgitgadget@gmail.com>
In-Reply-To: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Dec 2025 17:06:32 +0000
Subject: [PATCH v2 0/3] Fix stdio with app execution aliases (Microsoft Store applications)
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Cody Tapscott <cody@tapscott.me>,
    Corinna Vinschen <corinna-cygwin@cygwin.com>,
    Takashi Yano <takashi.yano@nifty.ne.jp>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

When I introduced support for executing Microsoft Store applications through
their "app execution aliases" (i.e. special reparse points installed into
%LOCALAPPDATA%\Microsoft\WindowsApps) in
https://inbox.sourceware.org/cygwin-patches/cover.1616428114.git.johannes.schindelin@gmx.de/,
I had missed that it failed to spawn the process with the correct handles to
the terminal, breaking interactive usage of, say, the Python interpreter.

This was later reported in
https://inbox.sourceware.org/cygwin/CAAM_cieBo_M76sqZMGgF+tXxswvT=jUHL_pShff+aRv9P1Eiug@mail.gmail.com/t/#u,
and also in https://github.com/python/pymanager/issues/210 (which was then
re-reported in
https://github.com/msys2/MSYS2-packages/issues/1943#issuecomment-3467583078).

The root cause is that the is_console_app() function required quite a bit of
TLC, which this here patch series tries to provide.

Changes since v1:

 * Amended the commit messages with "Fixes:" footers.
 * Added a code comment to is_console_app() to clarify why a simple
   CreateFile() is not enough in the case of app execution aliases.

Johannes Schindelin (3):
  Cygwin: is_console_app(): do handle errors
  Cygwin: is_console_app(): deal with the `.bat`/`.cmd` file extensions
    first
  Cygwin: is_console_app(): handle app execution aliases

 winsup/cygwin/fhandler/termios.cc | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)


base-commit: 7d43942e7c3b56799e9e46c4701f86a8eb0ed579
Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-5%2Fdscho%2Ffix-stdio-with-app-exec-aliases-v2
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-5/dscho/fix-stdio-with-app-exec-aliases-v2
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/5

Range-diff vs v1:

 1:  7edad15ac ! 1:  af87bd1d4 Cygwin: is_console_app(): do handle errors
     @@ Metadata
       ## Commit message ##
          Cygwin: is_console_app(): do handle errors
      
     -    When that function was introduced in bb42852062 (Cygwin: pty: Implement
     +    When that function was introduced in bb4285206207 (Cygwin: pty: Implement
          new pseudo console support., 2020-08-19) (back then, it was added to
     -    `spawn.cc`, later it was moved to `fhandler/termios.cc` in 32d6a6cb5f
     +    `spawn.cc`, later it was moved to `fhandler/termios.cc` in 32d6a6cb5f1e
          (Cygwin: pty, console: Encapsulate spawn.cc code related to
          pty/console., 2022-11-19)), it was implemented with strong assumptions
          that neither creating the file handle nor reading 1024 bytes from said
     @@ Commit message
      
          Let's add some error handling to that function.
      
     +    Fixed: bb4285206207 (Cygwin: pty: Implement new pseudo console support., 2020-08-19)
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## winsup/cygwin/fhandler/termios.cc ##
 2:  535cc52d4 ! 2:  8e9732407 Cygwin: is_console_app(): deal with the `.bat`/`.cmd` file extensions first
     @@ Commit message
          Let's honor the best practice to deal with easy conditions that allow
          early returns first.
      
     +    Fixed: bb4285206207 (Cygwin: pty: Implement new pseudo console suppot., 2020-08-19)
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## winsup/cygwin/fhandler/termios.cc ##
 3:  6ae42c5d1 ! 3:  e6101afa7 Cygwin: is_console_app(): handle app execution aliases
     @@ Metadata
       ## Commit message ##
          Cygwin: is_console_app(): handle app execution aliases
      
     -    In 0a9ee3ea23 (Allow executing Windows Store's "app execution aliases",
     +    In 2533912fc76c (Allow executing Windows Store's "app execution aliases",
          2021-03-12), I introduced support for calling Microsoft Store
          applications.
      
     @@ Commit message
          simply open the first few bytes of the `.exe` file to read the PE header
          in order to determine whether it is a console application or not.
      
     -    For app execution aliases, already creating a regular file handle for
     -    reading will fail. Let's introduce some special handling for the exact
     -    error code returned in those instances, and try to read the symlink
     -    target instead (taking advantage of the code I introduced in 0631c6644e
     -    (Cygwin: Treat Windows Store's "app execution aliases" as symbolic
     -    links, 2021-03-22) to treat app execution aliases like symbolic links).
     +    For app execution aliases, already creating a regular file handle
     +    for reading will fail. Let's introduce some special handling for the
     +    exact error code returned in those instances, and try to read the
     +    symlink target instead (taking advantage of the code I introduced in
     +    0631c6644e63 (Cygwin: Treat Windows Store's "app execution aliases" as
     +    symbolic links, 2021-03-22) to treat app execution aliases like symbolic
     +    links).
      
     +    Fixes: 2533912fc76c (Allow executing Windows Store's "app execution aliases", 2021-03-12)
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## winsup/cygwin/fhandler/termios.cc ##
     @@ winsup/cygwin/fhandler/termios.cc: is_console_app (const WCHAR *filename)
         HANDLE h;
         h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
       		   NULL, OPEN_EXISTING, 0, NULL);
     ++  /* The "app execution aliases", i.e. the reparse points installed into
     ++     `%LOCALAPPDATA%\Microsoft\WindowsApps` for Microsoft Store apps cannot be
     ++     opened for reading via `CreateFile(..,. GENERIC_READ, ...)`, failing with
     ++     ERROR_CANT_ACCESS_FILE. Therefore, whenever that error is encountered,
     ++     let's see whether it is a reparse point and if it is, open the target
     ++     file instead. */
      +  if (h == INVALID_HANDLE_VALUE && GetLastError () == ERROR_CANT_ACCESS_FILE)
      +    {
      +      UNICODE_STRING ustr;

-- 
cygwingitgadget
