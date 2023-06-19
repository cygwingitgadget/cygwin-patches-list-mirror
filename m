Return-Path: <SRS0=lA2L=CH=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id 347D43858D1E
	for <cygwin-patches@cygwin.com>; Mon, 19 Jun 2023 18:15:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 347D43858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTP
	id BF9tq44Y46NwhBJPMq6j3A; Mon, 19 Jun 2023 18:15:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1687198520; bh=+d9y4wVkQbDFDd7wYP+SkzLBTCj8+LHajxX1Em2apB4=;
	h=From:To:Subject:Date;
	b=ULJMesLKLoIDoyTUPLnvvWVonZaKhcNcM60my2jM51dPsjyHYGwRYE/vF1yK5oi/9
	 xM1oP+IA8JcpatG3ePKsubHtpYBid5ry0RBNKfqmsW6JaP1CE09EbSoXPBC21EXQXZ
	 qOYgF+5sZCQuAP/q0X3f/+B6qis1/1TeEzsvdsmOiWswGe9Y5zH0GPF5lKzha+pdSu
	 qePsfXPBVLBrX7o3WB4TdlqBPt3/QlUvcmzJ69MLhIxEHazBQjzvvA4DRmNzXYBFYd
	 UNEQNn6MmX398dWE/OWt5vr4yXQJheZJrt2k3GbW0sNeHLGM84seeEtgZZRolRXtJz
	 LRAt1qOuGrb3w==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id BJPMqSjlnyAOeBJPMq3Mu2; Mon, 19 Jun 2023 18:15:20 +0000
X-Authority-Analysis: v=2.4 cv=e5oV9Il/ c=1 sm=1 tr=0 ts=64909b38
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17 a=_Dj-zB-qAAAA:8
 a=YpMwFYBWliO98hkeVsAA:9
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v4 0/3] use wincap in format_proc_cpuinfo for user_shstk
Date: Mon, 19 Jun 2023 12:15:16 -0600
Message-Id: <cover.1687198150.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKRNrPw5+8BTNJog2vi/mxoL+MdQP/as/CCDL0Ad1610CxmbR+89FlE/KCfJjTj1ru5tIdGtI8YHuuNv0XgLFPWh0Mk5qH2Z+3C7coUkf4x5YnM8LmJS
 UvS1eR+4mE7j3U0fiZILQuNcRBXjAooR3+ddJ6TfKRH/5kqahCsIPVpVUIKw+mGunZPYB16X8YdRP5ZppmzH0I2/nP0kXsRZwloZsqkOpVA4Nhnvaj2LKTfo
 WPWzReQoPf05BS7Zlu4PZcCQENM5ZCSIZddCzGgmBQw=
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In test for for AMD/Intel Control flow Enforcement Technology user mode
shadow stack support replace Windows version tests with test of wincap
member addition has_user_shstk with Windows version dependent value

Fixes: 41fdb869f998 fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3 cpuinfo
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

