Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
 by sourceware.org (Postfix) with ESMTPS id 119B33950436
 for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2021 17:14:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 119B33950436
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTEzak4luKNjR9ateQAYtn24G4sjyxezEmqpFgY32T8qRipvJx4g1cjLdIvD5uRoC5Tbisb8v/2U8mOgCibZg5UBao0IJe1RSqouV6B03g4wvUDRBQ5XkCaXTNs5ob1Vzkqeeulye1vKNQKFMoAzSipkWNO1aYtEJaSjD/rxDgB26qN7BL8nFcWDeX6vxLnmU3o/KEjgrb2/W9jQZixQNXK25pt3WLegM2vv9bH0MXJ8IPCOszNSazCArL0OUKaIi99qq3ERARWnQOc8F3+PQtcJJ9DHhNtJwrL1cIkcclvCSlyHxfa4Dk4ercOzBjU26Z+5tzDKahXhiJeAvteGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xktNugp0P9dogZnd4ZwlMYV3W+/s5gWUfTMP5J+MgQw=;
 b=WWy7QSVYWFnn14iJQdZfLm1+fA4ngCohpH+iXw0plwpbyt5MCS9k9wzFP3hWfIeae1pjrl22VDBJIfMow5TyyFoBk8P8+PWzWyxRnqdpG4BUmTqJFlQej8XtGcz0IXjO6YfF1Qu/5O3AUZ3BEvKPJgsrQNRkWtf3Lm2y3HhRgWTsijPMEn4/ka+OpvImhnOArU463X29yiKBKSC1gGrPDBkuwNRWZ+UFBOru74/3fdFEnYSc88+7LZM9ICtrYy0lGVIAgXeYCK+SmvY22XTnlb9uYEokH0NXyb+zGwrEJFB5SYeeRvX/fInTobXSmVaODtfoj2VdwavEJFCHFMUGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0434.namprd04.prod.outlook.com (2603:10b6:404:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 18 Feb
 2021 17:14:08 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3846.038; Thu, 18 Feb 2021
 17:14:07 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/3] Fix fstat on FIFOs, part 2
Date: Thu, 18 Feb 2021 12:13:45 -0500
Message-Id: <20210218171348.3847-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2603:7081:7e41:6a00:a842:7b47:be73:d167]
X-ClientProxiedBy: CH0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:610:cc::10) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2603:7081:7e41:6a00:a842:7b47:be73:d167)
 by CH0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:610:cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 17:14:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fe7f269-bc02-4e4e-f2ba-08d8d4309993
X-MS-TrafficTypeDiagnostic: BN6PR04MB0434:
X-Microsoft-Antispam-PRVS: <BN6PR04MB0434C21DCB0BA9A3B006761ED8859@BN6PR04MB0434.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVYKtSgTvisIOWhkthPVgDXgo4FktxLMFUMjLdndkVb/WzhjQj89NPtbXEqs/Xg4PSRb4ZjjyNUtH5XudxqPC4v6/2yLVHq++rom++c9zctjOntLGbTHB6azetrXKpY2wvvhpZAyUb6mTI+2YinD8grzWC3fvQbOMqd+2/ylk9RPksBtYumiBCln5ZYntTSf9Pek0Ka9pRK3zwD5+RCb+Tw7VkFXs3PJNEyeqmV+VIThRGWbcYw7Ck9D7lgkdkKTNXIVxPWUUaXz/BKdNQ4JZswknsDfVq7uqaCslG5Ze7M9w0dLOlpSkfaYhIuEJJTpVmWCZL5o8HYtxQAkFBmtzzXpU4rnorKavPiLnPmcAkYS2eqScqUDKi0qgjqMTDt0+ruvcQDsdVzRAXHQIQ5pCy7/CHDyDMAf66g1+SlOQGJ8/S3RDfjV6W6EROdn1X/yVvvdoxs0PSrHR8J/A0hdLgfQT1+QOxFu9el3a+DnRwu2h8zL1g7FtJsepSt8vCSCV4upXoa9iec1lPIIs8J1q9nYQPxJN4YK2Xy1o11B6xsszN3DXtNfrdmH88MQldMgTCOWRybFYxHT23C89vTXdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(6486002)(6506007)(16526019)(83380400001)(86362001)(5660300002)(66556008)(186003)(66946007)(786003)(6512007)(52116002)(2906002)(2616005)(478600001)(316002)(8676002)(1076003)(6666004)(6916009)(66476007)(8936002)(75432002)(36756003)(4744005)(69590400012);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ACTSvpD7kemcvZdYGeOh/DW0u8s6282KDNsBOdR2uDnCEyyTiJm0c/qhYUpI?=
 =?us-ascii?Q?sSWN5JAvxo+z1yiRgX633ERqWhYV7bK2mrpQiDbUL0a3Fw5mkf6tf7uJHGCV?=
 =?us-ascii?Q?K/o+Ii0mtnX80oc/90TtVtdjPCuKDnDxu5k4TXrZZtQGG1+SfxXGCBVF4ykA?=
 =?us-ascii?Q?vgNi803bqg1irrELJ0qW6JPN2Gi61KC2RQUGcnTn0EAA+ZzDWBgfiHAs3m7o?=
 =?us-ascii?Q?9Si0FnUAZC3QxKsT6YFwCncEYibzrZQ7LWepXLPE5dzFxgAAy3VT2WIiJ7DR?=
 =?us-ascii?Q?FKriObGV++0ywqnigAEes1keA5Ojtqk436P2z8Y230iZ8YpM8XsIgpe1Nkux?=
 =?us-ascii?Q?epOWNKWLCC9JGJT3KxFuf+xT7rwt9HVzKquz26JouOtD8sRS30ckijtD2NFU?=
 =?us-ascii?Q?jYOgqMU8mmhd4BOlwiQ0cvN+PYX+9rMFBmxGYk2kQAWMDTzHETz26/rVd1tQ?=
 =?us-ascii?Q?QkwcJSbsTiZjNeWkViY0sprsgu/f3JNCk6XLjig+GhyPBKDyyOV6LW2sD+iP?=
 =?us-ascii?Q?6MmlYcaT6rUWF8Efr5YysSJ3Wc+oTu6MDxhOKJeROPf89sLGlauhciWmKjSq?=
 =?us-ascii?Q?5G0aNiGr8PH5WK5e+b+Jrm93pLqqZRsDMd3z7WJQI6tGNAqXkWHolvsio1R6?=
 =?us-ascii?Q?o7xDj/FoW2/hmw7+bFCWTGFUVEA2odclrthBRACNKF9MOunsEfh15eW7kex4?=
 =?us-ascii?Q?ATV535dVdPpcAFRXV2VsHQiBmXU11ldzBvK5hqTVtP2xNsdsANY9/M4r1P9r?=
 =?us-ascii?Q?2epdM+hVSlob98szNafGf0vlb3KuscHMEQItNmKIfuGyxWZgxFsh0TmUjcc6?=
 =?us-ascii?Q?sj1vGkbTv2ZYejudPef46BUADwji7vQgE+w7niLiHIV41YC+AUAi3irD0oW9?=
 =?us-ascii?Q?EZ42adnwA6Dgr/fRVh8FTQ/LkdYDc0GSipeu+okh0forZUFNwTRi4GD8Eyzt?=
 =?us-ascii?Q?kUtEFURH9SpL4bfFxjI8F6PyJUIoL3WjuZZc1DVuB1y89XmYpGUwG9rLou//?=
 =?us-ascii?Q?oyfBkTKBuDnSXvIDYWn3AkU8DZ6qMA6wry/Wcf3n3xKtEXXtTqozwoJYEgDR?=
 =?us-ascii?Q?Mk3dZosIQWDfj08IQ9Wbb4t8zzIXnLcrIiriMruYhCkGbEKHZa0jO6XyQ3gN?=
 =?us-ascii?Q?bLA1p72xjGp2nD8znQqWY1r8fvK+Xb+CmX6XI5pJ5z2dxFV6j5zTod1uQjSB?=
 =?us-ascii?Q?aJFErw6cZlLd3AW0q40iKLAQy0dqhr2SaNIPEGT7fLH8eshFZYUFS7lezyHZ?=
 =?us-ascii?Q?MGttWMCxsan4H9kMOyvkczjD0pKP4JZPx/nuEjZS/Kd7F5Ccw5xpEltaV/hu?=
 =?us-ascii?Q?yXa7e3fDY02Go5SlYwjby/PzcMPUuDHGrL9x8iFWNjbXNovO52fpb4Ox66Q6?=
 =?us-ascii?Q?lJWQbBVswNVhlofHFDJi6aatamy1?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe7f269-bc02-4e4e-f2ba-08d8d4309993
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 17:14:07.6232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIHSkIPDclCappMbH7kOCmCdaWEf7kth56frhAmHwqhPslIK0YMkCIbgyKvs1vi8BPjERAD5L6w98m89R3MYYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0434
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, KAM_NUMSUBJECT,
 MSGID_FROM_MTA_HEADER, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
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
X-List-Received-Date: Thu, 18 Feb 2021 17:14:11 -0000

The first patch fixes a bug, in which fstat on FIFOs sometimes used
pipe handles instead of file handles.

The second and third patches should improve the efficiency of fstat
and open on FIFOs.

Ken Brown (3):
  Cygwin: define fhandler_fifo::fstat
  Cygwin: fstat_helper: always use handle in call to get_file_attribute
  Cygwin: FIFO: temporarily keep a conv_handle in syscalls.cc:open

 winsup/cygwin/fhandler.h            |  1 +
 winsup/cygwin/fhandler_disk_file.cc |  3 +--
 winsup/cygwin/fhandler_fifo.cc      | 23 +++++++++++++++++++++++
 winsup/cygwin/syscalls.cc           | 22 +++++++++++++++++++---
 4 files changed, 44 insertions(+), 5 deletions(-)

-- 
2.30.0

