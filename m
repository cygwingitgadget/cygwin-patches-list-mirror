Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.139])
 by sourceware.org (Postfix) with ESMTPS id C8E573850435
 for <cygwin-patches@cygwin.com>; Wed, 17 Feb 2021 16:28:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C8E573850435
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net. ([24.64.172.44])
 by shaw.ca with ESMTP
 id CPgwlIV36HmS3CPgxlRZTo; Wed, 17 Feb 2021 09:28:43 -0700
X-Authority-Analysis: v=2.4 cv=MaypB7zf c=1 sm=1 tr=0 ts=602d443b
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=nz-5sxVJmLUA:10 a=IkcTkHD0fZMA:10 a=yYUubzz5qDxymkkypRQA:9 a=QEXdDO2ut3YA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/2] cpuinfo: fix check; add AVX features;
 move SME, SEV/_ES features
Date: Wed, 17 Feb 2021 09:28:34 -0700
Message-Id: <20210217162836.57947-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: patches
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDPEFV+r2F08XOu+6V/0BaXXsJT6A7GtFOAD3MTXYbwDIe1D8WfIqfogkNz82stbVPZxeKim7eN2auGmLNXcN0YvCwHZszfPPXlErLIYbv44KlkGbNXc
 BnumnOp5e3TnaHxZ4l+AvruSlSRhQcAmZy2oWm+WNirLqFXntjYU0wWmTw9uUTc2nifk99HSHcWzr+dSI5+bltnlZARTCTIshrTvK82dDvDtxvQQKiOuCCuu
 V3jkhHyKavxVIz6AopjdH6Cz1k99tN1iXyi/DrCghtw=
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, KAM_LINKBAIT, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H4,
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
X-List-Received-Date: Wed, 17 Feb 2021 16:28:45 -0000

Brian Inglis (2):
  fix check for cpuid 0x80000007 support
  add AVX features; move SME, SEV/_ES features

 winsup/cygwin/fhandler_proc.cc | 46 ++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 22 deletions(-)

-- 
2.30.0

