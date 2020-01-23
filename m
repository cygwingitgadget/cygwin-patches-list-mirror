Return-Path: <cygwin-patches-return-9994-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108819 invoked by alias); 23 Jan 2020 16:31:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108738 invoked by uid 89); 23 Jan 2020 16:31:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-23.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM12-BN8-obe.outbound.protection.outlook.com
Received: from mail-bn8nam12on2109.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) (40.107.237.109) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 16:31:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=HTCI8yVDG7Qe/b0CGfo+uJ2eCU5xUytn+Bbt0zFwPwP0ahbf6pqDVhH+HaDfnVWYDDrw/6wFy5CxvtD+Aoy9vrHtKjEqGqwcnGfNMGl0cZbYVIbhE7F5lfZAs3pic8iJTB6qBoL8kuHf3PWAQy94wNpibFFN3RTjvflZ15czz3NLAHLkI5X31i3siLVOd/QDSeBktYCHeZopLq//9wuYhFF2rH5kW7pm0Zli90BpZ7GxiX8duIgbAXod+VxUp16aLv7CpzZu4i46nX5lJ+gFDB0GWOmzpa+uClpW2u8VW97N0A6D0S1Uf5bG2RnK7pTK8obFwQQktueiAuyzttoHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=VXCfRjYP0K8js2hABggiGKHpElPFG1qvyFyxtpDjN/c=; b=JGeAv/tOSs81TPbbplQIjrP305mU2RIr7PSRhJut1nafi1z4uzfL1DCO+durj1RBIqCDSJnfKRio4DGZueuKHGeCeajXfiA/m66Wlk/FJVaDWf+IM7cn+TfKyUssuOlrVEZKaFeD8Gak1/ZMqvaAd9lfMhFtl3dMgjP31WpCQYSJCz1/zxykIM3iAXj62B9ib6LhQJ9non+ABgZv52ewK10dBLiArHjmz5ytmZawsqsAB6pOt4O8Wtu9/Vi+N6bHgeYOmZRNu3LxxHG8HmUxYFmiI2okyjNJE4yh/3lBGxEKHaIAZhP33Sk4jdFk1DO8UmwzifL7ebiaPWkhxQt41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=VXCfRjYP0K8js2hABggiGKHpElPFG1qvyFyxtpDjN/c=; b=B4Z+OITMVOaPAdvLbqGXFYLEpbyKF/VLFDJO6yF25jeFYpy4wYH4k+NUgemdcCzqWkn0D242K2yvxtGLbReWOdTJLdyNspu//SzJV/e4fiRrx9REnEqWeYDTvkCz3dxwg7mhFS3ALfgoj3Qoon9Rr/FPSNAFVSGkLa8+6WhgrUo=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6393.namprd04.prod.outlook.com (10.141.162.145) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20; Thu, 23 Jan 2020 16:31:04 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020 16:31:04 +0000
Received: from localhost.localdomain (23.31.190.121) by CH2PR15CA0001.namprd15.prod.outlook.com (2603:10b6:610:51::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19 via Frontend Transport; Thu, 23 Jan 2020 16:31:04 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 2/3] Cygwin: re-implement fhandler_fifo::open with O_PATH
Date: Thu, 23 Jan 2020 16:31:00 -0000
Message-ID: <20200123163015.12354-3-kbrown@cornell.edu>
References: <20200123163015.12354-1-kbrown@cornell.edu>
In-Reply-To: <20200123163015.12354-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:935;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: JqAdEYJBmH9gyr1UBHG0R53V524n7SbMZdnpotriDBip1u5mS0p52K4JUTPD+qKKtx/jZlzd3hhPz1NK1kEvmDHyZbr0sJPAmT/w2bNj735rz1dV7/0llsgnkDbNbNJ5uPHT4JBSqqwjwSaAi2hd+w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rBcYK4YjRolUl0oO0T102BE99pjDtlcWqdDZUDbDUCLbcBJ6iqH6ju/rf8hj1wo6RfSXxcLSbYBf24M9T5xhg==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00100.txt

If the O_PATH flag is set, fhandler_fifo::open now simply calls
fhandler_base::open_fs.

The previous attempt to handle O_PATH in commit aa55d22c, "Cygwin:
honor the O_PATH flag when opening a FIFO", fixed a hang but otherwise
didn't do anything useful.
---
 winsup/cygwin/fhandler_fifo.cc | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index fd8223000..8cbab353c 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -453,17 +453,13 @@ fhandler_fifo::open (int flags, mode_t)
   } res;
=20
   if (flags & O_PATH)
-    {
-      query_open (query_read_attributes);
-      nohandle (true);
-    }
+    return open_fs (flags);
=20
   /* Determine what we're doing with this fhandler: reading, writing, both=
 */
   switch (flags & O_ACCMODE)
     {
     case O_RDONLY:
-      if (!query_open ())
-	reader =3D true;
+      reader =3D true;
       break;
     case O_WRONLY:
       writer =3D true;
@@ -585,8 +581,6 @@ fhandler_fifo::open (int flags, mode_t)
 	    }
 	}
     }
-  if (query_open ())
-    res =3D success;
 out:
   if (res =3D=3D error_set_errno)
     __seterrno ();
--=20
2.21.0
