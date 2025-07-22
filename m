Return-Path: <SRS0=IQA0=2D=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:23])
	by sourceware.org (Postfix) with ESMTPS id 55E143857BB0
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 12:10:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 55E143857BB0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 55E143857BB0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:23
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753186251; cv=none;
	b=uTLlnuL+4ylqEBa08VhnkEdch3KaLa/qhx4ZJ3ncAboK5wDx9ad6MGcsQJwR0UDQ7Wkxe7XIgIII9JSzrsp33cNEImrNcqAzg5OS1LmJCnjnhazvmWbf4SREBaTybuotN/QhzFdcJvizZ0PZaWoAicctTsbe3/msop3iIjXnpnE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753186251; c=relaxed/simple;
	bh=s5bnsHcMQTd5MaGNn3cz9AayB5jBnxduiNlLxnyPRZE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=f7AaxWWnSN6IQDTODuyiYKzE8CBFOmbCqEZrifF0mwPUKOLgxTKMXDWJMi/ihXUxZTO2Xnl2/Jkf1ErTEMcabDpkidUAuKIDzDuXTWUx+NcpI5h/1qDVHsQUgK4tR7x84SxO30hAVku6eVN8WaG9G5kXS2uYSKZQyJU28sfjP1k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 55E143857BB0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ijtGdU6+
Received: from localhost.localdomain by mta-snd-w03.mail.nifty.com
          with ESMTP
          id <20250722121047921.VVRE.74565.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 21:10:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v7 0/3] Make system() thread-safe
Date: Tue, 22 Jul 2025 21:10:13 +0900
Message-ID: <20250722121032.4755-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753186248;
 bh=gbSZXLOWOsgX/OzWHJGia0BT/P26dwIMdxze0DZmw84=;
 h=From:To:Cc:Subject:Date;
 b=ijtGdU6+Nk6KTf54F1vxR+dpX+j8ZIUFPVIq7WVYa1+1PMv4Rav/AtpeC/BiihSlkz1rS8h4
 siVQItUtPNFQXAYUicNWwM26X3DKz/lm++hYW2mGCldL38KemLiigy8hJyxczciyFw2cwQFOp3
 4LN2CKEqPk1c5howo2ryeVJwKjC06ZkOqiUVQDhNQbkVh7g+xP4j3rBR0YWkJqIlz+I6cx5A52
 7kxwan4EJxr0m8/vwSojm7Z0mWyGs/Ydr+WtboGbEkF2AwX4Tx6obRJ1DN/f37Fc7WVgYmdkqx
 Yh+ORqvLFN9KD98hp4bwl3MUrvpIAjv0pz1WZ9zfaA7lbqqQ==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v2: Introduce init_cygheap::lock/unlock
v3: Separate init_cygheap::lock/unlock patch and spawn patch
v4: Inline init_cygheap::lock/unlock
v5: Lock cygheap only when iscygwin() case
v6: Introduce spawn_cygheap_lock/unlock
    Call another child_info_spawn constructor for local ch_spawn
v7: Instead of v5, move close_all_files() to outside of locked region

Takashi Yano (3):
  Cygwin: cygheap: Add lock()/unlock() method
  Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
  Cygwin: spawn: Make system() thread-safe

 winsup/cygwin/local_includes/cygheap.h |  5 +++++
 winsup/cygwin/mm/cygheap.cc            | 12 ++++++------
 winsup/cygwin/spawn.cc                 | 15 +++++++++------
 winsup/cygwin/syscalls.cc              |  5 +++--
 4 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.45.1

