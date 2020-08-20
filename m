Return-Path: <kbrown@cornell.edu>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2102.outbound.protection.outlook.com [40.107.92.102])
 by sourceware.org (Postfix) with ESMTPS id DC92A3851C3B
 for <cygwin-patches@cygwin.com>; Thu, 20 Aug 2020 14:57:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DC92A3851C3B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnemVIKWrnx/17Qs33UyTcC3PZuHwx5IxfnObD40M17sxlsSZJ2A6E+hLjH50p5mwQoUQaUXkCk3i4Q+xEUhnfavXVcENfkK4+hjfOAqvlBEPDe6KjlPuirWNrgCf3fjXfZfDmw0dz/XWALIB9HHO4OvaiKGOgHKFhO+EXXmdaB+pas4CNjnuu/cOk3RP82KJeDvVemCuNnGIbghGGOunssT7sJzKIw4plony+W9EVKy2zBtkde3AAIHabmkQCWnvG0DpQfxVkN2vPFPSfnciRgHp8CfYGgt/wMGV0YeVEoJeQu7GyjqEoQ2n2VIkqaQchCCW3hFGo6qSxCNndUmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldQYkft89PiMLKTCWJmPLJzQw8XspMEXZ5Rv/HB2HRg=;
 b=RreSjlhahFt7qMcFYDYOzhSADgPTcBYYrQN2s/tw6k3Dy9fXyBrXEE4M+dUHBKEoK52pVk3ZWLOHe7Jpf9uPeoIXd1bZXn/dgibd6KSktmEh1rcAOSAkdzvCnxgXFXvAQpFWdYyJ0mySC7P76l3qJbghPvNQao3tqGzf9KqZxqRg/9h50ydRZZtkl2ws+ar/eEeHi8P/TeUxIVzUUPRYg+z0INNT5xaIsX35+8m06QxAMzO8dZuSvNsmNCkvsChkWv5IaeKHfZ8mAmQPBatHfN2d8b4GD0Lwbu5T+g3PwNmR3evc6q5NnYoQ/hAbWkwNtUF9SKZgmLluPtAMpXkLcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5647.namprd04.prod.outlook.com (2603:10b6:208:3f::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 14:57:44 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 14:57:44 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/2] GCC exception codes
Date: Thu, 20 Aug 2020 10:55:58 -0400
Message-Id: <20200820145600.21492-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:208:234::20) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR16CA0051.namprd16.prod.outlook.com (2603:10b6:208:234::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Thu, 20 Aug 2020 14:57:44 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06d911df-4d2b-4396-0cc2-08d8451964f8
X-MS-TrafficTypeDiagnostic: MN2PR04MB5647:
X-Microsoft-Antispam-PRVS: <MN2PR04MB564739BC411953D0234214AFD85A0@MN2PR04MB5647.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8dH1maEYylo6yCmJiz37F6z4FYM1k3sEycVJdJ+o5Rezj+LMW17JSK9pe3o5+9tx0yOwXwi6nXrmmK5hldydBxi+fbMi7reR5JgvamnbPrdUY3yJXCt4ot/LUtQPwpp2TF97bowVnOgcEtOFyAG5O4intcxslHql3KiUqMR2TfpmqtsgDCRgsQBN9TNzCZNUO5s+AGcQO7GvXP7D1Eo+fIvNZKTIe89Aizb26BbTbkPugWZPuu7SPhqHK6QgSd+wx8ptRgVUBB7yt+njKZZmFtjRbXocFNivdl6Jy/tQPc5xCDZY683YAyY/nsoO39B2WkU3QUrlrEejFar36oJjeufuhzORhOdtcLBv/XRtalXdrPTFApsiPyio/Pg6bcqA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(36756003)(5660300002)(1076003)(6916009)(16576012)(83380400001)(786003)(316002)(6486002)(110011004)(66556008)(52116002)(478600001)(6666004)(2906002)(75432002)(86362001)(8676002)(26005)(4744005)(66946007)(8936002)(956004)(2616005)(66476007)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: c1oMnnYvxEm1900ML0g5iMSq/msv10DQnCMjJKl9ZseHg+bskINKvGOguOEIuGDOG0knfN2DwYBXGTWdOxI0hWbORhnTHndrRZMbCO94xbATnUTRUYVReAONT3a0oqT26uvtLdxqYAke22hj6VT9jtRi3TPNUtN4wRkZkabvPvcvR9XA+agH141outdPeetCXTDk0taJ0nwK3KEYGCa7lH6TlLSRqPrjoYCIXG4d+rsleYPrDZ9oLCfSYIj/PJXdesvpanPUtBjBI7BH2e2DYeOTGh0zBPZSCQq/JZMlbt8JYRFGJI9Gg3/mA8RliDWhoskAAI0MGkYonKKEDUzEypUcQxL6xFtV4NFKzLltjrNIAIiBuOHN7EnIJgOXQkKyfRhAACQoSqB0toXSsiFhJLXp8WDAOMtPZ8zqDeyWgWIn4weaeeMupacMRz9TxDo7/HFnANywSkpU6wf5wb4Aw0ZYt0+W//U7U7KP9KzscO2nELEIthNGuFsmnLwuKp0L3iRsQE1uuIFr2Uo4tnPQnxI/bRM+DPyb5a/4PPoFjjmL4KdZA3ippxAINb4Fe7phTU0CShcv5cnRhdfqjhU7Qg1lL+R+xt4zuN6N+AtWQhpQgjXEEJvyttgt77KbGE/VkgRtRAxStkmdSesd2S0Z4w==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d911df-4d2b-4396-0cc2-08d8451964f8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 14:57:44.5440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIUFf3+WsSVLy65fON1LVEAVfypkflmIEJek9mTCBBigGsTw2BGnhRg1CcgN4Jwft1MCODyAJZusRwJidgrB2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5647
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER,
 RCVD_ILLEGAL_IP, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
 SPF_PASS, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 20 Aug 2020 14:57:47 -0000

Ken Brown (2):
  Cygwin: add header defining GCC exception codes
  Cygwin: strace: ignore GCC exceptions

 winsup/cygwin/exceptions.cc | 10 +---------
 winsup/cygwin/gcc_seh.h     | 19 +++++++++++++++++++
 winsup/utils/strace.cc      |  8 ++++++++
 3 files changed, 28 insertions(+), 9 deletions(-)
 create mode 100644 winsup/cygwin/gcc_seh.h

-- 
2.28.0

