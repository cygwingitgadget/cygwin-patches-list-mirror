Return-Path: <cygwin-patches-return-9993-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108513 invoked by alias); 23 Jan 2020 16:31:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108444 invoked by uid 89); 23 Jan 2020 16:31:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:824
X-HELO: NAM12-BN8-obe.outbound.protection.outlook.com
Received: from mail-bn8nam12on2109.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) (40.107.237.109) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 16:31:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=EIQGJjBxBrDA+4WjvVWDVpXCwjS+KBIpJ+eGssQ/yOyYqJ9D9S/UgPwePQ2q6fAKx5rpY6XxfaHD66Iho9yAm7Cbi2e9eE99QNlDwyMKHhg0s4A64Z7otoY14ZhUycwn+76KgRBYds+92BhBM6ChIhlWDONZAe77Z6Wa+FHD0m5+Il4In97CiVw9DIX2dUtU5e5L1BORbqTD/bkV2vmgk9hsG55Z5hierED0/iDOJZ0yCjj2R4ALUgmFKCCd9OFicDtxNyyPJFdfpUZjz8/EQMMp41dIIb4XkiJgaTm+hEeCF1P1WaKrSsEjs9sy5yysM9YTXd5ajKSeKZ0Cn6JpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=5ylrzrbKGoU8Oygr9hdupsmnEtGhFQtFG8fDVP7OKuc=; b=AiPX7lJ2E5DC6G3/4VdKXyzkVSbcmME8h+MVeP6qo3I84ZmpfbqMMtCARMUfXdpJ30uRgp5B3nGllZfkMqmuYcr8VY/6sbnjkSNBypLsc34ikPLx6Lj87mb1NfDp0hG2EmpJExxQjGglWz31BC8nSzNS1zhKJp/iMUVZhdcfWb5ckONTGd3EKYov0o4ISJUxdhPrOmbSEaI8RKaSbhNSqLiWaVFi7DAM3nSlWH1Ug6uxdOb/0qiiJyj8XnKfJUheKIpml6j9+RZ3FEst44TcFvRA63DWcnW8Uz/BpeWDueD9Qlz0qM/ZpP9oByJ73qs+uVXadM3OL1L/QcAuhMEZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=5ylrzrbKGoU8Oygr9hdupsmnEtGhFQtFG8fDVP7OKuc=; b=B+KfgeC1AC73yLWD9v9ItY/YcI/56hPtgxjSjBBchpvw6H3Ok5yGL3z8OcVHJg+kO9qJsg37xbqoTS6wtEOcbxmgUMsotjGuNvNx2XoG0/aNi7ro9+Wip5c8HLi+XbIJcTg580eiJDeZfz529+vm+dSkNUN+exz718MYMRqXKmY=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6393.namprd04.prod.outlook.com (10.141.162.145) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20; Thu, 23 Jan 2020 16:31:04 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020 16:31:04 +0000
Received: from localhost.localdomain (23.31.190.121) by CH2PR15CA0001.namprd15.prod.outlook.com (2603:10b6:610:51::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19 via Frontend Transport; Thu, 23 Jan 2020 16:31:03 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 1/3] Cygwin: device_access_denied: return false if O_PATH is set
Date: Thu, 23 Jan 2020 16:31:00 -0000
Message-ID: <20200123163015.12354-2-kbrown@cornell.edu>
References: <20200123163015.12354-1-kbrown@cornell.edu>
In-Reply-To: <20200123163015.12354-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8273;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: nUgDtcpCRBQ+HT3a7P1I0FtRSDNlezkuoFjfdzPpWYvbqxAtuoUMcNNMn3VFszpNqJDQs0yXHaaAPn1iRKGATKJXbrca0KasmObYgmd6UWYqUkr8ZMhGh6vGGkC5XhmZ8utOLQNahz/KC7FOdO3QJQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vR8cljSzYeogFMIQEZqaGEzdb9SuNV949mbStCKGxaqXbNdHjmdxtgxcLPmgH6TJ/8xsXtWbXRWpYwiRd7pnsw==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00099.txt

If O_PATH is set in the flags argument of
fhandler_base::device_access_denied, return false.  No
read/write/execute access should be required in this case.

Previously, the call to device_access_denied in open(2) would lead to
an attempt to open the file with read access even if the O_PATH flag
was set.
---
 winsup/cygwin/fhandler.cc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index b0c9c50c3..aeee8fe4d 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -335,6 +335,9 @@ fhandler_base::device_access_denied (int flags)
 {
   int mode =3D 0;
=20
+  if (flags & O_PATH)
+    return false;
+
   if (flags & O_RDWR)
     mode |=3D R_OK | W_OK;
   if (flags & (O_WRONLY | O_APPEND))
--=20
2.21.0
