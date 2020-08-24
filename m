Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 03F4B3858D37
 for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2020 20:11:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 03F4B3858D37
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id AIoDkEgGn695cAIoEkGDod; Mon, 24 Aug 2020 14:11:15 -0600
X-Authority-Analysis: v=2.3 cv=fZA2N3YF c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=AH9w8aHWnBEEz-Kbr_EA:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/3] FAQ api, programming, timezone, setup patches
Date: Mon, 24 Aug 2020 14:10:56 -0600
Message-Id: <20200824201058.4916-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Reply-To: cygwin-patches@cygwin.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIs8n4bu+ynukEF85MT1QIAB22t1R4F9uxFn292dQekS/fXeK6aYBfMvfAv8tUr4qOmdwUTTlLl4lEh3HRCOHeTd3HrxijZB9LNvz1XxZ39BmMd2xcVG
 47RwlpCOIt5weC1+dNxMpqRxGXgEzi7Le3NE39HBugSxeBZjAYB4ka7iAi3V7MzMa7PyZ4RBZZ9KR9Z0kwXGovKTokpVdJMz9CpYH9QPePW+HE0CBAxsFE8l
 9xd93Kzk0pVrwLu4x/Zj7g==
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 24 Aug 2020 20:11:17 -0000

  winsup/doc/faq-api.xml,faq-programming.xml: change Win32 to Windows
  winsup/doc/faq-api.xml(faq.api.timezone): explain time zone updates
  winsup/doc/faq-setup.xml: update setup FAQ

 winsup/doc/faq-api.xml         |  39 ++++--
 winsup/doc/faq-programming.xml |  20 +--
 winsup/doc/faq-setup.xml       | 229 +++++++++++++++------------------
 3 files changed, 144 insertions(+), 144 deletions(-)

-- 
2.28.0

