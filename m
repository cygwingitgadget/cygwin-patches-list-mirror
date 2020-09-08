Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2128.outbound.protection.outlook.com [40.107.243.128])
 by sourceware.org (Postfix) with ESMTPS id 0DAC4385702E
 for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2020 16:51:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0DAC4385702E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GH42q8d5pMM2NkkidaYYt3/00HemlZG8W0Ao+Ggxtiv1tRQESRYR2htcAZAsbZIlrYtPy0ISl5aIn+CmNIBQeBB4tjFvnJCZCL9qYJGOB902E2EYxYKyefz0kupGdSmQaav9eyPHuBVVXw1yALfJYs8FbXfjjePfJp4c1Dr6eA7xEr7EaIRNTw7isrsTKzdUMtFjzaNzrNlawlHVRpQw3kUY36sNP1bxUeyk6m8Y9730VUFJHyhW66eq9dPu05nb7uH7n/m4Er4KV8k3lSe2k10TxPOaHRqwss7nRig/ENnLq5x89WwGOziyTJATh20zX2lw1AezMImVA5jRfxdPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRCX+NLNaH/AKbmbvshpC7MRNzviczeltVPWT9Yn0/k=;
 b=Uw7cx/mTvU+cn8ZaK6/Rpmwc78pz1l1CwBTuHjYmJorQro5dCTVJeMI4ShAZX1kjzi2u660trnHWe6qhFOJ2XuRnWVBy4VRgzsFAbVW5xtwlSdc7AqD63kAyT4yoOg19o0Ftbyj/57GH3XV13NAxReGbu4CC0fydz+59BGdT8gz6QZCi4rH0WcpzxXLNAFJWmNuwJA8X9s0Fh3YcfxhfR18ireBRQhPtCQyUpdDjar2j60aZxBD+YVIqsu7OGPCcOZOHp3LHL//zTaCH5BxekOiWON2TldgQ0MQoPcRqoWBzlILUM/42AkKWBTz985ob3N8n2d6gF2RFAA2r0mlh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5744.namprd04.prod.outlook.com (2603:10b6:208:3a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 16:51:04 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3348.017; Tue, 8 Sep 2020
 16:51:04 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/2] Fix problems with /proc/<pid>/fd checking
Date: Tue,  8 Sep 2020 12:50:46 -0400
Message-Id: <20200908165048.47566-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:207:3d::39) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:fc34:902a:527a:1c90)
 by BL0PR02CA0062.namprd02.prod.outlook.com (2603:10b6:207:3d::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Tue, 8 Sep 2020 16:51:03 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2604:6000:b407:7f00:fc34:902a:527a:1c90]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96a926dc-a3a2-457c-60e9-08d854175f99
X-MS-TrafficTypeDiagnostic: MN2PR04MB5744:
X-Microsoft-Antispam-PRVS: <MN2PR04MB574420F8640ED83D0270CE39D8290@MN2PR04MB5744.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfSW01jNq2wkCMLOLj3E70NAudJ5rfudY/T7IB6W3exXBOEQ37SiiTwGPusoiTL4T9z/BZUpD+LWv9t492awB7h4MaBaZGtOhHdLh9PFfhYbbKJAffr04IYTIXLaCUNvRauTRHM+vkW/JALjGKe+v+24tV6gNK+XjYxBPkmYsb5j0IYOztwgdpMmtOtHPk5WpqJNoyt7GQDXS/NBpCHZXzyMD1gqIzhD4UVqJOES5sd9ibWMIIRaP9Ia3o5DG3Py8/ZUqe1EJn4JzXpPYzPvm67Ff5u2Pzq8NSHbjMFK1AHTaYQSn+QTlbRjtnbVqYuzm0MfCiz1QARBwfIVwgo5n0P/pqVNeiEGMh+6FlgnDtfOC26Dk0Bfsfb5yatmOkD7cd0VEDL7x8jloEHvxRGcDc1g6wClHlpBPFis5HwS6GvrHlxJqCSGf1TDS1GWVP4on+ejot41J8Fx/WkVrxeVkdYdDxuBtvdcBz/Obg/v78ug1zWl5l/T0ITW3H/Y8KKHbFkqp5ioskbbWIuYG3s5dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(66946007)(66476007)(52116002)(6486002)(5660300002)(6666004)(69590400008)(1076003)(316002)(786003)(966005)(6506007)(6512007)(83380400001)(8676002)(186003)(2906002)(4744005)(2616005)(66556008)(478600001)(75432002)(86362001)(6916009)(36756003)(8936002)(16526019)(460985005)(2480315003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: T+pdwE/gUTyX2PE8z4vE0B9d/qtVdtNBadm5xps4t4N0ppLODG4tNo02575wVZGvB0r21P0ZoPLXsmxtJhCai2S971RFV45PaA3n609a3n8v5vTVPklvY6tBuN/7inCcURu3lWX4a3m0enLD4Tslt9viMrxgaJvjmj6aLT5rgdsN4lwiAsHvoXgRCsK8yhMcOgiSlx09Z6EE/kFf4sb4qUb6HPZyp0igRkZ/mvvPz8bDcq7wJ5wqMWGfAXuntnZg9VcXVVYNDnhDvy88E7/8FCPQOdmZzJeuLOqmS68tQDpgLKuLHiDsZx06K9RkNoClqFw/a7CafGL7Wrl+atzCZ9hYODU3umFsJBWbdxaxh5WgnECd9ODwdCET+BKrDTYqt7muydPhwx8aR/ZE4S381iTxokOT4UX22S9GJAh5YeV+U979XBeAHcn/kM6I71Sb8bF9gfIhO4Ed5ClYbUB8ooIKA0oHcpy9Q32sHXEq8sxblqd9i+b+i/pz2zwzaQA/vmxtfmfV2K/XzQ735ALJBooCMqWoYCweBVPy55U+slk2qQfSqXYpeaDz/nZx1imoFm65/PaC2kPyg/ALMU/A8iU+NAnTcTjTDGv4/DgIPWPKUqNAcN6G3pyAP7QVguwqOl30I4MqOILHPMDP7vEFK6Es36CLHB4W1lNWBaAmvEFqaqt+/TBm8MyMEmEZAusPitcs1u1KgQSctisRrQzQ2g==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a926dc-a3a2-457c-60e9-08d854175f99
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 16:51:04.2101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOE0milqMNd4+EU+0h0DgEFU8CThfY0SHJ6EJjqupg3yqm/zWFWg4Vy61jnXJbN5HuJ3pioRNvBgpCw+mLW/bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5744
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 08 Sep 2020 16:51:09 -0000

This fixes the assertion failure reported here:

  https://sourceware.org/pipermail/cygwin/2020-September/246160.html

with a simple test case here:

  https://sourceware.org/pipermail/cygwin/2020-September/246188.html

That test case now fails as follows, as on Linux:

$ ./proc_bug.exe
open: Not a directory

I'm not completely sure about the second patch.  The path_conv::check
code is so complicated that I could easily have missed something.  But
I think it's correct.

Ken Brown (2):
  Cygwin: format_process_fd: add directory check
  Cygwin: path_conv::check: handle error from fhandler_process::exists

 winsup/cygwin/fhandler_process.cc | 15 +++++++++++++++
 winsup/cygwin/path.cc             |  6 ++++++
 2 files changed, 21 insertions(+)

-- 
2.28.0

