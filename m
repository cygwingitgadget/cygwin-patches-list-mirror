Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 208894C900C2; Fri,  5 Dec 2025 16:38:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 208894C900C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764952738;
	bh=n2S1Qts4V85T4ko44JifqKTaefEmbbVgIlfAo24/kXw=;
	h=From:To:Cc:Subject:Date:From;
	b=rdt7LLYdbBtFRnJFVv7gLhmOELP/mdjoAoyQsMrbf847UVVv22+G4MMt7/HNNrSj8
	 n2UsTEnl5+0dlmT37A/EaOr8Ho3RrSJ+8TMm816khAsmEmzZ9BSmlz/R6X7tf2WrUE
	 W5wx+S+hnK40S5o97RkbZGxFPyvd9C97n66MgEOw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3F855A80CAF; Fri, 05 Dec 2025 17:38:56 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Marco Atzeri <marco.atzeri@gmail.com>
Subject: [PATCH 0/2] Fix overriding primary group
Date: Fri,  5 Dec 2025 17:38:53 +0100
Message-ID: <20251205163856.3993550-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Fix broken code overriding primary group at process tree startup.  THis
is fallout frokm the newgrp(1) introduction which showed a problem with
this code.  The fix from commit dc7b67316d01 ("Cygwin: uinfo: prefer
token primary group") broke this differently, so here we go, trying to
fix the second problem without breaking the first again.

Corinna Vinschen (3):
  Cygwin: uinfo: correctly check and override primary group
  Cygwin: uinfo: allow to override user account as primary group
  Cygwin: add release note for primary group override fix

 winsup/cygwin/release/3.6.6 |  4 ++++
 winsup/cygwin/uinfo.cc      | 15 +++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.51.1

