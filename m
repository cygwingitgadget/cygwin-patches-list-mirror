Return-Path: <SRS0=8byy=UD=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by sourceware.org (Postfix) with ESMTPS id DF62D3857C6C
	for <cygwin-patches@cygwin.com>; Sat, 11 Jan 2025 00:03:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DF62D3857C6C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DF62D3857C6C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736553793; cv=none;
	b=aftdtvUYIo0te7nVNJ3yA9YyKlOl2csvnTwsyWMZmBhApK4btEGeL/SpyvuCskTAJ69mHjch2X2xcJ8djmRE/XCdgKzvMlPFBxNTxvcJofveZczo3vnU1uuzzExI+STNlxj4Bww38M8c11e10TNxyN9QptLXUlPOegtPUoG46o0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736553793; c=relaxed/simple;
	bh=tppFDLTiTqd1EBdINPbpGpAIYMcOzQCvEqRnxd/togk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=jnGYIJ4RWVtVHAm2MuJAtRUbI1YoSg+w2Q0W1FJWRM8p40i0mX/s/fP49hlV+EUTvVHgqj0CFSISHQQVn4wqE4qG0yGBAV5g19dwtk53//CxlV3V8E4y7e1xW7MSlFHKqabuSJjp4ovZ9HY8gYL2otoqeRo2SejQx93nnaUHinM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DF62D3857C6C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=VOMefRqU
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 750FB120F03;
	Sat, 11 Jan 2025 00:03:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id 2A96620028;
	Sat, 11 Jan 2025 00:03:11 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v5 0/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 updates
Date: Fri, 10 Jan 2025 17:01:01 -0700
Message-ID: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Stat-Signature: fr41eznxc4att44nn1ohn7ik7qwo556o
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 2A96620028
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/8tA+NUl3QUzFWcnx4jxKWnV60TM+AsqI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=he; bh=MsNYQ9rwOv10dPRPkHFTzazi1/TqhZpLmjZRsOT98h0=; b=VOMefRqUl0gBB8gdk75TuKoY3XAejRYZMuc3ykjZkBWWAJ5SwzIiu/eTFDVcQMsyFMH7bPZzXnrTPiR/q8/GqWAOR3OAgbFsWzlWFCOH3MIZy3IQAW86NJKok/V0slY6vW3jk8kK8E4ndMve24guZGPfy/r6r1ogNueJrZxhoi9FnhuWQrV1biaNIEbW0bDBk7ePkaNr0PXSqFRImfxYm0x+m5B5EEGyeGb2RLivl3hpd679XJls0bAWcS0z8g5NrniO33yEH6StKFLOo5KBrW3AEjkGh1tvzaUi04OG1rNiNnb0NOiqBImPfgSxUBKRybJA22KhvEl/jJ0dBmPERw==
X-HE-Tag: 1736553791-424413
X-HE-Meta: U2FsdGVkX195cp9Chk7NLeNV2moHbhMQJf3R8GReV+3+ni9fe+qMCfQB8uqz5OFLR9ntsbR80b7flpAcpBqPw3u/PL2QVbiqh/MzMwnOrQ66iBX2Z+gq/kQcnSpxf+2AU2eU21trDibjbGkXlFNULPKFSilppcfGShb3+iMrw43w7zptAjb84MtZ0hfl+GyWxPJ2T9GIpE79L2lR0n2DVQgl62A/optGirlkN25lSmjDwPw3ysUvtL08bDDXNfByS2eblpkLOSu9CkAqqGe2Kw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 updates

Brian Inglis (8):
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 move new
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 new additions available
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 not implemented new additions
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 combine multiple notes
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 group variants with base
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 merge function variants on one line
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 abbrev variants of base function

 winsup/doc/posix.xml | 618 ++++++++++++++++++-------------------------
 1 file changed, 263 insertions(+), 355 deletions(-)

-- 
2.45.1

