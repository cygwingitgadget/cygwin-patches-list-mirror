Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.139])
 by sourceware.org (Postfix) with ESMTPS id 5A3273947436
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 16:17:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5A3273947436
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net. ([68.147.0.90])
 by shaw.ca with ESMTP
 id JIZIlHyUyHmS3JIZJla4dw; Mon, 08 Mar 2021 09:17:18 -0700
X-Authority-Analysis: v=2.4 cv=MaypB7zf c=1 sm=1 tr=0 ts=60464e0e
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=nz-5sxVJmLUA:10 a=LF2dOfbMAAAA:8 a=N33GcLBcsBIFXr2wvvsA:9
 a=TmiWL2DCWjWbbQwbIu5r:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/2] cygwin-htdocs: update MinGW references
Date: Mon,  8 Mar 2021 09:17:10 -0700
Message-Id: <20210308161712.11280-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Reply-To: patches
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIWWkaYxVayM+BnQwCs1dyQVVcHOKtlemuOrjWsMSWFMZBP60Txfj9gRsGvTP75ZZBQBP68NrEX7PchcoxTm0QcNFLA23TdWtZsg75OgorXhtIYjNqjr
 WPliAHFruZ2iBYfW1FMPHmE5ujZ0nzGVa/hP9hS1hKWiNS0yQ6b//K1dUqIAm8baaANoi40ZRn8m2srylNJ3sLyZwmKMLSWJtkBayHzZPW/4elHfMHMLRbR0
 XjaW/KXQvNCCS7tid9Ml0gLuonq5XRLJi9rG+hyvjVE=
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, KAM_LINKBAIT, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
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
X-List-Received-Date: Mon, 08 Mar 2021 16:17:20 -0000

update MinGW.org references and update package categories to remove MinGW

Brian Inglis (2):
  cygwin-htdocs/links.html: update MinGW.org reference
  cygwin-htdocs/packaging-hint-files.html: update categories

 links.html                | 4 ++--
 packaging-hint-files.html | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.30.1

