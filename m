Return-Path: <SRS0=3bqE=I6=leafsoftwaresolutions.com=pcahoon@sourceware.org>
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::1])
	by sourceware.org (Postfix) with ESMTPS id B8C4F4BA2E0C
	for <cygwin-patches@cygwin.com>; Mon,  9 Nov 2026 15:21:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B8C4F4BA2E0C
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=leafsoftwaresolutions.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=leafsoftwaresolutions.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B8C4F4BA2E0C
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c107::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1794237713; cv=pass;
	b=tdQ4YIX+2+jvwFq3/fJ6p3PUKGo8bxNj8w1/QICbezVQUC2BU6eApyuOpbT293CocEXSBQUw2cCrIGT8GRsG+X1C8jUR3H/V4GOVK1KxBuNbtOTHOm1UnCCf9YLcIXOZKU5kNqeLyG8HvTEc8fcf3lBIPuHUx8/AdGzGG1ujvUw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794237713; c=relaxed/simple;
	bh=ywOgcvMQZUfcZ4zYURXlymnbB2/aM2pSPMLlFCi6XgI=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=VBOv3VNb6aJx6f88v+sbLZHb5q1RZ3cAbKmkJAl8e7Yfq0thGaIo/QWhORVUEh5L0hRiLIrnNihjw+FZHWdsyUn0rwld4dp3SKiUvCXcyer+escjKcsdIe549UssyHYZzctnhdbHAulfhu3SUfsxbazVhaOHkh/R22t0tGipS40=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=leafsoftwaresolutions.com header.i=@leafsoftwaresolutions.com header.a=rsa-sha256 header.s=selector1 header.b=ipIDfJx8
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B8C4F4BA2E0C
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=leafsoftwaresolutions.com header.i=@leafsoftwaresolutions.com header.a=rsa-sha256 header.s=selector1 header.b=ipIDfJx8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeWbEfIaeP2GbMqFETZTEjAd2+wQ02Slp75fKfHbgKl26NQr5HV2CQc1rz0iRqW4Na9POHUt/fuWoigzej/mWWchDxUkandHH0rMpn/SjYc808zgufRmvQtml47c0173oOg1ihqBoevoFYDvSk2uB00mfIvAxhV1xBkUbso/qX3PGZ8pg/8mifKB5Fu6zPStsR4v75fg3AsdrZuMUHCn0ynDvm5F7V+OMQ7ulXu1ZY1IKebpn6+Q5Y8Q9ZzjJuf7PBpOvK13FAkVFVtLw292dPBiZdwY9v5FwxOZZW94CAm4OSRbeQsTLYTeaMKWebNw0tvIUwMkEHLhiQvONJa5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJVgyVPCCJFYoEdCsfRBRNT5mTuxJ1nZP4dgAiGsQjo=;
 b=PBeE8fbpjhrfq06T3hcLzA6jVgWDHo0mBWQnLy8I1gvUmYvfac46KlU/Rg0uslsypjrIFQdKoe2ovHWUDJkU2WFpuiuzPIyLBRqPDW/HNZd9ZrI5kzYYbjqqrxmxE9wbCX1rGfBo5+Kmvj0TbgvdN3jlPprhHoKqpEL1wwECSV46Z/A40VIpEohdw+AK4iX8iFjTWfyCAY84udICwbHufGfAAxiIPAm6u21SluKxLC/sINWG6fIFNdCMWHoI8v2FaFp8l+ZX/tSN8aJxNLfZ8I8ErBTMG8u8SmEFkHcjzPZXGfVKKtb1hPqTC0wfb6MfZK4y43fKmf/rG3IZwVeOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leafsoftwaresolutions.com; dmarc=pass action=none
 header.from=leafsoftwaresolutions.com; dkim=pass
 header.d=leafsoftwaresolutions.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leafsoftwaresolutions.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJVgyVPCCJFYoEdCsfRBRNT5mTuxJ1nZP4dgAiGsQjo=;
 b=ipIDfJx83qvAkkut1DYWf8YYdWipFesRkpE42HSq23Fa2F5oH7JOlLN68GPDBu8HVwX0sbwaW+ytxKSnx6bmN53mgRlV1gLPOGrSpi33FmKyac0iefX5HWsi3pyslD03gBzOv1B0SHhkbyjV81GNYtjjNscHcjpToo4HqUgbor4=
Received: from SN4PR17MB978366.namprd17.prod.outlook.com
 (2603:10b6:806:219::11) by DM4PR17MB6183.namprd17.prod.outlook.com
 (2603:10b6:8:8d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 15:21:49 +0000
Received: from SN4PR17MB978366.namprd17.prod.outlook.com
 ([fe80::c85b:546a:19a8:621d]) by SN4PR17MB978366.namprd17.prod.outlook.com
 ([fe80::c85b:546a:19a8:621d%4]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 15:21:49 +0000
From: Phil Cahoon <pcahoon@leafsoftwaresolutions.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH RESEND] Cygwin: serialize user shared initialization with
 a named mutex
Thread-Topic: [PATCH RESEND] Cygwin: serialize user shared initialization with
 a named mutex
Thread-Index: Ad1dYv2LFHGJuBsiRYyn0xV1rCbJagSPM0EAAC9g/TQ=
Date: Mon, 9 Nov 2026 15:21:49 +0000
Message-ID:
 <SN4PR17MB97836679EE6035DBD067169FAFAA732@SN4PR17MB978366.namprd17.prod.outlook.com>
References:
 <CO1PR17MB5321BE63472EAC7A500BCCA0AA9B2@CO1PR17MB5321.namprd17.prod.outlook.com>
 <f5b464c0-09dc-41c8-a0a2-c85588a645e0@dronecode.org.uk>
In-Reply-To: <f5b464c0-09dc-41c8-a0a2-c85588a645e0@dronecode.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ai-generated: mcp-office365
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leafsoftwaresolutions.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR17MB978366:EE_|DM4PR17MB6183:EE_
x-ms-office365-filtering-correlation-id: f5d2cfc6-ad43-4d23-278c-08df3e752d0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|23010399003|376014|366016|1800799024|38070700021|5023799004|4143699003|56012099006|261021121427099003|261021123027099003|261021135927099003|261022105027099003|261022075727099003|261022115727099003|261009220027099003|261009221227099003|261009223027099003|261009221727099003|261009223327099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003|8096899003;
x-microsoft-antispam-message-info:
 bBdNTxE4Egx7rn2Saa0EAVRoJyB3fpw55auU9BeurBlJSGKGmWHL6DdiFqixFxcncLAKcSGCgdkozzyDlXYd96jWXFSk8Pk8jdzqIuMimu3t9w1TdjmabiShS82gUAW9mAlCIvClpXcv5OehewJLqqF5dhnbziZT39K6HigZaQSC+wWjda9ZaEJFyRg8CiTnAnHcz5Z+VbliSNxY3OwiY5afPgjoMOgXdlOq9Ra57+fJVByKOIg+99+ILKPQK3mnKjxbzXjQcGC+POhADunGOdoNpNnsChxg2VQaH54y/S63JxJIOdfd5aF3IT0gFlEOqkopxoORpGzxH852Z3vIAHC6n3PP7ktjNryv85RoaL8kUNkXX1uKx0YqL82wEBl3YDdlWaNMIvpZ4EK/1iZbpCqErt5ez/VufEhSa1dTV72u5frGdfCBqE9Th9hW0dQIHzvublaAOpEMxyjuGPMSeeOh6V7DROVFQlvZUHLLPpwG720JSg5vrz2B6EAZVmUyUKL/IfurnntxiW0REgnU4/rpCbrJaXCIZWYfUsiMBpZz/A9j1mATPVuwK1C2TkkDTFAgBOfTcnysLkIf3TvFDWbN1qWDTwFkiG/KAaoW2VqfVEF3bi6KZEoAfX2wkynf+YnCAWUnWDNVRiDPPmyJAG2W6hXaAlqfK4Kb60Dy5+A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR17MB978366.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(366016)(1800799024)(38070700021)(5023799004)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261021135927099003)(261022105027099003)(261022075727099003)(261022115727099003)(261009220027099003)(261009221227099003)(261009223027099003)(261009221727099003)(261009223327099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yGIqcxo1Wc2HNRnUq4Ba52QqvaTfqunGqKmEMbJMZ66xSTMd6SVzDGK3c1X7?=
 =?us-ascii?Q?gBUibs+k9AUQAekFqGObbkpx4Vcz1igExIqxcWf6gRxKMmvm5gUf6ix8Bsv7?=
 =?us-ascii?Q?M8RWjX+CDTri02NMHG36BiQEw+L5wrYbLyJ3QKd+XReVj0Wj/Hwy/ZJKtZ/Z?=
 =?us-ascii?Q?grupDaiQlIjz5oPsF2zaxt8AncxHLmNCdSGPscO1KVvAStKjtjYDq4sSXn90?=
 =?us-ascii?Q?0zO3kh8uoQCO7DwnBz5YK3+h/bL4t60zM5KozoTWHB42RuWVUumBfPYo+YAF?=
 =?us-ascii?Q?HK27J6RjV5R2a2M0V7RKm5/UN/8fAdhGszAZATQAs1WActU8Q/MALttdyH8A?=
 =?us-ascii?Q?G2m2P5CEwrbOfWPwMQRuHqf/QbzHs5euDEUsGiR94qg3zFOkVPQ4X6K0I/md?=
 =?us-ascii?Q?7/+kmXe7C+8maXRPK8t1Z9ekKYIaHRJx/MSQhBzWdRdiN76GSNCagO8SYyXO?=
 =?us-ascii?Q?R4QPZ9OEIRU4GvBEVv+Uwc2aQ7P8oWtCuNSifR5MMTxPj5lrvC3XKt254Jp4?=
 =?us-ascii?Q?DfmcabpJgy2UHvOHPdhH9Iw+jFzP+fqfjpbnje0l/NiqZv1uUtv2IUTj1JEq?=
 =?us-ascii?Q?YlkB+0RyuUZDtVPV3jQZvNLkihWNGYIV+S7dMbSyRO90rByEa03nEra7rUBx?=
 =?us-ascii?Q?PnYYBvBnMJAzlnKy88cG54bY3B7k1zj45C6O1jQN2ydPiWXrGjVzQXyanc9f?=
 =?us-ascii?Q?Q77xkJ340zmRswoxq/B8ai9/OuKlufhLZ+E+HLRqiwyeqprFyLhT4RK7yi/j?=
 =?us-ascii?Q?RmAh2cpkpbdc0xwjge7rRuClS2ioIOx8QsCuYorLwBSba+YjYI/N7nGKySAs?=
 =?us-ascii?Q?t7y+cNDrdt3b9MUFVcBCKS7aaYiQzdW+P96By0vmeusjqxWDs520qyXYgDwZ?=
 =?us-ascii?Q?gHSJmNMuTql8nTNEeen8+grtyKWsdatd3mgoTq6PwwCnsBirooD9sEfqgsyN?=
 =?us-ascii?Q?Svk+qDkkQjHnQGUIqNlpFfmR1mHSJGS4obu5TyT2J7NAlNzbrPcCj9vi2OlI?=
 =?us-ascii?Q?6ijAMja+Y8pK5FP5spOV1jC9s5iDfaTwbpf0+NUZ26ENhwcFXV1vFRt/vu4J?=
 =?us-ascii?Q?zpQrZC4KDIsT65Xcxp0ph/OBTD+qX9WxTOE7UxHB/xLsm+7z9C8wavK7Lqty?=
 =?us-ascii?Q?0zIQUm+/yxerZf0BX83AhO52sf74B+YfVlIzO0k1dmsz3dqi2uRtvdSttESY?=
 =?us-ascii?Q?ZCKZR2lK7MFzkoZPGi+xj3ZI07lX/rZFZyR5cuXnifblLaW5SVbqDUPN2ypZ?=
 =?us-ascii?Q?HkingFVsdiJjVDiEsjwN+TQJHxOkDxRLorrpNylh8XHji5LPywNp/fHkvbyx?=
 =?us-ascii?Q?oMQAPJVyZeIdkeMlzkLiLwfcOeL6h//coYWkrqnVZ2m7hHDPnjFpcUCYoR5Y?=
 =?us-ascii?Q?rWX83QR15UlW97MEgz21NYVtKZSFZIGAQfUZklU/14lh2IqmOcSuCDx82Au+?=
 =?us-ascii?Q?W6xl5VWRGn7OTjh6Ye5PXr1Mx5y+nk1lCPoXBIwiZ0Tl2vxHjJpO1x42j2Gl?=
 =?us-ascii?Q?4NSRVeYsibNR60l3EXuKh7TEKCTjHwc7DBjwEsXSOeduAhBioIKZswGXtbas?=
 =?us-ascii?Q?wSmbAzbAt+jUJBC4I+LBzNWx4hX7LhlCzz8rt/8VDtCdIv4yyIP3YUtmufe9?=
 =?us-ascii?Q?VjCBvXr6g0Fmo6+6IegM2CMH0GRZkKBNJQT5kp21svaDRultJMwd4z6f8AtH?=
 =?us-ascii?Q?H40ctSRVUasyRM3KjlC8kMHPzYpQZbfjcIhRtyj+h1QWVYvyOKvp0wVQeyvY?=
 =?us-ascii?Q?CYg7QunlI/gCA2Q0uZeCLM93D6Kc5M4kwZQ4NBbW2SnXzWiNysKoTq0OHj61?=
x-ms-exchange-antispam-messagedata-1: EWHVchBZJ1JZWrK8VOShMHFNQAkGI9Z+jrM=
Content-Type: multipart/alternative;
	boundary="_000_SN4PR17MB97836679EE6035DBD067169FAFAA732SN4PR17MB978366_"
MIME-Version: 1.0
X-OriginatorOrg: leafsoftwaresolutions.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR17MB978366.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d2cfc6-ad43-4d23-278c-08df3e752d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 15:21:49.7504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 925dca83-2532-40a7-9105-03cb15e44d10
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOLTXvwPpCS7rB6m5n22xGseLM4CjIVeL2uV7EMIWzDdc1TEY6RJbu0qW5UoKw9Fvrxyv1LYbiszSwrkosSPqxf9MfI37+p2BIoG2jDoMU7H5fip2yyyawbIcnHSe9Rn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB6183
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GB_MSAUTHSOURCE_NORTHAM,HTML_MESSAGE,SPF_HELO_NONE,SPF_NONE,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_SN4PR17MB97836679EE6035DBD067169FAFAA732SN4PR17MB978366_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

Thanks for the review. Answers inline; I'll follow up with a v2 that adds
the comments you asked for. The code itself is unchanged.


> Firstly, a statement on the licensing of the patch, as per [1], would be
> welcome.

I provide my patches to the Cygwin sources under the 2-clause BSD license.

> There's probably room for some commentary here that mutex and file
> mappings exist in the same namespace, so the '.init' suffix serves to
> separate them.

Agreed, v2 says so.

> (I'm kind of surprised that the mutex name doesn't also include the
> installation key, but it's not in the shared memory file mapping's name
> either, maybe I'm misunderstanding how that applies here)

It's in the directory rather than the name. Cygwin's own CreateMutexW and
CreateFileMappingW wrappers in kernel32.cc open named objects relative to
get_shared_parent_dir(), which is
\BaseNamedObjects\<shared_id>-<installation key>. So the mutex and the
section sit side by side in the same per-installation directory, and two
installations never share either one. v2 mentions this in the comment.

> Uh, what these special values of 0 and -1 correspond to is a mystery to
> me.

0 is a newly created section: CreateFileMapping zero-fills it, so nobody
has initialized it yet.

-1 is the "initialization in progress" value the old spinlock stores in
version while it builds the table. With this patch nothing writes -1
any more, so it can only come from an older DLL with the same
USER_VERSION sharing the section, e.g. processes still running during an
upgrade, that died or is still part way through. Treating it as
uninitialized matches what the spinlock itself did after its timeout.
Any other value that isn't CURR_USER_MAGIC is a different Cygwin's
section, which still goes to multiple_cygwin_problem. v2 adds a comment
covering both.

> Reason for using InterlockedExchange here?

Processes that find the section already initialized take the fast path
and read version without the mutex. The InterlockedExchange is a full
barrier, so none of the stores that build the mount table can become
visible after the magic does, from either compiler or CPU reordering.
It's the same publish the spinlock's done() used. ReleaseMutex would
also be a barrier, but it comes after the store, and the fast-path
readers never call it, so it doesn't help them. v2 adds a comment.

Thanks,
Phil


________________________________________
From: Jon Turney <jon.turney@dronecode.org.uk>
Sent: Sunday, 08 November 2026 11:39:58
Cc: cygwin-patches@cygwin.com; Phil Cahoon
Subject: Re: [PATCH RESEND] Cygwin: serialize user shared initialization wi=
th a named mutex

[You don't often get email from jon.turney@dronecode.org.uk. Learn why this=
 is important at https://aka.ms/LearnAboutSenderIdentification ]

[EXTERNAL]: Use CAUTION with links/attachments & verify sender is safe.


On 16/10/2026 12:41, Phil Cahoon via Cygwin-patches wrote:
> Resending because the attachment on my first post was archived as
> binary and scrubbed. The patch is attached as plain text this time;
> nothing in it has changed.
>
>
> 0001-Cygwin-serialize-user-shared-initialization-with-a-named-
> mutex.patch.txt
>
> From 2cfe69e107a15ad2b4106bda3bebb5efe5a6ee43 Mon Sep 17 00:00:00 2001
> From: Phil Cahoon<pcahoon@leafsoftwaresolutions.com>
> Date: Thu, 15 Oct 2026 08:45:20 -0400
> Subject: [PATCH] Cygwin: serialize user shared initialization with a named
> mutex
>
> user_info::initialize guards the build of the per-user mount table with
> a spinlock that gives up after 15 seconds and lets the waiter initialize
> anyway. The waiter cannot tell a slow initializer (a slow account
> lookup, a suspended or starved process) from one that died part way
> through. In both cases it re-runs mount_info::init on a table that
> already holds "/", create_root_entry fails with EPERM, and the process
> dies with
>
> add_item ("\??\C:\cygwin64", "/", ...) failed, errno 1
>
> The timed-out waiter never resets the lock, so while other processes
> keep the section mapped, every new process waits 15 seconds and dies the
> same way. Tools that start a shell every second keep the section mapped
> indefinitely.
>
> Use a named mutex next to the section instead. A live initializer is
> simply waited for, so the table is never built twice. An initializer
> that died is reported as WAIT_ABANDONED, and the waiter clears the
> half-built section and rebuilds it. Already initialized sections still
> take the lock-free fast path.
>
> This patch was written by Claude Opus 5.5 (Anthropic) using Claude
> Code, at the submitter's direction.
>
> Addresses:https://github.com/git-for-windows/git/issues/6368
> Signed-off-by: Phil Cahoon<pcahoon@leafsoftwaresolutions.com>

Yes, this looks like a real problem, so thanks for investigating and
producing a patch. I apologize for the delay in reviewing it.

Firstly, a statement on the licensing of the patch, as per [1], would be
welcome.

[1] https://cygwin.com/contrib/dll.html#before_starting_legal

This all seems reasonable, but I have a couple of small questions:

> --- a/winsup/cygwin/mm/shared.cc
> +++ b/winsup/cygwin/mm/shared.cc
> @@ -190,30 +190,62 @@ open_shared (const WCHAR *name, int n, HANDLE& shar=
ed_h, DWORD size,
> void
> user_info::initialize ()
> {
> - /* Wait for initialization of the Cygwin per-user shared, if necessary =
*/
> - spinlock sversion (version, CURR_USER_MAGIC);
> - if (!sversion)
> + if ((ULONG) version !=3D CURR_USER_MAGIC)

Hmmm... yeah, after a bit of head scratching, this seems OK outside the
mutex, because we've done all the initialization by the time the value
is set.

> {
> - cb =3D sizeof (*user_shared);
> - /* Initialize mount table from system fstab prior to calling
> - internal_getpwsid. This allows to convert pw_dir and pw_shell
> - paths given in DOS notation to valid POSIX paths. */
> - mountinfo.init (false);
> - cygpsid sid (cygheap->user.sid ());
> - struct passwd *pw =3D internal_getpwsid (sid);
> - /* Correct the user name with what's defined in /etc/passwd before
> - loading the user fstab file. */
> - if (pw)
> - cygheap->user.set_name (pw->pw_name);
> - /* After fetching the user infos, add mount entries from user's fstab. =
*/
> - mountinfo.init (true);
> + WCHAR name[UNLEN + 1];
> + WCHAR mutex_name[UNLEN + 32];
> + cygheap->user.get_windows_id (name);
> + __small_swprintf (mutex_name, L"%W.%d.init", name, USER_VERSION);

There's probably room for some commentary here that mutex and file
mappings exist in the same namespace, so the '.init' suffix serves to
separate them.

(I'm kind of surprised that the mutex name doesn't also include the
installation key, but it's not in the shared memory file mapping's name
either, maybe I'm misunderstanding how that applies here)

> + HANDLE init_mutex =3D CreateMutexW (&sec_none_nih, FALSE, mutex_name);
> + if (!init_mutex)
> + api_fatal ("CreateMutex %W, %E. Terminating.", mutex_name);
> + DWORD wait =3D WaitForSingleObject (init_mutex, INFINITE);
> + if (wait !=3D WAIT_OBJECT_0 && wait !=3D WAIT_ABANDONED)
> + api_fatal ("WaitForSingleObject %W returned %u, %E. Terminating.",
> + mutex_name, wait);
> +
> + if ((ULONG) version =3D=3D CURR_USER_MAGIC)
> + /* Initialized while we waited. */;
> + else if (version =3D=3D 0 || version =3D=3D -1 || wait =3D=3D WAIT_ABAN=
DONED)

Uh, what these special values of 0 and -1 correspond to is a mystery to
me. I dug around a bit, but couldn't immediately find anything.

A comment explaining that would be nice.

> + {
> + /* An abandoned mutex means the previous initializer died part way
> + through. Discard what it left and start over. */
> + if (wait =3D=3D WAIT_ABANDONED)
> + {
> + debug_printf ("user shared initializer died, rebuilding");
> + memset ((void *) this, 0, sizeof (*this));
> + }
> + cb =3D sizeof (*user_shared);
> + /* Initialize mount table from system fstab prior to calling
> + internal_getpwsid. This allows to convert pw_dir and pw_shell
> + paths given in DOS notation to valid POSIX paths. */
> + mountinfo.init (false);
> + cygpsid sid (cygheap->user.sid ());
> + struct passwd *pw =3D internal_getpwsid (sid);
> + /* Correct the user name with what's defined in /etc/passwd before
> + loading the user fstab file. */
> + if (pw)
> + cygheap->user.set_name (pw->pw_name);
> + /* After fetching the user infos, add mount entries from user's
> + fstab. */
> + mountinfo.init (true);
> + InterlockedExchange (&version, (LONG) CURR_USER_MAGIC);

Reason for using InterlockedExchange here?

> + }
> + else
> + {
> + LONG found =3D version;
> + ReleaseMutex (init_mutex);
> + CloseHandle (init_mutex);
> + multiple_cygwin_problem ("user shared memory version", found,
> + CURR_USER_MAGIC);
> + return;
> + }
> + ReleaseMutex (init_mutex);
> + CloseHandle (init_mutex);
> }
> - else if (sversion !=3D CURR_USER_MAGIC)
> - sversion.multiple_cygwin_problem ("user shared memory version", version,
> - sversion);
> - else if (user_shared->cb !=3D sizeof (*user_shared))
> - sversion.multiple_cygwin_problem ("user shared memory size", cb,
> - sizeof (*user_shared));
> + if (cb !=3D sizeof (*user_shared))
> + multiple_cygwin_problem ("user shared memory size", cb,
> + sizeof (*user_shared));
> }

--_000_SN4PR17MB97836679EE6035DBD067169FAFAA732SN4PR17MB978366_--
