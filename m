Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2113.outbound.protection.outlook.com [40.107.93.113])
 by sourceware.org (Postfix) with ESMTPS id 029AD3987942
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 17:52:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 029AD3987942
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxNRRQ/T9vjUNWSi3fCDSUnQhKHW2jvv9IsvfkQhLESafJExjtV6xgi2cSuqNs8+CaQAIkdJc9sKtpfPwKvdx4lD+yArSrUnxu6EPhq9TjvawixqYSjzQppBTofabK9Z03885Na4qXxKTki081BaKefRV9B0h2qQD8HWdpG9d9oX1vh9n13MSu9GsXWiKLlYjeCKUd2wLwD/wOMSg1PvzadEu2h3p6uRKbqu59Ad1eF1tWp72KMUeRxZq+bMYe+2N27quS/ZzuJjZ50SRt3WTkRxfw4UKd4b7sWSZb4DtoTlWJkS2PugOKu14ZCO/UdV4T+Ui08hjw4d12czGkzLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvSIviG+N0ecbTAfcjojbeD2bSy098xEJ6Ymwebn880=;
 b=DjJ/3uC6467AEp4lFRXhrRKFHN+BZ+RQtm7P3lg9PDG8f8nfGe1xtMuS2tmrawoHb01fsqzhT8TZFoXWpgpzK+Hn2LMmnjpVtM9eu53ymOjeinC2LpZG12WcUwS9BNPZi9uPsswSSpVa773A4md9vRxv4A2Wts9ID+DFH1kelgvr4DA1GOh6Yck/yF+oWeWZcaYcO3Hvs44vozsWipBTPy19hSZA42svBYAMEJYjc9O3AhV9NXMPR2SogN7MqRZ0lERDsDLgsdCr8BiOhyk8kvK7xsZaVDcQjwN3NAEnnltwE7LNiMcpEBNDEQG6v/4EqLczFz6MKkjgRamrqvqP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6387.namprd04.prod.outlook.com (2603:10b6:408:d7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 17:52:36 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%7]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 17:52:36 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: document a recent bug fix
Date: Fri, 15 Jan 2021 12:52:15 -0500
Message-Id: <20210115175215.16678-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN0PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:408:e7::22) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 BN0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:408:e7::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Fri, 15 Jan 2021 17:52:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a76254df-b6f6-46d8-7531-08d8b97e5793
X-MS-TrafficTypeDiagnostic: BN8PR04MB6387:
X-Microsoft-Antispam-PRVS: <BN8PR04MB6387D609A46851D1AD7A00E9D8A70@BN8PR04MB6387.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:124;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2DyhtX2DndgPhmAFbpmAWLHSbXpIWrBC23fAkg7pMChBrom7G85m2L1gkO9q3gKKGam0WIdzxwYfhCWsPJnfih4+DdbvnUTq39HC6Wa93Xo8lTj0lL2rwfdKod7WEccuo6Zw4iPoj/Qhovo8TiYcCUOi+hz4aBtxUwGSTBlxD6dcvWeYYspMnWbqcBSa4HnCPmElL+vnMVTYQelRrdcv8/KmknNLmqSDgb0qmdxX9khU0S/zF6mXd5+WBx/XQu1Sk0SiXm6V/C3cdn9furUd+sXyEBPTznr20U4LUaOtV50bG2DInC8XALbwNCmKjUz7vfkufkYZfTGWsGUIHt0dCz1Kjrh96/WsyVqUDl42GrlSQr/9nyrUDKD+61glpXtA1ASWr5Ih59kxtPK3Z+xcFuIynDKbHXgg4OTGKBC6w2HlVa3QOUzExCvTXPMgg9bYti+lEVaKnEETlzudc23Q5/PwAuyjd0YOURW2Bc6PvRWSvtqi1+SUjm0B/zyoxfkxwA495se7ridrGS1F92j2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(1076003)(75432002)(5660300002)(2616005)(6512007)(786003)(6486002)(316002)(86362001)(69590400011)(52116002)(6506007)(26005)(66556008)(66476007)(6666004)(2906002)(66946007)(16526019)(186003)(8936002)(966005)(36756003)(6916009)(956004)(4744005)(8676002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GAMaxshyE39D8Z9NLQj4sqXMRUT7JUhNhtrpebwzJcFH5O7l6yPf7ZibjdGi?=
 =?us-ascii?Q?rfbePNKNvXU4YVPmEqpDVUCM8BlO3oOLQJ66vEdh3bnr2r5xUGQToYRkPQEH?=
 =?us-ascii?Q?PtjbKKLLF2EAvmGcWRgRYntaAspQtAugkCOPT4bR2Gqjru56qpHU9+DeI753?=
 =?us-ascii?Q?75oniMWO9eQ4fs3fx/dK5BFotnKMGryLw85UL7t/QOLknciflqaj5yEVD5Yy?=
 =?us-ascii?Q?5FkbIjJOoLLyGwXAYWEUxK6dRSHP/H97bpGux//UyrbV3X9/SqCZ3Ht/hpGf?=
 =?us-ascii?Q?6Y0pUN7Zl2FSvcQlstBfBEH1eAhz3bTbcFa1QifxQ7nNkVowvHkBOue0SFC2?=
 =?us-ascii?Q?Reh5Ej4DgVbV9hYl7PzHDFMLoPZlhS20i+blS8NvKvwMnjySpP054ZZ7LWms?=
 =?us-ascii?Q?i1i2U2Q4YVgBaCJp8brsLjtJ1oCrHFUTi5OHZ5h6s0TVfxNJ61kUkCDGfFq+?=
 =?us-ascii?Q?DtuXCXyPyvP9IVEmCktmyWA8V5EBfOcHsNVxezWHpjerTLOmTpos5pro3O9K?=
 =?us-ascii?Q?g/yv004cM/hVFxhEzAWJlShpeVMq6zfQ5b7puWSwDJQ/DZm0U9sCOt5YjDFG?=
 =?us-ascii?Q?FU9yPtVA2YDhRH4mt4xR/uO1Jp0PwST5lUqxHMW9qsw4rJluwC0+v4u4vWfC?=
 =?us-ascii?Q?RQxgVLKedMVhytp9Vb74nBlG5C8AZvD7pbkHOhB3meMfEYMK5omJokfsezZ+?=
 =?us-ascii?Q?aiIud4lzCS7np4DOjo+cXOMPTVIQDq1otBKydDGUUbL/Q5Kg2eqSZOO4SAGM?=
 =?us-ascii?Q?y6uK7nf+E9SWHuSCuGtKJUk7PLjMCYpu9O7KVrnscp3MDWfv/SMi/lavURRE?=
 =?us-ascii?Q?5iBQf9OQogwr3lL53RCAh18RHORvqIif6cJaHCq/lKhqvjkEC6kvCn1+uAP/?=
 =?us-ascii?Q?S3XrKGEPShLjFdTBEpC1r3WZLFF5AKEAzRBSZtWiRCVF1jBBx82BblFyk9rX?=
 =?us-ascii?Q?WnH5YcQLI9cyxfqc5JzvhXyjCJZVQVS1EPUDpZYPLM6+kCRm+BKIqzR2HAdD?=
 =?us-ascii?Q?cMqb?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a76254df-b6f6-46d8-7531-08d8b97e5793
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:52:36.1053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kye2nVu2fIiJ+rugmaO+WrdQIrXwO6E8w4UY7KsbThVdKFu62Zbweb9Q2TbfBGP8U8Q/oHmkKb4qjsOcpnJQjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6387
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
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
X-List-Received-Date: Fri, 15 Jan 2021 17:52:38 -0000

This documents commit aec64798, "Cygwin: add flag to indicate reparse
points unknown to WinAPI".
---
 winsup/cygwin/release/3.2.0 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
index 132d5c810..c18a848de 100644
--- a/winsup/cygwin/release/3.2.0
+++ b/winsup/cygwin/release/3.2.0
@@ -43,5 +43,8 @@ Bug Fixes
 - Fix return value of sqrtl on negative infinity.
   Addresses: https://cygwin.com/pipermail/cygwin/2020-October/246606.html
 
+- Fix a path handling problem if there is a WSL symlink in PATH.
+  Addresses: https://cygwin.com/pipermail/cygwin/2020-December/246938.html
+
 - Fix a bug in fstatat(2) on 32 bit that could cause it to return garbage.
   Addresses: https://cygwin.com/pipermail/cygwin/2021-January/247399.html
-- 
2.30.0

