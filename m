Return-Path: <SRS0=Yd2F=VN=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id 100B93858D20
	for <cygwin-patches@cygwin.com>; Sat, 22 Feb 2025 17:49:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 100B93858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 100B93858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740246540; cv=none;
	b=iuiFjObghBbKZPltwVSxDVmEimb/wksX0ShLMXR8HAB3T3sBHRWKyMQcf0IxnHmwqQY7FWPgW9JT1dgFIdEYq+ey7U6eUm6CJFVGfiHXWE31vjobdqNYeDl1BDMigO4sgeK1wdFD+DTw5GWugWJTMHJzUlArD9jo1W4eb2ly4LQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740246540; c=relaxed/simple;
	bh=2Yrokge3xjrXwtAzP72p72cMSzhDiHqH6dYBeZcYTOQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=SKwmzkGi21Orlykwfmz412mzvUKXHd7DGTJZ7Kc5ILFxJq6tnf+kI6n2yena4wjrkxjx0kkkdIacVZJtRONqMkT3j4MQ7LjxP3CBVUm9kPlZ/L6yygD9uVHaDeOLTqWnyQV+tXeAt3f4Rxfq9WZI795q8pkx7dfkaG10O97my6o=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 100B93858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=szQNI77W
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 744D05187D;
	Sat, 22 Feb 2025 17:48:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf16.hostedemail.com (Postfix) with ESMTPA id 28BDF20013;
	Sat, 22 Feb 2025 17:48:58 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v8 0/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 updates
Date: Sat, 22 Feb 2025 10:48:17 -0700
Message-ID: <cover.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 28BDF20013
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: f8bp1m93gpou5m9i1enjdyzdqxyy49gq
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18otd5OGfP863D7AKPdt4LY/xql9t/TUxc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=he; bh=6A6rD0bKt8YwBc0hKqZ/VRfBpTuiw5xxXwq7AnTI0CY=; b=szQNI77WoiyJ2NmlRs10MyFrHQNigdoZZ5Gr6kinoIKYWQzg3J3TP2Ur5E7y8gKkhMHB03ZeodWNWTpXhRUEpN3eKNd5UR88rwE6UB+ZSQjyaACTAlNN9jMTOzl3IPyYoSP9R4SssScVMs7YaTpDN38Hi4qhm8yqWgcq2RMAUMkI3drrUvkRPuhLZgnVyMdaiVzVSYAlvSUxsrWsTU0qB5UEhD6gh4vP5fVWEH4pGrcUte1zTz3DsgxnT+jLbk0hW3ZSkgmoWmbcVmH6A/TSKm/5Y8ckJUp95NhwoJK0yUVwMSqF9CtN9O0llBDBemR7h0PUbVa7K+SEE35dZwWQTA==
X-HE-Tag: 1740246538-10520
X-HE-Meta: U2FsdGVkX191iYE+ET9C6q5FJrj2QWA4p9WLOSF5O1damouxBdZsuEvWazOrRiaDbNm0pbm2bCzfBTxkFDDXtsebsUvXR4nmBI/LEeo/vPI0OZDDDCiVPnL+8OtmJcgrQ1xoeVepkxNFJn6YpWCleeXMmjKA62ZLeFrh27fys0lrHF6wHdaQjlaUFU8xwv+lY2+6Bih/wyXqhYqHvpzDzRRk4lGj4kbBogbAgSDdKhM7D8xPJ0jUp9Nxic8ViC5/G+4WYNnCWzrEY/70+KKYuA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Missed title update squeezed into last patch.

Brian Inglis (5):
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 move new POSIX
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 new additions available
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 not implemented new additions
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 combine multiple notes

 winsup/doc/posix.xml | 297 +++++++++++++++++++++++++++----------------
 1 file changed, 186 insertions(+), 111 deletions(-)

-- 
2.45.1

