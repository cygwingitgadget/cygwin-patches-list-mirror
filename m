Return-Path: <SRS0=9W9l=IF=leafsoftwaresolutions.com=pcahoon@sourceware.org>
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	by sourceware.org (Postfix) with ESMTPS id 0E6AB4BA2E0F
	for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 12:53:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0E6AB4BA2E0F
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=leafsoftwaresolutions.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=leafsoftwaresolutions.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0E6AB4BA2E0F
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c10d::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1792068826; cv=pass;
	b=rB+BBo7iRnWjDNQuuTUYfOf560zxWzAAGxdniLzuv7m0Q9EBErz0XMk8B5F25FQVfNKKl1IgYm1gxIy9dbY6bI6i2ewcKj27B+Fzq8p08BHfOCYrOsqUajqeCpw9LzxoWtOudQPoP8mXGJxculyRRNNs+gqr0cgvrH67VeW/Ezw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792068826; c=relaxed/simple;
	bh=pNI6JkWaPXArpxd8OyeU/Jqd7WAd5ie+J0WW7JlVA9c=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Ka7k01cSoHplw4Re2akwyvlvLBIeYA+N/hRZkbfV3gyPL0AnugcjCIA5dGgCQXh1TvhlYmKR8GO+9CH4+0yBgtrTqPRb59csP1k6IwEy/1T718pjtHqVT90H2rEmRczsKWQ5xj/AzjWnnQhOeOwWXi+SHhD+CR/FR9cxT50wdrs=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=leafsoftwaresolutions.com header.i=@leafsoftwaresolutions.com header.a=rsa-sha256 header.s=selector1 header.b=V/pSByu/
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0E6AB4BA2E0F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=leafsoftwaresolutions.com header.i=@leafsoftwaresolutions.com header.a=rsa-sha256 header.s=selector1 header.b=V/pSByu/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGo+LbzPjOPY78mM9lmLFEfO/a/XqDK2oNEKxO1WLNvBMMgrxLkW/qTNzoajrjLA9U8V7eghqkfh2j1FK1Kl653VxBzREa1NoxI6V0XBpuPTCIKC4Ee+ek3dG76X9uqMi392a0cTl4oz6QtWnDBNAoe7tSSLJmmE46u6ReUuMUPypO3mxbzsCmH8PnPxlK8pioQ6RduXKva/GurrAv41qA2GZogDAOV9d8sAN2j11E0BpNvWX2rTAdM0tH9FDbZiu8AlAQpo4d946/kjMJtQG6Hz3hiReBi4mWFB7ij8sg3Ud+rHifeNNTiBBqtFLY3MMGoXqydONFNKHjMMgzbXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlTaLG6HcYMvyctoBNw7rCgxkXQYW6hO8oUthu/dBRM=;
 b=ssG+g0JDR6bV37l2EGmWlnPyMM5hdfZhO2obuZkf6hs1d41JsCgC5D2ZBJpu/es2NMsvyAMrzKWbhGvkh6Ikm6HATcIrNyMMyTZGtAqCUMim/rZFe1ZI9vCnK66QFTLcL9sjs4gka9XRlQ3vSuII3jJfNARqLl+C+fcVXe45MKhxgnPXdKJjhZKqjGNYTseP/sxh8I3vYvjyfHDi3lEggIxYjO9HwzAvYiNK3PjmSf+Pvtc18km3CLl3jDy2OV4t4Sv4IzsgRHqI3qNRGnxP4zLAbJ6MGlzCGuhYChxiZs/hLfsymaRRVr1mv57MPhi/Lt5bdOAm1Pysx0Pm+2X9hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leafsoftwaresolutions.com; dmarc=pass action=none
 header.from=leafsoftwaresolutions.com; dkim=pass
 header.d=leafsoftwaresolutions.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leafsoftwaresolutions.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlTaLG6HcYMvyctoBNw7rCgxkXQYW6hO8oUthu/dBRM=;
 b=V/pSByu/NgycRRL0UjRKRKmPE4ur0tvttX42tkU8MahZa0Jpz4i6fXSm8f0Y/kRazKYjg2OJ5GamZ7T1lLb+OUYly5eclkjshhLrW4jAekpG2XhtWH2FosdpVc+7xavzIRb3q6cggmMCF1auQ/gJbJVgRaWHYfXy8k/m4kP6nqQ=
Received: from CO1PR17MB5321.namprd17.prod.outlook.com (2603:10b6:303:e4::19)
 by SJ0PR17MB978438.namprd17.prod.outlook.com (2603:10b6:a03:40c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 12:53:41 +0000
Received: from CO1PR17MB5321.namprd17.prod.outlook.com
 ([fe80::4aea:a917:dde9:bc7d]) by CO1PR17MB5321.namprd17.prod.outlook.com
 ([fe80::4aea:a917:dde9:bc7d%4]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 12:53:40 +0000
From: Phil Cahoon <pcahoon@leafsoftwaresolutions.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: serialize user shared initialization with a named
 mutex
Thread-Topic: [PATCH] Cygwin: serialize user shared initialization with a
 named mutex
Thread-Index: Ad1co23dKjneUTyFTa+1ZfsNcENQdQ==
Date: Thu, 15 Oct 2026 12:53:40 +0000
Message-ID:
 <CO1PR17MB5321E136F3EA222A2D560800AA9C2@CO1PR17MB5321.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leafsoftwaresolutions.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5321:EE_|SJ0PR17MB978438:EE_
x-ms-office365-filtering-correlation-id: 8804ab49-2c80-4138-a214-08df2abb5683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|6049299003|376014|366016|1800799024|6133799003|10067099003|18002099003|4053099003|3023799007|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 7KhXNNXw5Y6/QOZCYERucwKvSdgdCWhuEsrrax+GqQTAwp5DkpCLeFdhiSWQAdHxGcNMBZhEC+pq35g/2gegUlg+4ohqT/mLgvhnXfbWgyRvogcF2yFa6qDnpHxSRKR6j2g8bsED3nM0fpJM1pDQGglGXOjhsoouCe1rBRkBJSIC1IuSWzLAC6xI0Dss8rAx2vLeKYEubGYV3V3eqAYKNBMBoXGYU6+AlqWrb1Pw9sZER7T14VUgGaeFBvM5z5UpRXIQzlXKpPZHLxmlpvJYdXzJxOVyIedRXkNMkAHbWwyhESrEmqxmjTkv7H3Q7FOxLRVXaUxbIo6fqt3k6gdPOljcQPn5ihuIMBE0FX26c94rElYZfCsX2LvbOyG/oYBHyCUwrmOHk8lXfHsFRcOcBhwotZQqXISytTgL5wMrkt53hweXzLQEFLMXmLPHjlk8+X3c1Wm0YaU2J5YYgRVUdIj4trDWz6zoLdnH9zTUlSxVqyYyAM8WIDmxdq6p6t1ulUQaRO4QSh+RuvpvIqJ7z9eLXlyVODoPZHuLgFSDeMh8z79fUIZNQSw3puw/4a/BypT1nO9sjElHtk23JE8J+uycF17VeL8NccdoMTPuLIdJ37Kc9rB3N491es2J+8/1DwRX8Nh9F8WjkeemJoA8inUqdacXCYKp73tARSZhDWTXBXFf4mxN4Y9ndVaQEd1GkRpCVs1kb5ePQ5bdyio7lluu9crpe/OvDPd84ym6R6M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR17MB5321.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(6049299003)(376014)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(4053099003)(3023799007)(261009223027099003)(38070700021)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/30dHf9KcRuNaLWA8zjYPmzXmZCKA+3GaXKVJNqIH4+v0WqiwmLjHGPLvRBU?=
 =?us-ascii?Q?p2i2KTGKl4++wbsdERUvo/e69lfxPAc1rw+0h01znvQr4O0fuD5yTYyOWZmW?=
 =?us-ascii?Q?2Z892EmW2sw6w3tSindOzZZL8m/1+n4UrayVuVjqjQ2nokHFN6GCU5gyuNDd?=
 =?us-ascii?Q?wORukQSRxGORPiP5Y16lk++bDvG79RdDW+RCtVzu0NYe9LxG4Gs/NUkFkdpB?=
 =?us-ascii?Q?GA4ZfKxQFlFUBx8kT4Pl16DJRIFMhCVhln95xeVCP6+vVDvjyNEQs54buIMR?=
 =?us-ascii?Q?F6o2sD+ZZuEGKz5NMS3BZhv0KHs7MTFOEGnjoaU9w4I3ngj+SOvSGIeX5Kug?=
 =?us-ascii?Q?/JohvhQR1r59uCE8P9O3JoCW0RmmluxJmoeKsz0E8XY7qdOUGz/Wq+iNDi9B?=
 =?us-ascii?Q?27OBpcMuqX3qljZeBpxmSL9ryGPDZPIJ2HQ1iFuu1PMg8Mq8BTyMO87xiMh6?=
 =?us-ascii?Q?g2RRnG9AT7iIcQuizfbtoOhODBdqedLBiKjUY2opzAb6jQSmWM9VM5608LpS?=
 =?us-ascii?Q?yqGum4g29fnXIPzxTn1HlLUGVe+tp4V9gDEj/MlF/UOCg3jyW7KPByDDo7Da?=
 =?us-ascii?Q?ssv+y0GnlaouUYbihCchxAQDPPfgtswxMAK+QKhNiN+0McQFY7VWeZwVzvwS?=
 =?us-ascii?Q?2wMhiipiYrYxh1TU0f3qVJJQJVCV/FX/u03M9WGQeEuQy808FVbbGKw0yx/s?=
 =?us-ascii?Q?AyCr/irbObewBKR7qjnrkgiaEICgBUus0RRsq8U8FJjnb2FdgvNAl1tGJSAn?=
 =?us-ascii?Q?9kSL6Tkfw61McaLwDM5Xw9Sju9+jrwd5IGFwHjWA1j8lVEeBjK+C9xVh+CeU?=
 =?us-ascii?Q?Dyw53UMaw7U1UEaXNjjXJKdSpNB/NJCuzXMCezS/WXJxhZWKuI2Bq3rMv5vk?=
 =?us-ascii?Q?DoDDg3rpavZTtKMwAYuH7hXSBTq+ZDvmIXKCRybIxFKUezOgQ9cuk1wBv2JB?=
 =?us-ascii?Q?Ve/kxFl9RsTNkQlZb0WNiUwaaKzSzCy7cmX4jMd1TC65U+GyiCIBmmv0Cf2P?=
 =?us-ascii?Q?83jrDyBsXbVo3OWTtGKFtyn3TU1jTallv0BywWLpzVT7O0tZXGu+rC80yToy?=
 =?us-ascii?Q?goNeVZxHpnbKTDzfffRkR+vLJ2MRfHQSFAiAfawDn4fDXNmIK6Zutpx1uoLo?=
 =?us-ascii?Q?kzcE7xp1el73PmII0Jf82qaMemvlMgjEpblylDSN+QLkaSJl0bvYDkYw7VpC?=
 =?us-ascii?Q?2/cTLpQ/SdY5c9tyEY/WcboRWeYI+xXB8mY47jaK/0z7m2i7VbPiu5eb+GQH?=
 =?us-ascii?Q?E5fOC02TbR16FCvuDccfwG2jMMAW1F6be7ohY+LD53JDwfdJfi/QEAWEGKfI?=
 =?us-ascii?Q?8IOeR/5s5UoRKPLcxKKe1P5eBRhltd5FFWlneVWdy1hW6uL5su5YZ6c/rJLt?=
 =?us-ascii?Q?03DYncNSj+y9mcZBhGuW/z0/IvvU0MBMAV2xfri+RKsuxpCio+3EwEWmj1rE?=
 =?us-ascii?Q?IrtiEAF5u2lILvSPgGJWYDkuryIdRu5BEtWoOpBeDbrlCCd7IzHdqCIISQM6?=
 =?us-ascii?Q?IVwdxTvfA4EwAD0nhO09n298GbzNtadSIdwd3+209hebbdkCQAKuvmE3UZnf?=
 =?us-ascii?Q?tVjrvjdPEoQBKA9Aiknf/w6Moc7DuHGnAJsLRfaLePvpCmBe2UAmbh6yjViL?=
 =?us-ascii?Q?0raFpMi4XQiZI5SdEjKAPbp3f6AjCrD1Ku/Kj0xSPxWuTKiIJVKnaqWDAaVT?=
 =?us-ascii?Q?c/Y9rtz7K49yhUNaVfCVOts3ZZgWKDMLRL3f2xAeEBSNOcfhFEXIxbIcEkJ0?=
 =?us-ascii?Q?/QH4CwZOzuc4/86j0bfVQ/wbOiOxo4M=3D?=
Content-Type: multipart/mixed;
	boundary="_002_CO1PR17MB5321E136F3EA222A2D560800AA9C2CO1PR17MB5321namp_"
MIME-Version: 1.0
X-OriginatorOrg: leafsoftwaresolutions.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR17MB5321.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8804ab49-2c80-4138-a214-08df2abb5683
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 12:53:40.8310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 925dca83-2532-40a7-9105-03cb15e44d10
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVHr/1efwN/ZY3UxkLYUWsTHaevbiDCh5F+YZPljkQspOXe+x5dVJLqQE6DzoIIGQAAF0WYGSopXg/iPS/0wWtJq3IQ3XUJRH+gTMBSStSwrkyjT7XjAgumg6tA4FpYU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB978438
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GB_MSAUTHSOURCE_NORTHAM,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_CO1PR17MB5321E136F3EA222A2D560800AA9C2CO1PR17MB5321namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

The attached patch fixes a startup race in user_info::initialize that
makes new processes die with

  add_item ("\??\C:\Program Files\Git", "/", ...) failed, errno 1

after a 15 second hang. It is reported against Git for Windows at
https://github.com/git-for-windows/git/issues/6368, where it can last
until every MSYS process is gone because tools keep starting shells
while the per-user section is stuck.

The current spinlock times out after 15 seconds and lets the waiter
re-run mount_info::init on a table that may already hold "/". The patch
replaces it with a named mutex next to the section: a live initializer
is waited for, and one that died shows up as WAIT_ABANDONED, so the
half-built section is cleared and rebuilt. Initialized sections still
take the lock-free fast path. The one behavior change is that a
process suspended indefinitely while initializing now makes later
processes wait instead of dying after 15 seconds.

msys2/msys2-runtime#333 proposes making create_root_entry tolerate a
second initialization (MOUNT_OVERRIDE) instead. That stops the crash,
but a slow initializer that is still running can then be writing the
table at the same time as the waiter.

Testing, on the Git for Windows runtime 3.6.10 with the identical change
(it applies cleanly to main):

- Git for Windows CI: build, UI tests, MSYS2 test suites on all
  toolchains, and all Git test-suite shards passed.
- Stress test in Windows Sandbox: start sh.exe A, suspend it 3-15 ms
  into startup, start sh.exe B, then resume or kill A. 50 runs each:

			stock		 	patched
    A resumed		15 add_item crashes	0 (B waited in 20 runs)
    A killed		18 add_item crashes	0 (B waited in 16 runs)
    100 serial runs	0 failures		0 failures

  In the killed case B proceeded as soon as A died, through the
  abandoned-mutex path.
- Running on my workstation since; no startup time difference
  (about 150 ms per process either way, dominated by endpoint security).

I haven't built it against main itself, only the Git for Windows tree.

Thanks,
Phil Cahoon

--_002_CO1PR17MB5321E136F3EA222A2D560800AA9C2CO1PR17MB5321namp_
Content-Type: application/octet-stream;
	name="0001-Cygwin-serialize-user-shared-initialization-with-a-n.patch"
Content-Description:
 0001-Cygwin-serialize-user-shared-initialization-with-a-n.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-serialize-user-shared-initialization-with-a-n.patch";
	size=5278; creation-date="Thu, 15 Oct 2026 12:48:08 GMT";
	modification-date="Thu, 15 Oct 2026 12:53:40 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyY2ZlNjllMTA3YTE1YWQyYjQxMDZiZGEzYmViYjVlZmU1YTZlZTQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsIENhaG9vbiA8cGNhaG9vbkBsZWFmc29mdHdhcmVzb2x1
dGlvbnMuY29tPgpEYXRlOiBUaHUsIDE1IE9jdCAyMDI2IDA4OjQ1OjIwIC0wNDAwClN1YmplY3Q6
IFtQQVRDSF0gQ3lnd2luOiBzZXJpYWxpemUgdXNlciBzaGFyZWQgaW5pdGlhbGl6YXRpb24gd2l0
aCBhIG5hbWVkCiBtdXRleAoKdXNlcl9pbmZvOjppbml0aWFsaXplIGd1YXJkcyB0aGUgYnVpbGQg
b2YgdGhlIHBlci11c2VyIG1vdW50IHRhYmxlIHdpdGgKYSBzcGlubG9jayB0aGF0IGdpdmVzIHVw
IGFmdGVyIDE1IHNlY29uZHMgYW5kIGxldHMgdGhlIHdhaXRlciBpbml0aWFsaXplCmFueXdheS4g
IFRoZSB3YWl0ZXIgY2Fubm90IHRlbGwgYSBzbG93IGluaXRpYWxpemVyIChhIHNsb3cgYWNjb3Vu
dApsb29rdXAsIGEgc3VzcGVuZGVkIG9yIHN0YXJ2ZWQgcHJvY2VzcykgZnJvbSBvbmUgdGhhdCBk
aWVkIHBhcnQgd2F5CnRocm91Z2guICBJbiBib3RoIGNhc2VzIGl0IHJlLXJ1bnMgbW91bnRfaW5m
bzo6aW5pdCBvbiBhIHRhYmxlIHRoYXQKYWxyZWFkeSBob2xkcyAiLyIsIGNyZWF0ZV9yb290X2Vu
dHJ5IGZhaWxzIHdpdGggRVBFUk0sIGFuZCB0aGUgcHJvY2VzcwpkaWVzIHdpdGgKCiAgYWRkX2l0
ZW0gKCJcPz9cQzpcY3lnd2luNjQiLCAiLyIsIC4uLikgZmFpbGVkLCBlcnJubyAxCgpUaGUgdGlt
ZWQtb3V0IHdhaXRlciBuZXZlciByZXNldHMgdGhlIGxvY2ssIHNvIHdoaWxlIG90aGVyIHByb2Nl
c3NlcwprZWVwIHRoZSBzZWN0aW9uIG1hcHBlZCwgZXZlcnkgbmV3IHByb2Nlc3Mgd2FpdHMgMTUg
c2Vjb25kcyBhbmQgZGllcyB0aGUKc2FtZSB3YXkuICBUb29scyB0aGF0IHN0YXJ0IGEgc2hlbGwg
ZXZlcnkgc2Vjb25kIGtlZXAgdGhlIHNlY3Rpb24gbWFwcGVkCmluZGVmaW5pdGVseS4KClVzZSBh
IG5hbWVkIG11dGV4IG5leHQgdG8gdGhlIHNlY3Rpb24gaW5zdGVhZC4gIEEgbGl2ZSBpbml0aWFs
aXplciBpcwpzaW1wbHkgd2FpdGVkIGZvciwgc28gdGhlIHRhYmxlIGlzIG5ldmVyIGJ1aWx0IHR3
aWNlLiAgQW4gaW5pdGlhbGl6ZXIKdGhhdCBkaWVkIGlzIHJlcG9ydGVkIGFzIFdBSVRfQUJBTkRP
TkVELCBhbmQgdGhlIHdhaXRlciBjbGVhcnMgdGhlCmhhbGYtYnVpbHQgc2VjdGlvbiBhbmQgcmVi
dWlsZHMgaXQuICBBbHJlYWR5IGluaXRpYWxpemVkIHNlY3Rpb25zIHN0aWxsCnRha2UgdGhlIGxv
Y2stZnJlZSBmYXN0IHBhdGguCgpUaGlzIHBhdGNoIHdhcyB3cml0dGVuIGJ5IENsYXVkZSBPcHVz
IDUuNSAoQW50aHJvcGljKSB1c2luZyBDbGF1ZGUKQ29kZSwgYXQgdGhlIHN1Ym1pdHRlcidzIGRp
cmVjdGlvbi4KCkFkZHJlc3NlczogaHR0cHM6Ly9naXRodWIuY29tL2dpdC1mb3Itd2luZG93cy9n
aXQvaXNzdWVzLzYzNjgKU2lnbmVkLW9mZi1ieTogUGhpbCBDYWhvb24gPHBjYWhvb25AbGVhZnNv
ZnR3YXJlc29sdXRpb25zLmNvbT4KLS0tCiB3aW5zdXAvY3lnd2luL21tL3NoYXJlZC5jYyB8IDc2
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
NTQgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5
Z3dpbi9tbS9zaGFyZWQuY2MgYi93aW5zdXAvY3lnd2luL21tL3NoYXJlZC5jYwppbmRleCA3OTc3
ZGYzLi44YzRlMjBjIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL21tL3NoYXJlZC5jYworKysg
Yi93aW5zdXAvY3lnd2luL21tL3NoYXJlZC5jYwpAQCAtMTkwLDMwICsxOTAsNjIgQEAgb3Blbl9z
aGFyZWQgKGNvbnN0IFdDSEFSICpuYW1lLCBpbnQgbiwgSEFORExFJiBzaGFyZWRfaCwgRFdPUkQg
c2l6ZSwKIHZvaWQKIHVzZXJfaW5mbzo6aW5pdGlhbGl6ZSAoKQogewotICAvKiBXYWl0IGZvciBp
bml0aWFsaXphdGlvbiBvZiB0aGUgQ3lnd2luIHBlci11c2VyIHNoYXJlZCwgaWYgbmVjZXNzYXJ5
ICovCi0gIHNwaW5sb2NrIHN2ZXJzaW9uICh2ZXJzaW9uLCBDVVJSX1VTRVJfTUFHSUMpOwotICBp
ZiAoIXN2ZXJzaW9uKQorICBpZiAoKFVMT05HKSB2ZXJzaW9uICE9IENVUlJfVVNFUl9NQUdJQykK
ICAgICB7Ci0gICAgICBjYiA9IHNpemVvZiAoKnVzZXJfc2hhcmVkKTsKLSAgICAgIC8qIEluaXRp
YWxpemUgbW91bnQgdGFibGUgZnJvbSBzeXN0ZW0gZnN0YWIgcHJpb3IgdG8gY2FsbGluZwotICAg
ICAgICAgaW50ZXJuYWxfZ2V0cHdzaWQuICBUaGlzIGFsbG93cyB0byBjb252ZXJ0IHB3X2RpciBh
bmQgcHdfc2hlbGwKLQkgcGF0aHMgZ2l2ZW4gaW4gRE9TIG5vdGF0aW9uIHRvIHZhbGlkIFBPU0lY
IHBhdGhzLiAgKi8KLSAgICAgIG1vdW50aW5mby5pbml0IChmYWxzZSk7Ci0gICAgICBjeWdwc2lk
IHNpZCAoY3lnaGVhcC0+dXNlci5zaWQgKCkpOwotICAgICAgc3RydWN0IHBhc3N3ZCAqcHcgPSBp
bnRlcm5hbF9nZXRwd3NpZCAoc2lkKTsKLSAgICAgIC8qIENvcnJlY3QgdGhlIHVzZXIgbmFtZSB3
aXRoIHdoYXQncyBkZWZpbmVkIGluIC9ldGMvcGFzc3dkIGJlZm9yZQotCSBsb2FkaW5nIHRoZSB1
c2VyIGZzdGFiIGZpbGUuICovCi0gICAgICBpZiAocHcpCi0JY3lnaGVhcC0+dXNlci5zZXRfbmFt
ZSAocHctPnB3X25hbWUpOwotICAgICAgLyogQWZ0ZXIgZmV0Y2hpbmcgdGhlIHVzZXIgaW5mb3Ms
IGFkZCBtb3VudCBlbnRyaWVzIGZyb20gdXNlcidzIGZzdGFiLiAqLwotICAgICAgbW91bnRpbmZv
LmluaXQgKHRydWUpOworICAgICAgV0NIQVIgbmFtZVtVTkxFTiArIDFdOworICAgICAgV0NIQVIg
bXV0ZXhfbmFtZVtVTkxFTiArIDMyXTsKKyAgICAgIGN5Z2hlYXAtPnVzZXIuZ2V0X3dpbmRvd3Nf
aWQgKG5hbWUpOworICAgICAgX19zbWFsbF9zd3ByaW50ZiAobXV0ZXhfbmFtZSwgTCIlVy4lZC5p
bml0IiwgbmFtZSwgVVNFUl9WRVJTSU9OKTsKKyAgICAgIEhBTkRMRSBpbml0X211dGV4ID0gQ3Jl
YXRlTXV0ZXhXICgmc2VjX25vbmVfbmloLCBGQUxTRSwgbXV0ZXhfbmFtZSk7CisgICAgICBpZiAo
IWluaXRfbXV0ZXgpCisJYXBpX2ZhdGFsICgiQ3JlYXRlTXV0ZXggJVcsICVFLiAgVGVybWluYXRp
bmcuIiwgbXV0ZXhfbmFtZSk7CisgICAgICBEV09SRCB3YWl0ID0gV2FpdEZvclNpbmdsZU9iamVj
dCAoaW5pdF9tdXRleCwgSU5GSU5JVEUpOworICAgICAgaWYgKHdhaXQgIT0gV0FJVF9PQkpFQ1Rf
MCAmJiB3YWl0ICE9IFdBSVRfQUJBTkRPTkVEKQorCWFwaV9mYXRhbCAoIldhaXRGb3JTaW5nbGVP
YmplY3QgJVcgcmV0dXJuZWQgJXUsICVFLiAgVGVybWluYXRpbmcuIiwKKwkJICAgbXV0ZXhfbmFt
ZSwgd2FpdCk7CisKKyAgICAgIGlmICgoVUxPTkcpIHZlcnNpb24gPT0gQ1VSUl9VU0VSX01BR0lD
KQorCS8qIEluaXRpYWxpemVkIHdoaWxlIHdlIHdhaXRlZC4gKi87CisgICAgICBlbHNlIGlmICh2
ZXJzaW9uID09IDAgfHwgdmVyc2lvbiA9PSAtMSB8fCB3YWl0ID09IFdBSVRfQUJBTkRPTkVEKQor
CXsKKwkgIC8qIEFuIGFiYW5kb25lZCBtdXRleCBtZWFucyB0aGUgcHJldmlvdXMgaW5pdGlhbGl6
ZXIgZGllZCBwYXJ0IHdheQorCSAgICAgdGhyb3VnaC4gIERpc2NhcmQgd2hhdCBpdCBsZWZ0IGFu
ZCBzdGFydCBvdmVyLiAqLworCSAgaWYgKHdhaXQgPT0gV0FJVF9BQkFORE9ORUQpCisJICAgIHsK
KwkgICAgICBkZWJ1Z19wcmludGYgKCJ1c2VyIHNoYXJlZCBpbml0aWFsaXplciBkaWVkLCByZWJ1
aWxkaW5nIik7CisJICAgICAgbWVtc2V0ICgodm9pZCAqKSB0aGlzLCAwLCBzaXplb2YgKCp0aGlz
KSk7CisJICAgIH0KKwkgIGNiID0gc2l6ZW9mICgqdXNlcl9zaGFyZWQpOworCSAgLyogSW5pdGlh
bGl6ZSBtb3VudCB0YWJsZSBmcm9tIHN5c3RlbSBmc3RhYiBwcmlvciB0byBjYWxsaW5nCisJICAg
ICBpbnRlcm5hbF9nZXRwd3NpZC4gIFRoaXMgYWxsb3dzIHRvIGNvbnZlcnQgcHdfZGlyIGFuZCBw
d19zaGVsbAorCSAgICAgcGF0aHMgZ2l2ZW4gaW4gRE9TIG5vdGF0aW9uIHRvIHZhbGlkIFBPU0lY
IHBhdGhzLiAgKi8KKwkgIG1vdW50aW5mby5pbml0IChmYWxzZSk7CisJICBjeWdwc2lkIHNpZCAo
Y3lnaGVhcC0+dXNlci5zaWQgKCkpOworCSAgc3RydWN0IHBhc3N3ZCAqcHcgPSBpbnRlcm5hbF9n
ZXRwd3NpZCAoc2lkKTsKKwkgIC8qIENvcnJlY3QgdGhlIHVzZXIgbmFtZSB3aXRoIHdoYXQncyBk
ZWZpbmVkIGluIC9ldGMvcGFzc3dkIGJlZm9yZQorCSAgICAgbG9hZGluZyB0aGUgdXNlciBmc3Rh
YiBmaWxlLiAqLworCSAgaWYgKHB3KQorCSAgICBjeWdoZWFwLT51c2VyLnNldF9uYW1lIChwdy0+
cHdfbmFtZSk7CisJICAvKiBBZnRlciBmZXRjaGluZyB0aGUgdXNlciBpbmZvcywgYWRkIG1vdW50
IGVudHJpZXMgZnJvbSB1c2VyJ3MKKwkgICAgIGZzdGFiLiAqLworCSAgbW91bnRpbmZvLmluaXQg
KHRydWUpOworCSAgSW50ZXJsb2NrZWRFeGNoYW5nZSAoJnZlcnNpb24sIChMT05HKSBDVVJSX1VT
RVJfTUFHSUMpOworCX0KKyAgICAgIGVsc2UKKwl7CisJICBMT05HIGZvdW5kID0gdmVyc2lvbjsK
KwkgIFJlbGVhc2VNdXRleCAoaW5pdF9tdXRleCk7CisJICBDbG9zZUhhbmRsZSAoaW5pdF9tdXRl
eCk7CisJICBtdWx0aXBsZV9jeWd3aW5fcHJvYmxlbSAoInVzZXIgc2hhcmVkIG1lbW9yeSB2ZXJz
aW9uIiwgZm91bmQsCisJCQkJICAgQ1VSUl9VU0VSX01BR0lDKTsKKwkgIHJldHVybjsKKwl9Cisg
ICAgICBSZWxlYXNlTXV0ZXggKGluaXRfbXV0ZXgpOworICAgICAgQ2xvc2VIYW5kbGUgKGluaXRf
bXV0ZXgpOwogICAgIH0KLSAgZWxzZSBpZiAoc3ZlcnNpb24gIT0gQ1VSUl9VU0VSX01BR0lDKQot
ICAgIHN2ZXJzaW9uLm11bHRpcGxlX2N5Z3dpbl9wcm9ibGVtICgidXNlciBzaGFyZWQgbWVtb3J5
IHZlcnNpb24iLCB2ZXJzaW9uLAotCQkJCSAgICAgIHN2ZXJzaW9uKTsKLSAgZWxzZSBpZiAodXNl
cl9zaGFyZWQtPmNiICE9IHNpemVvZiAoKnVzZXJfc2hhcmVkKSkKLSAgICBzdmVyc2lvbi5tdWx0
aXBsZV9jeWd3aW5fcHJvYmxlbSAoInVzZXIgc2hhcmVkIG1lbW9yeSBzaXplIiwgY2IsCi0JCQkJ
ICAgICAgc2l6ZW9mICgqdXNlcl9zaGFyZWQpKTsKKyAgaWYgKGNiICE9IHNpemVvZiAoKnVzZXJf
c2hhcmVkKSkKKyAgICBtdWx0aXBsZV9jeWd3aW5fcHJvYmxlbSAoInVzZXIgc2hhcmVkIG1lbW9y
eSBzaXplIiwgY2IsCisJCQkgICAgIHNpemVvZiAoKnVzZXJfc2hhcmVkKSk7CiB9CiAKIC8qIEZp
cnN0IGhhbGYgb2YgdXNlciBzaGFyZWQgaW5pdGlhbGl6YXRpb246IENyZWF0ZSBzaGFyZWQgbWVt
IHJlZ2lvbi4gKi8KLS0gCjIuNTYuMC53aW5kb3dzLjIKCg==

--_002_CO1PR17MB5321E136F3EA222A2D560800AA9C2CO1PR17MB5321namp_--
