Return-Path: <SRS0=9W9l=IF=leafsoftwaresolutions.com=pcahoon@sourceware.org>
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::7])
	by sourceware.org (Postfix) with ESMTPS id 706F84BA2E11
	for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 13:02:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 706F84BA2E11
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=leafsoftwaresolutions.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=leafsoftwaresolutions.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 706F84BA2E11
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c105::7
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1792069327; cv=pass;
	b=gJ0Dpe2GID6dXjqdNr5sETwRTDgSG6eBLutOChLJouMcN2PJYON5CzLeTOpw0EG7TBG/WVTSYl1E+TjGTvvlgWgWJYpN8TRlsO75TzlI7FDdTwW1/NOE/aDce+fLPl974Mg7iKW9t34HeST2ME37cnDZ2ZCp0ngOlTITmiwW+lw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792069327; c=relaxed/simple;
	bh=8YH26LOIdTIOP/KR+r2myt4oh76CVZII0q6CGjYkUTg=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=RWp5b01j31SIXxxTBoHfuA2NZBXDaVzfNZwfU88aO8I6VCpibP5Q+rgPaQ2sORpWkWDS44R6fd0soMQfeFSfNbM6JTaMf3Emk2jQjlaksj11VJvVK7TeGhA2OAOEozcUIr5QyWnTpRuXGZ2Ra+zr2M3ZZrqPJD3Puinj7OopS08=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=leafsoftwaresolutions.com header.i=@leafsoftwaresolutions.com header.a=rsa-sha256 header.s=selector1 header.b=beA+I3Y4
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 706F84BA2E11
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=leafsoftwaresolutions.com header.i=@leafsoftwaresolutions.com header.a=rsa-sha256 header.s=selector1 header.b=beA+I3Y4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVymulSI1cAksLt1y5HXseu3IJKn8GFFOTdhORWOMOYlrMI9n0r+Xbb6oEBnM7YRYkZjbanTINCjGq/B8+hhqRdVSWtMXMXOtYa53SuNBURPL5W3b/1r6OjBFOPalyOBPEgVzUScpZqa8cIkhrhXLNZq13XDHJIT6r1Jq953acGRZjDukq+G6rebA/WGa1VWtXpLaOxPssO9SMJbht0yMUw4/OhMd8bTcddC15Dtmbp3f1uM2GR78i2DVrr8kaTQDUJwy7G+fS3EaE5MGuNbYT25g84pfdNFC7l8jTgG/qfEsaCCelpZvc5ZrlF39NMcPBAzcPwQGbzdZhIdMN2APg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAxYKBdR/9JxRanaEu0bp1zzMWnv3sUOR+lb9J/px0o=;
 b=GzqnhV93Rr06rl0kvol1osZmL+c0H/hCF9lcJZHnGprz2z1PxQmc0DjpUzyFOyjJauwu1InisbGNTGg10B0mFZL6HRVInb7W4WZwGnuWYh+FdsDzG9lNmdjCrkAkUDQXjlztZic1QcVOs7tsVTsx0U9sImsLiRHNdtFMUenOf5x+u4PQbq1QMy3X5HUjWZJApn4hTchs5scC9iIgx5ZAmzScPPLOGbX8SJ9qQGRQR+MAjkfZH8wS9LZ5kDS9pk31eT5PcHAw2e2U8Za0LuuyGK38yFv9yQIvdc0bhlKlB13UomwDTsaDo5iRZUP/8OplUHwLJlZ94R2BCcVFTgTSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leafsoftwaresolutions.com; dmarc=pass action=none
 header.from=leafsoftwaresolutions.com; dkim=pass
 header.d=leafsoftwaresolutions.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leafsoftwaresolutions.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAxYKBdR/9JxRanaEu0bp1zzMWnv3sUOR+lb9J/px0o=;
 b=beA+I3Y40CEpgaxV95zFjRPfpgmO8OpO3YvjcNJA5Xr4IMVUHE6Mhj8QZJ/8Z6VwNMR5BDetzImLdhWb0HBBVg+ZDjOW0UUjIMUjMe604KLsIyx9WXSe76eVXPv0vxdA0yDaKGxYhpdch/jKU9BWeVisz2cXR+EsdXp/J86qPOc=
Received: from CO1PR17MB5321.namprd17.prod.outlook.com (2603:10b6:303:e4::19)
 by CH3PR17MB6315.namprd17.prod.outlook.com (2603:10b6:610:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 15 Oct
 2026 13:01:47 +0000
Received: from CO1PR17MB5321.namprd17.prod.outlook.com
 ([fe80::4aea:a917:dde9:bc7d]) by CO1PR17MB5321.namprd17.prod.outlook.com
 ([fe80::4aea:a917:dde9:bc7d%4]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 13:01:47 +0000
From: Phil Cahoon <pcahoon@leafsoftwaresolutions.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: serialize user shared initialization with a named
 mutex
Thread-Topic: [PATCH] Cygwin: serialize user shared initialization with a
 named mutex
Thread-Index: Ad1cpTt9nwRdGQ3nTI++zk9D85sLNQ==
Date: Thu, 15 Oct 2026 13:01:47 +0000
Message-ID:
 <CO1PR17MB5321FECB097C636C96DAECE1AA9C2@CO1PR17MB5321.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leafsoftwaresolutions.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5321:EE_|CH3PR17MB6315:EE_
x-ms-office365-filtering-correlation-id: a997886e-8973-49a3-5ca9-08df2abc7887
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|366016|376014|23010399003|1800799024|10067099003|3023799007|6133799003|56012099006|4053099003|18002099003|38070700021|261009223027099003;
x-microsoft-antispam-message-info:
 sgdss7jwgoxH0C9ZsnCFzd4cO2QTU8pUFNdVJglCAmVCz4va2wsWj2XFLGsqN7Mwhu6j8pY4wHFPqYBHjbQki79JWNXAvRe37n8qYvNjqQ9tgm5RqH47ddh9yeUiB/znYiUGlFLB/q7M62wikDa39a4yatK6Bf6KmsclV9F9s6JH7EbjrrMPaL3blCHS+ZngZnnJG/W49oP8S2bsqDefTYNatBv0+H4ZKTrPKl5CtWlkt0MsUXnyhzkib1VRTtVKb7MULHVWoyhBbxqQx9o0mkbkFuhnRAuM2KY9cr9+/WeBrS+xeNP+RwJSKgjlqlT5+URyt7SQYP8//PTa8bhmQP8Gdzi+zzPdVCroJPZEra4fuPQJuweP77b294TLfCuMDW4hd8WqXTXYGNmwS85sIEQq6nwdgvelY8yzpLS1f8L2Q9Jah6a9ia5UdLWOLIPoPSFSrGgi76OfiBIMow4SGd/hqcEV9qTOJfY6lq7QHvAVbphwPssFB22L6tvPrOxa0xUJ8WqcP3ZW4kIO1BLKxy8v5u0H8SpfjB0swNVv9tZnOPKIiM5Fzf8tpf/4JiR4oviBlZ0TuN4Rt5Z4GPCwMLtniAkV2k+MKqdAm+hO1YojWAIlssgnG1rco0zkHcjXqxkmXoF54ZrPD/ssN+1xXntWGRIfn11KqU4SO+UKeCbgsDo/fqSkEptuEl/2oFBdNeTf1d5o71LmGn/HElEYv0pqc/ltxuGLYbPAcQ0M5mA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR17MB5321.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(366016)(376014)(23010399003)(1800799024)(10067099003)(3023799007)(6133799003)(56012099006)(4053099003)(18002099003)(38070700021)(261009223027099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g1ia8Zuyk/VIKQ1+0BpHFDR3EBsYj0sJ9ITYyGQHiy8jHvsWrGaMaKrFI94l?=
 =?us-ascii?Q?EB4kvfLnibANVvSS+Ousg9SDmiArSMiUcpyYxb1P22lWCccVIGJqYRCnxPIF?=
 =?us-ascii?Q?7+Yo9fsc7iKcD31jbCbXY7Sfnnq95CBE/rw7YL2aQ3te9g7yj62SZ6Toj/3l?=
 =?us-ascii?Q?PqNd3KGTYRppL+qF3pQMZ8mImn+ADnFkun9FDE2q4rawHcjA5ugfnARTW6px?=
 =?us-ascii?Q?3QFv3ZDKY1raTjOeWysKxuA40h00qeNpHLSIHufkKexMo5ZjLlz3AfypbPrw?=
 =?us-ascii?Q?X5IxQLILg2aROG9dRE/Jk6jawErlz4SUT6sM6twfDHVUnhQL1OboO4Za3AUB?=
 =?us-ascii?Q?0NFkunyLx/AIPj84FR2lQDmxy/Qls+xzlRS7s0KC82073f3zDkGnCn01HUSA?=
 =?us-ascii?Q?vEAOPVnDUJPvH3dzyIjeF7T5dxVO+7fua0slblXNb1xktuYC4/BrRRCoeX7C?=
 =?us-ascii?Q?cOLicXCGwpej1Kl/jQ468MahhK+DTrlgNwSq6azbBmC3sTFVH7GRjmPUrSSg?=
 =?us-ascii?Q?DZsP5HZ9vCG6GG8rdL1dVUddXgVODNY1Q/FAVBL9es3F69+6xQ2JEl3Yd8Uv?=
 =?us-ascii?Q?DB2vaPvjBVUp/S051SWDjwWTFYME/J7i1yIeUElWsp2d0NIqGlJ2LabSQSHj?=
 =?us-ascii?Q?OMkhqemlm1URQ7EiI1G0D39mHn9GuvnB9+Z3nUmuOto5+ffSiXBtc84JymZY?=
 =?us-ascii?Q?qPAUVnjxzXl4oKWXFykKsoGVdsupcB66kHRX2rB9FE29BuQizaacDBPsGHqt?=
 =?us-ascii?Q?x8ssvhwVpgVt2q0wp3ouIC+CbDD2fZTuR/nHOLaDvHtq5EhB4ieYUL4/ujMW?=
 =?us-ascii?Q?9zvgjEfN0GwXKcN3V9IQdXq6jEypkND3CqSMeVrMkj7o4078XkmOC7B0no/V?=
 =?us-ascii?Q?BQPSJYjWG98N9zx3PXiAJlbM0M6StVDOLhCNsFk6HGJovS/r1rBkp7AyjRvo?=
 =?us-ascii?Q?796/LP00s+kdgBHkgfUwhVbq3q/nyePhxJC7Mxa9MRuuNZbRihYp/8zpmMgW?=
 =?us-ascii?Q?cpWiplUXata1k138EQ5v3U6BbyDpInJX4JTZvK6hS4KvhyqE3wEqVB1YJTJP?=
 =?us-ascii?Q?K3lVuilxCegNSJdzUh85nwlmLAO9Vs7N2OSD9wfHLY6jaK+CxL0L0KbIzAw1?=
 =?us-ascii?Q?J4UqolA9fxRVP5LRoEMOLNZbZif1PxWSYuBd6wGc3Wmm5KsQ/A0JZAVFn69X?=
 =?us-ascii?Q?dhqYizK/rh8cSSDeLkfgqyTA1RgTPwOMGj08I4DriCkmHpAdlw0nk0gO89XA?=
 =?us-ascii?Q?Qw0sN4ONPQifmnzBCCjzSlkK01MjfyscKIJnACiJHA6XB/jlRT2/tRJE2ggW?=
 =?us-ascii?Q?m9R1p+bOc2zXMWDRbVBLfa0uz6XsgGXjNy5xeaD18qo3GjYcB+3MduHOizKE?=
 =?us-ascii?Q?nzwxOCvGYWR6jP82bQpakmPgtsBnG9iq77mXrTykVtL1bklmwQuhEi7KvNkZ?=
 =?us-ascii?Q?5pj12fVUxAytwbr/D8MMS+BMxC7NsQVfH23jcqPx8Cve/l8PdvOIz8TduhF0?=
 =?us-ascii?Q?/mmDVJEOuG7eN6wY8ss2SwxlLGq9tjm44TVQlC5FtnFc+xGVf+NKi4eC02Ri?=
 =?us-ascii?Q?IX5gbEtLOxjVqqFcpMUHBgGpni+cAwLTFHJQ/IM3LSBOu8C7gq64Q1Llo1M6?=
 =?us-ascii?Q?oNoXlLTC0nsYqxYG+DD4RcyuuAVPw/XAd1HJzO+OnkSjrJbJhuoksaNrBRNy?=
 =?us-ascii?Q?JjapSWm6DAguIhTKmZ07IG3sFrs4yiCVNOO+alx9YX5PhqrTMctYFPCEUTCj?=
 =?us-ascii?Q?kMYWwXDn5Nvtgj671rzH/h313+ELBL0=3D?=
Content-Type: multipart/mixed;
	boundary="_002_CO1PR17MB5321FECB097C636C96DAECE1AA9C2CO1PR17MB5321namp_"
MIME-Version: 1.0
X-OriginatorOrg: leafsoftwaresolutions.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR17MB5321.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a997886e-8973-49a3-5ca9-08df2abc7887
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 13:01:47.3856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 925dca83-2532-40a7-9105-03cb15e44d10
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mdp0V2t2Of3c1accEy/gP7Q072gS41n5KakDo3FSlihxi27R+FEbcm3AKAefAN6ouWTQnLkGSxRQRgoJrbaH0SEKRKA5kcAtHbUEIA6RpyUNLBjRquM3/yCPe5Dz8f+7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR17MB6315
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GB_MSAUTHSOURCE_NORTHAM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_CO1PR17MB5321FECB097C636C96DAECE1AA9C2CO1PR17MB5321namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

The attached patch fixes a startup race in user_info::initialize that makes=
 new processes die with

  add_item ("\??\C:\Program Files\Git", "/", ...) failed, errno 1

after a 15 second hang. It is reported against Git for Windows at https://g=
ithub.com/git-for-windows/git/issues/6368, where it can last until every MS=
YS process is gone because tools keep starting shells while the per-user se=
ction is stuck.

The current spinlock times out after 15 seconds and lets the waiter re-run =
mount_info::init on a table that may already hold "/". The patch replaces i=
t with a named mutex next to the section: a live initializer is waited for,=
 and one that died shows up as WAIT_ABANDONED, so the half-built section is=
 cleared and rebuilt. Initialized sections still take the lock-free fast pa=
th. The one behavior change is that a process suspended indefinitely while =
initializing now makes later processes wait instead of dying after 15 secon=
ds.

msys2/msys2-runtime#333 proposes making create_root_entry tolerate a second=
 initialization (MOUNT_OVERRIDE) instead. That stops the crash, but a slow =
initializer that is still running can then be writing the table at the same=
 time as the waiter.

Testing, on the Git for Windows runtime 3.6.10 with the identical change (i=
t applies cleanly to main):

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

--_002_CO1PR17MB5321FECB097C636C96DAECE1AA9C2CO1PR17MB5321namp_
Content-Type: application/octet-stream;
	name="0001-Cygwin-serialize-user-shared-initialization-with-a-n.patch"
Content-Description:
 0001-Cygwin-serialize-user-shared-initialization-with-a-n.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-serialize-user-shared-initialization-with-a-n.patch";
	size=5278; creation-date="Thu, 15 Oct 2026 13:01:29 GMT";
	modification-date="Thu, 15 Oct 2026 13:01:47 GMT"
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

--_002_CO1PR17MB5321FECB097C636C96DAECE1AA9C2CO1PR17MB5321namp_--
