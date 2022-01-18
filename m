Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxway3.hub.nih.gov (nihcesxway3.hub.nih.gov
 [128.231.90.125])
 by sourceware.org (Postfix) with ESMTPS id AD9E33857C53
 for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022 16:11:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AD9E33857C53
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.88,297,1635220800"; d="scan'208";a="331384841"
Received: from unknown (HELO mail.nih.gov) ([165.112.194.63])
 by nihcesxway3.hub.nih.gov with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jan 2022 11:10:45 -0500
Received: from nihexs3.nih.gov (165.112.194.63) by nihexs3.nih.gov
 (165.112.194.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 11:10:40 -0500
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (165.112.194.6)
 by nihexs3.nih.gov (165.112.194.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18 via Frontend Transport; Tue, 18 Jan 2022 11:10:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9V21QFKj/mqW4fZspm8bFsUnUJmrrr3p/3cddgBjaEdm40Mz1F+QnNNsf+S6g2PcdauC6q02FydEsQKFOYXn46PyQ/uK5QAIzeCmx3bA8GeqD5jCmpTMUqzGkB5UwsEeN+SSWSzQZNmtQFnsRrkGMy06nw/MKdWpP0lKW1TpYTBoaNBqtxJtnIsgWdQykk3OzUO8jsv2B2BjS517MgZXc8Z+XsOxwFLJT03cD8YE/ry6vHt4+Z9J/ZuUIQfk3Olu4Ky4dlO+2aE9/kAX1EimiLSsRiRnTwKqAjLstDutkk/9Ur4zI9mfjoaVJh0/MfZjLSh4iR4+hi4atU6tCGIbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUs4uFl7MSUq6VwYOov+9rFn1T1PJq7pnjnyKq+PrRI=;
 b=Z7/tw2Q3E/UhrU3RAOD8bd4hBhuUFMi+8WM56zA8PA+vI1ONSz6d62pYHxeZkNoHxUaEmZINTK92fVB2CjpLB2wulYPIXqqjNajF96P0pezIepx1gfJ9Vfjt/1MYHRccGy17IHakPPdDn3lTS8p2ETfs0hlgEUS+pAbtaxczqT/W6eunCJu1BLw9hLIfGOtckVWxsEoi3MubjAW/aIJQn4LEImqKFf7HAhxC5NYk92Zzq6bUcjtc4o4BCqGAtmm+eLDfWWNE6yn3jYZQ3FXZBTtTNL4ICHuKq8xxV21z+VhXwOEVxyuJiuw2r00PCxVtR5HRs8cId8rzEGYJrT7Myw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none
 header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
Received: from DM8PR09MB7095.namprd09.prod.outlook.com (2603:10b6:5:2e3::14)
 by DM8PR09MB6407.namprd09.prod.outlook.com (2603:10b6:5:2e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 16:10:39 +0000
Received: from DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41]) by DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 16:10:39 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH 2/5] Cygwin: resolver: Process options forward (not
 backwards)
Thread-Topic: [PATCH 2/5] Cygwin: resolver: Process options forward (not
 backwards)
Thread-Index: AdgMhe75RVWRyn2ETEW6G3iu9mPGiA==
Date: Tue, 18 Jan 2022 16:10:39 +0000
Message-ID: <DM8PR09MB709501BAEF27549E39A65308A5589@DM8PR09MB7095.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c85c76a-cc09-4d3c-480a-08d9da9d1215
x-ms-traffictypediagnostic: DM8PR09MB6407:EE_
x-microsoft-antispam-prvs: <DM8PR09MB64077F168822589778C83B79A5589@DM8PR09MB6407.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:421;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X5LxvoTYPlWI0quT82teLAAdAVtMhobV57IN0zRiJY1Biuz8MhUbsCL1osfyMiQaSxSfXIXlGoceS8H03TT/1y/rGEWntVhaxyw7d08L1ON6VmireW7OowMhNTGp38kYxQgy3vDulQ7f0dJaToZsdjNOPvA2bV8WTuMP5sto+sxAF1fMj4uFKqdIJD4SO1GSCnhN1LC9+cMQ9VbCL60ixg9nvCW4i0H420sg81vz/lU+Qeo1otrWRabf2qTwVK00lC99nyKbWvvKcnfmbkaZ7jFw0olaWY5Y0hnraG594015vr2ARN9otmrk43FWsXHnmXnVbwpRndcReD9YT7wQQSdho0RK1+EPVRIF/PifiZeM7z7dv64mbDywtscWDIeGVCxVr2QjGnz/H6EvYVbQyiNBJZqIzhI163ZSHo1/hImANBCl28fj/QLSd4tY1KrntrK3glzPTyVvodkcC1s8bEAeygyS9m5ihcT7ZyqlJh4pU/Zq4VUF2ytzy/uIJ+UTFfvNRNodj+UjyxvPxoq+335iKR6ceLP5WAIRWriTYWhnWEq2HLZu8/GBjRvBzPNDBlmuHSiZbfYOnaavbNV8LgQdcTvc//xlP71eTa/nyVOl0xrMLlfOKLKt6hb7Mznn5ighcoWTJ4CEyZ/Gv8yDlNv05N7eq4H41vROyJc7G+WTwEMtSnqbImb5QrmNwUV+x/pkhu6gItRePrPCvt+WYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR09MB7095.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(2906002)(6506007)(122000001)(66946007)(38100700002)(66476007)(76116006)(71200400001)(66446008)(38070700005)(64756008)(55016003)(83380400001)(26005)(186003)(5660300002)(33656002)(52536014)(558084003)(66556008)(508600001)(86362001)(9686003)(8936002)(6916009)(8676002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmVjdHJyT0J0WDBPU1NTWDAzMHYyNGdPcFVIRk9YQitFVG1sU0hxZVpGV1BU?=
 =?utf-8?B?b2FqbEY0S3Rid25VT1hCbHF2bUJmMUtLV2ZLc2VuRjh1QWNOdFpwQU4xNEJF?=
 =?utf-8?B?S1lxNGdNakhhZWtGbHBzeU5ZK2JvTGU2WjVDbjVEcGs4MGptcUh5aVBJSENp?=
 =?utf-8?B?djRLc0ZtZSszZEkyaGp0WmxYZXhrVE52Vjl3bG1rVTJXY3hBTE1vZkR2Wmc2?=
 =?utf-8?B?ZHFoYVRNTDltT2krZTcvc2crUjlrdjZIbHFsMmJiQjlRUXAwU1liTmtJcWVE?=
 =?utf-8?B?emZvZ1llM240WGQ1ODBFd00ySEs3bnFPTlJsYUNtcG11Q251VzQzeTUwbEFJ?=
 =?utf-8?B?My9DWkFWeXNtVHluckpkWnF0aUZpWnNXUlR1SHFqckE5M2xWaUJvejh1ajlT?=
 =?utf-8?B?UFVQNUdnb2xJemoyVzFHQzJqYmx5VjZTOVZyVDV0YndBQXVaSXdzNHhmbHFQ?=
 =?utf-8?B?eTFuK2NxdDg3SnBRSSt6ZFIrM0RvYUkrVFdDYjJUYXQ3amJUeGRZZUp6ajZu?=
 =?utf-8?B?cUw1RFJQeGI3bjVDZUZaSG5MMUdjS1Foa0czSzlwZmtGYnpWOEZVVUZyQ01u?=
 =?utf-8?B?QWdBQ2IvaWp6THN3eXJiVjdRNFBIa0MvNmFaelIzRFNEQk80dnR4T1VKeFJh?=
 =?utf-8?B?cXdXRDVTUXhyeWlXQ2JoV0x4UWZqTWVveTdra0dxODBpc3BIZ1VGRk9qb2pV?=
 =?utf-8?B?d2JkQk5JNGMvOVE3MWE0MjhFY1VadTZhaDRCcmZ2eUlwb2hMZCtGeVVqYWhJ?=
 =?utf-8?B?SHBvN2ltMmlCa3hoZmtxbE5vMDZhV01WWmZidVM2Z0g2bDZpKzUycGhzdmhY?=
 =?utf-8?B?SWU5NnNldUNwVVgzcXhPZkQvQXZpRVZ0SzVkVmZaTVF4ZlN4NWNCV0ZyN1o1?=
 =?utf-8?B?MzBacmh5dzdzaStiMmhWME1MYmNOZXAvU0N1cm80TnNMZWt0MUkrR0hHbnlM?=
 =?utf-8?B?S1lrS3FsUG5QbGEyR2VyYThEM3pXMUo4WnlTcS9vdlZIVjdsOElaOUJzSEs3?=
 =?utf-8?B?a29hU2x2RE1iQkpyU2JHWDFuZ1BrUjNOU0ljTVB3dWREdksrZnhCTWNkQ01H?=
 =?utf-8?B?YW81UTJJeVhEM3dtdGs0SU5YeWt5a2RyUHVWeFZpZU9lblJEZ0xOR2t2dHJG?=
 =?utf-8?B?WDFhQTRIWEVYcEJ1SGo4UXJlTlVaMmZTMVMzbTBWZS9PVFBxTzNMNVA2U1FY?=
 =?utf-8?B?OGpOYndqOUw5aklrSFNBQm8rS2RTSCt1NlNOQzFOMERYNkhUTEw1ZjM4SkE5?=
 =?utf-8?B?Nm1PaFV0NS94b1lLQzlTT3R6SHp1S0JKamhLb0N4VEtSVFNHUU53K2tuSVQy?=
 =?utf-8?B?WnpKRWVWd3NJZlRyT0hmQ3FXcGxwWVlBUDB5cE5PUXVuRHAvSWE2cFhsc0N0?=
 =?utf-8?B?aDZubEI3bXdORUJ6MVFjeGJSM2hXQ1UveG1VWGFLenNaWnR2WWNqeGE1R2I3?=
 =?utf-8?B?ekNmQXlkMHFkY3JNUFJ5Tk9EUi91Tnl0TEVjYjhYRmp5TWkxM2kwTUd1ZEFs?=
 =?utf-8?B?WEhLaFVXSG1Ha2NMeGFYdEZ1NmU3eW9VNlZIM0NjNXNITmtZenJYR2YvWWNC?=
 =?utf-8?B?enZCQXdlZk1yMitYWnpKMHF5MmFieGJrMjBENFFjT040VUlSajdQdDM5VnBj?=
 =?utf-8?B?cWltdWovVXlYYnRPeGVyRHNFZGFPT0pPc1N1d3ZqeWFydzkxZ1ZnemlpNU9J?=
 =?utf-8?B?elBkMURQcEF6ZC80dkU3Y1NidFJwQmpBeWF3L0FkVStVNDd2cit3SDhDVTRE?=
 =?utf-8?Q?C8IaB4RrGCgYXIIDHU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB7095.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c85c76a-cc09-4d3c-480a-08d9da9d1215
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 16:10:39.6217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB6407
X-OriginatorOrg: ncbi.nlm.nih.gov
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_EF, SPF_PASS, TXREP,
 T_SPF_HELO_PERMERROR autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 18 Jan 2022 16:11:18 -0000

PiBUaGFua3MgZm9yIHRoZSBkZXNjcmlwdGlvbi4gIFdvdWxkIHlvdSBtaW5kIHRvIHJlY3JlYXRl
IHlvdXIgcGF0Y2ggd2l0aA0KPiBhIG1hdGNoaW5nIGNvbW1pdCBtZXNzYWdlIHRleHQgZXhwbGFp
bmluZyB0aGUgZGVidWcgZmxhZyBzZXR0aW5nPw0KDQpPa2F5LCBqdXN0IGRpZC4NCg0KQW50b24g
TGF2cmVudGlldg0KQ29udHJhY3RvciBOSUgvTkxNL05DQkkNCg0K
