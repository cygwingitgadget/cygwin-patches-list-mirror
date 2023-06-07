Return-Path: <SRS0=d4VT=B3=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id 1AE083858C54
	for <cygwin-patches@cygwin.com>; Wed,  7 Jun 2023 16:37:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1AE083858C54
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTP
	id 6rqFqsAitLAoI6wAPqgxgZ; Wed, 07 Jun 2023 16:37:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1686155869; bh=o4i2q8IPZJfUKrqAePeUm5VhwaOxLOU9WPTGEFPvFoQ=;
	h=From:To:Subject:Date;
	b=jV2k4/3wKVwzp6mw09TBwV8j6MBOpuQZ0PkQq8ohmiCGfKpVWeLDAIK3pLNPMCLrw
	 OzwnHk1wLPLrNz4WbDgS0Mz/jv2Fupy7qu5AxGFArhseuEoPucGPcjf9FbEwnDFedV
	 Dw1kvXI5HX5zpOIOBDPUFAGYrPWXA8/fEEFWdTgV5g9bZZl4iwBNugdyUqBoFfxtiY
	 6k+D2miVF1RBiZSdy9tG9z/oW/JzWNXOIJ8H6UMSlsX62K+v4kzpxkh4TrELHw3u/6
	 1GBFe5sXm+ogBxBgmbQNLcHBt2vRRlzVP21vN19Ba/CsWm5+fNGzhWvfZ8uPGu7JGW
	 OTYyxmxPFNaLw==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id 6wAOqEVv6yAOe6wAOqbkrZ; Wed, 07 Jun 2023 16:37:49 +0000
X-Authority-Analysis: v=2.4 cv=e5oV9Il/ c=1 sm=1 tr=0 ts=6480b25d
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=-LfuWsWYIZxDvZOVVBcA:9
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/3] use wincap in format_proc_cpuinfo for user_shstk
Date: Wed,  7 Jun 2023 10:37:44 -0600
Message-Id: <cover.1686095734.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJyBKf+QzY24bK+pYmABvWn3Z9nHDSpSeAwJNT8ytizyYHXAbgVRYhiabzI610YVCmVFzXIrb4MkXNrS1aWVFpJEuX514GOK6X/PiKztIC8rnb4APWGe
 qYFmHxbm+e7j6kGrnJontKkqhn0Vn6nSpu+qfvgFkK1Nh6jQBU8XX93Oo3dH8Fu1Mltr8oCjUxICXpSZnx86cDCP5Ik0/aZFSA2Wr0YgVYyq17b+qYgUSLrU
 f0tgyg6eU2x5dhHBdsVjo6YckhEUqv31gujjVYhcmdM=
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

replace Windows version tests with wincap test for AMD/Intel Control flow
Enforcement Technology user mode shadow stack support

Brian Inglis (3):
  wincap.h: add wincap member has_user_shstk
  wincap.cc: set wincap member has_user_shstk for 2004+
  fhandler/proc.cc: use wincap.has_user_shstk

 winsup/cygwin/fhandler/proc.cc        |  8 ++++----
 winsup/cygwin/local_includes/wincap.h |  2 ++
 winsup/cygwin/wincap.cc               | 10 ++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.39.0

