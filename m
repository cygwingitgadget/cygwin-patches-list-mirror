Return-Path: <SRS0=8yVf=OS=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id CB4773860760
	for <cygwin-patches@cygwin.com>; Thu, 18 Jul 2024 16:29:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CB4773860760
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CB4773860760
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1721320195; cv=none;
	b=s3lJbXA/fCWwEZnmG0h0tiJOLnIVTLWWYKuwr3httC0ZddW1dj2/NSkFr9ewXyg+zW65E905YEAZoTQs4I3mLMis39p8XUTMy/p2lhfOqN5BLVVFo103kqs7fD4tc2girtoMP2jPLMkOTesyGzMy7q8cWeoOi0Lckqdl72bc/qc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1721320195; c=relaxed/simple;
	bh=oFfXkeEuzIrXNMarTmgrjAg1KVRk2duMF+wcfot+6E0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sLPqowoXniE4ReEoP7JPi1CfI1QNDvuGVRd83W0smhbvCnbLSsUGzL92p3W6ahIO8NtUn8+fpBnSai8e6fplyTtT0OJTOFkfB7R7GS5aJ8kv7YcJ64LW+LZmudIruG/i34cLZMqVex/J3OPhGxm6acagiciWxptlsBA9366YYI0=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 71964A1B99;
	Thu, 18 Jul 2024 16:29:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf16.hostedemail.com (Postfix) with ESMTPA id 113072000D;
	Thu, 18 Jul 2024 16:29:36 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/3] Cygwin: fhandler/proc.cc(format_proc_cpuinfo): Linux 6.10 changes
Date: Thu, 18 Jul 2024 10:27:47 -0600
Message-ID: <cover.1721213593.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 113072000D
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout07
X-Stat-Signature: 3thxqc9d7hwz1p4xykhswxfor36ishwj
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/4jeaFuaqDZeY0mtWRG6E1v0/sU8URais=
X-HE-Tag: 1721320176-815630
X-HE-Meta: U2FsdGVkX19IRMxx7Z7Mwq/fdLE66N2khLzDXN2WCgl9bvbqYQ141ztef/6T2sIgyq+eOfx/UeZvJfyBsB3G6yolDOPPdwAg9d9qQSqLLWeU8pgQJbCxYMPAT9pxT0LNzEBCvTpnVSAn3lVPUCtC2TzZcnqjbN8LwAh3pts2FSUmGBCW1rX/DObx2NePVJjrIirj1CCeedmmzMqBeKYtTnBZ5yR2Ndm7F3S6iXWLWBbdFaZXaVvU93mSWDmIil6Ve5M3Z/u+XwtcPHbEVpwR/Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Linux 6.10 "Baby Opossum Posse" added cpuinfo feature flags for output. 

Linux cpuinfo follows output for each processor with a blank line,
so we output newlines to get a blank line.

Linux 6.10 changed the content of cpufeatures.h to require explicit
quoted flag names for output in comments, instead of requiring a null
quoted string "" at the start of comments to suppress flag name output.
As a result, some flags (not all for output) were renamed and others moved.

Brian Inglis (3):
  Cygwin: fhandler/proc.cc(format_proc_cpuinfo): Linux 6.10 flags added
  Cygwin: fhandler/proc.cc(format_proc_cpuinfo): add newlines
  Cygwin: fhandler/proc.cc(format_proc_cpuinfo): Linux 6.10 flags resync

 winsup/cygwin/fhandler/proc.cc | 50 ++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 20 deletions(-)

-- 
2.45.1

