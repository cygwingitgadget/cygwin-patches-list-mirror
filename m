Return-Path: <SRS0=SYvf=UH=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by sourceware.org (Postfix) with ESMTPS id 31F1C38515CE
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 19:43:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 31F1C38515CE
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 31F1C38515CE
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736970206; cv=none;
	b=roQBd9gZifCVxBRSpNMpc2zSwjN0vo6A8biOUI7CySGe181hL/t2oo+2zq7rWsvf2MMjDH+QYNrcOwMKEzb5jn7e/LdWJ19lqD2Q+HPrv4QHAF8e9pU7j4vSnPDjbnX/IdbCdt4IL85pHOmRZy+gNrexIiY40oracMhpR6ov2xw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736970206; c=relaxed/simple;
	bh=unWF/6zjizXJPXXHgLW2fWxLdUATO4+5NT5kq8eG8b8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=jHFprRYIKLuBZsRXlk782h90vCfzR88051Ql/QDD2/kER72UljNxdU5zTovu4lJPOfOVQX3+UBEKuC7ifnL58VPkwl/tFMjm3IPm+NmaELOR88TZO2iXd7De4ikBkH3d16N0KqIVRNMuW5xLOr/qLiJ25rVYLI+4ispwXhWpHtk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 31F1C38515CE
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=lqHzyx+R
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B167D801B9;
	Wed, 15 Jan 2025 19:43:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id 6C5772002C;
	Wed, 15 Jan 2025 19:43:24 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v6 0/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 updates
Date: Wed, 15 Jan 2025 12:39:17 -0700
Message-ID: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C5772002C
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: oodtmf4ub65pyu3prjdyuzuafufz36w8
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX181NsoRYU8A4phIE/CQHxLGFdiq3rM+yTw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=he; bh=MAglQcd5WSKSvX8n9YuSzwvwq8G0ZP8HdutN+i1yLwY=; b=lqHzyx+RHdLMJtIzElRih9tg5PwWkdLPY/ZYkRNAYdstOfB41CLH2yNCduTIdbg2+rnX5MqUcnQwM2NuZHvt3qo6sNbQLPq8ypetrFxnLvGNV4trbPjAbBRQSS3iID77FBcpO/FxIxpJELAnINNKX7MfRjk0HaXLDP89WLVpBYFuwKImJmKcDf5gbyd/y7pSnblhE03qJWq/znbFy2SnweNNWlnrsL1nLW75UfWgHtSbf33kqi6xi+zhO5DPMD53QfxjuQZBmNU53om3wTchpKQ0PjweHM00FTWtClLxUwCh7eSF6xZSDi1tpZEfiFlOEkyba+ej/iq0fRG1KFsWQg==
X-HE-Tag: 1736970204-873472
X-HE-Meta: U2FsdGVkX18nixHPCcgvYkNXpG/4SeQluOCxVG4v5gDxFVvKskG71EewXeJALTXWK80yS6uXKcjNaPQEkBhOWX+dsDIdWKn98Y9Lw8LS9NMiordpZnE6vB/KCQSfhmfb2obx9gp04QBG0SILMN+wobGvheW41TgrU7hugzEMQBuIr6UMrlHYGkhneoveE6Bs/gR2pGjfiARAVXmK+75m8FyZx8ITwMildfXrBHnNBTyiusZeWd1jVMILwRe79mgFHImQm4DWhY+mPGWq1THJgQ==
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

 winsup/doc/posix.xml | 1298 ++++++++++++++----------------------------
 1 file changed, 427 insertions(+), 871 deletions(-)

-- 
2.45.1

