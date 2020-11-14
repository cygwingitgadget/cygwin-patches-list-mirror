Return-Path: <kbrown@cornell.edu>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760099.outbound.protection.outlook.com [40.107.76.99])
 by sourceware.org (Postfix) with ESMTPS id 4D71A3857C78
 for <cygwin-patches@cygwin.com>; Sat, 14 Nov 2020 14:16:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4D71A3857C78
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erOzBFTEqbmHqbxd2EeR/xUQA0F/VNMuwFoFn2cHCzxPLUlCqfcsCyfMxuaibGou0w7N6Mt0Uk8tmcgz1nfEN7GmnL1tE4HczxdMQackQ6fxousrNdizsgre8X7Ki7EO3RxbVLIR1tD+jkNvJXDEOa+EPyd8C+nuBWfq/Aky9sHLixZOn0HRz8aBblXdZHt/R6EceWVlq+3TC2fDQL0MDKeIQlUaj+a6u9GuNsF9mDns/RbLVmXhHiFpK+zzXwt4+aNzPQ5HorulTexg5HmHQb3CnaW/9QIntRGdJo1YH6fuZRiRqtqArWz1ZLmZdTpamRwN2w40mqrvUQLF7wcg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvdu4de21lsujUDNjYR5OUuPvAqBKzdJ/KiA6NnMHE8=;
 b=AtShIOyshR/SJsi5GK3D6PQpGGcSw0Z0L6zJVIis1ElAyYApoZ07JpBmZd4F5rlPEQHhJnAG0awTzk4uBq3LsraMC+GglmeNhlpJiB+4Bm6U8m3NWkCoc75it41PFrKnpnkqJk7SLlsMF7kXJpF2rgx6tuc+ba4XzHpYGGhlyyVz1flni0iSsINJ1Roh7SbOdjMuJEcDtZIEBFs4ZWwZjMsBbYyuzhWiJQKnUl8lUzhvpGAe6FRT+gisyly5E2um0S/YNX3ODwn7EK6KIZvI8cQ6MAj0/KNcLZU5lCpFAtmeDj3hZnvFI5T0IW+3cKRNG/3HEHGYA64wYfePaNci4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5838.namprd04.prod.outlook.com (2603:10b6:208:3f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sat, 14 Nov
 2020 14:16:44 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::113e:c874:1207:eca8]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::113e:c874:1207:eca8%6]) with mapi id 15.20.3541.026; Sat, 14 Nov 2020
 14:16:44 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: path_conv::eq_worker: add NULL pointer checks
Date: Sat, 14 Nov 2020 09:16:25 -0500
Message-Id: <20201114141625.24465-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [68.175.129.7]
X-ClientProxiedBy: CH2PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:610:59::11) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (68.175.129.7) by
 CH2PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:59::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25 via Frontend Transport; Sat, 14 Nov 2020 14:16:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9700aef-f1ae-4f5e-39f7-08d888a7e9ba
X-MS-TrafficTypeDiagnostic: MN2PR04MB5838:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5838D80CB8B8711B81AB7086D8E50@MN2PR04MB5838.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQ1vo69NSLiF7T/H4w/KHuZOqe4HhjL+7FX0ep9zBJDaR/hwzyBAgaMFJAsKrhAG5tj0ggtF6Za9XLtLhMBpSSz0slE0kgtgUBoM8PGJiPewq2PUfvZr6qUebdF7z2VltzuU5b/ZmUftZ4yjYMjTmB2X/KIEgnhTgRYjADMmBKb4S2bddC/+AgmzlMVDkx1mhCQETTL+i6d9ZqyZIGk4dHXPquFXiowdHpuaxjnrHxC82ZdRpNMKYfR5WvUTarH4+RZKWfmVdumlu9panrAsM8XiwALinw1ZFsdsyQqvH///uVS0Jgy4pBZYd9VRAOysIVBEAfJ35F9033uktakmXYX9jlL6Cnypt8+dBVEuK04iK+rpyj6qqOVjDuGc9Ky9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(786003)(316002)(2616005)(2906002)(52116002)(956004)(8936002)(36756003)(75432002)(6506007)(86362001)(6512007)(26005)(6916009)(478600001)(16526019)(6486002)(8676002)(66556008)(4744005)(69590400008)(66946007)(1076003)(186003)(66476007)(6666004)(83380400001)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: y40xUPK0//ljbRC76vROLj32KEYiFg3oDtJiQhsqTSj4W+vPHcdeBWvVB3/4qFjNL33NDAyRoY5X62hQ0hNbpanwmIN6F7RvDKtdrfKjr/L7GVi39I9L2k4PELJth3lARFZ54ZeC5CuzPrhpYy4HJ/adxRqS0GzNAZLzCbDOAHgSBBqsaURpBzJyoamOb1hZsAWpLgtCOvWKy+bnFkQMsNkOOXmaDqlyn3d9d93xCmqJrUWAdWRQO3xZU849+Rzs7maS8/75VD7zE+DRVRjB5gTm5Zje15YeGHIc3etP7vSdAioZ+QxwmG68hgnSdkrZautzradUTwMcTo6kg5XN6YtbVjOfJRS7bd0vlwzBulyNqrn8ktjLnM/YL5h9p1ezli6zxh9luRL+4mqmWKymConXM71bMIKkRXAXkUdKBicXHhb0F8atp4VWKre8P6JAF6zMo0cJbP5GLmdNv6PUE0TERylmSV4FHhjGHE+m3O5ouXbxjM2fhcB5pBGUQhKciY1yHIMVUZ4KDqyqGVb1rdrmVHLq3KfmfCp7o/HN1OwV5rDVL5Eaqq4AtfbEzl2skibM04NPhGjIv9Oi5HLMpVklgDDuuTgODGoN+HyoPEkYSmFPmfkaAGyiW9LS1QWADymiPHKa7pPEq8wSTWAPfg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e9700aef-f1ae-4f5e-39f7-08d888a7e9ba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2020 14:16:43.8405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20Or7PQi67z0vwV8ruZN4Daiiu27RwptrAq3hIQShMmUPcWmDnCSM6txdnfuMag41JQDCis/fRRbEBKQu/gF1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5838
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sat, 14 Nov 2020 14:16:48 -0000

Don't call cstrdup on NULL pointers.
---
 winsup/cygwin/path.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/path.h b/winsup/cygwin/path.h
index b94f13df8..0b3e72fc1 100644
--- a/winsup/cygwin/path.h
+++ b/winsup/cygwin/path.h
@@ -320,9 +320,11 @@ class path_conv
        contrast to statically allocated strings.  Calling device::dup()
        will duplicate the string if the source was allocated. */
     dev.dup ();
-    path = cstrdup (in_path);
+    if (in_path)
+      path = cstrdup (in_path);
     conv_handle.dup (pc.conv_handle);
-    posix_path = cstrdup(pc.posix_path);
+    if (pc.posix_path)
+      posix_path = cstrdup(pc.posix_path);
     if (pc.wide_path)
       {
 	wide_path = cwcsdup (uni_path.Buffer);
-- 
2.29.2

