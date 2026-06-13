Return-Path: <SRS0=y1f5=EJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 91AF44B99F40
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 14:09:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 91AF44B99F40
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 91AF44B99F40
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781359767; cv=none;
	b=vtCno3vnX7pAy9hdgka3KAxfVvMVZL30aenkBXfzGw4mGRuSraOFHSM5NcGdBCPAzxA9ZTM4WZQuypC8y25pbDu8qtTIne6FDds3/UIi0BBiczPluIGiJnd4nm50vKYgNidNASNcGN5jFDOTSOf+qw0hAQU1tLFVezNvS4WnJNw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781359767; c=relaxed/simple;
	bh=YYrez18i38/GHzU6NllTERbviRoo207rES8TebTWoNU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=f9nmtp7XtXUTSw7eY3kkGNYrojdvDIFYL1tXEdQJmZBXagH6tBsvfrh/RoFVdcWlKiL6OJi80LCUX026RIuI/LO9hIM4sbFjFe3Q/vXTWENoLDeaZbtxuhB9faGg1AFvZhJyfKmNCc1smOBtVm54cgUFrFJL1emMgq42CEWdL0E=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=XrBHKCfa
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 91AF44B99F40
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=XrBHKCfa
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260613140924688.XYYJ.102121.HP-Z230@nifty.com>;
          Sat, 13 Jun 2026 23:09:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/3] Cygwin: pty: detect pcon-backed pty for non-Cygwin-spawned children
Date: Sat, 13 Jun 2026 23:08:59 +0900
Message-ID: <20260613140917.27155-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781359764;
 bh=c2p6VDuBWk7IyIdscPYonbeu2gQDfdHZJ0eYpzM5PoM=;
 h=From:To:Cc:Subject:Date;
 b=XrBHKCfafv1ZmfMvvzFRltoImsrT2JW7fYdfeoE0IFkrHqnJ5OJJX7FMgn3yaO2dMXF/Srd/
 9AA1Mz4i5i3T7I88oGXy3Hu81baOYA5KXsG1jgiRN9kG5xmKU4rrjGq9JI2c3UnwEvyefwA1oA
 KIaWCrNbic/XMUJujbuAzvldMrvJ3I5MlEwKYZq+9116oU0It4IHoATg0tFBpFRotr3nBX0XV7
 7VCXX8q6dZaZniC4I6v5M7XsGuFUP0YfGTd8BCi0SPZuhDYmIxUvTZxg9qwJupokLM7CrHirCR
 NXWEqvzg5/HdZYnNGvRBzEm6NCvJZI5hJFJQH8Rsm0f6x82Q==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v2: Add two fixup patch for Johannes's patch.
    Rearange Johannes's patch a bit to ensure it can be apply to master
    branch.

Johannes Schindelin (1):
  Cygwin: pty: detect pcon-backed pty for non-Cygwin-spawned children

Takashi Yano (2):
  Cygwin: pty: Discard pcon input buffer when discard_input is called.
  Cygwin: pty: Fixup pty state after a cygwin app exits

 winsup/cygwin/dtable.cc                 | 14 ++++-
 winsup/cygwin/fhandler/pty.cc           | 84 +++++++++++++++++++++++--
 winsup/cygwin/local_includes/fhandler.h |  2 +
 winsup/cygwin/local_includes/tty.h      |  6 ++
 winsup/cygwin/tty.cc                    | 37 +++++++++++
 5 files changed, 138 insertions(+), 5 deletions(-)

-- 
2.51.0

