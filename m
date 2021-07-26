Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2127.outbound.protection.outlook.com [40.107.236.127])
 by sourceware.org (Postfix) with ESMTPS id A1379382CC2C
 for <cygwin-patches@cygwin.com>; Mon, 26 Jul 2021 21:06:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A1379382CC2C
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Db3rlCxGTV9HZ6iQfpZi0CWD/3dRqe3BLS0V3Pe7b/tCzaVog46Eb5ZKuJCv3Tm3eLq7suk/Gm7/j6hmcH6a6erqWeifW69ebdn8sT1IKBP3yHwyGQXPj5+ulStbjZmzltek3bKBJsxcYmYRs7KJiG5qKyp6KAPKaUAdQ7Ky8lL7wwClPx05KShyTg2sFFK9Y6MRC6vAAYMdnBPf8UFLS1dp+AUHqcLgOMDoJUzbM0yy5PS7PVWOZZhiC0YFuVqhyF2Ek4R4jg+QFWwo9EdhsyGejlHz5oDtURNHMHEkWz1qILQOIfZcdP3DN8nEqgb6wMBuI4TCGBrSqunaEN/Lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcO4nRSeX4ejx3sB3isDqvUUKtWJkOjiqV+1fB3364Y=;
 b=adG03nY+mLeM6Bbb7yR848HlN/BSVUtSj181FWA8jddJGYWJAZiUe4ZiqpmBgRl126/2pNsHo5i4zLFsPWjKw6CUKL2Lv0CJd/7tJUmqqeVPMhZrNCDrYjeWmbSWbUar2tjxO8Qko+DNkyGH2MTVUEs2Sf8IoQGZui6D5V5R7UR/L/2Alr8PNzb9Nkw9kwZhcdytM9T3WO8+2AVW1Wi0lbhYt8NYfURUmyIqPo1JV91AsQgDCQ0iI7UpDH6y0Q8QXVfeYBqr2ThA0Eprne/ocDIStt1Pz3rbeMD8vC4GY6mCTTFkjnt55ZQyrfL+p/k9kzVVnfJ8iHKTNNThYfHv9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcO4nRSeX4ejx3sB3isDqvUUKtWJkOjiqV+1fB3364Y=;
 b=I0RMlQxs3YqKlZOFzdqPn9yAy4Pxf19sAIw8STajaHPKJioYjgrYTKKG/9F782sX1yzLAKzxp0rdpgqhG2Tpd0CQBs2zbgXRuKAvV5SXUOW+zIytUkMXgq64wIIHOxesDNStaRuH05IZGS73plKw+GbKtMFug35y1pPYUbEOyTg=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6161.namprd04.prod.outlook.com (2603:10b6:408:50::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 21:06:41 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::cda2:359c:cb66:5c42]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::cda2:359c:cb66:5c42%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 21:06:41 +0000
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH 2/2] Cygwin: getifaddrs: don't return a zero IPv4 address
Message-ID: <9dad7a6f-8fd9-22f8-a084-2dbeb19c1277@cornell.edu>
Date: Mon, 26 Jul 2021 17:06:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Content-Type: multipart/mixed; boundary="------------4877D9CB82F2807DFDA85226"
Content-Language: en-US
X-ClientProxiedBy: MN2PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:208:15e::46) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.19] (24.194.34.31) by
 MN2PR17CA0033.namprd17.prod.outlook.com (2603:10b6:208:15e::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Mon, 26 Jul 2021 21:06:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2aaa599-cfd1-4626-0f2b-08d9507943f2
X-MS-TrafficTypeDiagnostic: BN8PR04MB6161:
X-Microsoft-Antispam-PRVS: <BN8PR04MB61612D7AA54524FB876503C3D8E89@BN8PR04MB6161.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HKujzcDnag8Z1+M7OqPS4Tu8iZBBj644wejlCiL8yx8Hw2HH8j09INmFXqsZ8qb1MRDFJQL91l04zjZbVULlsPOtXCHOBDoGgLYChO+WEtRUZX1S/tCwQmflO/XmdNy03DLZO3YDGoAdCaK8q3q8pNVV37HKIRCyH3lWGHz9vhGm9nNZ+eeZmks2RY5CWcj+cOzTp5el2uRF9Ft7lgUsJZdCs4nCo5hjFKmLchw7pNz2nA3KzlBNtkoyq9fLjLnwedsjUmqWG8DbydtGwAvALDagjnNXRJCVvaUvZglWYG/sorwWiTr0PP6aWe3WxJ2kOX7/QAkFhzhlQvo4hhd2OU7U/0Xz2mz8kWDGDtnCUZnqxTIfQCRnUncCfYM+VoLXiduSyK/zJpYCA/dXXVajxbGwvu13JT0UycBPS18tWvryQlqD9LJK7SkUkQNoQ87OvDnVCJZFNxZ1v4LNUYvGydcOS8hsINHn1L9TdMWcB/Um4EI22SSaQH0LLp3uoUa/J4gLcpbj5VAaLLLjzsFv7SHwYCE44gkgCRD+Y//ZE8o4QJ2Y8Q8kpyRCXj9JspQm4svZMJNBhxqmuArfz0aYezAknI9S7vX0Ptz/OkSssneLpY3scLHOQDSzaMN3cO1gTWloVwjoRuUybomQMkywwKku6NxI8V6OHoXgxwTeEKvECDXAeAi0PfHAGV3L+5M+eaLR3neb6S0QgBKGSCsMR5+zO4CrzfyFoSr6WYBJRUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(75432002)(316002)(33964004)(66946007)(86362001)(66556008)(478600001)(186003)(66616009)(66476007)(786003)(26005)(16576012)(2906002)(6916009)(36756003)(2616005)(19618925003)(235185007)(956004)(564344004)(31686004)(6486002)(38100700002)(31696002)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?efuiJQet5u2Mz1FDYHYDaeLD0TeYmYql3DuUyTcaOqUlef0J4/P4XApD?=
 =?Windows-1252?Q?4pyXU1L2Gcq9x3t4CWACdhtRMV2PDtpzoenouR27dvYAayPaKG6XKXMk?=
 =?Windows-1252?Q?NgI2HIZ8+znDNsl/EjPgAXbpOoc6AwuQwQX+eWm38xwyCSOqrBr8xX43?=
 =?Windows-1252?Q?JSuftwVsZSSAf2l2ldlkTSZgaBUiEKBwtF6vcGGrtdU3GwhfOa2Rvokz?=
 =?Windows-1252?Q?Onec8/fXsAvZbx+9/st6Vl0aBClgP7NxNlZwud6EkRqbK10KMJJBwBV7?=
 =?Windows-1252?Q?Q/ScCUG7BJuZ1KECHN1fM0/Y9X6pi60D0an1Tf8CJWVc+Z+/fZarC3Su?=
 =?Windows-1252?Q?652gQoLlA84swouuo8jwk3iX/ug7e+PhZ6D/tZQIWP7Yf2BxhDfCGGCF?=
 =?Windows-1252?Q?SFg0n3+eDLrmQ/btKeA02Lusmi90OK3fblvWkaX0sFYAmCVaRc6/FlKp?=
 =?Windows-1252?Q?PLE8jjZz5vjggJCwiAml5HBQZ5gR4Vn91g4V+xCf2erFJ42nHk+sIGY5?=
 =?Windows-1252?Q?32LJqqYPbhj+QsCXAiTpgXOfAzXDdkPNKGYrJGx+hzyQlangtn8CgXg+?=
 =?Windows-1252?Q?21EbEaBpZByGBdwGpB8h6wxd629FvGaq9EiCpKTBEZjK3xT4aYkuQdVW?=
 =?Windows-1252?Q?YQewccxKPur+rzbDAYDKSRT7SdcfdnLiZraXfdk7RWdQbByMeZ1KZdQZ?=
 =?Windows-1252?Q?57TcB/wxdSENaahOzbLKrDcnX3jrvVMRxyD0fQU5KsMTmpb4qfpwBM73?=
 =?Windows-1252?Q?uUpidBRcYrl9eJUjZzofMcQRgAdJjh2KUIq//HhSoKY1QKiB/BpgwfY+?=
 =?Windows-1252?Q?QGUdcSVhjs6nrPf+plMAf/UmRJWijWH18N0rDiSUT3mfaNrMlbk7LyYV?=
 =?Windows-1252?Q?qlQualhfrhCJ0745g3c+KA+exnyNLT/Banpwc+A7lhFlSZJ0qKRZ7D9R?=
 =?Windows-1252?Q?WdIrTZRgwGOSqy1tqdq3mTtMXq3yaCEwGC1Uj5IaByvKXpymchNlVfQS?=
 =?Windows-1252?Q?GUZkXNNVt2ChbfnG7P2qP3CHV+g6ilGQzm6FkBPx/SKLbmxXScPQsSD0?=
 =?Windows-1252?Q?U0dzD5TtDGH8Hww6v66IYvwe1Sd4McYWWcc0RaWH4CAhn7Za9+fbdrdB?=
 =?Windows-1252?Q?8BGc0/KjHu+9NaHmhQp0XDxAOMLI0LU5Y+4nVzV89Wmj3NmPlhwI+unq?=
 =?Windows-1252?Q?EndpG/qHmeIJXHUDJF677ijR+dmYBWvI6LF1HpVJkbV94x9DDXo9DfGr?=
 =?Windows-1252?Q?mpCqqBFY2W8swUKe9yX9kuNdVWhxKfY+c4mY1vTINqRnOCXnhT7Wg9f5?=
 =?Windows-1252?Q?73gCGFo5hYmSCmLtqHgbsX2kjbqYsOx5IBBfRbR1wBafQKmzD+NV4Ie9?=
 =?Windows-1252?Q?HFSTYT0kG1rwNK8RaTH4ndonvtJBIw7BKQoCoj7dzSeftceVJr/WpTp3?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f2aaa599-cfd1-4626-0f2b-08d9507943f2
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 21:06:41.1977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CiDmcPoSgO70lssGDN11n0MKxhKL1fckjIBSjM9AhTCgrQkF2x41cmlHjGn+yyksMlDq7RDMFZQgrsHCmUhAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6161
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 26 Jul 2021 21:06:44 -0000

--------------4877D9CB82F2807DFDA85226
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.

--------------4877D9CB82F2807DFDA85226
Content-Type: text/plain; charset=UTF-8;
 name="0002-Cygwin-getifaddrs-don-t-return-a-zero-IPv4-address.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-Cygwin-getifaddrs-don-t-return-a-zero-IPv4-address.patc";
 filename*1="h"

From f869ec6f96e16f09be7098740bc21c0c39544fd4 Mon Sep 17 00:00:00 2001
From: Ken Brown <kbrown@cornell.edu>
Date: Mon, 26 Jul 2021 10:27:53 -0400
Subject: [PATCH 2/2] Cygwin: getifaddrs: don't return a zero IPv4 address

If an interface is disconnected, net.cc:get_ifs tries to fetch IPv4
addresses from the registry.  If it fails, it currently returns
pointers to sockaddr structs with zero address.  Return a NULL pointer
instead, to signal the caller of getifaddrs that we do not have a
valid struct sockaddr.

Partially addresses: https://cygwin.com/pipermail/cygwin/2021-July/248970.html
---
 winsup/cygwin/net.cc | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
index 67dd7fc04..5bdc8709f 100644
--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -1595,6 +1595,7 @@ static void
 get_ipv4fromreg (struct ifall *ifp, const char *name, DWORD idx)
 {
   WCHAR regkey[256], *c;
+  bool got_addr = false, got_mask = false;
 
   c = wcpcpy (regkey, L"Tcpip\\Parameters\\Interfaces\\");
   sys_mbstowcs (c, 220, name);
@@ -1637,9 +1638,15 @@ get_ipv4fromreg (struct ifall *ifp, const char *name, DWORD idx)
       if (dhcp)
 	{
 	  if (udipa.Buffer)
-	    inet_uton (udipa.Buffer, &addr->sin_addr);
+	    {
+	      inet_uton (udipa.Buffer, &addr->sin_addr);
+	      got_addr = true;
+	    }
 	  if (udsub.Buffer)
-	    inet_uton (udsub.Buffer, &mask->sin_addr);
+	    {
+	      inet_uton (udsub.Buffer, &mask->sin_addr);
+	      got_mask = true;
+	    }
 	}
       else
 	{
@@ -1649,7 +1656,10 @@ get_ipv4fromreg (struct ifall *ifp, const char *name, DWORD idx)
 		   c += wcslen (c) + 1)
 		ifs++;
 	      if (*c)
-		inet_uton (c, &addr->sin_addr);
+		{
+		  inet_uton (c, &addr->sin_addr);
+		  got_addr = true;
+		}
 	    }
 	  if (usub.Buffer)
 	    {
@@ -1657,9 +1667,16 @@ get_ipv4fromreg (struct ifall *ifp, const char *name, DWORD idx)
 		   c += wcslen (c) + 1)
 		ifs++;
 	      if (*c)
-		inet_uton (c, &mask->sin_addr);
+		{
+		  inet_uton (c, &mask->sin_addr);
+		  got_mask = true;
+		}
 	    }
 	}
+      if (got_addr)
+	ifp->ifa_ifa.ifa_addr = (struct sockaddr *) addr;
+      if (got_mask)
+	ifp->ifa_ifa.ifa_netmask = (struct sockaddr *) mask;
       if (ifp->ifa_ifa.ifa_flags & IFF_BROADCAST)
 	brdc->sin_addr.s_addr = (addr->sin_addr.s_addr
 				 & mask->sin_addr.s_addr)
@@ -1800,13 +1817,13 @@ get_ifs (ULONG family)
 	      ifp->ifa_ifa.ifa_flags |= IFF_BROADCAST;
 	    /* Address */
 	    ifp->ifa_addr.ss_family = AF_INET;
-	    ifp->ifa_ifa.ifa_addr = (struct sockaddr *) &ifp->ifa_addr;
+	    ifp->ifa_ifa.ifa_addr = NULL;
 	    /* Broadcast/Destination address */
 	    ifp->ifa_brddstaddr.ss_family = AF_INET;
 	    ifp->ifa_ifa.ifa_dstaddr = NULL;
 	    /* Netmask */
 	    ifp->ifa_netmask.ss_family = AF_INET;
-	    ifp->ifa_ifa.ifa_netmask = (struct sockaddr *) &ifp->ifa_netmask;
+	    ifp->ifa_ifa.ifa_netmask = NULL;
 	    /* Try to fetch real IPv4 address information from registry. */
 	    get_ipv4fromreg (ifp, pap->AdapterName, idx);
 	    /* Hardware address */
-- 
2.32.0


--------------4877D9CB82F2807DFDA85226--
