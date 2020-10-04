Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
 by sourceware.org (Postfix) with ESMTPS id 0E6FA3857C7F
 for <cygwin-patches@cygwin.com>; Sun,  4 Oct 2020 16:50:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0E6FA3857C7F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5dEudrRngoZG404We2yRwKuw4RVgg+/N3jW4QNSFyMJ0MzE8dWdmUYXqfPanj0kv5Lkps3abl9MegWItAx26uv3h6GvV9L1wCrWoVVM2Bx7yNl3bhHR7Mj/2WiFmqEux5EjNP+n0BreEu1PwypszS9DDPe5pW95jeEndtUljsAGFMzFKpzsPsDviQNCwNDLID9kKnil/qtGOiBMDhcQcBKHFIaEVf83+DYRLhBFiNaWc/rELdgYISAiC7MfmClvrWJ6IXebT0AIn/dRGoxDyVH8bFePp+u0hif02W3P7zXwZdw0jvYEMnrV5BUT05vxFo3sqYZqXzq8vIhvxUZp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPL1Pdod50qFG4p3TJbx0XpFQDeiHCB4KlI3nF2J0iA=;
 b=CuUjrwgp8IlYO59/DviG36xm+pkI1btb/TeSBycllhwjij/4IQJpTktoqh/2Gtf1FI5Oe5XpSMNrwgzBKZo2qJbfqzrENT0QHTomA4XjWMC4WQC89GlHmNa6wX6BCHd7K4hbp/9Bd3wn2zApmb6oumrChPOeacSeVr3yWtTy13rJvP5AcIpoGxSxa42X7tmu9y8LEsAg8Dz6rqJfRo3gb+OUcad1mFH7SX4bclGiJ1wWx6HPmRqmqQ2uxGEyAAlKdjVu3JYUr9mpNEdJNIe6FPLcMAFwbNdg9UG/OS7fPbN7VbgcfZoXRX1W+CN72WPNRgaPalqtNl8BCqaOHU40WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sun, 4 Oct
 2020 16:50:06 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 16:50:06 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/6] Some AF_UNIX fixes
Date: Sun,  4 Oct 2020 12:49:42 -0400
Message-Id: <20201004164948.48649-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2604:6000:b407:7f00:48c7:bebb:3651:4c42]
X-ClientProxiedBy: MN2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:23a::19) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:48c7:bebb:3651:4c42)
 by MN2PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:23a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend
 Transport; Sun, 4 Oct 2020 16:50:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 808bcc74-5a79-4abc-7143-08d868858c27
X-MS-TrafficTypeDiagnostic: MN2PR04MB6176:
X-Microsoft-Antispam-PRVS: <MN2PR04MB6176EEF23F3969F27BA8BFEFD80F0@MN2PR04MB6176.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mz2eigWWetFvEvaM0msb/ns3Q7Tdubq2E28Xqauk+AbgOzCOzKRpFN460ZACZnxEvlGStLtKrtpoU7tjVXdxgxCVeOTDaETInwYLENyhHhWPCQvTfmgxOcP00gHgO6EsQCihoZgOhB27bDj1Hpx9Ab2rWXPha21tdcQ+DfYHryPKU7Jp7J2vl1IR7zYzaWiz2LNah4nn4KkRHM7mC0QnuO9br/75r6ttQWd20SyE8mQ9BFUmR95evphpZNLBAjaIOdVGmj9QKZ3ClE4Z6A38keOujOxgTraYfyU3MIwC5dbkyftxVbjod7B1IPWIzTLwGGc+9RIuR+NbjNdsCESbckBr7xnMtdf9Pve6f3kNvQIeWjZLJZNkw3/xo/YT6PU5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(2616005)(186003)(16526019)(5660300002)(75432002)(52116002)(66476007)(66556008)(66946007)(316002)(786003)(8676002)(36756003)(6512007)(6506007)(478600001)(8936002)(1076003)(69590400008)(6486002)(83380400001)(6916009)(2906002)(86362001)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: c1SQUq+WWldAI7GazJuHLTTYLmhqstunF2FoF0IrMMcmaS3tGdVmyFoZU2XDMIbVrJQkkOzDeqMPmLRs/WlQ9AWJGdBT7BNFw7jx+eS9xWGl3/UikcSNY1wKCbvI4sAMPqQu8oTlaUXMXxlIiGjns2QH5Bu3iJ1Fijqdl2oX6Oyo2CcgNQ53Wo4e22V3GWkaALHpZsVYjdxPZpWY4Q/zfHYEW223Z+4jsG+MHDUTCNGog3rUk9R5v0oMulSZg4pHv0CfEyli6vGmZhtRbuTgVwZl1X9ICQGDMlBbzOcQVwanP3PHKu0/62WBc9lnxHa8FBlcmyikuRHNQCKPfp3l8sTeyCduvWgdGzGvHpz2pxh7Bq0KhGqAV0q1IEdUxOu1Wr4T8xgFAEuHkrxpLj3qozGEM61vOij2ikv/g2sOp6vhtj1A9U+UQamfqq/wDgsXG9EY2jk9/KEm4Uofta9ydYYUP99FhZe70ONNPZKIgz11iFGTOnwahPANi3zOAZbXGWVwrnNP+I44Q6Hk7xkqzOJSXJt3KRee9vIrcZ8YsHc7ejcrEk9amhx3OCBGrDVrhYGiDdaofZMCS5zF0jqP8GBjhSG+BNeSBEFRzplkLN4i+kNXK0z5Tw1M8VcaKlRWDsDuDOAmFgep0ZIEmx3hf2+G2qIa3Lce/zI4l4baRCMEmCLTo6OeZ4ib8hGHlw3l81hD4p6txQrF5ZqyCDEoaw==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 808bcc74-5a79-4abc-7143-08d868858c27
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 16:50:06.6698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeE93Idz3/tbcSnCHdqh50+ZRdDLWp5MhC1R52TbsjTXOn5wcLQnBRp7fNE9OEniCrXqUc/QHMos/54/WmegTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6176
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
X-List-Received-Date: Sun, 04 Oct 2020 16:50:09 -0000

I'm about to push these.  Corinna, please check them when you return.
The only difference between v2 and v1 is that there are a few more
fixes.

I'm trying to help get the AF_UNIX development going again.  I'm
mostly working on the topic/af_unix branch.  But when I find bugs that
exist on master, I'll push those to master and then merge master to
topic/af_unix.

So far what I have on that branch locally (to be pushed shortly) is an
implementation of fhandler_socket_unix::read, which I've tested by
running the srver/client programs from Section 57.2 of Kerrisk's book,
"The Linux Programming Interface".

Ken Brown (6):
  Cygwin: AF_UNIX: use FILE_OPEN_REPARSE_POINT when needed
  Cygwin: fix handling of known reparse points that are not symlinks
  Cygwin: always recognize AF_UNIX sockets as reparse points
  Cygwin: AF_UNIX: socket: set the O_RDWR flag
  Cygwin: AF_UNIX: listen_pipe: check for STATUS_SUCCESS
  Cygwin: AF_UNIX: open_pipe: call recv_peer_info

 winsup/cygwin/fhandler.cc             | 11 ++++++++--
 winsup/cygwin/fhandler_socket_unix.cc | 31 +++++++++++++++++----------
 winsup/cygwin/path.cc                 | 27 +++++++++++++++--------
 winsup/cygwin/security.cc             |  8 +++++--
 4 files changed, 53 insertions(+), 24 deletions(-)

-- 
2.28.0

