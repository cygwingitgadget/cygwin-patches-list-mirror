Return-Path: <SRS0=2n0R=CE=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id 4EA783858D35
	for <cygwin-patches@cygwin.com>; Fri, 16 Jun 2023 17:17:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4EA783858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id AA85q6Z2NLAoIAD4Sq9UW5; Fri, 16 Jun 2023 17:17:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1686935832; bh=GBfvNWLdrOR1wa/9NC3+2yGfGzaUQ64+zU9s+Z6YWWM=;
	h=From:To:Subject:Date;
	b=MdQvHmzF+KJIzIDeQQ95y+Q8YGxGQyPBLVfxLFzjSrsOtYp0+fA00s9ozoE/n9uCz
	 zGnYdiFayWH/QlCN2p8vary0fYLSQSszX04mY24PpjB/jVpDY9n2wnLxbvhhu+nBPp
	 Q6/MrVW9oHWaC9LfPMpxYZGol2J3BhR3NScmx3GSQyBe9Tj2VqBKOVlNtPD8elL2tR
	 phHXloIeQPYJGi1BZ1OFiluBtQklYKJ3z/A1XgykpuheJFDDI/RHxr5g63ZY8cRDkv
	 9x4WLdP6kNCoyQPLeTHJ8zw1x0qdjpzYhConVn+HFTteJlFLHvZ2TIR6UwbquI5s0P
	 sfDvHrSw4hKgQ==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id AD4RqcnxzcyvuAD4RqPWyW; Fri, 16 Jun 2023 17:17:12 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=648c9918
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17 a=_Dj-zB-qAAAA:8
 a=YpMwFYBWliO98hkeVsAA:9
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 0/3] use wincap in format_proc_cpuinfo for user_shstk
Date: Fri, 16 Jun 2023 11:17:07 -0600
Message-Id: <cover.1686934096.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBXapB+lXM6izAccewDvq90b7Eg9pkg1vjNXXdcHROXmzitm5P2ctevrJkbJkXH+owmWsJvszK0h5ST2QTMfGFA2xTq6n+oKGbKPasM3niOxfhhe8+JP
 F/SJd0VS52QV505X3b0QkcVAONukvpLBVzj9ZuIO1WTTlH900dQGsxevYmtGkcBV7rK5AvQS+n5Qseu1zcOFoDdOwBIsN+xtJFfijFNc7fX+lQJznbXuLEyN
 hQQnICcTB/4N9dDjxP8Ex2dVVGnxmvjUSfsqbcz5Xl0=
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fixes: 41fdb869f998 "fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3 cpuinfo"

In test for for AMD/Intel Control flow Enforcement Technology user mode
shadow stack support replace Windows version tests with test of wincap
member addition has_user_shstk with Windows version dependent value

Signed-off-by: Brian Inglis <Brian.Inglis@Shaw.ca>

Brian Inglis (3):
  wincap.h: add wincap member has_user_shstk
  wincap.cc: set wincap member has_user_shstk true for 2004+
  fhandler/proc.cc: use wincap.has_user_shstk

 winsup/cygwin/fhandler/proc.cc        |  8 ++++----
 winsup/cygwin/local_includes/wincap.h |  2 ++
 winsup/cygwin/wincap.cc               | 10 ++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.39.0

