Return-Path: <cygwin-patches-return-9877-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68797 invoked by alias); 26 Dec 2019 15:09:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68786 invoked by uid 89); 26 Dec 2019 15:09:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.2 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*M:edu, H*UA:10.0, edition, Brown
X-HELO: NAM12-BN8-obe.outbound.protection.outlook.com
Received: from mail-bn8nam12on2095.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) (40.107.237.95) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 26 Dec 2019 15:09:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=g21VhvNaFTv0GPIGQtK5MiefXnMIApDmZR06xaakBzFxEJKPt2MMDI+uEQqz4+eToN9EaKEmXB4lpobo4T6PKy4SuXWBM/cws8CUvYXLbncUrG0r8SaM1IIJYfufc20GL7D+hFURbaIXQJnq0l4XB22+0K8xcuHYc0ZJDxhKlHKsfEeSyFmMGCk8WMj4sLCED25v8dPRn6Hybka2swkuY6D9mi6OlWPOyqmqGs8Gh0CsbfwlqqGNyByURJMBl/8RVf8faITk0ObirFiSQHnCb2wrcXR+/VNPbdg6QA3mNlUpTCZfiI62lgYhv2MR/IsJcUPwW34ZjN3rGM2/TmG2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=DBDXhdilMM1hjpn2qNTPrDN4CMJE8PbaoLoMiWy5vgk=; b=RnQObWHYCnujrpVCXM/tOvZq4YZf1o2gfbECjYHZpmtkp0htLDN3W05uWkEaopF0iSTSPIaHWsB+tnLY4CtaxuINiVa24zvOnayVL+O2d559q52GC6L2qsQba+/XHzWfjkVSrQ1lvQ/wQeElVk/UqCswp8/81g8kHNk/4u4ZYo2voZzyfRD/zRxOghW/21FMpftSCmEUcDMoQs5371sdBT7IRUFK0jBTGLkEcCFSbmD9XrUXpxWUIrocyX4VJA66WSbHncqOWzMyUESDCzoPdgJiwwuGa7uqHzyi2VSuhWEyoiajv1t7sPvOj9eL+z1aqKVbuigMmFv5iOSq9/QB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=DBDXhdilMM1hjpn2qNTPrDN4CMJE8PbaoLoMiWy5vgk=; b=GmYqAMNjpNrery3pEzyYQutXOrVyR/xsqHBDgVA+yR154+BF2tbuBnsjoeQrNlyl5utGMYZwEp/Mcg1SNnMOfrLSxAQoyAQGWhXHlYtQ2ENHp+wPZzphsnxVM+O9kiSAqGnZT5hvDO3v3x6/rIvSpkybEgaOkCb0NfbXfM3OH3Q=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4252.namprd04.prod.outlook.com (20.176.82.17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.19; Thu, 26 Dec 2019 15:09:36 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019 15:09:36 +0000
Received: from [192.168.0.19] (68.175.129.7) by CH2PR04CA0029.namprd04.prod.outlook.com (2603:10b6:610:52::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12 via Frontend Transport; Thu, 26 Dec 2019 15:09:35 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: fhandler_socket::open: set errno according to POSIX
Date: Thu, 26 Dec 2019 15:09:00 -0000
Message-ID: <a0f68139-4ae5-f024-ede4-73d9626014c0@cornell.edu>
References: <20191224192722.43497-1-kbrown@cornell.edu>
In-Reply-To: <20191224192722.43497-1-kbrown@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:4502;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <59CDE21ED18C36418D30CBAF4B0B04F5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4YW0OuH1RzhnyaEXjvICKVsZRsp/Fmcz8BYuA31nB+pitbu3PDYqrpQwp05QBtMJARDUd8nSD80u+bKCmjLWaA==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00148.txt.bz2

On 12/24/2019 2:27 PM, Ken Brown wrote:
> Set errno to EOPNOTSUPP instead of ENXIO when 'open' is called on a
> socket.  This is consistent with POSIX, starting with the 2016
> edition.  Earlier editions were silent on this issue.

Please ignore this patch.  A more comprehensive patch is coming soon.

Ken
