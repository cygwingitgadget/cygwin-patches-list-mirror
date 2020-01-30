Return-Path: <cygwin-patches-return-10035-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104031 invoked by alias); 30 Jan 2020 17:01:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104013 invoked by uid 89); 30 Jan 2020 17:01:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1753, *buf, ulong
X-HELO: NAM11-BN8-obe.outbound.protection.outlook.com
Received: from mail-bn8nam11on2098.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) (40.107.236.98) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 30 Jan 2020 17:01:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=UaCBKvOlJ1T/loBVUQz0LaY3AEGXM4mDbQBCW7D5NvV34brVdCJIWxIlUJPCPZP29CnITvVs1z5+M4OYdF0/QZpQx3slFakYrkr1s8aysxW3QBYoxCFiAL3yu07EdRJUpZNOL2sWqITOflFn1bnAoBUqLExFqmE60fhaNVC082/H07iywcQzjrxC+5mmB3qN/aJxksQb/1WmvID9UgtPhTdXVW5Nw/XmTTD1G9GmY13tRYJ1gyd3gZyGywAS8sEEBEp1XvSkmKjGw5ucM1cT9NOVZ7yUfd0FFp79DUgOWCkS/x0hw/qs8ara+TNlFqM6EeVvBQmu/Mi+XI8Bhd3L+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Tdomc8ghDS5oJjfy1sUPN2qmdmkZr/xy8TS2vyygx2s=; b=YE6ZQ3huGUk+aSH3gCZgR/n7MnbGreacJDz0paHlV6Fyxo72mJNQsnuDJS0SGznm91Jq+yC/DQ3tywjPJ/Jh9x20vqisXesWTPrPwbOCojfS+Q8uIvhx9xwg02ENWRzQ33WQ22oNj1bI/6N6HA5osBxG0ukUVI4uioqczyEx8F2S/mMwlDtMf3BXLi58XbtZGxDq5xVU+NF6jq6Y8C9bzQP1E8iMRF+VQHHuEkaIFVffUCrvPGonK9k5GMJZ5DU+F6UWJQcWZqls8eBX3zljF86FKl9yUrYB7LiSFTfhKYm9mTUBKNytPxDIHxXq50jZD+fEpfdvNQJdgCIImbo8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Tdomc8ghDS5oJjfy1sUPN2qmdmkZr/xy8TS2vyygx2s=; b=CwjqOtxJSc3Ge6pz+PspatFZxzST3W9B4kakt8TLrUxnMh8DDxHfssw5OUWGYhoejDnr0btARJEpBqjKy8Blt+Rdhq3M1Z7CZSNaX+zNL5NRsBm5pPpv0Fxx3trxMuB+kXOblPYqLwfpYZ4GsIRkNguxoRgbbwAm6h5cLzDVSe0=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4027.namprd04.prod.outlook.com (20.176.86.12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22; Thu, 30 Jan 2020 17:01:46 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020 17:01:46 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fstat_helper: always use handle in call to get_file_attribute
Date: Thu, 30 Jan 2020 17:01:00 -0000
Message-Id: <20200130170124.30431-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Return-Path: kbrown@cornell.edu
MIME-Version: 1.0
Received: from localhost.localdomain (65.112.130.194) by BN7PR02CA0022.namprd02.prod.outlook.com (2603:10b6:408:20::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24 via Frontend Transport; Thu, 30 Jan 2020 17:01:45 +0000
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
Received-SPF: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-MessageData:	RRRlYiZxC/Kelk9aj2T2lkB72ntvH5kz3m44VmdX7360MMXg7P0UZYVNLKhcSCnGNvpjfuCk/L94U55nERXD1mHbbylUjUQIHop3n/gp+tu1zL2cWGYe1gzt7VZbmIAQmpbogtnOuUBZ7fLycUnG/w==
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmE3TgNFDHiclvuuqotyuw4t6FbMPPwK13o8VQCFvOfSIGX4wdBru12IIKoy2uaAFhXt96ZBOd3m3ct537+2aw==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00141.txt

When fhandler_base::fstat_helper is called, the handle h returned by
get_stat_handle() should be pc.handle() and should be safe to use for
getting the file information.  Previously, the call to
get_file_attribute() for FIFOs set the first argument to NULL instead
of h, thereby forcing the file to be opened for fetching the security
descriptor in get_file_sd().
---
 winsup/cygwin/fhandler_disk_file.cc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index f362e31e3..ad63af824 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -394,13 +394,14 @@ fhandler_base::fstat_fs (struct stat *buf)
   return res;
 }
 
+/* Called by fstat_by_handle and fstat_by_name. */
 int __reg2
 fhandler_base::fstat_helper (struct stat *buf)
 {
   IO_STATUS_BLOCK st;
   FILE_COMPRESSION_INFORMATION fci;
-  HANDLE h = get_stat_handle ();
-  PFILE_ALL_INFORMATION pfai = pc.fai ();
+  HANDLE h = get_stat_handle ();      /* Should always be pc.handle(). */
+  pfile_all_information pfai = pc.fai ();
   ULONG attributes = pc.file_attributes ();
 
   to_timestruc_t (&pfai->BasicInformation.LastAccessTime, &buf->st_atim);
@@ -475,8 +476,8 @@ fhandler_base::fstat_helper (struct stat *buf)
   else if (pc.issocket ())
     buf->st_mode = S_IFSOCK;
 
-  if (!get_file_attribute (is_fs_special () && !pc.issocket () ? NULL : h, pc,
-			   &buf->st_mode, &buf->st_uid, &buf->st_gid))
+  if (!get_file_attribute (h, pc, &buf->st_mode, &buf->st_uid,
+			   &buf->st_gid))
     {
       /* If read-only attribute is set, modify ntsec return value */
       if (::has_attribute (attributes, FILE_ATTRIBUTE_READONLY)
-- 
2.21.0
