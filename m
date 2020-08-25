Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.9])
 by sourceware.org (Postfix) with ESMTPS id 3EA17385DC14
 for <cygwin-patches@cygwin.com>; Tue, 25 Aug 2020 12:57:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3EA17385DC14
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id AYVtkhGx8ng7KAYVuky6T0; Tue, 25 Aug 2020 06:57:22 -0600
X-Authority-Analysis: v=2.3 cv=ecemg4MH c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=GxlEIAqMwO1gw-7zkmkA:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/3] FAQ setup, using, programming, api, timezone, patches
Date: Tue, 25 Aug 2020 06:57:12 -0600
Message-Id: <20200825125715.48238-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Reply-To: cygwin-patches@cygwin.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCRLEjTAB+o1YUGoGgobXN2iC71KIu1a4AswFMJrnc263kfHzt0Bm29B1Nk1h15yQiBB7H/uTrKOTv089FpjOPEQe7KKjEEVr+QyW8b/aHjhSgmejDhY
 qZJY+1VkMR1R/yrf7j2jnFZE784oLEjh2MIZ/GQiI0LS8Yh0ccuoo+pgNtX6KcR5BitcOJFYMrRxcLsetK0VJboRyVH2E6Esh14Q0xO41bXjRxBr5FKbSl61
 XH3zBIMgrTnKIWfB7hRVeQ==
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Tue, 25 Aug 2020 12:57:25 -0000

FAQ updates from suggestions made in various posts

Brian Inglis (3):
  winsup/doc/faq-setup.xml,faq-using.xml: update setup FAQ
  winsup/doc/faq-api.xml,-programming.xml: change Win32 to Windows or Windows API
  winsup/doc/faq-api.xml(faq.api.timezone): explain time zone updates

 winsup/doc/faq-api.xml         |  39 ++++--
 winsup/doc/faq-programming.xml |  20 +--
 winsup/doc/faq-setup.xml       | 229 +++++++++++++++------------------
 winsup/doc/faq-using.xml       |  27 ++--
 4 files changed, 158 insertions(+), 157 deletions(-)

-- 
2.28.0

