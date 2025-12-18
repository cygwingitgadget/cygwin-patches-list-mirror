Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 245E74BA2E05; Thu, 18 Dec 2025 11:23:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 245E74BA2E05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766056990;
	bh=qebXyNKwJm0pZqZl6NaGiKscQKJQl4rO7GbrRb6ZtcU=;
	h=From:To:Subject:Date:From;
	b=XAUt6dRjCdP/GrDQiLJlAxEfeg9c89EZ7D7nIn3EeXakDZf0C3aEwoydtInXRt1Dp
	 JzuVfH7AveFBp8SGyZK7vAtGUnE0lYoVlr2QDVJ8OUTj7f1CG/sgvuC+seGevKFpw6
	 WPPg0RxC5q4OYH2G6tIyurpl+eEtsp352XvEvx3U=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 413BCA80797; Thu, 18 Dec 2025 12:23:08 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/4] Fix overriding primary group
Date: Thu, 18 Dec 2025 12:23:04 +0100
Message-ID: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Fix broken code overriding primary group at process tree startup and
overriding groups from local SAM comment on domain member machines.

The first bug is fallout from adding newgrp(1) to the Cygwin
utils.  It turned out that the Cygwin startup code didn't take
an already changed primary group in the user token into account,
which made newgrp(1) a no-op.

Unfortunately the fix from commit dc7b67316d01 ("Cygwin: uinfo: prefer
token primary group") made newgrp(1) work as desired, but broke the
scenario where a user's primary group was changed in the passwd entry
or in a SAM comment.

The second bug is actually pretty long-standing behaviour, but
apparently local SAM accounts are not in muchg use on domain member
machines...

Corinna Vinschen (4):
  Cygwin: uinfo: correctly check and override primary group
  Cygwin: uinfo: allow to override user account as primary group
  Cygwin: uinfo: fix overriding group from SAM comment on AD member
    machines
  Cygwin: add release note for primary group override fix

 winsup/cygwin/release/3.6.6 |  4 ++++
 winsup/cygwin/uinfo.cc      | 25 +++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.52.0

