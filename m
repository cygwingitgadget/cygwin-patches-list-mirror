Return-Path: <SRS0=szJs=ZE=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id 6AE65393B059
	for <cygwin-patches@cygwin.com>; Sat, 21 Jun 2025 17:06:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6AE65393B059
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6AE65393B059
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750525570; cv=none;
	b=pfz/tTBi7ppas0BCPo13maw5+7vbB5mmnsBtNfK+6ORvjKRsv63QwwC6n2wH2YtGZ2ot+5Ra7PCm53fpRYhEnDB5wnFdtE4xev6GIQ3IjFA1kojdQGMp+FPf7u7jZSH/qvRnNPPUl6H5ykQMIWdOfXqOyuz+BplRgnBAraT3acM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750525570; c=relaxed/simple;
	bh=E4FLqSl6f62bgP8SGACOYiwkqmI+ILl5nXxXju7sSS8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=TQrcghwAjN36ZC3/sa+rpCIVhihoUNhv5dB9PG+YgWg36rCWgY1kJOfaTV33zJPb1aFhhdqUi1KjGpPdzwJRkWaZADdDtQa1FgysqmYOQ9AU+WIVwxcLawAA6oqSnwzLJkpfehirb56focjk5WfSLDGsXTQHzAKBWnzEU/xUkqg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6AE65393B059
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=nZYKKp7J
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id DEF2B1D7599;
	Sat, 21 Jun 2025 17:06:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf03.hostedemail.com (Postfix) with ESMTPA id 7A8456000D;
	Sat, 21 Jun 2025 17:06:08 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: winsup/cygwin/include/asm/socket.h: add SO_REUSEPORT
Date: Sat, 21 Jun 2025 11:02:15 -0600
Message-ID: <6f703b770ddd29e5c174622ae1570761a8a52a92.1750525279.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A8456000D
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: uem4peawgxyeu3yj3hur5eeuc9zrr15p
X-Rspamd-Server: rspamout06
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18Xn4BU9BUMqIp4RnNQuehfsTm0bnkhcEM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=he; bh=qRBZVFEXIn9hURtOFis0u4KbOfIYdcGrflK4Pkh7VII=; b=nZYKKp7Joz4j1FVrIpu/d4ZunQRgTJC4BlPIkIFtwgDfqijnaz9tKH/W+3v9udFhCHvecJK1cnh+O/0u4chXUzFdzuuc0cm+JZ0VV3R5tcQ+gN4IyvekZ/JtmHweYcX9VZi53+q5f2v6LoC18kt4LKUo8PlcFBnqgO5YnisZXqjzIvu5Y0blXJKIg36noTHwjQ4S+Q+ymLUDRsrPn6hIM/VOWTJ6bILOknsz8mRSPLu9oqzqRTPV8QymN4yjhaUT8oUtjJnS+9B9WZNewEkitevAHVkiHOJdJL3AdnceprsMUn+4VMVbyoPf6r2M7azfEhnhw9aPCS95EQha+hSRTw==
X-HE-Tag: 1750525568-838511
X-HE-Meta: U2FsdGVkX19+9wf2e4NXh7bWhYw4n4BySqJwzZVIeP6h7PRW6QQWVPdw4pUyb7JlMJp9CLTxEjgSWSvL9PnZjFDweQALYyAX/9KWpIEvduyDxoVzSLPOdv3IrYSUoSVJsrwmTTOdZLnLG9T+/ykbgq14B9DNjcOlcAG2syQHA+ziWt5CkwZqODSlgLyAXQWxn3hCBROuC+iJAjFu8pAa9hmEvnTBvNaG1f4knumhvoC5dJjRsQatr0EFifkRtkA3EEdgqgVoTkA9+Oa4t0giKDDpBe4X+lMV9MBxJ3CMIHp9gdROgWnp4QaorLzOOmIbwjjvcuy5EFo=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SO_REUSEPORT is defined in BSDs, Solaris, and Linux (since 3.9).
It is not available in Windows but S.O. articles suggest
SO_REUSEADDR|SO_BROADCAST works similarly on Windows, so define as such.
Required to build nghttp2 1.66.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/cygwin/include/asm/socket.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/include/asm/socket.h b/winsup/cygwin/include/asm/socket.h
index 276df3a0b5fd..d65dc41a0d5d 100644
--- a/winsup/cygwin/include/asm/socket.h
+++ b/winsup/cygwin/include/asm/socket.h
@@ -72,5 +72,8 @@ details. */
 #define SO_ERROR        0x1007          /* get error status and clear */
 #define SO_TYPE         0x1008          /* get socket type */
 
+#define SO_REUSEPORT  (SO_REUSEADDR | SO_BROADCAST)
+				/* allow local port reuse - synth on Windows */
+
 #endif /* _ASM_SOCKET_H */
 
-- 
2.45.1

