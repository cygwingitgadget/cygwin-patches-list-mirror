Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2118.outbound.protection.outlook.com [40.107.243.118])
 by sourceware.org (Postfix) with ESMTPS id 197ED3857C62
 for <cygwin-patches@cygwin.com>; Tue, 29 Sep 2020 22:08:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 197ED3857C62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wxwk4/LCm/4xit6B8H7KCc/GJMVEHvbQFBaTNRp2KnexNimV5Mm8AQaDmLdSEPpIU3RFWh9jcVI0TRYZ+vhgb6bOu7DtyzFOoQ6aHHfqYOstQFxmUlMvIgW0jWOYObtkl6muOBjhh2Qmv3Finc8AIJI1cDPpgGwZyawOouHhAnNWlq9+ubYRKimEVCc6gph/thY505lzRAWzzX4vqOC7Vy4VPAh7BE7g0jx+pfV21Bjoft558ESsg4jRDrDZaT5Pni3HGlXBC4wYIFPpR1I80W3vonZHzwrpmxOpJEWz4i4HWYCZDoUybLfkH9QcEumHHih76Gw1kH0WgFAWh+9fyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbCTbZDTHWTDHnZijr5pEJvCMP0oQRRK1Cr745xtOsk=;
 b=dx+h+63/oy5BV2yL/AA7nTPwOzjEyBK0Jjk2ER51nJ/hI8s4KEuUh8XeI35i1bAJEv1rADC47IONAtchigEPOUTwapR8j6iu47+SIZL4ZENFv9qLIeJy2911eoywKKkoGr9YcCg3oDqZUHKO44vysp0ew6Xayi8ghx4sdO2LJjfa+Mn3N+UC7K5h5VkNNO5giY5W7LG+lP4xCAPksO3qZyjjqolAHHRAxeyV4bx2rXx2amcdfD+eL2SeMPrSzuSVl72nAXGFtyB2Y/AInG7o9SU2zt4mZhpNGL5rQGDvbpr5c/VRU2Z5sSeCC/IFin1XmMFJ3exjsN9HNKUbPXysvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5486.namprd04.prod.outlook.com (2603:10b6:208:e4::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 22:08:21 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 22:08:21 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/3] Some AF_UNIX fixes
Date: Tue, 29 Sep 2020 18:07:59 -0400
Message-Id: <20200929220802.9980-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2604:6000:b407:7f00:f15c:4f14:d254:947b]
X-ClientProxiedBy: MN2PR15CA0031.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::44) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:f15c:4f14:d254:947b)
 by MN2PR15CA0031.namprd15.prod.outlook.com (2603:10b6:208:1b4::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Tue, 29 Sep 2020 22:08:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0269a745-f443-44c7-2567-08d864c42d6a
X-MS-TrafficTypeDiagnostic: MN2PR04MB5486:
X-Microsoft-Antispam-PRVS: <MN2PR04MB54863F54C5D2C17FCCE008F7D8320@MN2PR04MB5486.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9UAsEf7ijTFT+OiRC79AC9cmVIdBHbqNdQcM2i6e8EUbPEFFIBRiBCgwu+aWGXi7jGf4Xbsb8p//VUFnoQjFv8hmB9aJG3I9VJIAKfAuu7gUCferhhietueBbQEPcy0mo8uV+c8VqKuCiXyGb87m9/ZvoGtyaO9SsoVoeivU+lGqzS9uwaQBAJ3VOvRlOmrz5OputdKZUKZuu7+8i+w9PeMwLVkAj1W/PpbIOMzhNHmBkxCjafE2HMbhzeH0lpn9Kf5ehBGtlGSmij9Ii4eXmyKQuxiRrxFtCUHJHZlcsumRzKgdxU/hwniRWmHh24STsUqkI4pSsSBVP7WU5Fc4+ibH7jy9P30Lqp2WCaspJPQ5VgrIyFIHRUIa3KMBLjI7gWv7ilYIJVUTdnLcPJbhN40X8tOCQ7b//30mQTr75fFOgw0Unzg3uXD/lQxCzgW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39850400004)(83380400001)(75432002)(16526019)(8936002)(8676002)(2616005)(4744005)(186003)(6916009)(1076003)(6486002)(5660300002)(66556008)(66476007)(69590400008)(6666004)(478600001)(6506007)(36756003)(66946007)(2906002)(52116002)(6512007)(316002)(86362001)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: uAiq+qn0Oo+ykrxyn6EabcqH3SO5rhVI6uB0sNEkvfG1Hyq4xmyZ1SQYsOArpZFwnBFbgf1MISeltJth6Np8GPRl1I0IJ+neNt8NKtvoi1QzloJf8nROxWcbgRAc+LpChWctimdl52sABgm+Mugj2QRn8Oru6ak0zcVpIam9pdX4UGv8pKVLe+QTjw3IUKMtEQkl6PeWSaCBEQ8/43qvL8Eyh3pXN9CNeqFU9PcwbZWDTvxkgBn99WLmHG7oqaIyHRALnDQ4M2qkhUFa8ijoueLG0TQzQ68kRfNL4qDqpFhbyNDlnF5owg8jXejBYrokkxvYvjREAmkxRcoAyeiPnFqNFbz/0eJfSY6ibJQOceTargKBKRm8kg6RRsOe005QVJaNjpX6SqyvYsD7eR7Qek86llssQ95IKLF5MCknXCsqv6F76sxPHY6WujbH+fGEJQYt2Onyh99vb2fdGJukNj6F+aGSnCKic5yHwkUjyO5PUa1KQ0cDJxHMttbUn5E8uYlJ+aq2u0k+qTAWQTMH6n2axNA65CHkg2VrgetrtvzdKl8uq6x2nEXGVIYsPELPrm6SdgL5/Q636DnphCtJRnA5LVXfvYtNTLiQxiDJe3dN+I/jRupEIyBHsJEAOzlAXmC51YmVTEd55ikGDsiVek7MsRFvBr6+l3Pv3nwHc0SyeH7pXv7v1D5otvhljUptUPer0l3cuiSW9Ep+RhF7oQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0269a745-f443-44c7-2567-08d864c42d6a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 22:08:21.5071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArsnqfA1QKDYIrkNlmNMm8wFYSIhrhY6T7KRzpzCKAMLexAFryJUsfdbmtNwoGWlXCAI+B5fSQbVKz427iXxiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5486
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 29 Sep 2020 22:08:25 -0000

I'll push these in a few days if no one sees anything wrong.  Corinna,
please check them when you return.

Ken Brown (3):
  Cygwin: AF_UNIX: use FILE_OPEN_REPARSE_POINT when needed
  Cygwin: fix handling of known reparse points that are not symlinks
  Cygwin: always recognize AF_UNIX sockets as reparse points

 winsup/cygwin/fhandler.cc             | 11 +++++++++--
 winsup/cygwin/fhandler_socket_unix.cc | 19 ++++++++++---------
 winsup/cygwin/path.cc                 | 27 ++++++++++++++++++---------
 winsup/cygwin/security.cc             |  4 +++-
 4 files changed, 40 insertions(+), 21 deletions(-)

-- 
2.28.0

