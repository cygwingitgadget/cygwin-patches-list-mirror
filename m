Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2113.outbound.protection.outlook.com [40.107.94.113])
 by sourceware.org (Postfix) with ESMTPS id 066F33857C71
 for <cygwin-patches@cygwin.com>; Mon, 26 Jul 2021 21:04:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 066F33857C71
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfjPKSNG5NUBM5XN8wgdI5IZ7MQdS6BYvguPB+16ESd2xzIiqZbw4xxehv/0gb92JnoBKVQHF4RM9yCC3Jahqt7raVaqle7wrUGpZteuhj7TmSw+aoKLctFFJ4agOtiVc0o/z4OyabkGP68oMsj6CJxgX+QQbEOG9owkK4EZ4nhY2mNP6vs9RxfA9EUKcB+FrYoZgaGF2AaXV1EblkkMyM7OuyeXcPDSMaywLD2JRAMIUMLoznIAnxP5F97nz7uM18dPb4HVrihDbSZPqWXGJZ3u0m12CGk0pD9kk0rXQSnx+nRMTYPhVOrpC0xZ9RSCGrzoVQEyVsP4CYd4I9eHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWBbSgWUB1BYpw3NAxhGC5b0o1U+vZ7aUgBgcjWxz3g=;
 b=T/DDS3UT6ym9EWbdwj3ThR3fkXM8jUhH41V3HuWy07PyfDg36os9PmPX4f6HgQN6hhcToFmw6Up3Mu8VablueewSilc0KAEX2jCQe/r4WHkiKNd7dUFqsBqHclLjpy234zLX8kxQe3QZ3MKEy7jUg9ZkyUivhdJwDrVy3VPbhzkeutuZ8vrS7q7nu3ASG+Zr9YhyLXzS1X5nD4HCrgo6t2AEBbjVKDcbptkHNbZZZBroGzXJxg4SOlw93dGc/Peb4uWt3mXHl6cixkwaKnXHkYz+eXbZPrbmc0OgtDX/I87Ue0lJf0JbBNZhSfUeXUdvhzcKsixcVpPT/XBd9u1Ncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWBbSgWUB1BYpw3NAxhGC5b0o1U+vZ7aUgBgcjWxz3g=;
 b=XqktMPScO02QbZYfF3AilI7bnKmKOQRk4h8hUi5R/p9VIYuSdYz4forVqrc5lf/rFeI+tXepHdCOGeMmo80lwS3shcMwhpq2/io1H8DDeZEIIZFoqIxLrI3k7J6wtFA3EvrA9VXUEPOX2h6yGSgQu6FQCddFNRYpp5b3n8tEWwA=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0354.namprd04.prod.outlook.com (2603:10b6:404:99::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 21:04:11 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::cda2:359c:cb66:5c42]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::cda2:359c:cb66:5c42%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 21:04:11 +0000
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH 1/2] Cygwin: getifaddrs: fix address family for IPv6 netmasks
Message-ID: <63cb52fd-9014-03e4-87f0-83831574e94a@cornell.edu>
Date: Mon, 26 Jul 2021 17:04:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Content-Type: multipart/mixed; boundary="------------70D2A61BB5CDBB5809F9FF49"
Content-Language: en-US
X-ClientProxiedBy: BL1PR13CA0259.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::24) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.19] (24.194.34.31) by
 BL1PR13CA0259.namprd13.prod.outlook.com (2603:10b6:208:2ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend
 Transport; Mon, 26 Jul 2021 21:04:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c24b549-5a44-4f72-20a4-08d95078ea73
X-MS-TrafficTypeDiagnostic: BN6PR04MB0354:
X-Microsoft-Antispam-PRVS: <BN6PR04MB035493C052B029D6B0A85767D8E89@BN6PR04MB0354.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kD1xD1wK5y0kEyMbmYNnj64J1WS4pDq/jdRaZfDtbFdg8gRFXSvrd59GwWlXOQ/AWDcFLHwk5BG9rknwU2lmuA9fnKYTu8jQweuuxY7UVgzp9vND6AdBPJQ9TWXuebXOBcD5e2RV0IJaaSyF2ru38MG51BxiAezI8BeS08kDevLHHNKbOPvqyCzrbEnBykg49MVyW3wm+z8HnbS0YcMvlVzemTGTnabSie773lBLHNU01CGZTOMCFg9l083FzK1Uft8i7PMjBT+U8J9jPGbc/lhfSF73v2BqscuOUgS3Ky00La/9HwMggK0T9RRbR5NXuP3jqiwHhXMWybZBL+iUG6KxKWV/KkUW7p2tcCNaNIJLlc8fXp/7m4h+w6bRyDI47RrukP4YA9SvG/2/hrFn9TG8h6jj0TLIVBB+XPyBBA8ATJK5ynTA250Y0P2jbvVQLn5gEOY+w284Xa4X7iU8kzaso7e5sg044z24EACesk2lToxcFj1KnxUHifd6Oi/ENzEBYhYRCOCuaP/+MVGMs/B+YY/FqkILrDtmI93UeBTiHnZDGuU9co8UVIc48WvJcJrfH6eLAMqoZOzm7qofCSvG9CNDwjWlfmF2l2fZ7gVXxbX7bUc0hiJ/80l7Yl5Vfi5XtnndVLVCZI/FxGjM85r54BSyQQVejEuDz3Rx5NswE4zs5xTfekSmTHhy9EwXFl+b2X0zkW0K6gqKPwG+HVBUPr3TXdCt8O73D/8EcYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(6486002)(33964004)(66946007)(66476007)(38100700002)(66556008)(75432002)(36756003)(186003)(6916009)(2906002)(26005)(66616009)(8676002)(8936002)(478600001)(31696002)(19618925003)(235185007)(2616005)(31686004)(956004)(564344004)(786003)(316002)(16576012)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?7PUT/kPA/9mFfJf6GSZYIrHN3ncnyEGf2aE08JS3uE/IrQE1ii1ZEuFK?=
 =?Windows-1252?Q?J6sF2gG0WmxwImAfhc3bHRrqmoCzR7euoIN+rHOcu/ArjVwh2F1PnOnf?=
 =?Windows-1252?Q?/T1+64cjF74gnsoATE/ZyxzKLqticat8J2962UXc1y5cMsJRnPIUw8Ja?=
 =?Windows-1252?Q?fqMXtMUwnlxeuQ/jtfzsSNQzosiPXxjCt6xgwFhg2MtMJlWFEcYqfSbE?=
 =?Windows-1252?Q?v0qbjmMiX3b1vG/wIwuQRPUFECJJo4FifkS2rreaEeD+nv5PbfGEzL8D?=
 =?Windows-1252?Q?nOsSLRRUX0eSEbb7vsnGVMftd1gaHPeN5AJuF9zI+6uiTYhehshgPAzX?=
 =?Windows-1252?Q?lzOWcmMldPtZK8PWHbNuDJISQMYJ5SYsenuowBJ2nXFN7LDQAVdpew3f?=
 =?Windows-1252?Q?MpxcRVRRP5EdjGpixTRWBk7vMk3rJcUV70UJ8Zp7uzaq9JfFOMV3ouRH?=
 =?Windows-1252?Q?79FEZ2ZWSn03tUkZaKeHqab5GUziuLdHbZHSd2GNP+cmsNCbjWA26LVs?=
 =?Windows-1252?Q?9l1Bx2zEvB+c+/frzBjpH4qr9FYSMiBoHINRZHCOrX8q9ju9T07+wQf1?=
 =?Windows-1252?Q?m09k6JfUxhT6HuJ5WPlVjaSWV5zRbCl1AEpmPNvBvudpZDL1TGKaAzfS?=
 =?Windows-1252?Q?VkfF7ySlmY1GCKdk5kwPFli+cGmvZxSOeRBi/2wY2y27cPihi6Hg2n4Q?=
 =?Windows-1252?Q?W2c94pXO8Wg2U17HqrBdgprk3GdrNX3TJKMAgk+U174zo9ljzLCz9Whi?=
 =?Windows-1252?Q?FqkEVzzKVFjX2zNVpDnzRyuiKpUVXx0ETAxjrayjfmodelvncAQBjHzB?=
 =?Windows-1252?Q?WCaYL1y7in7vS1aLuoHHAMYbBPsVg6yH0VlwlX7C3Muz1T62KcWpzxmn?=
 =?Windows-1252?Q?mqBDxgdn6WzQxf3CE3ZtATT7dcShpPhAICwAEe3LH6nEopoCFGMxJzeC?=
 =?Windows-1252?Q?7H9t/GKwRHsNlML5NzMi2OlzCTtBte4jfEo3rXwgMfiBPz08JpUrC4GS?=
 =?Windows-1252?Q?NqgtjUoZkwECF33vIRGRK5s8hTrzF+4oz0DeMpP1srX7MACyoo+JDSWh?=
 =?Windows-1252?Q?SiHYukG8Y+8tYYArZtwOo+S23JRC+kHO2pA2n4Mcv+TqUUpLL+2GsMge?=
 =?Windows-1252?Q?GDBS54Ty43eXqnNrA2vLdeblLsXwkFNoiny+uwQLQsp3vbhWA2ObFDVl?=
 =?Windows-1252?Q?EutBDCP8R8uqtexeBMd11f6wpeqAuJxvQwRYi8jz7aT1Vx6hmoH7rUyt?=
 =?Windows-1252?Q?7ckjg6CdPETvXxssn2JqpvwQKDZ3YabaLdOgOl4Z570YDHszd1DS0j9u?=
 =?Windows-1252?Q?iekhbCXzwYEy0mA0egHInIIcu+eGcV22lQXGX5q2yiKy2VWP0hOP+qBq?=
 =?Windows-1252?Q?9LyV4kpDKtpONzY0XSvQvkK3Bc7bS2aOLtZECtSepKduxpAGVRQAOHRP?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c24b549-5a44-4f72-20a4-08d95078ea73
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 21:04:11.0816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTTbSgGBr84y0/gZbnPyyVpBsSP5DqKI4OQpEVvQEG6B+jAdh1zz+NCZV4eSh+y9pl2RToJldMGA3ZtCAqDhHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0354
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Mon, 26 Jul 2021 21:04:15 -0000

--------------70D2A61BB5CDBB5809F9FF49
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.

--------------70D2A61BB5CDBB5809F9FF49
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-getifaddrs-fix-address-family-for-IPv6-netmas.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Cygwin-getifaddrs-fix-address-family-for-IPv6-netmas.pa";
 filename*1="tch"

From 49ff12b47d9d71960fd7b39846b302b8031affa4 Mon Sep 17 00:00:00 2001
From: Ken Brown <kbrown@cornell.edu>
Date: Mon, 26 Jul 2021 08:59:09 -0400
Subject: [PATCH 1/2] Cygwin: getifaddrs: fix address family for IPv6 netmasks

The code in net.cc:get_ifs that sets the netmask omitted setting the
address family in the IPv6 case.  Fix this by setting it to AF_INET6.

Partially addresses: https://cygwin.com/pipermail/cygwin/2021-July/248970.html
---
 winsup/cygwin/net.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
index cec0a70cc..67dd7fc04 100644
--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -1869,6 +1869,7 @@ get_ifs (ULONG family)
 		    if (prefix < 32)
 		      if_sin6->sin6_addr.s6_addr32[cnt] <<= 32 - prefix;
 		  }
+		if_sin6->sin6_family = AF_INET6;
 		break;
 	      }
 	    ifp->ifa_ifa.ifa_netmask = (struct sockaddr *) &ifp->ifa_netmask;
-- 
2.32.0


--------------70D2A61BB5CDBB5809F9FF49--
