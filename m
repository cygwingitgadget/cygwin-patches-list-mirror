Return-Path: <SRS0=8c6S=3S=vandusendesign.com=bonnie@sourceware.org>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::62f])
	by sourceware.org (Postfix) with ESMTPS id 89402384F4A8
	for <cygwin-patches@cygwin.com>; Fri, 18 Nov 2022 13:06:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 89402384F4A8
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=vandusendesign.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=vandusendesign.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeuCey+i1RMo/dVw5+LD2Tf1QsEt48Tuo6JvxImI1/SSFBu4VZ9i8lKzAeLRWqTeLbPwJDoKM5cCS51PJ6V+CC9kw3MEs7vlJ2Y1Lu4rtZyeRLDRhLOZyNJ2nUPwSGVIZM6KQQeYnY0w+afosYdXXBTdxnlXiGaf4iGhBBC0AEpqUDE8MhSLcCOAhY79/Z4gzOM/9R40/sw6JaowEj9eRNHsSa9ys4vKNBTDoyBWrFjo1fRrG32objaeNcNa/+RnyyouNqGgp8MuHHj/qHySsMPEiQW3bW3D4T3vbW0bF2ZF5+ZzBJdCYw1BK8TEbn423QbrBpfbuo9nORfMDgY1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyA1jMvZ+U+CtBCwoSWuhohhZNmb/SXYva04FbyVEg4=;
 b=WtUIqX+3spYB17XKDM7u3jbT3mkewr0E5SMUrf/e8scO/qlD2No9PpFIJUdX+w8HFMQIIRc2bP4rBIdD3b86HW6SpCz0gOFACtPEvtRBSSYAmnynjamkfAzFFW2o1TB3bwieSzXtXgTQxkL50JhVd9UNn4NyoNM9lqwPISf7IQesbKw7y5cEj2LLNFs2lpF9oYriiBiZRUC0GnN3njNrjb3Mi6ced3lRgWWK6ND+6QJWdry2UwfxZXiU/lOuAWhqqOVUTJEx9Am9sjyQXmwlxJZJ+42W18OWNpv5NYNPegWdLCjwJ8d3pwn7/MpBYG2Tc7rYmovMashsLll4rKAxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vandusendesign.com; dmarc=pass action=none
 header.from=vandusendesign.com; dkim=pass header.d=vandusendesign.com;
 arc=none
Received: from CY4PR2201MB1077.namprd22.prod.outlook.com
 (2603:10b6:910:44::39) by PH7PR22MB2990.namprd22.prod.outlook.com
 (2603:10b6:510:13b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 13:06:55 +0000
Received: from CY4PR2201MB1077.namprd22.prod.outlook.com
 ([fe80::8134:aa75:6c12:9e04]) by CY4PR2201MB1077.namprd22.prod.outlook.com
 ([fe80::8134:aa75:6c12:9e04%4]) with mapi id 15.20.5813.016; Fri, 18 Nov 2022
 13:06:55 +0000
From: bonnie vandusendesign.com <bonnie@vandusendesign.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Your OpenSea Order #25MBG557ST has been Confirmed
Thread-Topic: Your OpenSea Order #25MBG557ST has been Confirmed
Thread-Index: Adj7S2mtlamCsy5aQBWQj2rKixCznA==
Date: Fri, 18 Nov 2022 12:48:13 +0000
Message-ID:
 <CY4PR2201MB1077AA14B4F4D4CE39BF1A52B6099@CY4PR2201MB1077.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vandusendesign.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR2201MB1077:EE_|PH7PR22MB2990:EE_
x-ms-office365-filtering-correlation-id: 04824014-21df-4ff4-03e8-08dac965c47a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2EmMFI5dv2YaBUbwDC2GSqvJ4BorNL4a3+0VFQNOSmW7Y7dYf1QtyAp8YhJ3yU6XWtXZS414kHW9w/JcOTgSbF/qA867xVdEVf+jSLmIpPzXXF/mWCL9iOMwG+kEH/DTapvRIiI9bgE8NJTvxR8suInxNLeZTEXQBCRYDiWDIge9Dcu9gICls1v7QcaBceNJBWoaJgk8xcPloSALBKUJeu+pe8EaLHowOGNRcpDMCrmZeGktsrwgeB58icxDPZBbWxaNEy6YG1uuvmDzHDJzZVhjFm9ur2ON6GWtDpdxjt5bDfVRW1dcg56zNXEiOHViBbmibyHWB8heylF6+yj7FijQG8fKF1NG9yxA89qRWwczt4KMdQz+pQGqs3x0MdV3uziSfp2vwVpQLZ919ildl87osFapizsBqu3AYk3lCgRT7Ys7QVDxwTP7QLxnjZyiDL42TyXtvxs6SPJAFknICgCA0ycbgRgHe4tuAQi+e4mZHDnrg6EAyn1fK+7L1iYSo0y4HKPt2doCencj/wq8gNXx3VOhMDUYMUfywOPb4j5v1+4VKjeaqAzMEuAiI+CeH8QbvxjELgxr/tOFz5lsMbJYVp8hJREEalZmO8iZHdZxi0HmyCnkXeEwwjfF/al4qW9iuM6831cy60dxUYkV2NaF6XKBlqLEKyp8V5IK+k5Ck0U9eDB21SbTCH9VLT1P
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR2201MB1077.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39850400004)(136003)(376002)(451199015)(71200400001)(478600001)(6666004)(66476007)(83380400001)(26005)(66446008)(64756008)(76116006)(8676002)(9686003)(66556008)(2906002)(66946007)(41300700001)(186003)(8936002)(52536014)(4744005)(5660300002)(38070700005)(122000001)(6916009)(38100700002)(316002)(6506007)(7696005)(55016003)(33656002)(86362001)(40140700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w2/QFmvjoHul8tBGcAikVg1t9pp8yaMZVbGEBx4SbQEe0/mHxlfH3KBHOBtu?=
 =?us-ascii?Q?wQqohcQVHlvnN8706E6wOSL3yxmZBCTRqh1XOIs7rgWoxSpkIqSwW7uK/X4t?=
 =?us-ascii?Q?noDKAKyZNUWdWYQQJsh6VjUIjMt/UJsgUGV1XOX4Pl8mskyLi7cdhmBfhjbF?=
 =?us-ascii?Q?kDTgkKocBV30s/4rDMFtN5PCgVnR2lzkq2NfTdy+OLQRQch7+Usv+65PEtW3?=
 =?us-ascii?Q?+grdpYeBhx2vd+Dr+68nRsopWqa2TuAI42vd+XnrHhMpq3kmHneiQkNIh1Xi?=
 =?us-ascii?Q?byrtUp75Um4jUSXKlQcvcLxcDn1iP6yisiz19COwWfGzaEK2RlHyvwTOxzDI?=
 =?us-ascii?Q?HkWooT6/nZmmX9s0xOxAAopbN+qv20W/2dDRPWdRCBoB/vbq+98uC8FRo6Ii?=
 =?us-ascii?Q?ytraW//OrlUhKTKx7+LqV2hUUzKeM2+MNZkw6xmz52b2M9Tj0BriePpBUvck?=
 =?us-ascii?Q?vq0TMrA+Ug4nTqasTzpmHabe6qZ9MsJ/iIHrPDkRRPIc707eP5R8UCIrFXVg?=
 =?us-ascii?Q?TH93riOePlzTh9hTXp4YXQrsh7f6gTrlYbmVGLzqf/f0h4GIWV++w2yyzvDI?=
 =?us-ascii?Q?Ioo7RPGQOxLApZXHLTJXKJX8wbt4dqMLIlivdXYPz0ssBqO1aH5Dc64yd8y9?=
 =?us-ascii?Q?awj457Ojxh4W12NXEEekOptQsZ5siDGWxImbENghJj0s94WRN96CaDNHMjR1?=
 =?us-ascii?Q?fGbVwmKoWW+ej2po3zcYoWQE26dGVxoPW2lFLyl678AqD4MYYAwinhjXdC9S?=
 =?us-ascii?Q?0TToUOeuTn+KgoIYcHA9Za6G7FO7bBpaYfSW4b8zhGIfpDoUQ0kr1UIPbB/3?=
 =?us-ascii?Q?QBJDGFFDaCh4y8eCV0kHf3omGKcIYB9j8slOp2wnsGlLRbm55ItbLvrbKXXj?=
 =?us-ascii?Q?3YppbbhQz1Gob8sERWpSvvm2AehtMdMfMxErOev1PQvMpS8p8d/x5EjkzB8t?=
 =?us-ascii?Q?9MWJZ8OQgbhXilS0E9Oz3t76SoHVRhptVweT05vOfpjRgUklp73B2m/i+AZ3?=
 =?us-ascii?Q?jjEb/5IgKBfN+ihv7y33he7sTvlUoIG4alisUfKLZrEL0E6XACh+cbQMV6SU?=
 =?us-ascii?Q?I+HKj+rlp3Wf2AZxQRoH4i/Hpld1IfbtCvq85ncg8JtMXqSPukNLimXXJMF+?=
 =?us-ascii?Q?UgtfiFfhYDH9hmPGJunKxc5HxcjZ9EKOUrF7zNQf/36XhC1w3Z1+zhdkE7iW?=
 =?us-ascii?Q?g52100j8xlnfTqkl3ujiFtVrsc42zmdMFzqp4OaXHquixts8oO9isEiv9gHk?=
 =?us-ascii?Q?KDdfWfr/8AnFW5zXYHZoRNYox5r1K09qEkEswjD1PW4ELhSiuWcL+7EQ+11H?=
 =?us-ascii?Q?Y83eiDXXQwgZaNVBQjvfP0fA2mawVLq4lk8mhkMHb7KtLbkk6zpJ3sKP2MP9?=
 =?us-ascii?Q?seit/WR6+Enfv3SAwz5k/IlSE5/JIJU9xIHKt6JXq5TaoUfKu931EVX17Ut9?=
 =?us-ascii?Q?xZzFd8FGCV48yfwoVf0KkjZ+X0niMsu9ZGX3h+rUHUZV1miTnYihaUhmSY5y?=
 =?us-ascii?Q?WA0nd0DGzwBjrcT/eVtE57RAoPv+umHwz81wNWjltUH5yItA/S49nYjXGnZD?=
 =?us-ascii?Q?AiNrLewfM0DW2kz0u2LJgUlNy7DIK4MzSY56FMjQ?=
Content-Type: multipart/alternative;
	boundary="_000_CY4PR2201MB1077AA14B4F4D4CE39BF1A52B6099CY4PR2201MB1077_"
MIME-Version: 1.0
X-OriginatorOrg: vandusendesign.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR2201MB1077.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04824014-21df-4ff4-03e8-08dac965c47a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 12:48:13.4030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2ea9ef46-1c52-4261-b50f-60e84f634b25
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDawHK1cMz4yUgVjsWqui2yI4uH0eUZKMftb70Og3sr7whekEIKmi6DzQlsqcNLNbToTKaFbd1Efvpf8M+xnICeLlkHiKG8yOFE7LJrnHpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB2990
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TVD_SUBJ_ACC_NUM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_CY4PR2201MB1077AA14B4F4D4CE39BF1A52B6099CY4PR2201MB1077_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

PayPal

     Dear Customer,
      We have finished processing your order.

       [Order #25MBG557ST] (November 18, 2022)

Product
Quantity
Marchant Name
Unit Price

       Crypto

            1

OpenSea Inc

$699.99

Subtotal:

$699.99

Payment method:

       PayPal Credit

Total:

           $699.99


Issues with this transaction?
You have 10 days from the date of the transaction to open a dispute in the =
Resolution Center.

For More Information Call us:- +1 (800) 775-7798

Please do not reply to this email. This mailbox is not monitored and you wi=
ll not receive a response. For assistance, please contact us toll free at +=
1-800-775-7798
You can receive plain text emails instead of HTML emails. To change your No=
tifications preferences, log in to your account, go to your Profile, and cl=
ick My settings.
From,
PayPal
2211 North First Street
San Jose California 95131
United States


--_000_CY4PR2201MB1077AA14B4F4D4CE39BF1A52B6099CY4PR2201MB1077_--
