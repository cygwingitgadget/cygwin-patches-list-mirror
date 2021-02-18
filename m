Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
 by sourceware.org (Postfix) with ESMTPS id 1FEFC398881B
 for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2021 17:14:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1FEFC398881B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jELCcp9nN+tIEiKljN0avd6H6XHlXMAuAeNNB+6oZtdbTdJZvDFy854bQa9f6lf1dMq/r9u9/2BfxxVV2I/HtXs+2ZSAZE0zJozAskGD6/wJJjL+LI2R7d/+c9D0nMKbpSLZfZo0invqaRkDix4VCF/EAd7fHJINUTnxj92eizLOB9cPdHYDFtoTIDZUm1qU9FIUl0o2hcG3fMVZ1nX2hf6ZOJmFKBSCCULnNi+OYm9vVW0pwOsyIfVycCB8/ayQ86pL/JEvQtwOE+HZiSqQvLiB6zbyOh7+Zp6plg6UN13HR7tl0l9Nm6x1xy3a03yIw4Q1CYwcVssxxnZfXG0J+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+UZ1UpIE1HmJuIw5B4g6w7OUm4/muBFBpUBiLurQDk=;
 b=IQn17OHSZEgCzD/nbLoBGGFR5XJ6X92AGWc19wUnNPQ62qnsicNlxEh4sSV35dxlstYgYr0rejSkhuTcnegRBgIIg1GNQDO31ulHf2dg1KWonXfBocxrMrurdIXZfXPWMiCnmVbJp8CWepuv22WP/p8clV+lxyn+OgNp/EEqIyB3Hz1jwo+RspvyoEctOq3S82IgNKjsxzVw6ZOAbt9cQ4I0UdS56idygE88/SpQtZ4+DuIUiaypcJknc8a+F9K+LqLQN2ch5XA1mWIpOH0BUfbbhRngZ7tVkc8eskwx3C1/zIxBWb/8Tu4wMkeNOcnSivG7wJZo5kl7BrW0CFf4pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0434.namprd04.prod.outlook.com (2603:10b6:404:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 18 Feb
 2021 17:14:10 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3846.038; Thu, 18 Feb 2021
 17:14:10 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/3] Cygwin: FIFO: temporarily keep a conv_handle in
 syscalls.cc:open
Date: Thu, 18 Feb 2021 12:13:48 -0500
Message-Id: <20210218171348.3847-4-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218171348.3847-1-kbrown@cornell.edu>
References: <20210218171348.3847-1-kbrown@cornell.edu>
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
 Transport; Thu, 18 Feb 2021 17:14:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30310353-5d3e-41b2-0f95-08d8d4309b4c
X-MS-TrafficTypeDiagnostic: BN6PR04MB0434:
X-Microsoft-Antispam-PRVS: <BN6PR04MB0434DB3577ADAA3754E27A68D8859@BN6PR04MB0434.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLwnPwyWWyb4Lk28wtD+sWtJOnWBV9GSXSL9B01n5AerdISM0tWelnQZXii9K6E3Rsn6WWytrfE0iGRQQzFszRKaESVqqZMOapWghwyPl6LzYzKrgUVTLX1s+Nh2qDSVxa2acaRcL+TzKXdDuN7DF6rHv7b/8WTdQ35w13x+S5UfcCe8haNQRpfq9HAarnfqXPhuGnYJ4NCkgq/kwgc6fXmCosdgZPVkqlooOK81iaK+pE4ufNSgiYzDcAdVQfdXe1WMO2KlEZCc8CIur2VRjObjyp5sFfxal/YaIR2Dt3XErQRpenyxuVn24hNdX+CxAXMNapJikLoS2pQ1fYG63Aauhls1GGX52cunuEZJZRBcU5IL1oHlNp6RSCuJzXyDc5efrbWtkM0IX2mpx1s8u8Lyuzhkkrik+SoWPMs2t2AhvYxJt/VDyMsGT6DsIdagkMFrYV88hTaa8drB6dfzaUxuZDTcxNMFsWIf4TbEFXXn0R3sxp3PCE+/pKi/oh22tsaqtrNk+QSv+ufRG0SrDZJ5zribwrmAvIpSfPf/FmovAkHXpCgR/IrySoeFLmrrmUBsSlrf6um6eP7Pcq2t9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(6486002)(6506007)(16526019)(83380400001)(86362001)(5660300002)(66556008)(186003)(66946007)(786003)(6512007)(52116002)(2906002)(2616005)(478600001)(316002)(8676002)(1076003)(6666004)(6916009)(66476007)(8936002)(75432002)(36756003)(69590400012);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SD6qAG4OCsVQMmv7VhGn1sw5r+ExjVRmjqVjhRNW2l8Frud3oiWjzlfaxGLu?=
 =?us-ascii?Q?UIi6BOzUzL/vT0bDCF58Y2ShFe4kDSejBCheog5keso3dM+mT0qAc42dhUfA?=
 =?us-ascii?Q?IAebud6wO38G9bYeUc82Zv2l391HvHjtpbmYDV0yCHrKoEK/Rp2T3WVTJjvc?=
 =?us-ascii?Q?Ls605J8ZNWxbAebRbLdDPcj7aIKxXuA7ROn9f+y1G0Zu7+yaZbO5vXH+JCZ/?=
 =?us-ascii?Q?i4rpQjvpDDgYaGdtaOyIAUMKWthjk8hnESyAM91MBZ6RkRtz+jHCHJ1ad67k?=
 =?us-ascii?Q?IGzkTZz4DyXLup/iNSIW3vunrlB27FiDXWc2vq8ZmdkrkJxLeMrwZR3kJJ8k?=
 =?us-ascii?Q?EQxc6sQi2qZ4037a/QoMDcDbMa2tydjsJ11SG+bJGZMDoY85IVRoQzTk8NMA?=
 =?us-ascii?Q?177Yfd3O86/HHi/oDXnNeBwhjR2eLybK47H+lRxM99Yuifv3EyNUrTYOHqXH?=
 =?us-ascii?Q?nmwyTc2H99GsfRWQgcKSr1p3zyQVoyT14CzoVlcKqijeYmfpf1j+Mi/a4Ekr?=
 =?us-ascii?Q?EXkYS9URhSz/N0M13vl7M9WKOpzjLCMScpnHmqnGkndSXz2m7yQIhDZy+y4t?=
 =?us-ascii?Q?xA1CgfjchEfT9yNHm/w+b5gMvjrzblbL8+g90rLGystMhfplOpCRdm9WwfzJ?=
 =?us-ascii?Q?QvAmPYufX+GiGuf9W11Kg4POeewjdef9J9vwyB07UHYGejAnT1xBvyKwmBjC?=
 =?us-ascii?Q?QmvhpB7Bm8HDIM3yFJGE2eEaeONPAfydSedkwczv4sGtdSG/mdu1e/HeAgUO?=
 =?us-ascii?Q?ipiz8Bd1tXDpkcmYDqmgjYEOgwPNqazttrUD14eXV7yLwWVvt0I0hZiA3Y9X?=
 =?us-ascii?Q?U8CAJSIRwws6FOQ2DvFB1F4snFOH5+cyHMPnGloNw6Me7hYEbeHYSK/8NfKP?=
 =?us-ascii?Q?FtWNnv0LJ+MK2xFwZUiet1Jf1+AEwZsV6iPRcosBQqsrwFXERsv1nabNQXrS?=
 =?us-ascii?Q?IrAmoISlHTnmAkNsNzfkJlJ1ok5BWMV9dBW9pJ1iH/mquNVsOKxVaRwgMC1B?=
 =?us-ascii?Q?xE8MIfXXuAlIXVO/6dUP927mGXkNdoE+qTO5xo6HtJFMPv6c8b5fIk21kEsZ?=
 =?us-ascii?Q?7/SiFeT9IRyLyNW4gUE6QDEiL6qnnbvkJqBukm8Mx3B7Vbu3NouV2KOIBHTS?=
 =?us-ascii?Q?GGWrG0etyq4JTvVJIJ6JMrcx3aOVabAyZWynet0yb245BdcVWnKUCqJo7Ihp?=
 =?us-ascii?Q?UdpnO0NSuIZgLoBIbMZhu8MNxA9cuTXm0P1knsWLnSa5gsTvR0qyJia3wIMB?=
 =?us-ascii?Q?mEt2VxIpvZ0WusF+DbF9LsfPwECSiVOSFhqOMpF6Urvm2hZzTi9Tybda2zsz?=
 =?us-ascii?Q?JLwt8bsSyttVKUJDu9U6rUoRJ8lbsjHEYRpG+QJ3+ozdPdLYMM4RLlOixmrp?=
 =?us-ascii?Q?mfXJpLv1OQ5LmPqhe64zCYSRWVJy?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 30310353-5d3e-41b2-0f95-08d8d4309b4c
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 17:14:10.5714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvuwPI3klca+ox9ma4jgA6btqm3Uy0B+eYeJNhJJZvofwnM1PrqLw5mwjbw3Yi8B0/whw7X9FnKeBrsJ/HiBYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0434
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 18 Feb 2021 17:14:16 -0000

When a FIFO is opened, syscalls.cc:open always calls fstat on the
newly-created fhandler_fifo.  This results from a call to
device_access_denied.

To speed-up this fstat call, and therefore the open(2) call, use
PC_KEEP_HANDLE when the fhandler is created.  The resulting
conv_handle is retained until after the fstat call if the fhandler is
a FIFO; otherwise, it is closed immediately.
---
 winsup/cygwin/syscalls.cc | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 32a155a1c..460fe6801 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1487,8 +1487,15 @@ open (const char *unix_path, int flags, ...)
 	  opt |= PC_CTTY;
 	}
 
+      /* If we're opening a FIFO, we will call device_access_denied
+	 below.  This leads to a call to fstat, which can use the
+	 path_conv handle. */
+      opt |= PC_KEEP_HANDLE;
       if (!(fh = build_fh_name (unix_path, opt, stat_suffixes)))
 	__leave;		/* errno already set */
+      opt &= ~PC_KEEP_HANDLE;
+      if (!fh->isfifo ())
+	fh->pc.close_conv_handle ();
       if ((flags & O_NOFOLLOW) && fh->issymlink () && !(flags & O_PATH))
 	{
 	  set_errno (ELOOP);
@@ -1555,9 +1562,18 @@ open (const char *unix_path, int flags, ...)
 	  delete fh;
 	  fh = fh_file;
 	}
-      else if ((fh->is_fs_special () && fh->device_access_denied (flags))
-	       || !fh->open_with_arch (flags, mode & 07777))
-	__leave;		/* errno already set */
+      else
+	{
+	  if (fh->is_fs_special ())
+	    {
+	      if (fh->device_access_denied (flags))
+		__leave;	/* errno already set */
+	      else if (fh->isfifo ())
+		fh->pc.close_conv_handle ();
+	    }
+	  if (!fh->open_with_arch (flags, mode & 07777))
+	    __leave;		/* errno already set */
+	}
       /* Move O_TMPFILEs to the bin to avoid blocking the parent dir. */
       if ((flags & O_TMPFILE) && !fh->pc.isremote ())
 	try_to_bin (fh->pc, fh->get_handle (), DELETE,
-- 
2.30.0

