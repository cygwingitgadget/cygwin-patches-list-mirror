Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.13])
 by sourceware.org (Postfix) with ESMTPS id DD9093858009
 for <cygwin-patches@cygwin.com>; Mon, 23 Nov 2020 22:11:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DD9093858009
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id hK37kKOHT34axhK38k8h4f; Mon, 23 Nov 2020 15:11:07 -0700
X-Authority-Analysis: v=2.4 cv=LvQsdlRc c=1 sm=1 tr=0 ts=5fbc337b
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=kOp6T3oa1HU7oCbQ12gA:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/2] winsup/doc/: add proc(5) man page
Date: Mon, 23 Nov 2020 15:10:59 -0700
Message-Id: <20201123221101.16864-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Reply-To: cygwin-patches@cygwin.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfD82NZRuXS03LAq+38pKq2hy8b9isEO/ZbyKcI84XG8wHu9uB2X8M7vGa3/3PzsJ+WO73msII+U3jx8w/18Mp9NbX69JxE77MsuNFZNzeRCWNJ1Ehamw
 XYTFtMtJOCRrQp/kU4hgD8U+ARF0Ob2IrEukz3DfgWQpacDPuCLgKyJq7D9cEx2RHFCn/iRTiAK3ZUxPTtNfpUWjVOI5A/fWkl+T5Qih0lU2ISH/GpYxobUJ
 34oDI++Asn0t04HqIRQhBz24mtP77CUsuf/+UXi3boU=
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H4,
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
X-List-Received-Date: Mon, 23 Nov 2020 22:11:09 -0000

Hacked a Cygwin proc.5 man page, by combing through fhandler_proc...,
converted to proc-5.xml using doclifter, included after pathnames-proc
before pathnames-proc-registry sections in specialnames.xml, and
modified to match and create a refentry to generate proc(5) man page.

One of the issues with the xml input is that formatting wide screen
displays as if at .in 0 appears to be impossible, or at least not in
evidence in any of the other inputs or outputs, which don't include such
heavily indented lists of lists, and ending and restarting heavy
indenting context appears ugly.

Brian Inglis (2):
  specialnames.xml: add proc(5) Cygwin man page
  winsup/doc/Makefile.in: create man5 dir and install generated proc.5

 winsup/doc/Makefile.in      |    4 +
 winsup/doc/specialnames.xml | 2100 +++++++++++++++++++++++++++++++++++
 2 files changed, 2104 insertions(+)

-- 
2.29.2

