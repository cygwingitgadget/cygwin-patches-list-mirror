Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxway6.hub.nih.gov (nihcesxway6.hub.nih.gov
 [128.231.90.121])
 by sourceware.org (Postfix) with ESMTPS id 14DA33858C39
 for <cygwin-patches@cygwin.com>; Fri, 14 Jan 2022 20:18:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 14DA33858C39
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.88,289,1635220800"; d="scan'208";a="284850337"
Received: from unknown (HELO mail.nih.gov) ([156.40.79.162])
 by nihcesxway6.hub.nih.gov with ESMTP/TLS/AES256-GCM-SHA384;
 14 Jan 2022 15:18:56 -0500
Received: from nihexb4.nih.gov (156.40.79.164) by nihexb2.nih.gov
 (156.40.79.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 14 Jan
 2022 15:18:56 -0500
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (156.40.79.133)
 by nihexb4.nih.gov (156.40.79.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18 via Frontend Transport; Fri, 14 Jan 2022 15:18:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PodCCTw0qGvRauZVUxEEA/v70YbiXAAE9fkPh5Mgpz8FMdqd9SbXWHZfqVWR3zUltumvEs19ndZPAYDts3PEWuoikkoBuEUGyTPOTHso7S8Eu+wIegZo/Wqi+yHo15zIk/8apz/3dR8NeqZZY0vkDHfh0Bn6/vUs82kam60Z8OjkRiBy7JkvPmhD0+rDsSldDmGlwa3KMKQjK3YD8sfxcBtFmQW5OK3Y+jURX3+5EnQWrqHGAaJcZ475h4BBPeV7VGs9vAi+FkNRq6s4DbvVMETMmUB6iXJ3Af4LmAKxdQLFssF0DrzAjwk/cckrgj+EKiEsYKuyDDfbDSeqAwPrhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Xkyn9o/Kel39KL1B/bgEiKQcVrR2K8vB8Pvtr+Tx0k=;
 b=HQG59YXpgOAjGAlPohNXpQbwakROPU/GXJhCohfQIMtLLwGJBarId/0XWuYGNq83PykCHT1Bbk5aC/b5bDBXKWPFUzSqT5SYb7YUkJeVOqaopQXcdyo/C7O4A2Cfe25+oFWBDpoqFmrq9jKkNCui28Z4kM2QsInc/oqVK/WP8Kd0yimekQUXE2u5SKhMgcIJiBOVIWXK+mJgTaOqf5lSv70Yz3TO7ygXAManXUogUEK3lmuq6ibXMPlhUnvMDuzGYgYThuAD4qaDtzV4Y3WaGpniU6IgSkDE4RXIzsCnpa/L3UJg0hjKTDXtn4Ve4ZL0G/lN3fVqYfdgMDOS2pf0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none
 header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
Received: from DM8PR09MB7095.namprd09.prod.outlook.com (2603:10b6:5:2e3::14)
 by DM8PR09MB6774.namprd09.prod.outlook.com (2603:10b6:5:2f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 20:18:55 +0000
Received: from DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41]) by DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 20:18:55 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: Jon Turney <jon.turney@dronecode.org.uk>, "cygwin-patches@cygwin.com"
 <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] Cygwin: Conditionally build documentation
Thread-Topic: [PATCH] Cygwin: Conditionally build documentation
Thread-Index: AdgJg/PT224S2+RWSqG7LmiiAzfcaA==
Date: Fri, 14 Jan 2022 20:18:55 +0000
Message-ID: <DM8PR09MB70950BB104F774E1F959F7BEA5549@DM8PR09MB7095.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6eeb1a23-b290-42c8-18bc-08d9d79b16e5
x-ms-traffictypediagnostic: DM8PR09MB6774:EE_
x-microsoft-antispam-prvs: <DM8PR09MB6774A04E8239631084491EB5A5549@DM8PR09MB6774.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FOj1a2D9DmBtO2anaDt8V+sdPZsVYypCVFzzfHdUJfg9Usga883j4ThMRjeVn/cTqbRw/e2m91Ds9FI0JXjPvosiejGkELtSss5AG4+JlQmFsgavkAcoPcr4WGyBVxhLCdfiiY4BY+oToG0pe4oLaueTwTRM+8MD/dM5Ws8dhy3MSBj4Anmxe52WYCZHQQ4JuepGPVYYgTtqJeEPNd5d4UDJweNUuOqKSnuwfPbKpKsvgV7wRkoWU0o9dVpBLAy/BjNjuwW8ZmKGb6xaqPhLPszlXHhkqkwjCUGA3zHUAu9LqazmJcuXGHiHeqf5liGop8tgTDo+QjotGiqplkRSF7yYkLHILn0s5Dq1U52ElcaWgu+q0sMZtDQlCFd2PXnZrjr1gHueZmplXZMREIp5dGDaanXSLeSn/ahk5qOYI2m00mzT7IVOeg5YaZlo+4xpu0iEAAU9v+xJdhXVOezRzWSCk3fhbYtg9xVitK+MMh0D7f/TJiobOCYpjgyDe+YD10vuwu56ywbT1T+V0F5XfGcPLESegZ6D8t1QmGaoUzEUkIy0ea87jNl4k8a/YJmbeNXfqI8AveUSmS06p70KugId5ObrxCxaxUmlotHXxPcSwQBLu4NjSrvVb6/EZ+IoBKhhmV3uvZQNXOmasjm6+KKbSnYw88tN0mMpyNpbOhwWNVBvB9Ag2iYDdxVoa3MXF5r28NzOZRccZjehu8BQ6sON5aVXNGhJntq7kV9dDlCvGhqXpUoEKwulZjwLBpKDSNhflJAYZpjKtID631rM1PIsH+8QAH00yVqDr4VwOdk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR09MB7095.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(33656002)(8676002)(8936002)(26005)(76116006)(66946007)(508600001)(966005)(7696005)(66476007)(66556008)(64756008)(66446008)(316002)(2906002)(122000001)(9686003)(4744005)(52536014)(71200400001)(38100700002)(186003)(6506007)(38070700005)(83380400001)(5660300002)(55016003)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a6bBltjQNv8RPUpkzEpUHYrpdY3dQt7A2B6Evpv+eSusgLJMaDErMx1+0ijm?=
 =?us-ascii?Q?TFZFdqZPo81PDtLr/LNuZZE/L36KBjSYRQTQ1R5HFRFjb30PqnYhc4ZknGX/?=
 =?us-ascii?Q?dvPRigo4BNVAfBuT7RJ3m5qgDG9xvChDe8GkD2P8AjmyppupTrCuQnhuvcRA?=
 =?us-ascii?Q?ZsYw7DJzggQmJo0HChHrFZDps17qorzi4E/Wq34yibQt5MqwCFWKMdQkue3z?=
 =?us-ascii?Q?FmlrG9Ib2IbCUTEcr1VzQ7fakgsTArbzTImygtb9DLuspY1/ptF2GcuPn/NK?=
 =?us-ascii?Q?Cx68APqTZwcUEXZQCXPvLEO/0jnCbrU8FYJNZcKS3wfpqClsga47yJ6OiDlB?=
 =?us-ascii?Q?37UqRy14CCEOd1hZTPJdSgCKO+mz2iSoBIj9tlLHuory4MRYHcaB5c/EqAx/?=
 =?us-ascii?Q?KsXjb/jcz8bCZBgyltjK4mjV2+DaukdiSZKOGNjHixNqiiEbQPsvLDNWLkOY?=
 =?us-ascii?Q?Z80k9NkxeD7KG49syf9VIJKJp4VQcQrxL7A/3EO/iAQis9JC4Ea+HagASsFA?=
 =?us-ascii?Q?Ih/yjzhjgxCBdU3oDres1qHzAC4+mwfB0XLqEQXl9yTeQqbOs8cb3epLSoYc?=
 =?us-ascii?Q?oNfU4Jt5Qd2konshzFXcAmdKEMP8JtItcADiDcNREguSJ5ylPZ6O90nnHB2B?=
 =?us-ascii?Q?uJ20iumR2AvdyKh6EjKXfxWhDnLW3qS3qZiaIW9kANKEBvCxJlLSSKKFWBCg?=
 =?us-ascii?Q?o4Qko4lej9Uo5d7fGZVvb7V4ZwHid1NuT5Jx4gXTFFWvwmmw27eYfD3MKj89?=
 =?us-ascii?Q?oV+8BxoTTFLjEo7vV+oFsTkjoBHPJuamflX+595+05Qu66jybQcRuAxbnlwu?=
 =?us-ascii?Q?EJQnfA8O8uyjfxmbOYKwBnGy2YCmFH+V3DyMllEamP6kMAelqEscU7TctOgl?=
 =?us-ascii?Q?V6Wh6dFwLWUskaaFY0uTwU4AcZ2vBMFvHwML8UUSR2ew0hD0H5DsAMUh5twe?=
 =?us-ascii?Q?CG7zjZUbJNasTJ512wzPtOe5nOFYQVGqsXM/uTjvPqIQJ6e2FrD7ZJoHfA/c?=
 =?us-ascii?Q?l0QrSAXk7HELJb9o0bN/XkBlO50waMZWl49gBM6jSr0waryCm1q7UZw+vNwt?=
 =?us-ascii?Q?JLYgId2TTCnovVv5dO0bJt8n49l8jTyBPST2VnOzuAhAvyTFte8aO/2D1jP8?=
 =?us-ascii?Q?mdszEt7mgZ5cz/W93DlPvhVdWMhp8G9ie3lqOWxJJGHovkTSRe3AGeuY+uNo?=
 =?us-ascii?Q?yYAPbZ66Jw4OQZ4aF8AIeInW/g1mCxn9v+yjvKm+1QqpvBHINyQneBQgpnv0?=
 =?us-ascii?Q?SXbeIBuF9Z6FYIuHoCFCju0qJ1sVhaCtNjIW/o1YvyxbmJ9i+RTX5kSk1pG8?=
 =?us-ascii?Q?PSA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB7095.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eeb1a23-b290-42c8-18bc-08d9d79b16e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 20:18:55.3004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB6774
X-OriginatorOrg: ncbi.nlm.nih.gov
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 14 Jan 2022 20:18:58 -0000

>=20
> Add a configure option '--disable-doc' to disable building of the
> documentation by the 'all' target.
>

Can you please also add --disable-doc to "configure --help"?  It took me aw=
hile to figure out which option I should use to skip the doc from building =
because it does no longer ignore doc build failure by default (unlike it us=
ed to do).  Also this fact is not reflected in the FAQ here:

https://cygwin.com/faq.html#faq.programming.building-cygwin

which still mentions the doc build errors ignored:

> Normally, building ignores any errors in building the documentation

Thanks!

Anton Lavrentiev
Contractor NIH/NLM/NCBI

