Return-Path: <SRS0=l28s=ID=microsoft.com=Alexandre.Chohfi@sourceware.org>
Received: from SJ0PR00CU001.outbound.protection.outlook.com (mail-westusazlp17013000b.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::b])
	by sourceware.org (Postfix) with ESMTPS id 332D64BA23CE
	for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 02:31:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 332D64BA23CE
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 332D64BA23CE
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c000::b
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1791858668; cv=pass;
	b=X9byb2UHLCqek7N9SqibVzyu16XwvttM3FA/nqAOX6m9kwtDt15JF1UARZp+b7Ct+18Kp80jyNDYZU57DX5VprfcFtLDe0/qWzjJfKF2UCODDyqtFPfF0842zJ99sRsilcqOlcNdgWoXTQPkeNFJFeFYYHQrahI6Ho5VtdMRVQg=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791858668; c=relaxed/simple;
	bh=2DABv3JAaAR04n1YHji/L/02SYshRhG90C8nWCz6EK8=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=rM23bGC14MZ+9bj+E5Jn2/tiV/WPkc0QYip/ynBe0yQ/LrHSmYdOhOhDwrGM9yXO6M9ctdpk4iELejm1tdinPQC8oRAT2OLZHJ72V8jH+oE/ldpHj37ZxD9bqi7hkmsc5T/nVIsHQSzrQRGQX+tIIE7DpI/g0/BqKHA6F2SaI3o=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=TeDbrxTG
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 332D64BA23CE
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=TeDbrxTG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYvN3SFxwoe4uVN2356l2GtiFuGusx2LO7Jr+WLw1MONuI0d1oLHI/8BLDNbNqLg3GPuxhNl27NZGqHsnkPd1DJSbCbyyRcP1LpXF2vOxE1Lzi6lIC+lSAQlNLEpv4PdRqA27kqS7gvSEY3gLMJ8GjzGo92eS1I5258YnF/6idX+OzuKxX51RakUZpqjz3wxc0LUggNTiazE3QCmsgP4jRFCHmom+C2EPIbOGhbtFlTW+/UE0RCCkwqSjJcyeyuJTKviJ2hsmo8uto9Y0yVuC4eNewmgXFV1Dqa4OGOw1VTffp0pNTe6zd7r6DhKs7tseZj+Koy0cAYE9XJxAmCr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=e4pwB2AT8vAgNK57JcQVL/qU66AwVwmD4bomSAoQNbY=;
 b=aypHavI01VfLc8zSzh5EvdQyvgSDt3D7/X4brsTrxEBt1YrtsRgdU5+yfl+PKPgVHnU2o/fKituT9wnxV2e6E8NPvZGwLZiwYJaA2JVUh+NitWNvTTJrXRHxEe/RVUeW88Ot9p9/lVxrsY4YL3pQmBZUwWxLwTEpk0T1gd9D8rHwFTMQ07ZzMFUwgQQNBFjX4AmqxUuBzDIRh+wU9BA/EA7Je0BQNGDp+OAbJzhE2ZLlWOF7oWvFexwpdlr718qmfrK9dThRh8iTHSnEneyHkRvWOKVRNwBLwcRSBY8iPMAo3qhMC1/xPQdCzeHCnRaIbd0B/ZhTSUz4JRiQCtkQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4pwB2AT8vAgNK57JcQVL/qU66AwVwmD4bomSAoQNbY=;
 b=TeDbrxTGgHdG1G2kSTLJJd6pS1ui3tOm6ftgIJgxQEAemvM3CNW78gAVrwymxXR9WS2vJ9295LPHdjku3U0xB0Jqf6WzEfPhK+eVoT532weXEZQztPHGhY72vi7PLynWP1EISfkaglmirPiGJmyBK2qQgHIHqnm1dHkGM076bK8=
Received: from PH0PR00MB3386.namprd00.prod.outlook.com (2603:10b6:510:3bf::15)
 by PH0PR00MB3763.namprd00.prod.outlook.com with HTTP via P2P; Tue, 13 Oct
 2026 02:30:54 +0000
Received: from PH0PR00MB3386.namprd00.prod.outlook.com
 ([fe80::59b:592:f9e6:7bc5]) by PH0PR00MB3386.namprd00.prod.outlook.com
 ([fe80::59b:592:f9e6:7bc5%6]) with mapi id 15.21.0560.000; Tue, 13 Oct 2026
 02:30:54 +0000
From: Alexandre Zollinger Chohfi <Alexandre.Chohfi@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH RESEND 0/2] Cygwin: avoid loading Winsock and iphlpapi at
 process startup
Thread-Topic: [PATCH RESEND 0/2] Cygwin: avoid loading Winsock and iphlpapi at
 process startup
Thread-Index: AQHdWrrfft1X79GziUm5HLUp1eiwmw==
Date: Tue, 13 Oct 2026 02:30:54 +0000
Message-ID:
 <PH0PR00MB338699008F36947D666826C5809E2@PH0PR00MB3386.namprd00.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-traffictypediagnostic: PH0PR00MB3386:EE_|PH0PR00MB3763:EE_
x-ms-publictraffictype: Email
client-request-id: 1e3d9598-68ab-4486-89e2-bf7601b141ee
request-id: 01c68f0e-e749-4044-c220-08df28d201cf
x-ms-office365-filtering-correlation-id: 01c68f0e-e749-4044-c220-08df28d201cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|6049299003|376014|38070700021|56012099006|11063799006|261009223027099003|10067099003|7146999003|18002099003|6133799003|4053099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qGmZS8u5nbiO701fEhhnIq4c2QgutUbbIchKQGGA1+94b5OXFMnjqTbGiv31?=
 =?us-ascii?Q?9Z3dnK2+cYKo8bwyvR+c9vn/c+mgav8qtmS20zot69aie+a1dC2ElI5doxjV?=
 =?us-ascii?Q?Q2rR/Ub/PV9r9A6uV8G8mi17cOnoXlTFBp25qAv7TzdaoonSqHloxZ4NQ4MQ?=
 =?us-ascii?Q?4zSc6daSy7dV3E043zCGS4QobLQEwZeCTCjoFL7WpZur9Spi6m2PWEaemhPy?=
 =?us-ascii?Q?7Lt34fGgDtfDhFDyyDNfE6JHJf1KUZnWb7oS0r2UnGbztvFwl+NstcxVcY7y?=
 =?us-ascii?Q?Ambwn1qud4+E54xzfHkPa97FgOuUpxMBpk3GUr2e8g7aJn/LFONGYnbgCD/W?=
 =?us-ascii?Q?fPImaHrNXSoTV8Jzorf2QFK+fTWn5Q6U08pLkefJQjYUzJTJ7JWGm9eIJwcz?=
 =?us-ascii?Q?IQoRDGpEpjb4s4Zbi/m162a01E1LoYergOlOW87CdHwmxxgdOMuneW8oOaDG?=
 =?us-ascii?Q?uShee+ywpYd44aoekZ7HGVUf9Qgi2rh7Scqksm01lgTGZN/4rUnYVsciJv7f?=
 =?us-ascii?Q?TmY3b4YVZZmyXFIqkZHl6Y6YMpxpn/GjKsLf+0vRL8XfzOC6EFqDt/XxikWb?=
 =?us-ascii?Q?ztNyh20CNScEHZp59vxlM2+q6i9ac+w4rCI9dc0VO3QyBLxL81GueBeQ+dEc?=
 =?us-ascii?Q?lSNoHpH/7cYuIH/Vyet6EmKOa441zz/zeGa1IFcxI8mGSz8w7DAIXdIb/+zq?=
 =?us-ascii?Q?clYvyl9EW5YQbcIu1fnQHgCjv9U7Wjxh8jP+E9595aE8/mG3l6WhKYBvL68D?=
 =?us-ascii?Q?2J4htFV+jh0+as5k8qFH/P/5pCf1UkrPmcrBQfIayKH+us24NVJZ/yK4Xh4L?=
 =?us-ascii?Q?+cexKqorFZdmJSrDLrABUzsMn4Q4ezVDfI8r97n2XGcx8daAYuYM8D0Qp/G3?=
 =?us-ascii?Q?pZ/3150m4eY4qxDEdW2EdEQgNrq4HZMo3L8Sw2BCqy3k/x4MpvVNFm3JB/K2?=
 =?us-ascii?Q?5VSvap4kngXJK8Jhk6jwaz7XII1TVKVPvZNqT+nwlHEC3HtHoL1wzDKSYY7w?=
 =?us-ascii?Q?DZ0J?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(6049299003)(376014)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(7146999003)(18002099003)(6133799003)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2yH/uvEMAb2hSvTNCynAjwuWTt1tcy5wqjS4kka8QdbfYf7qVIBKSZByXayl?=
 =?us-ascii?Q?grOXymZoS9NMoYVqUwWLFUym/JQKGiPo39G3h09YOjsBaKGFmiZ556MkWyaH?=
 =?us-ascii?Q?cRI1pGf3M+gHCdvMlpprcdV9mcz08nO6N3umqp3A0miMakW3XL+VhPFqdUQz?=
 =?us-ascii?Q?Th5QxhJJ4ruwWcc42qyoPe+WpmTHl5tW1pxv/PjlRiSa/hK7X9fGhl5HteL1?=
 =?us-ascii?Q?MKV8UJBXeE7yxpijxg4KhFhdcJUrYdGm+B0SCVrYoOCIZSGhVXR1Vbbuklbi?=
 =?us-ascii?Q?tpoCPZiY4kGW2gF00s0LN9Vlbhg2xJm31W8jVsAv/WeTXVpi+iUIBdMCD97R?=
 =?us-ascii?Q?GmU8IZ5Z1IdJ8U9nfmAsRUqT+kr+8qi4LZlymF7v26qBMSONFyuxZCkmFy1V?=
 =?us-ascii?Q?trO3jWH8v0RCV095SAWPOZt0v5tb555cIOq1tPByU4+zpbJvT/6D6jWHTdNO?=
 =?us-ascii?Q?6HIpgJ0ymvjKjzmBA76GPDqxax+wj0sesxhYKZhQg3zw6pnk2BqnpCvVUCN1?=
 =?us-ascii?Q?27ai1VlZoUgXUkZHznYOE29xcxaJfwuZaOf0JIM0zqvSiCXejwaSn4mcIz5p?=
 =?us-ascii?Q?1SkqYcKmjEMdEAMxSWbYidJRBYoVBoG9a7nNQpYr9b4QaNWd9Tu5uD6hz1Q3?=
 =?us-ascii?Q?G15L+/5Ai+fTCyydTz59CPbz7ghpir2znEYa5zyaBd0CM2WLQAykvcqoL3Mc?=
 =?us-ascii?Q?rznnAZ8IUYnx3/l8xCUPOH/1bIczlEbPGk/bT3vm7VBHQG+RzZi8BxlG06F4?=
 =?us-ascii?Q?XnzYqHmU25b1EwSa1QZwjlwGT89DoiR/hFpL8VU7hYggZqZx4ol2K0BHQ2pZ?=
 =?us-ascii?Q?BoFyIj64VRYvykXh3drx4J+qbUjXLGcov52rxYgw065xw16WNuMrc8Md4n2B?=
 =?us-ascii?Q?iIhTyLuvb4M5Esfzv0EKOgJJXAEBb0lvHNAAYxlEqPmJV06LZWEE57ixbwgF?=
 =?us-ascii?Q?gwUDoJWwfisI1wHxRbRJ0I6oliLWqeR3eOhItu3JlXlmhrLNuyT5rT/W3m9J?=
 =?us-ascii?Q?1dfRxIazz8mmjiAXMvcocupvmRbQefPGpzM7H4gLWhp4QkrforqXsxKWq1I1?=
 =?us-ascii?Q?1EkTfTFPcJWj7AZ30Bpo1BpbcD6LB7dmK4zqU+nIoopzmrjC7Yq+yYL0dQql?=
 =?us-ascii?Q?G6ZujgmUFa2kzehKSwe5bH9mo+UBLCPdCicio7VAdkY5pCGu91Om2gbrgj9b?=
 =?us-ascii?Q?ek81HCEZ4Zn79zieIf1NFhQcMfezU49JRQa7b6fEKsjktLWX+Gc3fOe1+eP/?=
 =?us-ascii?Q?WKO31AGDWISDVXII/GBNZiSo1+lMqjclU/t0lR8RFk0Z1hlyfnv/6CWZQYru?=
 =?us-ascii?Q?10z0Mq3SGlRoqzNuuKh+HXjVOuPZcGIqYsKWTtVGlHTlibagxb3SCSQBDnE8?=
 =?us-ascii?Q?znqSEnAkQ5VStJ2SzJ3mlTpaIrDN8hnvgMa/iIweOGGNkaZHjLQ3qG8u/kTe?=
 =?us-ascii?Q?GB5Ptk9cccRrPP8BhUQ3mB3pxWhLSkCR0N2NlVRnqNNp3ViMVvfeyRhEMPAm?=
 =?us-ascii?Q?zPUj8NpEaFrUxDFCedeM1qJTjPX+IDtEjVMlnH+1ftqvzm6o4DJ9/88eYlZ7?=
 =?us-ascii?Q?jtJuuJ3XPztwRbxnNn8qr05Po3ZEqj8UaP9SgGThkHExwIyuQvYs5EkE8yUb?=
 =?us-ascii?Q?YVCM3eGajSMDyazg3hNlZTIOTrN41V1ogo/85MT8YTTroh3AQBKRmjsuAouL?=
 =?us-ascii?Q?y0mhXQv6+T0a3KUDoH4SbWGOz0Wi3DibV5eld1PEAM2Mjt4a7DlJ0nuxvDQe?=
 =?us-ascii?Q?3JMVSBwPMg=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_003_PH0PR00MB338699008F36947D666826C5809E2PH0PR00MB3386namp_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR00MB3386.namprd00.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c68f0e-e749-4044-c220-08df28d201cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 02:30:54.8068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVzZ7yNN2wd/miEjAd58Dl2YjUXTq9aRLl0z/JX7YuKksxhkLfsRYmyOKpKjEBKXOpDLoB3HzO8Z0i7q9wLHfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR00MB3763
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GB_MSAUTHSOURCE_NORTHAM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_003_PH0PR00MB338699008F36947D666826C5809E2PH0PR00MB3386namp_
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

--_003_PH0PR00MB338699008F36947D666826C5809E2PH0PR00MB3386namp_
Content-Type: text/plain;
	name="0001-Cygwin-dtable-don-t-load-Winsock-to-classify-an-anon.patch"
Content-Description:
 0001-Cygwin-dtable-don-t-load-Winsock-to-classify-an-anon.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-dtable-don-t-load-Winsock-to-classify-an-anon.patch";
	size=2822; creation-date="Tue, 13 Oct 2026 02:30:54 GMT";
	modification-date="Tue, 13 Oct 2026 02:30:54 GMT"
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

--_003_PH0PR00MB338699008F36947D666826C5809E2PH0PR00MB3386namp_
Content-Type: text/plain;
	name="0002-Cygwin-gethostname-try-GetComputerNameExA-before-Get.patch"
Content-Description:
 0002-Cygwin-gethostname-try-GetComputerNameExA-before-Get.patch
Content-Disposition: attachment;
	filename="0002-Cygwin-gethostname-try-GetComputerNameExA-before-Get.patch";
	size=1933; creation-date="Tue, 13 Oct 2026 02:30:54 GMT";
	modification-date="Tue, 13 Oct 2026 02:30:54 GMT"
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

--_003_PH0PR00MB338699008F36947D666826C5809E2PH0PR00MB3386namp_--
