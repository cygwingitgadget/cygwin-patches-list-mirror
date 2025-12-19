Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-w04.mail.nifty.com (mta-sp-w04.mail.nifty.com [106.153.228.36])
	by sourceware.org (Postfix) with ESMTPS id F333D4BA2E1C
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 02:27:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F333D4BA2E1C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F333D4BA2E1C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.228.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766111221; cv=none;
	b=wYRXNV6552sVRs+bCgmt9Z01KQc+tQXPvTn2CHNpgyM7kny4F7RbGKwhFkVwXQF4W8gndW+gZQ45lhz43aquNkXSVpKsX9qS7sbHLKnrewbIsZn4ykoxk+rh9AvH0jVFfnQsFci5VcShy3AO6W5ZCDmlYbUkDe31epaWAKUM+GA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766111221; c=relaxed/simple;
	bh=Oyb41IAJGdykAWI0/6hwOAlt+SuXSQTEbTl8ntltM/w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=LbKjXWVKDzI8E5vebrV04NynXl0yAzNfEuIUwNaJe8qJwEBvVOuxeQZHrtGk7fS/iSG5kSrPmA3dFNV1a+MbXHZf8ZYEXwlJEAlGNfB5iG23R272PZ7x8VJ5cIFrWmvnhPLaeQysCKYeWoBZBOzMOR3G2IEDNFh5qrp7+mljYhw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F333D4BA2E1C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=maLm2vu0
Received: from mta-snd-w09.mail.nifty.com by mta-sp-w04.mail.nifty.com
          with ESMTP
          id <20251219022659239.KVWT.123589.mta-snd-w09.mail.nifty.com@nifty.com>;
          Fri, 19 Dec 2025 11:26:59 +0900
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20251219022659163.VHST.116672.HP-Z230@nifty.com>;
          Fri, 19 Dec 2025 11:26:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 0/6] Fix stdio with app execution aliases (Microsoft Store applications)
Date: Fri, 19 Dec 2025 11:26:33 +0900
Message-ID: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766111219;
 bh=GC56gmhFZmNW84St4TjcaCe5neVytqaxU6wFiiuat0s=;
 h=From:To:Cc:Subject:Date;
 b=maLm2vu0aIwoUFrxLuJxgvTSp1Qje0hK2zTTWzBSO9JtUPxy2QFwQw7H9lj1NcR7XNfQDztU
 joYlhVYniR3HulIljm7c+jC17KL9BpXnI7IGvwUV72iDbHYGvoIBwl8NwZM6qtrTbtuc0Nt6fa
 e+vY6BJr8hHbcwm9m84pcimfHnS7gDkgvJ67mKS8raGeiFuV86rY6ERqgziE/WRMjyTSOGLIGu
 cDwWBIgQ8zO/06hXR5m4OMtG2KuKxLgTIvNMFzjPZ+yyBcLWQ5W/dHLfD8F1xgd+PMqPo63SSC
 AG8BlWPunPxCqzOpkiTWIaCeILBJoSPCNw3IMDYGxE2VwLkQ==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

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

Changes since v4:

 * Split 5/5 patch into two patches: one is for changing argument type,
   the other is for fixing a bug.
 * Improve commit message of 5/5 patch.

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

Takashi Yano (4):
  Cygwin: termios: Make is_console_app() return true for unknown
  Cygwin: path: Implement path_conv::is_app_execution_alias()
  Cygwin: termios: Change argument of fhandler_termios::spawn_worker()
  Cygwin: termios: Handle app execution alias in is_console_app()

 winsup/cygwin/fhandler/termios.cc       | 37 +++++++++++++++++++------
 winsup/cygwin/local_includes/fhandler.h |  2 +-
 winsup/cygwin/local_includes/path.h     |  5 ++++
 winsup/cygwin/path.cc                   |  2 +-
 winsup/cygwin/spawn.cc                  |  2 +-
 5 files changed, 36 insertions(+), 12 deletions(-)

-- 
2.51.0

