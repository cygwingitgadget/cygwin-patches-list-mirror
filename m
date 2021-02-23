Return-Path: <kbrown@cornell.edu>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2104.outbound.protection.outlook.com [40.107.237.104])
 by sourceware.org (Postfix) with ESMTPS id 6CDEA382E804
 for <cygwin-patches@cygwin.com>; Tue, 23 Feb 2021 22:50:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6CDEA382E804
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDGjqL5U6LRaKYFHkvm9MC8/11JHwstPOPrjIoH4T/AjN0XVWZPwNoV1BDZDd51qW/KNwzoEixU/srahl1Dpw7UAGki2BCj+FJpN8sprB7bbZ/vN7oXC4pKmr4Op2au1vUE6I5uTeFOOJEareKpH0g8Tt66EapLjegrYY3nELNWgusF7U3GzvulCSk/xUO0t0BKYp3PKupO4rPkV6K8VmQerIvLDs+wJlIId1be+xzOfO8q+rdWvqlkFxONLQP/g757W9SC37eVjat0iQaBdrRSgnv5vaOWxI04ZctIMNxmZ+DuL6cSypKH/MBbHpczwraoS3l+8P8VWjUzq3b+iuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFNuCiTxJLtp2gexa9EbSMO4ox0sRVskue9RwIBYRmE=;
 b=BSk7K13iuXULdMsun3n/tcMeiNgNYGS5c3TbxO9QHKWjE/8iVqKLP47z2LZ4QWO/OQdZU90bJQRts+gvNLmSuJPcx8VJey6ktpLwG1/gUanNluJ7OX6kkz9ryOMe4Gx+gwjrAphf6heCRY9qjLBpJeC6baCJ8IyCdF5BGb1hERSN5D/cbHu1G4xA4nP3z8F0ihfUshj++/LH43s+X/veH+abJ2MR7TSHhpFp6Cu3k3UeuP69vV+JwJbft5AHZp01KIUzMKn/pEACEK4PgReEBigA1z/oiVNpt68ZRdm+QJLL1VKyOJCAj08GADqvJ2mEvJetI+b5B5Swe40M0MnRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0866.namprd04.prod.outlook.com (2603:10b6:405:44::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 22:50:09 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 22:50:08 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/1] Fix facl on files opened with O_PATH
Date: Tue, 23 Feb 2021 17:49:49 -0500
Message-Id: <20210223224950.40895-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2603:7081:7e41:6a00:7520:1923:6c05:708b]
X-ClientProxiedBy: BLAPR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:208:32a::26) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2603:7081:7e41:6a00:7520:1923:6c05:708b)
 by BLAPR03CA0111.namprd03.prod.outlook.com (2603:10b6:208:32a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Tue, 23 Feb 2021 22:50:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd05e51e-38bd-4733-61ee-08d8d84d5e82
X-MS-TrafficTypeDiagnostic: BN6PR04MB0866:
X-Microsoft-Antispam-PRVS: <BN6PR04MB0866E6F96E4661FB9913452ED8809@BN6PR04MB0866.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9eicwtQqgZaean9DrPTjWi8P9D9wcpji2SgGPpVrH35fZfpLEpXAhW96ZADEfor+jbMpUIluOIFR8DCXfPr5Cth+0Jt5Pwwc783URdrVhhmKn+ERwp0wwN6jbMPp6mXV+iECkHb0KGlzYLrk1OWMNfkiA4UeRhKe1t9pyKIb5NfzocUPDkvZ76NrhlMEdXabWq9cd9lrhy/HBl64JdUVcXdTnu4czVurO0n92afdgqVvU7oaTyR28dMIlFnAvWDfEuJlbeFUh9ojo1wiLKMt1txwXy3lpYdcTf2Bbwbgj2zpW46zyB9BIyuqUVldBEbFOCXOOFXTsWiN9gSXCx9w+JFEDQPkW+9PEaT7fOAgFaymk0jhDXsuzjF1pk+i1lbAjIm8j0ufyE28GYlTkIC+CKL4nIHzvyHWkRGbSRkD83q7lN6XU8tNhtz0/mtnQ4JNSS1m68QwnwWFZhBKI6Ei7RudnHXbNhvO1SbhJEZPUDYPfuDZGAXJ+pqHfsyIHi7+vPAce7bA0qxsTWcixDuwcIn84q3fAucSNqYxNuSvc9pNMvsyWwMKtjkSx02uyxSAvOXtmZw1OJdWGYUNskRZYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(6512007)(4744005)(8936002)(8676002)(5660300002)(69590400012)(6916009)(2906002)(86362001)(478600001)(6486002)(36756003)(75432002)(66476007)(66556008)(66946007)(6666004)(786003)(52116002)(16526019)(186003)(2616005)(1076003)(6506007)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1cPCdIU964VJsiVHq57EOkq1rjBL8/SlqfV46tK2gzyQEkGI/kKOnRFshL3J?=
 =?us-ascii?Q?TmvYfyDKdEZTyyT/RAQZOg3bFNmnvHcivRajbOEyXjAwhWsyGciaEkBaHSHz?=
 =?us-ascii?Q?g7rtPLCCC+ggJT+tgyMG+B0KdgVL9HaUVuQH2uHcEHR3skSTp7G4msikn7im?=
 =?us-ascii?Q?AnXopXLWM1CcdWAitbvoPeC6x76qs54wJFycV2kviS90ZscubC6WQQPN39ri?=
 =?us-ascii?Q?yNivAcl+/wQ2GNdQVC90DVdByxVFEY3nPP3M/3VZKqOV4EKvZBuwMzIAnoMU?=
 =?us-ascii?Q?8OBw8YFBurojVlTRZX58gAc0EEaNwlhxCnTViZuRQswgfMlPkhNPN3sC4jMz?=
 =?us-ascii?Q?cLas7x93hjGCZ5RgOe+pcr2obmwxt1MPkarMWxNcQ7tI/YBAWVNdNht0ltMj?=
 =?us-ascii?Q?ufBxPt4EmAh8kHbF7M4PEut7pPAdm32dgSd6xg+SuS1JKW3zCOoZdgUeZnwD?=
 =?us-ascii?Q?165crzhzuEugUJfrxuFpq+7pi50wIYXkWXtKBnZqXSRcg/R62+I0r+DF/UVf?=
 =?us-ascii?Q?jkwwubIfyJM8w320KnS8DKCSkBkDlBfv4XFzwuKrEBw/g4GYLSy9GzO4EVJY?=
 =?us-ascii?Q?U2n485xk1CL+tSPWbZ+ifC/86ZICepRPBvl3ylXIwZihHXRO/RBb6mrarVKS?=
 =?us-ascii?Q?xI12J6v00jlp6EBqNfwBz+8OW7sBdaE3GXUZ8Qdaci4n16mV4Qjm+S6d1Ml2?=
 =?us-ascii?Q?L4Cg8+/o71cn/b6s9krVoC/0fVm6iIjLHGdMO6YfBZYzA2EBhY32639GFNOD?=
 =?us-ascii?Q?c96Rmb+I8PBNM/t0sA57TO7+3EoSd0Sx8kt4YfaG30SV8Z6q0AD59jrIey6d?=
 =?us-ascii?Q?KQY4/3wc7SjWUFsxp+o27TRKf9jIhbXZCdjXevT4Rb2Jm0Sc1UDGzr62343i?=
 =?us-ascii?Q?UaPKN6b9LZRcvFUW3eCwO1YBFLXtA3WqwBlOTkuWcXHewRX1/+2bSgKw9gxF?=
 =?us-ascii?Q?bSzSFa8Em2QHx59qboYyPoFYabiT/7w60Kq+AJruNAlon/dMDw++e1iKTE13?=
 =?us-ascii?Q?ELkB/SsKQvfhH4WA1dumk8RDzG21CBBaR9Kx3tgA81l7VAKItSVth5xA2PLv?=
 =?us-ascii?Q?rtFIjvx5wXwlIs22UUxAz8HyzMs1UKHHsbwb89OJ73w0+rOZSeVPbqiFIcG9?=
 =?us-ascii?Q?Siq5pkiIASWjziEF8q6AvXZqw74Hm7V6QYeqE7gCurhlJ3ONRscgmjcddzz3?=
 =?us-ascii?Q?6VqEQcf32tCCH7n89wqocyyqULUSgF/H5aL6hoT8fS3XL8khY7aEeHK7SSUT?=
 =?us-ascii?Q?02uTjI7cs3cpEXQ9USOAsHB34hs9N90LzmUt0o3k6+kHSej0AVVqIn9eTm5V?=
 =?us-ascii?Q?XgAklMws5tNx0kmizmy/79fro6fYoevYsD3iUyUl4+JzHp0Ozf0r3DtC6RLo?=
 =?us-ascii?Q?v1cmGzHssvCmgMe2kAR4CkuuDWCJ?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: cd05e51e-38bd-4733-61ee-08d8d84d5e82
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 22:50:08.6997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hutij1akBv+wQ4+vXHzbnscijpSlW9c5HCJvkGQL+B3gL+5qY2H1U/DB+b6Vzdc2crrkqqpugbAk3n6au6h5RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0866
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Tue, 23 Feb 2021 22:50:11 -0000

I'm not sure if this patch is right.  Should facl fail on all commands
or just on SETACL?  If the command is GETACL, for example, should this
fail like fgetxattr(2) or should it succeed like fstat(2)?

Cygwin may be the only platform that supports both facl(2) and O_PATH,
so I guess we're on our own here.

Ken Brown (1):
  Cygwin: facl: fail with EBADF on files opened with O_PATH

 winsup/cygwin/sec_acl.cc | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.30.0

