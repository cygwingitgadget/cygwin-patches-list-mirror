Return-Path: <SRS0=9YkS=6Y=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-e05.mail.nifty.com (mta-sp-e05.mail.nifty.com [106.153.228.5])
	by sourceware.org (Postfix) with ESMTPS id 70A324BA2E04
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 07:28:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 70A324BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 70A324BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.228.5
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766042904; cv=none;
	b=xJrU0ZaP6CROkZ5NFL4L7V9Bt0CESaLK9vdEpJBXoYf2HbrhrZMfn2N7k1KTRFWImtSb88n7Bj8Eo1hYE415XhruLeyOW92hR/5TRpzum7O6RQ0LSOKy1napJezdDNrbBPIhxasiL5y4Q50J82Bl/dw2Fh1g5xXzVUQhxXyNK0U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766042904; c=relaxed/simple;
	bh=yRK6XLaH7rYtm4w+J/2eqK/vdCddOjr+F2MxwFgekrA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=MpGQxCxIssufTA/LgXyKtpe0DVRJowC0Xq0Vh+0xbOnIF9ZdTyyRA62HIm2OE4UoD2vOt3rKES6AOdoQU8NhQM3lh23PJmC4Vhy/t7Z0eP32yVh/MDfPjWdXNsmpvjNQOznMFvwbgwNfGcj7L6mfWebFXUlJXfI27SMINNECW+c=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 70A324BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=igIQEC8G
Received: from mta-snd-e05.mail.nifty.com by mta-sp-e05.mail.nifty.com
          with ESMTP
          id <20251218072821522.KQUW.45160.mta-snd-e05.mail.nifty.com@nifty.com>;
          Thu, 18 Dec 2025 16:28:21 +0900
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251218072821348.LNWR.36235.HP-Z230@nifty.com>;
          Thu, 18 Dec 2025 16:28:21 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 0/5] Fix stdio with app execution aliases (Microsoft Store applications)
Date: Thu, 18 Dec 2025 16:27:54 +0900
Message-ID: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766042901;
 bh=9DeOeTgyl1pYIwm7+vJ8afyBVR/xxMN35ucu439bLxA=;
 h=From:To:Cc:Subject:Date;
 b=igIQEC8Gd+qMexP4yg8Fu6f79sWULNkMvIaWqJEfB6VUlwrYgtnJnQ0ToplsyjIYVjMjIH+o
 0ZyN4FjkZsfWheWnMy3xmWi/4+FOMkcciepfwMiNSCS5jLh3gOHKlOhnMTIdy0tcbkxFEHVFcq
 3gXmaZuDjNSlLflavn409FuPTiAI7obVvn2EIQQND0ORgzc3MQbfg/Ggj5xFzwKmSe7FJnCmDy
 oHdOMpNt8KeO9NUbQRvts4t5m16AotnI1a/TuFWRhcoI5ylNqZYNBUsGgqQGZdIKdBEysGefy/
 Cy+xDyGIza3kBEzlaaQZQisJ3LA6CwT6CqwFoEzDBC8chIDw==
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v2: (v3 skipped)

 * Merge Takashi's v3 patch into Johaness's patch series.
 * is_conslle_app() returns true when error happens.
 * Implement new API path_conv::is_app_execution_alias().
 * To determine if the path is an app execution alias in is_console_app(),
   change argument of fhandler_termis::spawn_worker() and is_console_app()
   from const WCHAR * to path_conv &, so that is_app_execution_alias()
   can be called from is_console_app().
 * Resolve reparse point when the path is an app execution alias.

Changes since v1:

 * Amended the commit messages with "Fixes:" footers.
 * Added a code comment to is_console_app() to clarify why a simple
   CreateFile() is not enough in the case of app execution aliases.

Johannes Schindelin (2):
  Cygwin: is_console_app(): do handle errors
  Cygwin: is_console_app(): deal with the `.bat`/`.cmd` file extensions
    first

Takashi Yano (3):
  Cygwin: termios: Make is_console_app() return true for unknown
  Cygwin: path: Implement path_conv::is_app_execution_alias()
  Cygwin: termios: Handle app execution alias in is_console_app()

 winsup/cygwin/fhandler/termios.cc       | 37 +++++++++++++++++++------
 winsup/cygwin/local_includes/fhandler.h |  2 +-
 winsup/cygwin/local_includes/path.h     |  5 ++++
 winsup/cygwin/path.cc                   |  2 +-
 winsup/cygwin/spawn.cc                  |  2 +-
 5 files changed, 36 insertions(+), 12 deletions(-)

-- 
2.51.0

