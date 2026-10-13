Return-Path: <SRS0=l28s=ID=microsoft.com=Alexandre.Chohfi@sourceware.org>
Received: from SJ0PR00CU001.outbound.protection.outlook.com (mail-westusazlp17013000b.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::b])
	by sourceware.org (Postfix) with ESMTPS id A86564BA23C9
	for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 02:05:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A86564BA23C9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A86564BA23C9
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c000::b
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1791857123; cv=pass;
	b=f6sPZHD2gXnVGAaW5noSzkX/GXN6WS6RDkVdO5HJHDlzI1lco6LCjxaicJay/vJ8VMH60hQBBPAQhR1wfm1l82KqUgfdpe0s3CGGjjzZ6lRnVZBKdLIVLo8dvUI73sENxylpvXjlKm/I17GBdf+qeic4nhlk821P85gf8L+MgJc=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791857123; c=relaxed/simple;
	bh=K7oPiz+CxBsUsTgPZj2gVgY/pH1vvRA8jRDUdU6b+KM=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=fmJ9IJ+B8ndvL7fFyb5JK8/zk7psvQaqD47p+aIZYH9rRB9AU5c+bFA0YwJOfk5KRBNQXH1yrblXf5kU0Y3sviS5TFKBOjt7iXzSTJxQbHHrf9ffnNNBDce/HmubQm3tVNBNzyTQEJZG++cVFh51IknUAY4Nqmdd4Xdipmn3Ix4=
ARC-Authentication-Results: i=2; sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDnH/XIdUzv1CI0Huk/C5EmI6Q4DtyWIIush9JJbhkvzCJhqF+GB7bzBvZ7UaHNVZuMVPlDKW51qe4UP2JVpSCmHMn+OrT7/SkaZBLucqCaF3CRytQ0+RrHslPQyKsjAIhWbDYHHws6thJxO10ndUtUbKpEpBYoZFjs/q6QnAZOsIj0bX/g71By92xIADZ7XKsm/jdp1UXoZbImKRb6xeVUDDClXXOyu//PhdYipgtgDccYfk5Wik82I6ADOoaDqXtTPbX2Y1Ais9gKIXp5FSHE/8sQjnmtjd+v09UiiRGqzK8gwSV8PUJOPIo9neLlajKoHHWiHvgRsRTkhY2sUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Zmo52DSpYPXuYh0leYgfahOojibnIcDl0aA5x5IkS34=;
 b=N/7iOcR5Igh2HFWfmm6S3zS8nBlEa9hwp1jraVCG3o9PH9D6x3sErPqhsfZ6h251/+V6LckbEiiaH8jeO+CB1qi0A9d5pcyUG9QI8TXZ4v11gFLVtVSNrnvAdO/UVR7BR06+ivg3WhUb2HC22j1Bx3231ltQFb9wuZVTipoS0wtplrx//e5RdkKuQxKwF1xPZKTxRMId+LMKpbMRtJru0Dq+ZlGGXdakvzt6PhvqBtApz8pzxSEnOgHYRJWyjXgs5nKTMHhI2xQXZqrw4H5ufhBhLCua+t0vMm2/OZLOmcG7bV0r9FNFMzJB3/VS5zIOodhsk5hILxT2VzvDC1hkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zmo52DSpYPXuYh0leYgfahOojibnIcDl0aA5x5IkS34=;
 b=Ye7llmwK1M1WGyi6WytjZBM2RdVvRheJj7LH7Py3dVMTIjAy0JoEiUGpKArKIvi5c4sh3ZEIyVGgAaDXO1KyG0FENnT+/n8x3l2CHG+JILM6Is70HgEUhC0iRsvc9UuwDRZsY9oCMOOPdEDSIGnwN5rLuDUhy6PQwSB9kVx0fvY=
Received: from PH0PR00MB3386.namprd00.prod.outlook.com (2603:10b6:510:3bf::15)
 by BL02EPF00042EE4.namprd00.prod.outlook.com with HTTP via P2P; Tue, 13 Oct
 2026 02:05:15 +0000
Received: from PH0PR00MB3386.namprd00.prod.outlook.com
 ([fe80::59b:592:f9e6:7bc5]) by PH0PR00MB3386.namprd00.prod.outlook.com
 ([fe80::59b:592:f9e6:7bc5%6]) with mapi id 15.21.0560.000; Tue, 13 Oct 2026
 02:05:15 +0000
From: Alexandre Zollinger Chohfi <Alexandre.Chohfi@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 0/2] Cygwin: avoid loading Winsock and iphlpapi at process
 startup
Thread-Topic: [PATCH 0/2] Cygwin: avoid loading Winsock and iphlpapi at
 process startup
Thread-Index: AQHdWrdDa41NtyermkKILpMZuvHpjw==
Date: Tue, 13 Oct 2026 02:05:15 +0000
Message-ID:
 <PH0PR00MB338654F8F60411E22F7D627C809E2@PH0PR00MB3386.namprd00.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-traffictypediagnostic: PH0PR00MB3386:EE_|BL02EPF00042EE4:EE_
x-ms-publictraffictype: Email
client-request-id: 74bcb774-21b8-4c40-a2f7-abb544b67e2a
request-id: c1115f2f-d80c-43db-65c9-08df28ce6c1b
x-ms-office365-filtering-correlation-id: c1115f2f-d80c-43db-65c9-08df28ce6c1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|6049299003|23010399003|38070700021|11063799006|56012099006|261009223027099003|7146999003|10067099003|18002099003|6133799003|4053099003;
x-microsoft-antispam-message-info:
 FT/aIv970zUjMgtzzEt7rT7pnieLB8l62PB2uttwROyw6OzKwf5Hd0M8Ocu/BeDzgD5iI5/AADSexwjHBD4zat16FYggWILdR0lhN3Q6CYNY5K24m56rrONIsphH3yzTpx5kIko8Y89LUhLWmKW3aFJECfv5bPRPLrwzfpLNbgjKY/DlWTGo0SmUesaDgNjvk+gXmpbGQx4nWoE4VhCUeA/8vVxVd68Mow/cWKnNor7ykJL/8EswVPiHEoZmshYEzY4x/kquTWoFEfHMy8/Fdaox/XAHVvSnC8RCdQ66XnIppji7SXPanMdpK1TuzT2tfsghozMDACPeFOKGmHRqwbsCv35xlIy9QUYA3MHPaYgn/G7kRzW9DGdkoZR1w75ZQGb9hK0AHdzetE4V5pCQxuJUKcRvK/difpkjxAPtHQErwWqXBFfLLhYgbUeZJgjIUCKt7VXfyXEbKygfOvtAirWI9hpURRYrIcDmnkAEa2GEYr6Vh95bdX8kNmJm3TAJigPmE2Ifxhk5nRMVrAqf1J75KPnA/5OY+Z4nH3tRfHT12UVnWVHzTDVhdMNdK35ngNbqvexV0zXfaEKXlI/4D80Gw1nxggWIvvrcMX++JpseGeMka7f7QehTRaDm0dYFSl8MCt4lLaHwdaDe2qI0oQ9hpQd4qUq0eQ1d1HTeKEmHOsjWiNJ/L2N9fGqJasBUeDZ+RqFU5kd/UYk9A7tJkmzqN0IrUfnJ/KrH1uABXIs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6049299003)(23010399003)(38070700021)(11063799006)(56012099006)(261009223027099003)(7146999003)(10067099003)(18002099003)(6133799003)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dYWx5JRfWRapaoAEr2jVQR/8zp/rfoGKj4fecKrLcrkm7uyKQETQ6v9hpgRK?=
 =?us-ascii?Q?vnS89ozrpF9Kj/XkGxSzV/47V4nB68ZGghcy2kbtdw8MIci7JzkhvuQD0maZ?=
 =?us-ascii?Q?ZrmvE8c0o3gaZvvK7W+nSAgspQ1r6SJa7lwLN/UJ5F4XyJxz+RROGsgC+sJM?=
 =?us-ascii?Q?RFsyX97QKpzZe+TX8lFo/tkc0ySK1Z0EfFhYqGxXRUd64YZ7pkF0jez9jsie?=
 =?us-ascii?Q?jsFxbe85hPy3CPkEru0DYI23Ov3JHWZxbcyJR2xly/Zko3JVOFXOx3chyuEV?=
 =?us-ascii?Q?3SB8yTujJJSrBwCTdlK0eTk+h39prNj4d/ZirMXBlYxj0FdVqUIAvYjpMj6k?=
 =?us-ascii?Q?J23eazAeRCvXbZ+uAgk8lxJJl6yaBGNQmUvIhDgUSi+Rof2K261qWE61XQMc?=
 =?us-ascii?Q?o/CYVZ9gpLwjkLSfDJ+Oht3s3khs50iZZkStQK2vqnk6ceyxBlLUkTMVx1BK?=
 =?us-ascii?Q?ZWhVWKB95oaBqiCqcyvwHo139JmhY7xjA3sRIcELjbKGfQb7CTHFRCVjCcPX?=
 =?us-ascii?Q?BqJc0l0q7PrA1eNw5d457mi5zwTlbbZByc9USMZnnc9ApF7bL0Epol6f+HQp?=
 =?us-ascii?Q?wo+4d5klo21TKNHeIZXymHT8DO3MmPLmYpdN3RJgH6/aQA5tXA+o1rkPOUdx?=
 =?us-ascii?Q?p2SXtqoFfnXItRkX3IR0PEaSbpEt4D2bN0E0sYg/2lEH3WpW0OMbp//Ku32G?=
 =?us-ascii?Q?ttpEAscX3BMZ9mh32zm0nnkbzb+/PTE5guwk24KiPp6kOfxNIKay32ylVqLd?=
 =?us-ascii?Q?1FbWfHY+8HrWqrKEEP0rlUaxoaJsjnTobCAM0xTOiQtQ3fr/lXRO7tHwXwko?=
 =?us-ascii?Q?RoEwwhpvMiLi+P9FoOF0QVpKrrRSmfVMyLCYsC5PmH0U1vRVU6htT1OxiG/3?=
 =?us-ascii?Q?OqgHDlpHD5BLFhpVJ+oHzjsR41Mbc4ja0Go7j4nC5JejxOgOHKNtHmPz8PFF?=
 =?us-ascii?Q?gJ/gd2nzF0jxsvpw06EsrTT91UA2vtVqAddqC34M5bp3YtGq77xLVdwLUflZ?=
 =?us-ascii?Q?ZSbDRdp642IBNlJpj+FOmzjDhqmGtm2tjMgZIGdCk50Ai/RrrSFvyIqv4Zc2?=
 =?us-ascii?Q?DJUB1Nsa0ar62s/KSlb7FBwyUj1lefYwWjBhtvAG9goSP/R38VadvE46JNv/?=
 =?us-ascii?Q?8vRw+Z8bES7389N8SBK/ZS3AUBF+fTzmgYsPDVMju0sX50uomHZTlsA+LuQ7?=
 =?us-ascii?Q?unh8oyqCX8L7OuU/PkKaV5lCrGQaV+T3k1Tt+cX334Y331W2EMibVy3UpOgs?=
 =?us-ascii?Q?itdyJtGYdxhf5JP7PSPF2xAfXhoYltjOn9sio6d2AOLeepRenoaTH8EXMRgP?=
 =?us-ascii?Q?xA+7H9QkfZpkNEVkEEFcLKKZy27x8JW/RN91SnrfNYc0/i1KAIwv2IBjccEo?=
 =?us-ascii?Q?Gfc/AZyHyM5ZDQnHtU1Tkaeyml+/baq2jau41O1LgoX7p7KU/uFSvgZE5yJ8?=
 =?us-ascii?Q?u/DIKQQriPwatLoQkwn9pDWUo/EnkdQHEFcJK3+HlI+3efWwBMDh2nKUcRxP?=
 =?us-ascii?Q?gEcremHFb8c2gXMY3GtSFGk9myc9nP21cgximdAvZHg14Y7cS8No1kAw/2C+?=
 =?us-ascii?Q?PjFlenQiUDFdxSTWXK03AAozvkh2mj+ig6/nnxUy6CF0fMc2KmxT7YUuZrIB?=
 =?us-ascii?Q?p584Zpyc8zqlxJKBgiKFD8fvh/m36or+oOujbe0Cdx5KiY8m8in1YRQJlw5z?=
 =?us-ascii?Q?lCQK7nnjqfrr+gblZJvHrmfdw/PxyQNS/zYlfQTqdBIw7XhWZgRE20wzeAbW?=
 =?us-ascii?Q?NcqfJrbt6Q=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_003_PH0PR00MB338654F8F60411E22F7D627C809E2PH0PR00MB3386namp_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR00MB3386.namprd00.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1115f2f-d80c-43db-65c9-08df28ce6c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 02:05:15.1970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: miD/HAPKR2hg8Ndp+hDGFbVepcmQmR6xk1+uYguUHBfUcZ6yaDbWEQkx+3voaLQOeVl3v+1PWqtIMPUn59UeIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL02EPF00042EE4
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GB_MSAUTHSOURCE_NORTHAM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_003_PH0PR00MB338654F8F60411E22F7D627C809E2PH0PR00MB3386namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Two code paths make a Cygwin process map DLLs it never uses.  bash hits=0A=
both at every start:=0A=
=0A=
1/2  When a standard handle is an anonymous pipe (CreatePipe: cmd.exe=0A=
     pipelines, and the subprocess APIs of Python, .NET and Go),=0A=
     init_std_file_from_handle cannot tell it from an LSP socket, because=
=0A=
     the pipe has no name, so it asks getsockopt.  That loads ws2_32.dll=0A=
     and mswsock.dll and calls WSAStartup.  The patch asks NPFS first=0A=
     (FilePipeLocalInformation), which succeeds on pipes and fails on=0A=
     sockets.=0A=
=0A=
2/2  gethostname calls GetNetworkParams, which loads iphlpapi.dll, nsi.dll,=
=0A=
     dnsapi.dll and dsparse.dll.  The patch tries GetComputerNameExA=0A=
     (ComputerNameDnsHostname) first.=0A=
=0A=
Measured on msys2-runtime 3.6.10 (the same code in both functions),=0A=
x86_64, Windows 11, i9-14900K: msys-2.0.dll rebuilt with and without=0A=
the series, 100 interleaved runs per arm, paired, medians with 95%=0A=
bootstrap CIs.=0A=
=0A=
                                              before    after    saved=0A=
  true.exe, stdio =3D anonymous pipes           14.2 ms  12.1 ms  2.1 ms (2=
.0-2.1)=0A=
  true.exe, stdio =3D NUL (neither applies)     12.0 ms  12.0 ms  0.0 ms (-=
0.15 to 0.12)=0A=
  bash -c true, stdio =3D anonymous pipes       19.0 ms  15.0 ms  4.1 ms (4=
.0-4.3)=0A=
  images mapped by bash -c true (pipes)         24       18=0A=
=0A=
For scale, a process with no imports beyond kernel32 starts in about=0A=
7 ms on the same machine.=0A=
=0A=
Behaviour was checked against the unpatched build:=0A=
- readlink /proc/self/fd/0 gives pipe:[0] for an anonymous pipe,=0A=
  socket:[0] for a TCP socket and /dev/null for NUL=0A=
- $HOSTNAME, `uname -n` and `hostname` are identical=0A=
=0A=
Questions:=0A=
- Is there a configuration where FIXED_INFO::HostName and=0A=
  GetComputerNameExA (ComputerNameDnsHostname) differ?  Both read the=0A=
  TCP/IP host name as far as I can tell, but I have only checked=0A=
  standalone machines.  getdomainname still uses GetNetworkParams.  I can=
=0A=
  switch it to ComputerNameDnsDomain too if you prefer the two to share=0A=
  a source, as 2166f7dc0d9a intended.=0A=
- Are LSP socket handles that fail NtQueryObject still a concern on the=0A=
  Windows versions Cygwin supports?  If not, the getsockopt probe could=0A=
  go entirely.=0A=
=0A=
Alexandre Zollinger Chohfi (2):=0A=
  Cygwin: dtable: don't load Winsock to classify an anonymous stdio pipe=0A=
  Cygwin: gethostname: try GetComputerNameExA before GetNetworkParams=0A=
=0A=
 winsup/cygwin/dtable.cc | 17 +++++++++++++++++=0A=
 winsup/cygwin/net.cc    | 14 ++++++++++++++=0A=
 2 files changed, 31 insertions(+)=0A=
=0A=
The two patches are attached in git format-patch format.  They apply=0A=
cleanly to the current main (06add56f7).=0A=

--_003_PH0PR00MB338654F8F60411E22F7D627C809E2PH0PR00MB3386namp_
Content-Type: text/plain;
	name="0001-Cygwin-dtable-don-t-load-Winsock-to-classify-an-anon.patch"
Content-Description:
 0001-Cygwin-dtable-don-t-load-Winsock-to-classify-an-anon.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-dtable-don-t-load-Winsock-to-classify-an-anon.patch";
	size=2822; creation-date="Tue, 13 Oct 2026 02:05:04 GMT";
	modification-date="Tue, 13 Oct 2026 02:05:04 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhZDFlMWNlZjZiYzZlNWExYWQ2NTk4ZjM1ZmNkNjU3MGJlN2M5NjZkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4YW5kcmUgWm9sbGluZ2VyIENob2hmaSA8YWx6b2xsaW5A
bWljcm9zb2Z0LmNvbT4KRGF0ZTogVHVlLCA2IE9jdCAyMDI2IDE2OjA2OjMyIC0wNzAwClN1Ympl
Y3Q6IFtQQVRDSCAxLzJdIEN5Z3dpbjogZHRhYmxlOiBkb24ndCBsb2FkIFdpbnNvY2sgdG8gY2xh
c3NpZnkgYW4KIGFub255bW91cyBzdGRpbyBwaXBlCgpBbiBhbm9ueW1vdXMgcGlwZSAoQ3JlYXRl
UGlwZSkgaGFzIG5vIG5hbWUsIHNvIE50UXVlcnlPYmplY3QgZmFpbHMgb24KaXQgd2l0aCBTVEFU
VVNfT0JKRUNUX1BBVEhfSU5WQUxJRCBhbmQgaGFuZGxlX3RvX2ZuIHJlcG9ydHMgaXQgYXMKdW5r
bm93bl9maWxlLCB0aGUgc2FtZSBhbnN3ZXIgaXQgZ2l2ZXMgZm9yIGFuIExTUCBzb2NrZXQuCmlu
aXRfc3RkX2ZpbGVfZnJvbV9oYW5kbGUgdGhlbiBjYWxscyBnZXRzb2Nrb3B0IG9uIGl0LCB3aGlj
aCBsb2Fkcwp3czJfMzIuZGxsIGFuZCBtc3dzb2NrLmRsbCBhbmQgY2FsbHMgV1NBU3RhcnR1cCwg
b25seSB0byBsZWFybiB0aGF0IHRoZQpwaXBlIGlzIG5vdCBhIHNvY2tldC4gIEV2ZXJ5IEN5Z3dp
biBwcm9jZXNzIHN0YXJ0ZWQgYnkgYSBub24tQ3lnd2luCnBhcmVudCB3aXRoIGFub255bW91cyBw
aXBlcyBhcyBzdGRpbyBwYXlzIGZvciB0aGF0OiBjbWQuZXhlIHBpcGVsaW5lcywKYW5kIHRoZSBz
dWJwcm9jZXNzIEFQSXMgb2YgUHl0aG9uLCAuTkVUIGFuZCBHbywgYW1vbmcgb3RoZXJzLgoKQXNr
IHRoZSBuYW1lZCBwaXBlIGZpbGUgc3lzdGVtIGZpcnN0LiAgTnRRdWVyeUluZm9ybWF0aW9uRmls
ZQooRmlsZVBpcGVMb2NhbEluZm9ybWF0aW9uKSBzdWNjZWVkcyBvbiBhbnkgTlBGUyBwaXBlLCBu
YW1lZCBvciBub3QsIGFuZApmYWlscyBvbiBBRkQgc29ja2V0IGhhbmRsZXMsIHNvIHNvY2tldHMg
c3RpbGwgcmVhY2ggdGhlIGdldHNvY2tvcHQgcHJvYmUKYXMgYmVmb3JlLgoKT24gYSAzLjYuMTAg
YnVpbGQsIGEgbm8tb3AgcHJvY2VzcyBzdGFydGVkIHdpdGggYW5vbnltb3VzIHBpcGVzIGFzCnN0
ZGlvIHN0YXJ0cyAyLjEgbXMgZmFzdGVyICgxNC4yIC0+IDEyLjEgbXMsIG1lZGlhbiBvZiAxMDAg
aW50ZXJsZWF2ZWQKcnVucykgYW5kIG1hcHMgdGhyZWUgZmV3ZXIgRExMcy4gIEEgVENQIHNvY2tl
dCBoYW5kZWQgZG93biBhcyBzdGRpbiBpcwpzdGlsbCBjbGFzc2lmaWVkIGFzIGEgc29ja2V0LgoK
U2lnbmVkLW9mZi1ieTogQWxleGFuZHJlIFpvbGxpbmdlciBDaG9oZmkgPGFsem9sbGluQG1pY3Jv
c29mdC5jb20+Ci0tLQogd2luc3VwL2N5Z3dpbi9kdGFibGUuY2MgfCAxNyArKysrKysrKysrKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS93aW5z
dXAvY3lnd2luL2R0YWJsZS5jYyBiL3dpbnN1cC9jeWd3aW4vZHRhYmxlLmNjCmluZGV4IDUzMGM2
NzkxMC4uYzk4ZWFkM2FjIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2R0YWJsZS5jYworKysg
Yi93aW5zdXAvY3lnd2luL2R0YWJsZS5jYwpAQCAtMjc4LDYgKzI3OCwyMiBAQCBjeWd3aW5fYXR0
YWNoX2hhbmRsZV90b19mZCAoY2hhciAqbmFtZSwgaW50IGZkLCBIQU5ETEUgaGFuZGxlLCBtb2Rl
X3QgYmluLAogICByZXR1cm4gZmQ7CiB9CiAKKy8qIEFub255bW91cyBwaXBlcyAoQ3JlYXRlUGlw
ZSkgaGF2ZSBubyBuYW1lLCBzbyBoYW5kbGVfdG9fZm4gcmVwb3J0cyB0aGVtCisgICBhcyB1bmtu
b3duX2ZpbGUsIGp1c3QgbGlrZSBhbiBMU1Agc29ja2V0LiAgQXNrIHRoZSBuYW1lZCBwaXBlIGZp
bGUgc3lzdGVtCisgICBmaXJzdDogYSBzb2NrZXQgZmFpbHMgdGhpcyBxdWVyeSwgYSBwaXBlIG9m
IGFueSBraW5kIHN1Y2NlZWRzLiAgV2l0aG91dAorICAgaXQsIGV2ZXJ5IHByb2Nlc3Mgc3RhcnRl
ZCB3aXRoIGFub255bW91cyBwaXBlcyBhcyBzdGRpbyAoYnkgY21kLmV4ZQorICAgcGlwZWxpbmVz
LCBQeXRob24sIC5ORVQsIEdvLCAuLi4pIGNhbGxzIGdldHNvY2tvcHQsIHdoaWNoIGxvYWRzIFdp
bnNvY2sKKyAgIGFuZCBjYWxscyBXU0FTdGFydHVwIGp1c3QgdG8gbGVhcm4gdGhhdCBhIHBpcGUg
aXMgbm90IGEgc29ja2V0LiAqLworc3RhdGljIGJvb2wKK2lzX25wZnNfaGFuZGxlIChIQU5ETEUg
aCkKK3sKKyAgSU9fU1RBVFVTX0JMT0NLIGlvOworICBGSUxFX1BJUEVfTE9DQUxfSU5GT1JNQVRJ
T04gZnBsaTsKKworICByZXR1cm4gTlRfU1VDQ0VTUyAoTnRRdWVyeUluZm9ybWF0aW9uRmlsZSAo
aCwgJmlvLCAmZnBsaSwgc2l6ZW9mIGZwbGksCisJCQkJCSAgICAgRmlsZVBpcGVMb2NhbEluZm9y
bWF0aW9uKSk7Cit9CisKIHZvaWQKIGR0YWJsZTo6aW5pdF9zdGRfZmlsZV9mcm9tX2hhbmRsZSAo
aW50IGZkLCBIQU5ETEUgaGFuZGxlKQogewpAQCAtMzEwLDYgKzMyNiw3IEBAIGR0YWJsZTo6aW5p
dF9zdGRfZmlsZV9mcm9tX2hhbmRsZSAoaW50IGZkLCBIQU5ETEUgaGFuZGxlKQogCQkgIGhhbmRs
ZS4gIGZoYW5kbGVyX3NvY2tldDo6c2V0X3NvY2tldF9oYW5kbGUgdHJpZXMgdG8gZmV0Y2gKIAkJ
ICB0aGUgdW5kZXJseWluZyBiYXNlIHNvY2tldCwgYnV0IHRoaXMgbWlnaHQgZmFpbC4gKi8KIAkg
ICAgICAgfHwgKHN0cmNtcCAobmFtZSwgdW5rbm93bl9maWxlKSA9PSAwCisJCSAgICYmICFpc19u
cGZzX2hhbmRsZSAoaGFuZGxlKQogCQkgICAmJiAhOjpnZXRzb2Nrb3B0ICgoU09DS0VUKSBoYW5k
bGUsIFNPTF9TT0NLRVQsIFNPX1JDVkJVRiwKIAkJCQkgICAgIChjaGFyICopICZyY3YsICZsZW4p
KSkKIAl7Ci0tIAoyLjUzLjAud2luZG93cy40Cgo=

--_003_PH0PR00MB338654F8F60411E22F7D627C809E2PH0PR00MB3386namp_
Content-Type: text/plain;
	name="0002-Cygwin-gethostname-try-GetComputerNameExA-before-Get.patch"
Content-Description:
 0002-Cygwin-gethostname-try-GetComputerNameExA-before-Get.patch
Content-Disposition: attachment;
	filename="0002-Cygwin-gethostname-try-GetComputerNameExA-before-Get.patch";
	size=1933; creation-date="Tue, 13 Oct 2026 02:05:04 GMT";
	modification-date="Tue, 13 Oct 2026 02:05:04 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwNmQwZGUzODNhM2JhYzY1MGY4MjQwM2E1NjllNWI4MzljMWFhN2JjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4YW5kcmUgWm9sbGluZ2VyIENob2hmaSA8YWx6b2xsaW5A
bWljcm9zb2Z0LmNvbT4KRGF0ZTogVHVlLCA2IE9jdCAyMDI2IDE2OjA2OjMyIC0wNzAwClN1Ympl
Y3Q6IFtQQVRDSCAyLzJdIEN5Z3dpbjogZ2V0aG9zdG5hbWU6IHRyeSBHZXRDb21wdXRlck5hbWVF
eEEgYmVmb3JlCiBHZXROZXR3b3JrUGFyYW1zCgpTaW5jZSBjb21taXQgMjE2NmY3ZGMwZDlhICgi
Q3lnd2luOiBuZXQ6IHVuaWZ5IGdldGhvc3RuYW1lL2dldGRvbWFpbm5hbWUiKQpnZXRob3N0bmFt
ZSByZWFkcyBGSVhFRF9JTkZPOjpIb3N0TmFtZSBmcm9tIEdldE5ldHdvcmtQYXJhbXMuICBUaGF0
CmxvYWRzIGlwaGxwYXBpLmRsbCwgYW5kIHdpdGggaXQgbnNpLmRsbCwgZG5zYXBpLmRsbCBhbmQg
ZHNwYXJzZS5kbGwsCmludG8gZXZlcnkgcHJvY2VzcyB0aGF0IGNhbGxzIGl0LCBhbmQgYmFzaCBj
YWxscyBpdCB1bmNvbmRpdGlvbmFsbHkgYXQKc3RhcnR1cCB0byBzZXQgJEhPU1ROQU1FLgoKR2V0
Q29tcHV0ZXJOYW1lRXhBIChDb21wdXRlck5hbWVEbnNIb3N0bmFtZSkgcmV0dXJucyB0aGUgc2Ft
ZSBUQ1AvSVAKaG9zdCBuYW1lIGZyb20ga2VybmVsMzIuICBUcnkgaXQgZmlyc3QgYW5kIGtlZXAg
R2V0TmV0d29ya1BhcmFtcyBhcyB0aGUKZmFsbGJhY2suICBnZXRkb21haW5uYW1lIGlzIHVuY2hh
bmdlZC4KCk9uIGEgMy42LjEwIGJ1aWxkLCB0b2dldGhlciB3aXRoIHRoZSBwcmV2aW91cyBwYXRj
aCwgYGJhc2ggLWMgdHJ1ZWAKc3RhcnRlZCB3aXRoIGFub255bW91cyBwaXBlcyBhcyBzdGRpbyB0
YWtlcyA0LjEgbXMgbGVzcyAoMTkuMCAtPiAxNS4wIG1zLAptZWRpYW4gb2YgMTAwIGludGVybGVh
dmVkIHJ1bnMpIGFuZCBtYXBzIDE4IGltYWdlcyBpbnN0ZWFkIG9mIDI0LgokSE9TVE5BTUUsIGB1
bmFtZSAtbmAgYW5kIGBob3N0bmFtZWAgYXJlIHVuY2hhbmdlZC4KClNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRyZSBab2xsaW5nZXIgQ2hvaGZpIDxhbHpvbGxpbkBtaWNyb3NvZnQuY29tPgotLS0KIHdp
bnN1cC9jeWd3aW4vbmV0LmNjIHwgMTQgKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAx
NCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9uZXQuY2MgYi93aW5z
dXAvY3lnd2luL25ldC5jYwppbmRleCA1NzliMWE3MGIuLmYyYjY0ODg4ZCAxMDA2NDQKLS0tIGEv
d2luc3VwL2N5Z3dpbi9uZXQuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9uZXQuY2MKQEAgLTc1Niw2
ICs3NTYsMjAgQEAgY3lnd2luX2dldGhvc3RuYW1lIChjaGFyICpuYW1lLCBzaXplX3QgbGVuKQog
ewogICBfX3RyeQogICAgIHsKKyAgICAgIC8qIEdldENvbXB1dGVyTmFtZUV4QSByZXR1cm5zIHRo
ZSBzYW1lIFRDUC9JUCBob3N0IG5hbWUgYXMKKwkgR2V0TmV0d29ya1BhcmFtcycgRklYRURfSU5G
Tzo6SG9zdE5hbWUsIHdpdGhvdXQgbG9hZGluZworCSBpcGhscGFwaS5kbGwgKGFuZCB3aXRoIGl0
IG5zaSwgZG5zYXBpIGFuZCBkc3BhcnNlKSBpbnRvIGV2ZXJ5CisJIHByb2Nlc3MgdGhhdCBhc2tz
LiAgYmFzaCBhc2tzIGF0IGV2ZXJ5IHN0YXJ0LiAqLworICAgICAgY2hhciBob3N0WzI1Nl07Cisg
ICAgICBEV09SRCBobGVuID0gc2l6ZW9mIGhvc3Q7CisKKyAgICAgIGlmIChHZXRDb21wdXRlck5h
bWVFeEEgKENvbXB1dGVyTmFtZURuc0hvc3RuYW1lLCBob3N0LCAmaGxlbikpCisJeworCSAgc3Ry
bmNweSAobmFtZSwgaG9zdCwgbGVuKTsKKwkgIGRlYnVnX3ByaW50ZiAoImdldGhvc3RuYW1lICVz
IiwgbmFtZSk7CisJICByZXR1cm4gMDsKKwl9CisKICAgICAgIFBGSVhFRF9JTkZPIGluZm8gPSBO
VUxMOwogICAgICAgVUxPTkcgc2l6ZSA9IDA7CiAKLS0gCjIuNTMuMC53aW5kb3dzLjQKCg==

--_003_PH0PR00MB338654F8F60411E22F7D627C809E2PH0PR00MB3386namp_--
