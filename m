Return-Path: <cygwin-patches-return-9482-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104049 invoked by alias); 16 Jul 2019 17:34:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104038 invoked by uid 89); 16 Jul 2019 17:34:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-10.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*MI:edu, H*Ad:U*cygwin-patches
X-HELO: NAM01-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr820093.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) (40.107.82.93) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jul 2019 17:34:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=lE8+xbEpW3Zgu5K6JgFnuN9gzf2PHpaCastCiz11hDWlRRVvrnhzKPxM7VsAwPzdZqu+NX+0UkT9YKxNjX9zkjKvcoRdm0MjJ3aOyTTAWeJM64GyWEbQvJMWTgoMgx2G67EXDd8d7Zf0JorQY9UhLm0WOByY+bEjKXJebSfTvIjCBl2KymDnXV1DWuxg5RHXjuwYlHat9wl0vI0tan3qh24S9Jg/PNh5z3VD7Pf+wIg4d6PTfsbn6nSFUS5xm3vx4e/b91BSfZYp+ZPpiBeY+AhVhiA5ErMvqfOie5tAJdjDuvXr1E/tUhsNVQIkl3gFf5qb3LNBPzHhbMLpnWdu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=00cRmaj9EvvC+rnvq2GZ1N0+JQM30n+e6Dnrre5COVE=; b=Q8hpq1fBBaVdOR+vFApowiiZwf0ZFmWUDp4a57aSQvFjykD7+aTSlkV//2wzLSBT72whEdf5GrdcrLMvFV91uxZxczVadB2EjT3sgNMeG0fDS8qkyWhLMlad5iQ3y/AeRpxilosjE6vFZMUYDPFwrxPSxDs8usA7GLixefGNb53/0JzOq9513kBouR3ZG+ovuMaYLBBiIUMxvWBTBL4pUYeJVC2sr+Ni2zdzRfMTic/aC2fOEj3pBfbKnKBO8lCKo+0sIXNKFKNUfU/Qa1m0A6pgcurQbu+ar5lug4jIUbOw5Q5ULXkmJsF7JXuJIznJLe4nu1P2lncAB3z4kth65g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=00cRmaj9EvvC+rnvq2GZ1N0+JQM30n+e6Dnrre5COVE=; b=QKUgBvzk6s01UOhV8aXiK9D1No0XzYQeQO1mzkxsQcF/dHdYHGSNaNCJhanknIg421xfqYxuFD686uFb04h49odkiEqCPHDCau9T5fW8UcBFP9jNgUGJK6bZ8Ed5Bgveat3oloZrwXXx6yXZ9C/Ts/48iRZXNUDeiJyE2o+zjGc=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2234.namprd04.prod.outlook.com (10.167.16.18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14; Tue, 16 Jul 2019 17:34:22 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019 17:34:22 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 0/5] Port to GCC 8.3
Date: Tue, 16 Jul 2019 17:34:00 -0000
Message-ID: <20190716173407.17040-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:6790;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00002.txt.bz2

This patch series tries to fix all the warnings (which are treated as
errors) when building Cygwin with GCC 8.3.  I'm not confident that
I've chosen the best way to fix each warning.  All I can say is that
the build now succeeds.

Ken Brown (5):
  Cygwin: avoid GCC 8.3 errors with -Werror=3Dclass-memaccess
  Cygwin: avoid GCC 8.3 errors with -Werror=3Dstringop-truncation
  Cygwin: suppress GCC 8.3 errors with -Warray-bounds
  Cygwin: fix GCC 8.3 'asm volatile' errors
  Cygwin: fix GCC 8.3 'local external declaration errors'

 winsup/cygserver/bsd_mutex.cc    | 5 ++---
 winsup/cygwin/environ.cc         | 2 +-
 winsup/cygwin/flock.cc           | 2 +-
 winsup/cygwin/include/sys/utmp.h | 6 +++---
 winsup/cygwin/miscfuncs.cc       | 4 ++--
 winsup/cygwin/path.cc            | 4 ++--
 winsup/cygwin/path.h             | 2 +-
 winsup/cygwin/pinfo.cc           | 4 ++--
 winsup/cygwin/uname.cc           | 2 +-
 winsup/utils/dumper.cc           | 2 ++
 10 files changed, 17 insertions(+), 16 deletions(-)

--=20
2.21.0
