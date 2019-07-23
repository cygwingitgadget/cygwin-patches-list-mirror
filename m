Return-Path: <cygwin-patches-return-9509-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29329 invoked by alias); 23 Jul 2019 16:12:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29317 invoked by uid 89); 23 Jul 2019 16:12:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.2 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=no version=3.3.1 spammy=UD:cygwin.com, cygwincom, cygwin.com
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730130.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Jul 2019 16:12:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=dLr/cvBjeRwtkX8ohQc1jb4iX53zgPrzbs85dZIpQlizDyhxhQE6FPUud1+kz2so+V5bARNoi8ca2L6YtuPR+TRh9eCYy2uF/+7v9ZF5YZsvPADfWVWhl8zUkczyX+wtAc5ht4JH+k4Dk9Aqj6+ju4ATB7rQvt5Uke5uHMTdC7ReswDEDAflCs2rRn4OQJZHwfD9KZU9+kDFmpqWo3nqotkIVB/6XsfQeArSho9p9Qreg/gH/QaAuxJu3NfOHf7ZngGPDzGXlkQEdtbR9/7OoDRCm4WXM2mK6WHABIbAgEm6ACH8d9lAij2EuYldgCutaKOZqyOAXp3AMoZSmQ9QZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=tfVDG2o2oDdbyJgWdfce5r60rocIxTgrTVvfkHRGyt8=; b=HjbhpvZZ0AqSpeKNjitgKB06yxvS+fj/wGhxl56thTjMEJPE2q9Ziz15Je0i1KCmkT4dj34MKxaXZpZ7I9V2qsHWyIi0s3IW648d5z3W/+sAW8ib/YVVDTb4WW/XOc+QgOYHmn7TXa4YVjMANe404TTNuJjAGXkZOpEwWIRnfDO3loyGsHSoLKpVZRXtbrEQhQca1mIrxAS/OzKofMm18iLazKfPSktsqBPs8IvHCpqGSK+5iB/alJy61yFZVfE/hytrvZM7Yl6p9Rx8Fdsa7RSrK+Xsnz6tKhZrgAFFa0f5NzTAIGrO08wxx4cHnYcKs3foWW5LwJf87z4sUhm6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=tfVDG2o2oDdbyJgWdfce5r60rocIxTgrTVvfkHRGyt8=; b=i4fpaUwN9GuwEF/dQ2qYxTbtPCs/X4MMp4hXi5KdkYYS1zHBChxYrO+Llnd7+Zcvy1O/1BJLkzLxH3dg5+Usah5rvVY5n7uKpy5+wh9z6KWO8sXz3qN/n5Qk8EieW41kErrO004/C+KsEBq9tMkxw9ovjJ2vGZJkWU2bS2XOgKg=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2331.namprd04.prod.outlook.com (10.167.17.12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.17; Tue, 23 Jul 2019 16:12:41 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.017; Tue, 23 Jul 2019 16:12:41 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 0/1] Don't allow getpgrp() to fail
Date: Tue, 23 Jul 2019 16:12:00 -0000
Message-ID: <20190723161100.1045-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 2
x-ms-oob-tlc-oobclassifiers: OLM:8882;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00029.txt.bz2

This patch makes getpgrp() conform to POSIX.  I have some qualms about
it because getpgrp() will now return 0 in cases where it would
previously return -1.  I don't know if this is likely to break any
applications.

The patch fixes the problem reported here:

  https://cygwin.com/ml/cygwin/2019-07/msg00166.html.

See especially the comments in

  https://cygwin.com/ml/cygwin/2019-07/msg00208.html

about bash.  Although my patch does fix the specific problem I
reported about debugging bash, I'm not sure what other side-effects it
might have.

Ken

Ken Brown (1):
  Cygwin: don't allow getpgrp() to fail

 winsup/cygwin/syscalls.cc | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--=20
2.21.0
