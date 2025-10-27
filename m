Return-Path: <SRS0=u3bu=5E=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id C648B3858D26
	for <cygwin-patches@cygwin.com>; Mon, 27 Oct 2025 08:23:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C648B3858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C648B3858D26
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1761553418; cv=pass;
	b=iBDtRHHOCYjC60atnk/NzxTEMnCAzxEB3wioVG+XLJe7wQEshALVDpaeVsZdBSIXjEIGifvMmgxKvDvbSfalNWtRdfQBETsUcLkAAOrtN3E0+yVza8pubDZsKJWAtGa+iJR+hMW0S7VqmsHhA8Qn3ezoUCrHeMnxQDq3wrvbri8=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761553418; c=relaxed/simple;
	bh=z+pC7r4ujAbkecoBFcKX0gNeErHh8eq1nf3l8XjiPm4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=BiOWFeUjjbx/UsO5M948mxl9HmSPNzmNn69WgUu0EBk+c0JMoU4HCyaLOrAOHteq/4zqVEKXdJha8deqV4tGO8NPkV2WOCAPktGAFm54N0iXBAyaIHL9OpDttUC31PL4Kznks/z1/zcWzxASqC82JKLrB+xCnVbownTZyG4g6WA=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C648B3858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=Nrskb2za
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feQtzwb9+PWzZVL6xhQHKu/doo03Jmu7MQcFvlmB0UXNT7hECWO3XnR+rgIscM7QxNAO6i/Esc5kbvbQwc7mb/iPUvX/zDXxj5uk5TCxVUvHADdsrFnEXxqnVooBZ7N54p/u5le3qZXF+uQf0qSu0IT4OcDKwwvuuBegwE6+3aOtMv41zJSPzuKswmNyg4wx/83JxnPaF0MyhcfL0vnATUEuIJbqO1xOKbU7JVDKpuCxjqkwm3+TwOBJBTKbi7MWjGnAi2BuCQLy2+aU6sDIzfkpfnsc8go+/QvZPiXP7Yo7QPncdsdomvCoMtRNfRRlB+UopQYeirdrInQPVwP8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae2ThJ1ScO3OXYZtP7LnqsoMdY1AxzsqCKJn4Ap/eUI=;
 b=PcWI/EkLe9rqKImvfv5rFByLw4oyyUSraLJ93fWU+3dsly+mqVVAEr8A9LlOEodVUSGU4xrqA3hCvwWeo/17+jNmbaARsCJCyKwsWsl3k606JeSjx81k6IPx39UBat4/MXuj6CpmEOETefdMdkP4FYZW+xdVFyJFnFp+yd/a0PbWoYUiztW9fs4ocWzmDw/eTo6pp4bGjxSCQ4I89tonONHebadzHCgIiGVMHL7VaVN3Wkmq/zm6RQMAIH/H/TfBu7Mg3RT+lWGpP9FtMagNZGgngk5YIgQVuw7w7dZmbXDZvpm+Y5bsz92TbB+U44S7JvYlJ/G0iPkNg0bLnai59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae2ThJ1ScO3OXYZtP7LnqsoMdY1AxzsqCKJn4Ap/eUI=;
 b=Nrskb2zaEGK13BRm1FQKj/PfWfGJej6u9OUW7VVuQbmpdPieWf5e25yCOZSmuwD3qvv+gt9c4OuBqFwzjMmwFJUM+yXboGbc0HgoL6GmuWTKGguTRmsC4yVLMtcqmB/vRsRsOcgqHkp1lZjG3jRPmNiH4p2MPkyvaPFnekDned4SIP8d4C7zskcOlnLiKSulI7+mq2ra9xLoSBFufCgSw9sqaR4iCLrUfxnFX/vhkDwvMFtLMEvfZIQA0w2z4NhMtduU0SeRlUce8s5zy45hquDbB5vWGv+fwQk4u1LHrMkdOQiFN9YyC/43ekzNOpHW8bGI7mBBHfG6bPAjwHlAKg==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN1P287MB3898.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Mon, 27 Oct
 2025 08:23:33 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 08:23:33 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: Testsuite: fixes for compatibility with GCC 15
Thread-Topic: [PATCH] Cygwin: Testsuite: fixes for compatibility with GCC 15
Thread-Index: AdxHGuOb8vQJdZ4xQ/2R+COfLuP+Sw==
Date: Mon, 27 Oct 2025 08:23:32 +0000
Message-ID:
 <MA0P287MB3082B86D9A27A995509C8EAC9FFCA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN1P287MB3898:EE_
x-ms-office365-filtering-correlation-id: d3749de5-77ca-416a-37b6-08de15321e0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021|8096899003|4053099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5oirlt+BiL9wRqNR6BSjT/0pb+DuUVfjYuEZ5G7DKXoDz2NYCJHn8363AS6G?=
 =?us-ascii?Q?I+hgSCJtJjZKgSqeJJ+qKPdiRVo5xJi/YjLNCollLqQN2PVzkUe9sYWeNOXQ?=
 =?us-ascii?Q?aZhG0FQyii7CDrOD82IDPrT9Tmlpa5djMDllp+sSOf1Z61OPI+pkNWYlhEKg?=
 =?us-ascii?Q?cg1V7oxQdTuiJLv6AY30+qDxZlSM+4LP7TRglGcCUWVIVTbNDwp3XvI7BoJn?=
 =?us-ascii?Q?+UW4iRoV19e4othYdNIrQ8gnSy6GcwqRZGpsBmP9VgessRAUPGlbS0nYmDaB?=
 =?us-ascii?Q?N0+9dqNdMRkP1uo0VhVF/mjj7z4haQP0C3skGpd3403Du/rTWjLygOr8h4es?=
 =?us-ascii?Q?JwLvDTXaT5qMmcnBUbZcMXU7AOXOmaysFuVy6e0l2MLW0v+75CLfkYcqgJ7B?=
 =?us-ascii?Q?w92hm+3YTur14G7dnW4fnY05ckLAS2WH3SWFizWP0JBUMSQHu0Hf+EgLHMYR?=
 =?us-ascii?Q?pKguY9mrtf17WBygBtMYDXhhVURJV80pAkePpJUQDO/RmZ0AEBiYlUL0Q6wM?=
 =?us-ascii?Q?pxu+x+Z6jY5+ko7gZ6kOsuLbESoMeNgERQ29FKRHzIO8ZhYahtVIlm+hXn2p?=
 =?us-ascii?Q?7WPDygOYmFSBe2IfciaRGhEHKjiAC4LumWtiRwuNREHaH8SRJLPcPJ1yRsUk?=
 =?us-ascii?Q?04s26N62hO/ZP7dbwqterfdnwECKz5VmIWIU2YfZ59K3D9cNxFg1gfcv7wuf?=
 =?us-ascii?Q?hamWXwr8HV/D8difGb+KvATcSqvDkXyrybsrXKnKlM+8tPLe1l5jvz5KjjOS?=
 =?us-ascii?Q?jvjMqaDLBhz3Pw9Bkn59tMa3JEyl+vyJhaO43qWag8s5Tf3t4zRnVyWA1fd2?=
 =?us-ascii?Q?1Rd93hiBle5PidreRXJnpGnwwEuHvXl/lFYf1B8ZnmegYY1KVXxHz5tO5DMf?=
 =?us-ascii?Q?t6Y1UJNMEQXanBEN3byRqSzZSNvOF4RrMF/of5ZwbmK76kLl6AuKi5coxhO7?=
 =?us-ascii?Q?RxuCYWOz/EEx9DOZGV/YFc1WZJ8EeF9t7oZhhVwZIR1p95Eilv1zIODzH/zu?=
 =?us-ascii?Q?OskZJ3608VXbcpSHValYGz+PmGdmrk/KxnJoeMuPr71wzuUSqbmZWoyNRvBX?=
 =?us-ascii?Q?gBRwGV5/mfHTq+I0x2TrwFwb2ujuvJUelf/6Z13iXUfnM+TTxXp9cX2Y41jB?=
 =?us-ascii?Q?oWxX5yq97JjDShrcD7z2U9RqGaxCr4jwE3AAZR4DN3g7q3/s0Bbt9v5RfiVC?=
 =?us-ascii?Q?wH8Vp/DUEupfE04wWIS8f+6fblrGXIcvM1ocC4bFVzMF6xxX3IVr3k+jrvLZ?=
 =?us-ascii?Q?zs7zo6jK5ajinRadB+QyWDBS00smCAqpsTsp3vcHrGH3kXwUkiHTCKoqkC5c?=
 =?us-ascii?Q?jqo6AU1meGt7cPYGclr0l8TSZ84QSoio/InUkmm2Hc369LDM29QlCTJ+lcZj?=
 =?us-ascii?Q?10dIiPnE9GQPuo7sQzLQgNX2PWlHl4bmlTffdAOm+S/zwyM/XU5lVxHdr7s2?=
 =?us-ascii?Q?5gqtJb+xJLBzLRz9C40BxolAbvAZlePKYa/7ue1TqKOgLfNFyepkPMx3rX5n?=
 =?us-ascii?Q?XZ5KbGetmIX04YmXK4c2yzDHj7VG5JSYS1pT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021)(8096899003)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6VlHs8IAvrPVZRChLBARa+6OkI1bD0/0KEEmoO8q7Pk5A1Ge/hZQnG4OmWFn?=
 =?us-ascii?Q?4CmE5czeP0Y1HOx7IPL9hOfW9ul50uA9BTh9XHAx4cNgACOiZos+/AwNw/15?=
 =?us-ascii?Q?rNj8yWeF2YLQSYID5d1FwqLTlt1Toz2z4XQPtgpbIH2qEfSVCnOKD61QL5s6?=
 =?us-ascii?Q?h679AKfwuagF3FmVq4lN2l4E/pGxhxMc2k7cWP9TzqUCPisjepTd3i2LQvgu?=
 =?us-ascii?Q?ttEfZ6djrnksNA3ZPndzBBd3NJ2GQhRZCNjUJ/jbMVo26ouDVYdTWn6khFzU?=
 =?us-ascii?Q?VVFWAGnzVtdGSzzq206kwKiq36yAcJOmUBj09PUYciXir0TuNZ8+l2eTtdjB?=
 =?us-ascii?Q?Ibv/WV7R8B6NoWekSTvofOiKJ8lKuXpiapUTq+wWw/DeEYT9S1UVkhnalnAT?=
 =?us-ascii?Q?PiT0vfnsxKDseZO+jALe9rGZ4pRB4XbfIwr0EaK0+yuErVCIv+uenul7j6ms?=
 =?us-ascii?Q?BBBozW1GPlfjkIpt/BYvm8OiqmyUg+FneUipmMQIT5MpYCBKEXXeHWYuVwOL?=
 =?us-ascii?Q?A0rv4k/+OWGvAyY4CkmpdKixLR156Hi3Z7GvaGdqKeq3C4FjHKgGTDeoSy6y?=
 =?us-ascii?Q?/2GpGGmGi6TCFhJcSkyFiIJ3X+cA+CgOPwRYQAY8T/Syj0ATkdxeJ2CqgTz/?=
 =?us-ascii?Q?cirinao1/z1x3LCOORq8UGMF1D0sZvX11zEXRdq6vz9L8xNPcPpdl+VLhuG+?=
 =?us-ascii?Q?GC7pPmngr1pQExAG2Jb43qNMkNTdgSn8cgjDofxHhVoUwVEdPVPCkqIJjWBk?=
 =?us-ascii?Q?21cU7Dyujp5wMlcuZtOXm/K9AVmZCKMvNmuOqtY0iwSsx7DNyN0e5QFeqOag?=
 =?us-ascii?Q?1zCZWtYEea7fAeco/dg8liHEG8ET7o65+azSoynsIeW6o3zG2lpImKrwq7F+?=
 =?us-ascii?Q?rE7gyg8UgUpFYpUHOWXbsQ76C0sOxS669TAVvny9wQ2ZgcqOiEt3ie4GFr+m?=
 =?us-ascii?Q?FSmn1Q2DWKNs4FRwZHg8+QBXnaGr4UZHFVRnG0aTo6HzKPt7l7pMQ5ehKXq1?=
 =?us-ascii?Q?emkxeIu8isxCY/iSDgyNJeyByuA2JFevmtqnUYPg5ymtOYaKF1lVj7hbdw3T?=
 =?us-ascii?Q?66irAOuPdLojP7alYUjgZpgWOgolByrRgOwQQSQf0WG2pzxJt7VtMcKi6B4x?=
 =?us-ascii?Q?4AwdzsuqCDayDRG3W51F7upp+fuO0VUwoUbi6nHp4fgt4vwqww8gJi0+ZDEz?=
 =?us-ascii?Q?uUUqIOPkVQ9v9UcLriBfQ/F8SU2hSfAqdG0zMcXL2GqgelfQ1CbNvDYNF3Zl?=
 =?us-ascii?Q?2yOLASJvG2YcPlHT8XzANQxgmB6WM3l5qumMfRpGZI/4ghWKtuMYx+Aj23OS?=
 =?us-ascii?Q?Sh5DFsnkUVQgl/Mv7qM/3JW6q4D8GMlflFHgkNvIgqnUgIdx9ogp4xmGqByf?=
 =?us-ascii?Q?rwBRlcGDLIln3zmUi3sOtMQxt7YixHrn1Te1L22EER+DZbDUwd/ZiUrq2+5A?=
 =?us-ascii?Q?MMbFBrJ6OMb4FfJr9cS3Uuwb89R4Ptjaso55LvAPuC9zXxsnt4qAVWXRL19F?=
 =?us-ascii?Q?kwaLQT6HYh9F7gmZRVCeo6HJYf+lT40/JSuBIptSK3fCnAarCuErS1sL3RTC?=
 =?us-ascii?Q?SVOWJJHh31r79JOA1/ZqldZnxmdMfZzABtPTDUXIG9mUwwg5BDUhHTOghELY?=
 =?us-ascii?Q?/TSMmCyFwX6Q7iyH4ei02UKvKnKyAfcjQH8dhE3KRsO/EWp+Vl8nh6JOAWja?=
 =?us-ascii?Q?txjGvg3jpiMRqpCMd5ebbmNxFRDBTxtbEeukeSwqnDXuLg4w?=
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB3082B86D9A27A995509C8EAC9FFCAMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d3749de5-77ca-416a-37b6-08de15321e0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 08:23:32.9437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AiQ9S0CwjLLPUcCN6cCPqyLVXGqzLMhDRhR72YcKcsESSgdLLcqsCAjX2Lye+BlVwgQ832xcote/KyRKBrH5gAzhcTfEKY1yB1YyxQozXnrANDCRU+pQXAGJ59qQJaySASF6a1csrgEPXSEneOf3CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3898
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB3082B86D9A27A995509C8EAC9FFCAMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB3082B86D9A27A995509C8EAC9FFCAMA0P287MB3082INDP_"

--_000_MA0P287MB3082B86D9A27A995509C8EAC9FFCAMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

Please find the below attached patch for review.

  *   This patch fixes function declarations in shmtest.c by converting def=
initions to

standard ANSI C prototypes to ensure compatibility with GCC 15.

Thanks & regards
Thirumalai Nagalingam

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
In-lined patch:

diff --git a/winsup/testsuite/winsup.api/shmtest.c b/winsup/testsuite/winsu=
p.api/shmtest.c
index e0b7acf7d..2c6c74e7a 100644
--- a/winsup/testsuite/winsup.api/shmtest.c
+++ b/winsup/testsuite/winsup.api/shmtest.c
@@ -74,10 +74,7 @@ key_t    shmkey;

 size_t pgsize;

-int
-main(argc, argv)
-   int argc;
-   char *argv[];
+int main(int argc, char **argv)
 {
    struct sigaction sa;
    struct shmid_ds s_ds;
@@ -177,18 +174,14 @@ main(argc, argv)
    exit (1);
 }

-void
-sigsys_handler(signo)
-   int signo;
+void sigsys_handler(int signo)
 {

    tst_brkm (TBROK, cleanup,
        "System V Shared Memory support is not present in the kernel");
 }

-void
-sigchld_handler(signo)
-   int signo;
+void sigchld_handler(int signo)
 {
    struct shmid_ds s_ds;
    int cstatus;
@@ -234,10 +227,7 @@ cleanup()
    tst_exit ();
 }

-void
-print_shmid_ds(sp, mode)
-   struct shmid_ds *sp;
-   mode_t mode;
+void print_shmid_ds(struct shmid_ds *sp, mode_t mode)
 {
    uid_t uid =3D geteuid();
    gid_t gid =3D getegid();
--
2.50.1.windows.1

Thanks & regards
Thirumalai N

--_000_MA0P287MB3082B86D9A27A995509C8EAC9FFCAMA0P287MB3082INDP_--

--_004_MA0P287MB3082B86D9A27A995509C8EAC9FFCAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-testsuite-fixes-for-compatibility-with-GCC-15.patch"
Content-Description:
 0001-Cygwin-testsuite-fixes-for-compatibility-with-GCC-15.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-testsuite-fixes-for-compatibility-with-GCC-15.patch";
	size=1639; creation-date="Tue, 21 Oct 2025 18:40:02 GMT";
	modification-date="Mon, 27 Oct 2025 08:23:32 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5Y2QzMjEyNmJkOGYxYTljODg3MGU3YjQyMzE0YWRjMDNkNTgxMzA4
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogVHVlLCAyMSBPY3QgMjAyNSAxOTo1NDoyNSArMDUz
MApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBDeWd3aW46IHRlc3RzdWl0ZTogZml4
ZXMgZm9yIGNvbXBhdGliaWxpdHkgd2l0aCBHQ0MgMTUKCkdDQyAxNSBkZWZh
dWx0cyB0byBgLXN0ZD1nbnUyM2AsIGNhdXNpbmcgd2FybmluZ3MgaW4gYHRl
c3RzdWl0ZWAKZHVlIHRvIG91dGRhdGVkIEMgZnVuY3Rpb24gZGVjbGFyYXRp
b25zLiBUaGlzIHBhdGNoIHRoZQpmdW5jdGlvbiBkZWNsYXJhdGlvbnMgdG8g
YWxpZ24gd2l0aCBtb2Rlcm4gc3RhbmRhcmRzLgoKU2lnbmVkLW9mZi1ieTog
VGhpcnVtYWxhaSBOYWdhbGluZ2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1A
bXVsdGljb3Jld2FyZWluYy5jb20+Ci0tLQogd2luc3VwL3Rlc3RzdWl0ZS93
aW5zdXAuYXBpL3NobXRlc3QuYyB8IDE4ICsrKystLS0tLS0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL3Rlc3RzdWl0ZS93aW5zdXAuYXBp
L3NobXRlc3QuYyBiL3dpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9zaG10
ZXN0LmMKaW5kZXggZTBiN2FjZjdkLi4yYzZjNzRlN2EgMTAwNjQ0Ci0tLSBh
L3dpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9zaG10ZXN0LmMKKysrIGIv
d2luc3VwL3Rlc3RzdWl0ZS93aW5zdXAuYXBpL3NobXRlc3QuYwpAQCAtNzQs
MTAgKzc0LDcgQEAga2V5X3QJc2hta2V5OwogCiBzaXplX3QJcGdzaXplOwog
Ci1pbnQKLW1haW4oYXJnYywgYXJndikKLQlpbnQgYXJnYzsKLQljaGFyICph
cmd2W107CitpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiB7CiAJ
c3RydWN0IHNpZ2FjdGlvbiBzYTsKIAlzdHJ1Y3Qgc2htaWRfZHMgc19kczsK
QEAgLTE3NywxOCArMTc0LDE0IEBAIG1haW4oYXJnYywgYXJndikKIAlleGl0
ICgxKTsKIH0KIAotdm9pZAotc2lnc3lzX2hhbmRsZXIoc2lnbm8pCi0JaW50
IHNpZ25vOwordm9pZCBzaWdzeXNfaGFuZGxlcihpbnQgc2lnbm8pCiB7CiAK
IAl0c3RfYnJrbSAoVEJST0ssIGNsZWFudXAsCiAJCSJTeXN0ZW0gViBTaGFy
ZWQgTWVtb3J5IHN1cHBvcnQgaXMgbm90IHByZXNlbnQgaW4gdGhlIGtlcm5l
bCIpOwogfQogCi12b2lkCi1zaWdjaGxkX2hhbmRsZXIoc2lnbm8pCi0JaW50
IHNpZ25vOwordm9pZCBzaWdjaGxkX2hhbmRsZXIoaW50IHNpZ25vKQogewog
CXN0cnVjdCBzaG1pZF9kcyBzX2RzOwogCWludCBjc3RhdHVzOwpAQCAtMjM0
LDEwICsyMjcsNyBAQCBjbGVhbnVwKCkKIAl0c3RfZXhpdCAoKTsKIH0KIAot
dm9pZAotcHJpbnRfc2htaWRfZHMoc3AsIG1vZGUpCi0Jc3RydWN0IHNobWlk
X2RzICpzcDsKLQltb2RlX3QgbW9kZTsKK3ZvaWQgcHJpbnRfc2htaWRfZHMo
c3RydWN0IHNobWlkX2RzICpzcCwgbW9kZV90IG1vZGUpCiB7CiAJdWlkX3Qg
dWlkID0gZ2V0ZXVpZCgpOwogCWdpZF90IGdpZCA9IGdldGVnaWQoKTsKLS0g
CjIuNTAuMS53aW5kb3dzLjEKCg==

--_004_MA0P287MB3082B86D9A27A995509C8EAC9FFCAMA0P287MB3082INDP_--
