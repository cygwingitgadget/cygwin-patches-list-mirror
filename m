Return-Path: <SRS0=N0H/=YZ=hotmail.com=Strawberry_Str@sourceware.org>
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn190100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d405::])
	by sourceware.org (Postfix) with ESMTPS id D53FF3830695
	for <cygwin-patches@cygwin.com>; Tue, 10 Jun 2025 03:00:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D53FF3830695
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D53FF3830695
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:d405::
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1749524438; cv=pass;
	b=Ll4EOm1Pe8xC43Jl+RkvcteQ3+kiLPkL3o/ZtsZ0auY7nxVc4fQ8y/Yb8pXjASEDD6kQAa2sIXY3epdC2b+j1MPqC3iDkCEG+jzgJGdjvsr2VBW5VnvgyM9H/8W8HTEYKSUGDKVG2LwNdQG8xKDQ50jHrAW9ihm1ucOMaCrdeAY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749524438; c=relaxed/simple;
	bh=BrQ8g7Mk2jR7i4a3IV772ZPA4B1ZnUjFFZMMJyMeh6c=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=f8rXWc2hNcX2P6khyzSfaCk4JmCuqqZDGCstl0gBmUL0iSXjLxzN7lNx5I3M+Kdfq9H0EnHs4/u6KKyT9EJZY7DBm8xq4XcWGwV9FUpjbWW03GZi89Nt9BEmD6mNuJXEHsVH3eWhtmRnS9a7L6OHgqpG7dHYEL5d2ogRnwP/Xmc=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D53FF3830695
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Pf2XG01K
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHSzIlELESLsA6CSdryTo4xPqtU3uwaWs+BufUMX0S7EugqhdWLnHBOoV0G87qHSl7mytqANiamU968aF+bVA8V3s5m6UXrEZnQPvHOZSnLs131i87mk0RbXS+sDPfe95IYW87p23lAQTUHABKBGEOUK0/dkBynOETVRNT8dizUdWbE9j0W3/ECKM2vbOlHFhBvg3L9UQKYOt/rDPl/RUtLxJlUXKcUnP1h5Dm1N43o1+t6oaSxk+13fak6wmXhG9kCIi0omPFwHkiAr74qWLVsbdM9+pxSKzlt8ZMdm404rEPnzUEg539T+K7WsUNKlvcS77wAJ5oCpHO6cT3Jo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrQ8g7Mk2jR7i4a3IV772ZPA4B1ZnUjFFZMMJyMeh6c=;
 b=tq0E2CxPFMwYcg6aOKC3X5jPV5Jgi5+ViccGHQ7XL63m50VQ5Q17fn3KLwedCuXX4RXWSrBn0HRdFSffDVXbUyhSiYm2fWTVWn1wD9eCwl/rjZ5UmP2Ffa7XbXtV1fxaHLpqkRZOA7dDIxgcOCFvS7xG6vS4p+KFFFXy3JHSXJ8uf/ujQASbYSjJv66Qs+iUZdhEZRze3eh1HUojKvkXLyASC4WWowNedzvrSEBFWyJxijGAvjymMzcADsKYZQoZd9HX13RlyDxj4tFOe1cfYF/6bc1rJHGTki8m+hCL+E8VBi9U44saMohmu4qw/nNLmPVRUTpA37sCc0vXeuqiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrQ8g7Mk2jR7i4a3IV772ZPA4B1ZnUjFFZMMJyMeh6c=;
 b=Pf2XG01KlDwgU/ComoUN363GYFbjM2p4cqLogwCb3aRr1ULANECX911tGXeVAD2t9vZFGAdTXjQ+ZmK0jbPmXVQxz5XMQkkpysi691/d0V48HBJMF0D7HMAnm4ANL4N5NWtvhtdD9rTmmjIs4OxavNKPrEUBkrNLGVR0MT6Oqu7tD305WNOnvdxQ8LTsbI16xeaRXLNhE5vMu93OkaQJfIM62DGQKKhv59P/eMdLoOLqMVQsupJuryapkGneG4ob1dZyOGwBAz/A5bXjnQRi3wFiSmOyMfAoIjOfZKjE24SsSUu1B1r3gYxz2tll4qmCXqq+0PBZYHjRridmDdxXSQ==
Received: from TYCPR01MB10926.jpnprd01.prod.outlook.com (2603:1096:400:3a3::6)
 by TY3PR01MB11496.jpnprd01.prod.outlook.com (2603:1096:400:371::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Tue, 10 Jun
 2025 03:00:33 +0000
Received: from TYCPR01MB10926.jpnprd01.prod.outlook.com
 ([fe80::45e0:7606:a365:9209]) by TYCPR01MB10926.jpnprd01.prod.outlook.com
 ([fe80::45e0:7606:a365:9209%6]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 03:00:33 +0000
From: Yuyi Wang <Strawberry_Str@hotmail.com>
To: cygwin@jdrake.com
Cc: cygwin-patches@cygwin.com
Subject: Re: [RFC PATCH 3/3] Cygwin: add fast-path for posix_spawn(p)
Date: Tue, 10 Jun 2025 11:00:09 +0800
Message-ID:
 <TYCPR01MB1092694C68AE1EC4E48F055C6F86AA@TYCPR01MB10926.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2f8b971d-a604-9bef-97d5-f816d92b9dfd@jdrake.com>
References: <2f8b971d-a604-9bef-97d5-f816d92b9dfd@jdrake.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To TYCPR01MB10926.jpnprd01.prod.outlook.com
 (2603:1096:400:3a3::6)
X-Microsoft-Original-Message-ID:
 <20250610030009.3104-1-Strawberry_Str@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10926:EE_|TY3PR01MB11496:EE_
X-MS-Office365-Filtering-Correlation-Id: 357b140e-12b4-43a3-0713-08dda7caf71b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799009|19110799006|7092599006|8060799009|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PSIAMS3ErnV0dBi8MxLpiYFCLdZKdEgRr8KL7bG6rvm2Z9vBDhSgpdtIlOR5?=
 =?us-ascii?Q?kBZEhniPJwyyuh/rjFxtwKRYkUd1BMPGHmgj6/1kKNEvODIhEFWr6k0a/dor?=
 =?us-ascii?Q?WJo8kwpNzLbu7jCJfylpO/B1HbFLAAY4QNFtFHI/y17zcbe3Yy3pe6VnsuOi?=
 =?us-ascii?Q?nBMzG+n3CzPNoA1WYfXZBH2mYClECyQduVA6iGCJStOyt6/F4OIPOmymHj3d?=
 =?us-ascii?Q?3JOO3ZV+TjXXDYSO7cVQ8BS9FrLzwtNVuZ/pTQuP9qBcxulHNQYn2tjceykv?=
 =?us-ascii?Q?+ZEdrx2DKJk4jBiQLx6dFOD2xidsYToDtAkq2ptWQKtWqDWEKWIy9IMvGPdo?=
 =?us-ascii?Q?iKNGT6gMsamussKhjq+SDAVGYClPfK4ubF3VkDGpYf5tEVspWOq5hy0R0cRP?=
 =?us-ascii?Q?WrjrPUd9oyPdYEwXEw3SPj6hhJwWl1F09EumcivWTMOShBZNIb8Y50twFkcu?=
 =?us-ascii?Q?I+D0NQGxC6jvj+E0e5LO7imIkWrPUBgV7T3U3gbK8DzYE9BzsX0XaJUpdFa7?=
 =?us-ascii?Q?Z/XRuORTgK3bkqPmJEIfF1QKYYgW4h/QsTBcibiOViuStOayE/E2Si1fgcDq?=
 =?us-ascii?Q?wfEEsug4+TLD2EgL/cDpkE0k2boTJi0sgwDNtvKQLLAgCaXBaH+wJJ4Qo9FE?=
 =?us-ascii?Q?QX0bWSZLhU5rOgvQ6YHMPuhKtfQLI68OnZg1epdgPRph9SjX9V9ENzw/COgd?=
 =?us-ascii?Q?TUqne3OnkTvIPuAbkAJwFV0ehcsb7yvAqoAa1nD7ZyjgBeRZ/ylXbDgXOf0y?=
 =?us-ascii?Q?nhF7cQ+0HG6Gc9PuVhLkZDSch+HazPW2Xs8s/YRdR2vHU9I/xQxCarH7LXPw?=
 =?us-ascii?Q?jRQWWn8TDNnJ5vGj9Vj8FeUcchuwcIwczpHHv9vET8eYcmkQ4TZw1rX2PdCY?=
 =?us-ascii?Q?lJATu4w/+cqrCU6QCGciZilUOUPLqJ8eRIaRB67uVDLZbOeDwlWZno8sCZpM?=
 =?us-ascii?Q?4SKJxhqXNqWyWRCtsFgW6MZtK70lv+w1ehxTVWEeQq/k7yTGOu+CIQzMhE65?=
 =?us-ascii?Q?Q2WsA/H4RbtHKWBhOKXEvyXcV1rjDLYP+l4b/RQWDi+Q6Ls2xp6M1Elkfc0V?=
 =?us-ascii?Q?rYWmi7Tzr5JeCCBlhLh7jyqe4Aiv+sbCwqiLAoVR1/V8uqXb+0cl7CpO/H4A?=
 =?us-ascii?Q?FnTWWjnQTspe?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yKaU5HwBZ9qYHkcoEuZWzYDpRCBqFFGNERKnIaSM6YFM2xkytsyrF5hJyxbo?=
 =?us-ascii?Q?Kfrq+TNKX6lZVIznPMLRyaQJOKVdBvNsxzzORI8FDNAe6Bn9FXrjP4CM6Ml3?=
 =?us-ascii?Q?0lxLYIX9YUohdRkYaw7ttMEINYQl4RTsspy+b6rTJVOEg2leHXoxxeBTVVLd?=
 =?us-ascii?Q?ks7EqKqn3vJLURY8paHer+GicBiSqQAeFg6drISFXuC9dJyyR23HjfJ7xzJq?=
 =?us-ascii?Q?4y3bOhMdij+jDy7RgxI2gQnKNwkQqrBvolX96M6IpkxreljKe6STrGVexiuX?=
 =?us-ascii?Q?2do7KhVKAwChRZ7Jt9/yxd4myXobiCB/vhIbC+JJda1ZxvUKHCkydNMklcUo?=
 =?us-ascii?Q?vEQyPHxx1zwIQPY+J4DPck9nDzaQKAx4NIij8wwbEMloZCWO2ms5rOiA7qkS?=
 =?us-ascii?Q?a9ZPeMw84+gzYnPtytnt7bsNSD+Jkb7Ji5hD/dA4JhzSgf4CWVI/v+13irUi?=
 =?us-ascii?Q?BcmoCMZu0GX35eBbjyQq+tZ0OQimCn3TTgO8ucbHw0+OYEAgifn2bsZbR+To?=
 =?us-ascii?Q?hISe3KCs8tXvR43nwATBm2MZzUnXrH0kvdFyWgT7vqSeGeWAlBWQqx6TUgv+?=
 =?us-ascii?Q?qREkXe1vKufGCEGRQtk0VZ8snauURX/9y2h4/AFcSYM78YiyOK1ioprgqKce?=
 =?us-ascii?Q?kPC+av313AGubRglQMNYMgRRhRJmJGcw6MmbJBWtgch0hSUYGU6lI/WvEKgL?=
 =?us-ascii?Q?5UOksn8wSVvg4FVKdFrNXrI0wC97ehXOt6N068DtaR/3rnSiniCld46B/IsC?=
 =?us-ascii?Q?MatI8ABhCHoelsw/q4q/BmZMmm6/GleM6iifbcHJaIWCeCbgg/lUf8oXT8H1?=
 =?us-ascii?Q?BnhnEaX6g0Sw22QLGT0snAWHFA2SpmfcAKZ5p9ry75O3gPJwAGZhCBZ3eyL6?=
 =?us-ascii?Q?GiVXXU162hoDqxUI97WF8hbjS2wMjvRt5NUAtY9F5/WXFK6lkP721AwuxXQi?=
 =?us-ascii?Q?J/u3D6ozlXTrbXk5Y91VHcKtAWPNT+d5ISAP1h4snutgLd9FWinzBm6RB2zq?=
 =?us-ascii?Q?tc/bXXdKssSwrgTK52iK9SgD3e0vQ+BwLzOM8YA3wYGmucra7Txqze0U9Z5R?=
 =?us-ascii?Q?q5W4qseuYxHFLkB3NZDo2lpkirNItOvuOBbp3lAGO9Bp+cYCVjeK+RIJ5aF7?=
 =?us-ascii?Q?7w5a2Jjgclor9cAwE0NZX2uQW/+Bd11lpkCtoHq++JfpR+T+Ty6tyxd9fReK?=
 =?us-ascii?Q?23UkcUOyCxCqh+0KNAcsNqQ1aI6gI6afP9CZuqNsL1XrQpb6PqZyPWPqKpUh?=
 =?us-ascii?Q?2i6De3V7x+ipd0qQoyxs2jtSaAPn/1ipMBvRNV4TbQ=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-9a502.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 357b140e-12b4-43a3-0713-08dda7caf71b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10926.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 03:00:33.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11496
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

It would be better to handle `POSIX_SPAWN_SETSIGDEF` in the fast path, because
Rust usually sets SIGPIPE to SIG_IGN, but wants to recover it to SIG_DFL in the
child processes.

--
Yuyi Wang
