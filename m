Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
 by sourceware.org (Postfix) with ESMTPS id 3524D388E838
 for <cygwin-patches@cygwin.com>; Fri, 29 Jan 2021 19:24:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3524D388E838
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYGSLmo3+yuiRBuhgttujWFSqVepHNbSUJtGrxZelenu7kCwS/aJ/Je62YKI8AjkjbPr0eXI4oH/EBhRl/TtV+d0UgRXuUqG4DcD2W+KZ3au4YJw/ebhOHI1gje9VOiXTa6JnLVOot49npGqPC1m6vX6fWA1RMSibI0yJLv9uw5u0gnl70wNbsnWkJelIcFqsKZvOmev4/CgdUgZzNvprJGJ38rNG16eGZXFM7f4u865KaXys6Z7+eV4UatRJkWmp9U7h1qNPsP5eHhYGjcGaDwBtxbHgPZd2t2O0W6YDLwvvdYdAoEN+hK0L5TeGB9Jqs9wcZvwwboxLBcO9O+dLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OI6O/SBuH1HPgEbtNDa8wEhrQgn8aZLkI0VcbllBSI=;
 b=Enoq3g2jZC80S3m1CJWILWg7782Dn9XblweCiL9Lm+rpXox3nAcDeWcewA+fQ3py/mCNwjNDYjeFgohCQe6K86IF6gvgmKQm0ONmOCuJG69VRdyOLwy/fyn25eagq2KjuWL0NdHHY9jYre0fyU0exjMzLxbJjWsUS6TflsJJqcUV8tY+dCQAEIxLDqwMExM/fboYCke/EQCapLbF1qvPElFjZnqLzIYg5DkTBeDr6Zb8zUpaynTU62E9onLT+E+MzmIs6vntxg+2RDIgi4iKYmX3Xo1RqtJFvjIaNjdcdyPwgPqelbLrdARN3SrSfhf/44sQsVyWwc/hJ14fof7jGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5715.namprd04.prod.outlook.com (2603:10b6:408:74::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 19:24:46 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Fri, 29 Jan 2021
 19:24:46 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/4] getdtablesize, OPEN_MAX, etc.
Date: Fri, 29 Jan 2021 14:24:17 -0500
Message-Id: <20210129192421.1651-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN8PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:408:70::21) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 BN8PR04CA0008.namprd04.prod.outlook.com (2603:10b6:408:70::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Fri, 29 Jan 2021 19:24:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4a6d58c-6374-454e-62fe-08d8c48b89ea
X-MS-TrafficTypeDiagnostic: BN8PR04MB5715:
X-Microsoft-Antispam-PRVS: <BN8PR04MB57158AC08A2B769085142393D8B99@BN8PR04MB5715.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwDHSAs4EXAE3Daq79xuRFrWe9hWVsxqsLsq0kQbwjtTKkZGOriJ5ANKbKBDZEWlixJuzvLWrOX9Qs/WHIEm+2ZEVhkEPLTIuHYbxWIR6h2Q+yvj4wXPxinV5nza98GsM6J57qaJ1D+09ghxO1YnYMOEDnuebMQbkuk90aAlgrKFpNfj09Yzy63Zcisy8pnUNdeE/pn7+u3BHxF6D4MAlxzlGNi7lDltSM2goZWpsTUQQvzr4E2e+IF2TMW5v8pkuVOYPthgugPjPNtjCXEwKi+bhius9VQVTJf3QRhE4lkmNHRg4G7YLMb812/CnFLmnjjXPj9vuUjz1QJThHgbvnD0ILZZ2FMDuUq5IGO2eoEyn0jrFZ20LLfZQsz1LoE8AYv0S+Xma4JTQ/qpugDCcOGVe1ygr6PHYDEpcjMfKVAzqNwX+5DePMjV+5A/8raZJMk3dOwaGWnnlE9vVByaTAE9xiAemNe6OTEfawzDwtJ3+qrdKiGFg1+Hz+UK0rhJg62RWcCHkj0AlDad7W9o+3JedigMxj4kAwPSlsX7SQCvoTDxe+KOdvIpq+cbmrRTqGt0znbZuIBRghIBG1Rtl1EIxmpvLygH29fsbPwtjdRjwyO7SXkPgR5n30C/Zn1ceyJ7mdmlonCfS1kx9x30gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(966005)(6512007)(6916009)(16526019)(186003)(36756003)(1076003)(6666004)(8936002)(66946007)(26005)(6486002)(2616005)(956004)(66476007)(52116002)(83380400001)(8676002)(786003)(316002)(2906002)(75432002)(5660300002)(478600001)(69590400011)(86362001)(6506007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XlNA9oUxy8x9p8+Lf9+0GF7RABnSLO2voong3KvZ/O/0NuXIHwBfp7tnGAL7?=
 =?us-ascii?Q?A8pm4vQ9nRYeb/O9YBENzzj/7snopDJLBYU5aiWthUizBO9Q0NcGMhMpln4U?=
 =?us-ascii?Q?2zIKcPLrMslLA4WybzZ6EY/XFX5Raq0aI7mCUYTd17+YTehxHHaD00OaHhYx?=
 =?us-ascii?Q?r9G/4ZPOhqivVpfGfMlJDRg+Npw5zbP4ThJBovaxd0oPhl35xEY1kl7pB+fC?=
 =?us-ascii?Q?OYvTvVppQsHpeCArJq0OoPku9mvJckhzTmDhss/UaXaPqGrJTa7OJJpC/Ur4?=
 =?us-ascii?Q?sEBDst+03hIZHkVZMWM5Eja7pkwRBZYkKydwyrUjKu1eWoW4bovdJKT1JIJ3?=
 =?us-ascii?Q?Ip4JFoV1jaw0CkL3bumPcu5/AwxIeV8ByumRIyW3aXYHGLxb6vDg0fWDAJkK?=
 =?us-ascii?Q?VAUnH13MELmaBX9AUJ5McSYAHaiVIawM9PN+ZwKOYi/vDLbs68MeqCEmBhaA?=
 =?us-ascii?Q?BISNpiU1C4582+Fzn5FbK56zHYh/X8own6tc0H1LDvnOTJkX3DE/WoeuYgYo?=
 =?us-ascii?Q?KWWxJMiF4xb4g94t3Ra10YHKFAC4wi2ChW3yni6Lc+6LUFKljwIXG1L0xae9?=
 =?us-ascii?Q?47MOQOXr484/lU0m5hDeZ6hnTCk9LjbQ+pol5x1aOtl264Tgns2PLSkdPIi9?=
 =?us-ascii?Q?vy0EK/j58WR2aAsecnfGgKww1Ve9ciNc4TuXBiiDgVroziV2Xr87Eoxm5X0R?=
 =?us-ascii?Q?RKkgt+xUIKZnqGKefxpsOFy0/tQzsTcv1m0aYbavC7Fv84ZNFOQhew8xnznm?=
 =?us-ascii?Q?In0JPyFcE6Yf9ac2lKZuSGcupHCdBzeHGCnmIE1p964tESd16X90Iia+YWAW?=
 =?us-ascii?Q?DpUFe/oMlT5/3G7iiWq0+D1d8cEUhwPlijuDa87lmMItytlGRLKqYW22rnAP?=
 =?us-ascii?Q?fsVl4ClJ41R1tFeAlZo2cd8AG9WVABVHHrUo017NsxbAuJmVwhrzMOBWGr7Z?=
 =?us-ascii?Q?F5GVqxlTrmzlcZmU0wgxJ4eR3vj5fHs345HZqtXEl8SSZLRjcX23iPQTw2Nm?=
 =?us-ascii?Q?cS3kCqoGWbEuFTLuIqpVTTVqka82PKSYqVupJlBhhviw6YxZK+e4ydlsaM9S?=
 =?us-ascii?Q?gJFrLfA9?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a6d58c-6374-454e-62fe-08d8c48b89ea
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 19:24:46.7841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6X+3MmvI7dT0nl+qTefWSOUzqsUXoM1je2Vm8115aWhPyzlI5KEu56fHDfrF2HbXiWTSoLvYjLIosfw7LtowQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5715
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL,
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
X-List-Received-Date: Fri, 29 Jan 2021 19:24:53 -0000

This patchset is an extension of the patch submitted here:

  https://cygwin.com/pipermail/cygwin-patches/2021q1/011060.html

That patch is included as the first patch in this set.  The change to
OPEN_MAX still needs testing to see if it has too much impact on the
performance of tcsh.

I've make a first attempt to implement the suggestion of adding a new
<cygwin/limits.h> header.  At this writing I'm not completely sure
that I fully understand the purpose of that.  My choice of which
macros to define in it might need to be changed.

Ken Brown (4):
  Cygwin: getdtablesize: always return OPEN_MAX_MAX
  Cygwin: sysconf, getrlimit: don't call getdtablesize
  Cygwin: remove the OPEN_MAX_MAX macro
  Cygwin: include/cygwin/limits.h: new header

 winsup/cygwin/dtable.cc               |  8 +--
 winsup/cygwin/dtable.h                |  2 -
 winsup/cygwin/fcntl.cc                |  2 +-
 winsup/cygwin/include/cygwin/limits.h | 65 ++++++++++++++++++++
 winsup/cygwin/include/limits.h        | 85 +++++++++++----------------
 winsup/cygwin/resource.cc             |  5 +-
 winsup/cygwin/syscalls.cc             |  8 +--
 winsup/cygwin/sysconf.cc              | 11 +---
 8 files changed, 111 insertions(+), 75 deletions(-)
 create mode 100644 winsup/cygwin/include/cygwin/limits.h

-- 
2.30.0

