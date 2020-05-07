Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770127.outbound.protection.outlook.com [40.107.77.127])
 by sourceware.org (Postfix) with ESMTPS id 15FAD395B81B
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:21:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 15FAD395B81B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJlLVXw3cvWbDDlSTAFCD49/0kaYnTpJO7zC3BYnLPYXiNPmyLhTuR2aakYkHRkgg8HAhgnxqKlM2gac9rczpZtgieJBzhjoOyovXl+JTbsiqitsbjRiItrz96GzZHuj/rTrOoVluL4BQ63D3BKMKnXbpF6d3seNz8zZ03w3Zl27kGAorBI2yoisST+vPpn84PkWsS3jGbAN8wMdqQOKrhvNRjI6YjsV0QY0yWngLXzVxNuevqvAjsl5avFgNJ3PqU1PS+9ZdpFN3d0GIhdTev7UlsxL2uzAtGbC7/P8q2sfX5CxrQ5JmTTFA6lmOCBndLwoweIKPSLWl/b1IHPL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EXQRR0cqdbRaOXT3gDOfVeB6i5xLxmtQANCx2TWm54=;
 b=I4iizKF7V8k85IpI+gGB1adm1qXCP709YeidFt5xJysvfLy9iOZLRTebGlXPqlDY0aEkCDg/mgbfGlAtcHGyXllNvFq9pFP8HSVXFuPjlieBDF7OecKkMGxl6QMmDvUV0yPqdZZwogjttzXji3nOo/XhzSA2KP2XM6bp5W2ttqmzPULv6sb5f3FFpceoCE26aBWZW2XgqmoJk8Sv6A0IbfMdgAHdytW96nDn3a+YVleNW1mzkM3h+OSahaYE+tzvw6m7KaTnC2W39Ah3BPzvySZ1sbmr3jkm/UckBRRlMORJj8W2NJtYMcsuNLdnEUp/w6qUmW/uJGlFwpxyvCXxgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB4666.namprd04.prod.outlook.com (2603:10b6:5:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 20:21:42 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:41 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 00/21] FIFO: Support multiple readers
Date: Thu,  7 May 2020 16:21:03 -0400
Message-Id: <20200507202124.1463-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33)
 To DM6PR04MB6075.namprd04.prod.outlook.com
 (2603:10b6:5:127::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:e532:58da:20b8:9136)
 by MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:41 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e97c89cd-1932-4ef8-7b11-08d7f2c4412b
X-MS-TrafficTypeDiagnostic: DM6PR04MB4666:
X-Microsoft-Antispam-PRVS: <DM6PR04MB4666A71E9B162965B311B844D8A50@DM6PR04MB4666.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0qB2XRZNpnFLJtd5Cqcd6DbDdAIlFdgbBL4RmNxqJgVa6Og62Mxwm/C5ZB8oC7oqvzBkqt+MER8w+N5gCl98NGokTFSccmP9Dxwpu9TOI50HLlNBvQ9zjAWCfwoODGc82QdyFX8OWyyM//8qN0AMv8Hunvx8Mt4IUGevGSjlOm1iN5gWRMoUsWmp7qojiESp7RrQAfYlBKpWzx6Q63/wpNeWozTcV9BnGma3X1uhFkJwWp8ANBHlGTyrXmt+C6GQ2GUlL0kVSoChGkAbo9ZfignCWLzQWpvCCa2/cP3CDvqHxtE2XnLlq8o9DA1UhVQJfiOjGMbn2+zJogPbKGjH8WfqwnbeAOd4wV1hV1+GCzLyj5+016j2E0ErFx+G/6wbdj9l9KcGETJpsZ/SeIZn3ebylDCijtohEk4bviPspSEKRL/uX0bBilAjNB3oiI5H3Zo4eGfC2MMoQ8lguP8CjgMv3d/YauGXHWu52NR/ZKevZTRUE76kiav5ngv/tV5CRFpYFZpAD69yCAIf2iDLj0qlt8vrbFoAGvzU9ixgitx6/DjO8GFcFizusrcl2XNOOPFcpoSUq0KcXTRvc3AJeDt4hC786l1C4HWUi5KygZtcgF1rHx75Wt0Ef2MdH3m+YRdRZJ/mNF3K/snvdWC1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(33430700001)(66946007)(1076003)(69590400007)(75432002)(6486002)(66556008)(316002)(2906002)(2616005)(6506007)(6512007)(36756003)(16526019)(4326008)(6666004)(33440700001)(5660300002)(786003)(66476007)(86362001)(478600001)(966005)(186003)(8676002)(83320400001)(83280400001)(83310400001)(83290400001)(6916009)(8936002)(83300400001)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SJvI9nPNlQwhu9xPZ3UqIslVdj+pxjFQT29mVNK7ekOQ+Re+wvlyVQrFfN/BZo0tZL/H3qtwMvfrWwTLnORpQgjtb5fA+ngaOnol54FSr+eHfmIaKxyY3/aAERZpEDDTFtNJQ3+Sk1NiN0qtbKF8L3YWk2LXiL8Jgq7Z0/ml9atL2iM6dlr0bNwxlZ4Yv50Ct+jWcTOe/KZa8s3w9JHrltCkYmAUoStp3Iz73C/lvUA+IPDsup+bEQedSLFP2/MfQAhJn92ijOKS2HanCChLb5Rzzou+wnIZyOgjoiToyDkqS0JIOq3AYCRU1jLmsHGvNZ05CmnolGh1w30hj/LmJOyXnEaf2UKQa+od3ijWimrkHjvWsA5vJu6ksWWTf5TM0yRhiF9jhkQ5Bj31Xwprh/rLb1wnsPo10u/zRwORZH+2TZhL8BeNQFkQlqgDyGCN6YTHGj3ZfqW2EjIoA+1F1lBzE4ju+HsM3v4p58CtRLAlrV/iH9xMkz7Ffi6fFy+3n6siokD30rqn5LfNE/C3lp2n6QcgPM7LnSrthHtTj+KYTJcLA02/QYXYx94ovMvEepXhusmZxI8rlgdgYLiD4BrgogHpF0KVqoIRLcUm29T63dTRv4Z4Sovq+zTz0o9M0iKvEXVYHpPrCO9VAQM+2myAgqWI8ctVe4dW5Imqosbh0CS/ECoqkhgRKY94rEYpSDX4wYXCOb40uxfd51XsdYEPZaDEe+d0GUwMq41XBSDGEmLXHVUkuaH1xKEqlR2q5JkSZ1jPY2TK5LDMOumRyl6LJj3UM/PfwqT96hIipThSTQlKZjPSNzQOqrkbBO/b+ae2PEWAPTeSKcZClp68RLvXg7Asqy5rx0AiTKr3zN1VEoE6/0xFICdlHD0P99pE
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e97c89cd-1932-4ef8-7b11-08d7f2c4412b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:41.8783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hV3ivmfMztX31g5JvcBIcfsjt+RrEsG2W7CYmMLqrEL0NzrnjsxTasZ410xUFPFtY0PSELI6dkjm1KcGzI6SpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4666
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 07 May 2020 20:21:56 -0000

This project began as a an attempt to allow a FIFO to be opened
multiple times for reading.  The initial motivation was that Midnight
Commander running under tcsh does this (unsuccessfully on Cygwin).
See

   https://sourceware.org/pipermail/cygwin/2019-December/243317.html

It quickly became apparent, however, that the current code doesn't
even properly handle the case where the FIFO is *explicitly* opened
only once for reading, but additional readers are created via
dup/fork/exec.

This explained some of the bugs reported by Kristian Ivarsson.  See,
for example, the thread starting here:

  https://sourceware.org/pipermail/cygwin/2020-March/000206.html

as well as later similar threads.

[The discussion continued in private email, with many bug reports and
test programs by Kristian.  I'm very grateful to him for his reports
and testing.]

The first 10 patches in this series make some improvements and bug
fixes that came up along the way and don't specifically relate to
multiple readers.  The next 10 patches, with the exception of "allow
fc_handler list to grow dynamically", add the support for multiple
readers.  The last one updates the commentary at the beginning of
fhandler_fifo.cc that tries to explain how it all works.

The key ideas in these patches are:

1. Use shared memory, so that all readers have the necessary
information about the writers that are open.

2. Designate one reader as the "owner".  This reader runs a thread
that listens for connections and keeps track of the writers.

3. Use a second shared memory block to be used for transfer of
ownership.  Ownership must be transferred when the owner closes or
execs.  And a reader that wants to read or run select must take
ownership in order to be able to poll the writers for input.

The patches in this series have been applied to the topic/fifo branch
in case it's easier to review/test them there.

Ken Brown (21):
  Cygwin: FIFO: minor change - use NtClose
  Cygwin: FIFO: simplify the fifo_client_handler structure
  Cygwin: FIFO: change the fifo_client_connect_state enum
  Cygwin: FIFO: simplify the listen_client_thread code
  Cygwin: FIFO: remove the arm method
  Cygwin: FIFO: honor the flags argument in dup
  Cygwin: FIFO: dup/fork/exec: make sure child starts unlocked
  Cygwin: FIFO: fix hit_eof
  Cygwin: FIFO: make opening a writer more robust
  Cygwin: FIFO: use a cygthread instead of a homemade thread
  Cygwin: FIFO: add shared memory
  Cygwin: FIFO: keep track of the number of readers
  Cygwin: FIFO: introduce a new type, fifo_reader_id_t
  Cygwin: FIFO: designate one reader as owner
  Cygwin: FIFO: allow fc_handler list to grow dynamically
  Cygwin: FIFO: add a shared fifo_client_handler list
  Cygwin: FIFO: take ownership on exec
  Cygwin: FIFO: find a new owner when closing
  Cygwin: FIFO: allow any reader to take ownership
  Cygwin: FIFO: support opening multiple readers
  Cygwin: FIFO: update commentary

 winsup/cygwin/fhandler.h       |  208 ++++-
 winsup/cygwin/fhandler_fifo.cc | 1564 ++++++++++++++++++++++----------
 winsup/cygwin/select.cc        |   48 +-
 3 files changed, 1311 insertions(+), 509 deletions(-)

-- 
2.21.0

