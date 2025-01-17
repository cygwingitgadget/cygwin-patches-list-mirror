Return-Path: <SRS0=IVSM=UJ=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	by sourceware.org (Postfix) with ESMTPS id 352FE383FB84
	for <cygwin-patches@cygwin.com>; Fri, 17 Jan 2025 17:03:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 352FE383FB84
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 352FE383FB84
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737133428; cv=none;
	b=taXLG8KUsQTBzH5UeRi2B2rmQkGD9sy/KS2fnBIsYI4aX3JndgmiiZLBcN3Ku2OJM9P2r7iHNTF3b4EtOKYQfbezbHbRAYG/u/KyMm5xgRgfF2PseeAn3pJcXgOWCC4uhA2Mm7jLscSjpMLcjryCsGM9V8Xdv2t1f+jkH9spRyU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737133428; c=relaxed/simple;
	bh=fjo1N/EYfZUg9vjo2MdaRLy2/nRKV/AJCTRQBpcfaw4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=AzM5cXecXc2aHEWHqb2S3pcd1qR8ZnjGTaATFtYneIemiojtb24sRjhDdPbj5qWUYNKYJCKhIBvy5g2aLjWaIf7P4gCpBOUEEMzRqcM/bGDOFNnN7Ui1tOhwXDGZ4YiXkmQF3cOGEofWxZBTX4RQrDMnlSgzP//SL+29vUCBrV0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 352FE383FB84
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=GbekkgAo
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 264BDA0721;
	Fri, 17 Jan 2025 17:03:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf17.hostedemail.com (Postfix) with ESMTPA id B96D617;
	Fri, 17 Jan 2025 17:03:36 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v7 0/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 updates
Date: Fri, 17 Jan 2025 10:01:03 -0700
Message-ID: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B96D617
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: oc4gdth6euab5tqkwgsmgbzmxgawwasy
X-Rspamd-Server: rspamout03
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+oG6lTeAK3I8/KQfcpC/K66M/0VwI3KMc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=he; bh=Hh/zc5+kQFzRq7kG68PQYcNrvS0JuhbGkl2qBXg3i44=; b=GbekkgAodwukgMljLazPxyJN1Nqaa7zSw8MSQp6E427BkU+qxA0aUSnWvjqOd74ZoVeZ0b4LOvVezNtzXOC5uX6wXDi6CxgmUgbmRMwgU0X5Z/AJV89gsYeThbPQCBHehht+U27AiL6BO49Wi2Or4Jr9YbOomFHPbwzLOL/MxvvH09M6CywNeLa9kb3nguOZACLbJTkUxAx/U8x1Swy58IA89BRJe3CQ3WaB0RQZwZ4voE0ozOn3gTMeNVuuIH3K5wZVHjbd7DIroeAnn8xSJlZczB69PBmGCdzZRtgcvqmGapHpOb8w3FzLTK7RXwa99VQPC0VTF977mvMFhJWdkQ==
X-HE-Tag: 1737133416-578503
X-HE-Meta: U2FsdGVkX18ctFJ0+ri0q/ganc7zfASUAEW7mk+SsqznDjABb6phbh0FLsq09ePn2Ro4sLdfwY28lmc6e1tlrvFO2+78An3xJgTzKBAvEFVNjL5952rxxE5n/7Gz/4Keozzb2pV/jwE5YwLhoBIdpT3zWyxynjS9NcuNRWvcZu2J4CrmHUgLsNHWt1tGam2PtJJaHuNGYQaZCT4vGx5gkE87Rse5THusEX6o4FqEMGufekghyB/FoTRQRkNB23Ju8F9wYvPhHZd8twGDUSGEvw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Please note some changes are displaced due to rebase conflicts.

Brian Inglis (5):
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 move new
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 new additions available
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 not implemented new additions
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries
  Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 combine multiple notes

 winsup/doc/posix.xml | 285 ++++++++++++++++++++++++++++---------------
 1 file changed, 184 insertions(+), 101 deletions(-)

-- 
2.45.1

