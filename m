Return-Path: <SRS0=1HtX=5I=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id 8B1213858D39
	for <cygwin-patches@cygwin.com>; Fri, 31 Oct 2025 08:00:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8B1213858D39
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8B1213858D39
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1761897601; cv=pass;
	b=XU62L1giHM0S0thgNgKxk/NRRk24/iH19BM5AeOEQucPNQEhDRpCm/tydAAWBLdsoQ+I03o8XyoAV7ggHlgR0nGKk+Svmo69W4SjCID3fHR0+sJFD2Bkwg7Hkrtdra8sWZnLGHcNhnjdF+RVISJAbl4rZhSQjuSaXg7ZThnO46o=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761897601; c=relaxed/simple;
	bh=oBnvCEvL1cSYccALIi8GuR0uTESTgRbWvxIAyHzxSEI=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=PFLSQ4hNQT6uzRiRhnui7+wKUqFokF4O9nc/Jb3PLEDuRD23B1eThzVp3p4uVtTuvqmrfm6G0IjhOb9sczeK6g71TRq02fL7Kq2Di0IVni/HRMjTwetZUuF2uEiCPGieC9JS7MMeJ7TLmVbHcpSomAIFhxFjPjpEWmdxZW1sk1w=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8B1213858D39
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=ifYXdV+K
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2FCuXx1K1xkjTA/HpxZa7DMpVJ9/8zWgHnI31udIxjZxbhem/cXphy+hzEA1tdifZcaMd8vSHe5rpzIM81dINP7T2wnUBHcn2zRoog+6OJ/GnL+BGWYIc300E12sm/fimbXKJNTaenDPlMlfAXqlgXF7W0TtQQieuk1F6jzfypTfYmD47jXn/0nJTckgPTxDE7vJb0c9fntccS8Mg0jy+UpQl+ERY4o62SbN9MoC+rImbkyGTfJUlweIlASWiZfcXuSXmE+f0zuIFavXyihxwphQC6XTWB0ayMuxcNcwrQZMxom44OD+gq514k1P630Ji96Vfqf1YFy9mrFv/c1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1mRLVsVSK1R/uD1txaqTW6h6KUDc4nohMLcLxErKtQ=;
 b=XEr7xsc2A2k3crYXJRq5Jq/RLDRKcJzKNM9uk6Xi+AhtmrCMqMFnMIDeimj3CZfQqd9ZUtDVShnGGH9jtHWys3fBcDx5C2K0IoRMfzqguOsaNnP25c2DLKqOe2A78kc7gd61xA+U+sN5hGYtFp3kvlnfruERBXjHNrSShYms8vDdcpQDdYJJL7aVxonupHhhcKPu6DOLLDpKuTADIZok770UyouNuUqVU01mNc/E+NZMN6ROz3cUN8JHVMijGyy8Tu7f8Oa0bAN39aXoA+ZTNXKPaxH0Rg6VwmKDeOJaJ3V9cOd3cr8RK8S1HEGnNSyOcPSFBWoHxwKRFtGX8V91Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1mRLVsVSK1R/uD1txaqTW6h6KUDc4nohMLcLxErKtQ=;
 b=ifYXdV+KTYB1M5nyVhB1FGJODwTLQtWnV7RVEwABQFRg9miXA9MunWGmdDLxux9IfsmcD/Gp3SuV09RGpYgRL8b4Nvizryjxq7gKTo7vCWi8pW3r052UdW+k1of2rb+HDSZ70staJqD/4VjAkyTqG7YujjJSdxjn9XQifJhnhz8sYqAvXL/5AyArPz7KxjjELTpyudsEYCjv925rvg32goxZ7da9H9BBaGjOjqK7PfEUy8MJYmNr66lAwSLOtfJbtizBNwngRZonEetWwHZVSfF9euwJYQIBv7oeOMnT08NkqMK/WUxxZQdsyd9S0evd+RZsj1zGBrKCl2G4sEq86g==
Received: from PN3P287MB3077.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:226::14)
 by MAYP287MB3904.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 07:59:56 +0000
Received: from PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
 ([fe80::af9d:8611:4e99:68c5]) by PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
 ([fe80::af9d:8611:4e99:68c5%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 07:59:56 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: "mark@maxrnd.com" <mark@maxrnd.com>
Subject: RE: [PATCH V2] Cygwin: Testsuite: fixes for compatibility with GCC 15
Thread-Topic: [PATCH V2] Cygwin: Testsuite: fixes for compatibility with GCC
 15
Thread-Index: AQHcSjxYfZDB4kLf1Ui3Ht5TTh7gpg==
Date: Fri, 31 Oct 2025 07:59:56 +0000
Message-ID:
 <PN3P287MB307716E6892DFD994EE173249FF8A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB3082B86D9A27A995509C8EAC9FFCA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <MA0P287MB3082B86D9A27A995509C8EAC9FFCA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB3077:EE_|MAYP287MB3904:EE_
x-ms-office365-filtering-correlation-id: 7534b96c-6b69-4517-cca5-08de18537b61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|4053099003|8096899003|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?C2u+5Ld/6f854MydvZQ6f76bBgs7GP4s+goZDC+2DiMuunjPQzjmpTPBu+z0?=
 =?us-ascii?Q?PvioZ+OJqh5dVas1PLv9DjpgZlpuf4V07OuWxQ1sWv13/4rtdkE9lWs+r5ZC?=
 =?us-ascii?Q?yNXdghcoE8SblPlwViPR0tcgaYHmCSpCDGd/WM3wuJV2kohhzcsBOy0mAPMj?=
 =?us-ascii?Q?YHuTPD4bjoXNhI24ZaNmIYXLOLPdbBetrs3Q5x7sEvDtf7vrngUDh/thzZAh?=
 =?us-ascii?Q?W84eTi4ADmXjYYJZGLAJwrxW5yh176LUma2RowkirN6eUacC3kYsqCFiSFT8?=
 =?us-ascii?Q?nC/pudeGKIhzwx+IBuevrylgjJkA8SKe5Kq+1MuB5MIk7SY9IuQdMfaPNRxL?=
 =?us-ascii?Q?11K3bFM21ddvBbh2k4UmuhHvzIH0fOzxb46wM04nK2WJLrQA0iAuVtBbr/Lk?=
 =?us-ascii?Q?M5lZBAJjIj1ptWPt/3gLRFBHDgdtLewjnsBUkJVKYwV1C/asesR8wbXMtDac?=
 =?us-ascii?Q?8aDgaU5BUvtRyPqLhFSmYMBBf6U6EXZSWxR1enuSE5+TjvDDJKNZccZ+k3sS?=
 =?us-ascii?Q?d7T0pjQuhAFz0WcCPGdIBW9chjDefmSml8cR2uPXK8GHu9Lh2cPokvSUYakp?=
 =?us-ascii?Q?0IRKkZ5TOoquOqKRowjDOCv608+FqPnMX+FfWUOXFMJbyeSbWuDGgwEK+Hm7?=
 =?us-ascii?Q?aii4+s4dG3pco1nzdQfPz2oxR+4OVS+tFOdNN+Qqwh2sMGgMaxk6MoUPFXzX?=
 =?us-ascii?Q?RmZP1M+6GEn+aeRaIJZ4jCm0XjCmqPD2/isFWf2L+RdzJ2aIXDbIZnUJR+Wn?=
 =?us-ascii?Q?unOiW1XXwJ+P0OtuhNJJ7tp8aFuDllZw9AzyhN1hcQZu1Yh5SqyBTf2Z7Jqu?=
 =?us-ascii?Q?zKLMB8JtfaRndPxJGWL4rxgSs4otEoPHFAl1QrCsOVrRUdaMQ1AyfAe7NNf0?=
 =?us-ascii?Q?3PWyrHPpNUCBXxYsM/d8ia5voPm09FuhY0yb4FX35Vj6n20iUZsgi2JQHaEQ?=
 =?us-ascii?Q?0XaOtBcWDibtBAyN7mfW9lDDZWAypGWx4xC46BLbKdVCVhqoMxbBYMkm5pE3?=
 =?us-ascii?Q?r28doHD77F5MV4fXjKG0fRmzeQB0orek/rqmSDDpBo0aaKJkU+/h8Je4F8dD?=
 =?us-ascii?Q?QNccL1LNBFB32ux/QZikEhEf532nj1bmhV5Xj5I5/6HmiM175KcYNmQ7b7zo?=
 =?us-ascii?Q?RabCQ+xxn0qea8+QUjdH4RcPUZEBrT5Pryk8iUI7HZ9KGZ2GCse7XDUDZ4UF?=
 =?us-ascii?Q?x6GhCYQK4y5Kxro6K/KKgtny5VZUc4bnfP5eEc87ioHNqKOfhaTo39pf56K4?=
 =?us-ascii?Q?mYgd1a5wNK/LBPaxPQm1MCXSZDi6lv4uyI1i5YFZ3uC2dNn5cGI2MEWH15oo?=
 =?us-ascii?Q?lSax0YcCTXxE1jfk+1VBleFUbRnQYKCrNDd6ujbjLFp8aYfGVRbOeeSViXBc?=
 =?us-ascii?Q?9QD/8uXNmnU9G+a7LYEhTChdz4R/5iL7zM5fkMc50YYn5eUzP7WN+9jYVI7s?=
 =?us-ascii?Q?uUE8Fkf4/u3pdJ0hbiLNEx23TismzTq/ZbTUIqnNzW7j5EkhIdWdVgeIkqUK?=
 =?us-ascii?Q?aogy2mnOsz5doN+2sTkAV8+L89Dyeqor6KiP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB3077.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(4053099003)(8096899003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zjgqHw10XXBGaJ82FTYM3CLcPBYuJ8Be8EV5X4Yn4Z1zeDrTAJ8XN/A5lWEq?=
 =?us-ascii?Q?swwXhq9VZjJ4rYFu2apA5RVsHvZ9v/3rW/Ok/gu5Y8jpQAE86jhQ0i018C2r?=
 =?us-ascii?Q?3jQb8AQ8RHs5vFBocEqRg3vB4ZHUheF3v9rXgZ3i2m019VWF+BFWV93uzTn2?=
 =?us-ascii?Q?HwL1xJ2P4ehcGipE1pk5/enMleiVRIG9xaNz6ydtpsFqH7OIMYVq1C0kFx0l?=
 =?us-ascii?Q?X74+F1Q9FmQBcheQj27N6kr0MDXd7ikD9SAGmK5A978H3z25lH/Qd8wjQD6B?=
 =?us-ascii?Q?vkx0FII/vfosTFbdlxDakfV7ESWRegINr2Gwi5dIi0Ew71CNIzexMnNddD9S?=
 =?us-ascii?Q?qN1stADrecFdbOlvclpUy5AGE2EJvc66gxdKmv2/o4LR8HdVTUkc8bSmthhN?=
 =?us-ascii?Q?qnGxlswmcYwdTTivRe4RMjAj2tFlY4IsBAVZSzrsCnIV6519sIke0JEYvkD5?=
 =?us-ascii?Q?Jheehf8imIj8Ye1qO3Ez3ki1WQAAazhGasGF7wS6HkQBgMNUZPYfhIHDsAvY?=
 =?us-ascii?Q?4/DlZIHW+dLPzfd/HRzap2fzwcQyR0oTRsfpbTjzjcISGNGQ0FVYpF81DX9i?=
 =?us-ascii?Q?b9aRP0XsBSL0LugTCH4n9N/mL1wuBgXGxmby55zu/WarTKmo/b5QfRbNqBBQ?=
 =?us-ascii?Q?XDsxp7lTAfSkWYk1dzEynbIYkJzEFIhUf6MEl4UZ4Szej48hhkA3OqMn2Fk4?=
 =?us-ascii?Q?+wq7uuNzdAwcexyPs+I9jQq1kzP37j1s0BkLB08wB8/0QZUmozyP5LtUo79S?=
 =?us-ascii?Q?r/a9hwzoe8X3t/K0aw1Tg3VYc7sQyT55yabMWXbXQsLh+5uuGXox5vOVcyox?=
 =?us-ascii?Q?56D+9KB00+wfReaFUfo8EvdmbKzxVvWbRPLrNFTBu6lM1qEXP5UX9qJjcg6H?=
 =?us-ascii?Q?oZMJaogsRQkzQjRIl4l1nN6TI2rleqado6kGek0g4+xrb49cqyU8l0najl8A?=
 =?us-ascii?Q?FgyI/8k8gsSdsEqQKAtS6AZb2tclNM3K0IXZ5iSnbyB0iLK9L2E2f8W+k8mO?=
 =?us-ascii?Q?I/GOfdkaysvhTq8INTz4GiCoxfTsTg/Lj1qf3JqXA4Dory6DheGkC7wWu4l6?=
 =?us-ascii?Q?eDw3wVabAjeedvxI7qNTm8QSV5YE+xV8FK5w7+rJwksAxsPdahQ41UvGWzL1?=
 =?us-ascii?Q?lHQdZ8PLBvtalvjVWB8X93ToqSR8yA3E57r6uqSWPrPHVM1OqTfoBmCplNG9?=
 =?us-ascii?Q?G2VGF2bJHVOaOUWoqG0Niu1VYUXO3NNU3P+H3yAWa89PBFMwPajG1YbVL4Vk?=
 =?us-ascii?Q?/He/k4qHkS1wrkMyqL1Jrfccpoobk1c8QFMPplstm5EqbZGwOoneS9ylCnnG?=
 =?us-ascii?Q?TM4Uj8XWj2yp/qEfEy6I2bGjZ57H8q+DkLFuflHBdfndzLRZyPfErAY6nqVg?=
 =?us-ascii?Q?A0KRYs/dw4WzYG3C+lCRv0FL/Fpi6kNXJNgMSbW6fiaJzXDxASt0IqD54Jbk?=
 =?us-ascii?Q?oJ/LfOcJK6rcSTlXQ+0NqtVkPiSYgCOtukm0mrhcU1GWuuLwhPrrYj5JRiht?=
 =?us-ascii?Q?bQ0CU653ZWS+m/dnfQ1cdvddmOPN0BBscG2thNG8y2NOBlH6B3ti9GJW992/?=
 =?us-ascii?Q?mek9zfp0KNt6Kj+iVX6RGosh8s6O9VWSMJ6iBhuOzkWtZEifupK98pHw+beE?=
 =?us-ascii?Q?cumrnYvEktofxVSgkKK4+71TNXW7u7+KW5H7Nnq1dOR7t/HWTJNes0koDaxM?=
 =?us-ascii?Q?OM+i+pjQ1Qtq+hA4TVGCDAU560NbjLr5iS60jflNA9jOMwzv?=
Content-Type: multipart/mixed;
	boundary="_004_PN3P287MB307716E6892DFD994EE173249FF8APN3P287MB3077INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7534b96c-6b69-4517-cca5-08de18537b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 07:59:56.4026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L5Nuxv6cd1ZLGpteuQa9QmyriVCPy/klH8ALAmS4NALQIwtDOSbKOv/fl3Ry9uBg0osKR3hd6sZXbC1GHX4E5M1krpgadD0AAYOgXIf3DfGInIayexXYv1V62iIYcULksJFGO0CCCJP2DtddeZxrQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYP287MB3904
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN3P287MB307716E6892DFD994EE173249FF8APN3P287MB3077INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB307716E6892DFD994EE173249FF8APN3P287MB3077INDP_"

--_000_PN3P287MB307716E6892DFD994EE173249FF8APN3P287MB3077INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the suggestion, Mark (mark@maxrnd.com<mailto:mark@maxrnd.com>).
Thank you for your feedback on the coding conventions. I have incorporated =
your comments and prepared the V2 patch accordingly. Kindly disregard the e=
arlier patch submission.

For ease of review, I have included the patch inline below. Additionally, t=
he patch file generated using git format-patch -1 is attached as file.
Due to internal constraints, we are not currently using git send-email. How=
ever, this submission method has worked successfully for previous patches s=
ent to the mailing list.

Thanks & regards
Thirumalai Nagalingam

=3D=3D=3D=3D=3D
In-line patch:

diff --git a/winsup/testsuite/winsup.api/shmtest.c b/winsup/testsuite/winsu=
p.api/shmtest.c
index e0b7acf7d..fc544c5fb 100644
--- a/winsup/testsuite/winsup.api/shmtest.c
+++ b/winsup/testsuite/winsup.api/shmtest.c
@@ -75,9 +75,7 @@ key_t    shmkey;
size_t  pgsize;
 int
-main(argc, argv)
-              int argc;
-              char *argv[];
+main(int argc, char **argv)
{
               struct sigaction sa;
               struct shmid_ds s_ds;
@@ -178,8 +176,7 @@ main(argc, argv)
}
 void
-sigsys_handler(signo)
-              int signo;
+sigsys_handler(int signo)
{
                tst_brkm (TBROK, cleanup,
@@ -187,8 +184,7 @@ sigsys_handler(signo)
}
 void
-sigchld_handler(signo)
-              int signo;
+sigchld_handler(int signo)
{
               struct shmid_ds s_ds;
               int cstatus;
@@ -235,9 +231,7 @@ cleanup()
}
 void
-print_shmid_ds(sp, mode)
-              struct shmid_ds *sp;
-              mode_t mode;
+print_shmid_ds(struct shmid_ds *sp, mode_t mode)
{
               uid_t uid =3D geteuid();
               gid_t gid =3D getegid();
=3D=3D=3D

--_000_PN3P287MB307716E6892DFD994EE173249FF8APN3P287MB3077INDP_--

--_004_PN3P287MB307716E6892DFD994EE173249FF8APN3P287MB3077INDP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-testsuite-fixes-for-compatibility-with-GCC-15.patch"
Content-Description:
 0001-Cygwin-testsuite-fixes-for-compatibility-with-GCC-15.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-testsuite-fixes-for-compatibility-with-GCC-15.patch";
	size=1554; creation-date="Fri, 31 Oct 2025 07:50:50 GMT";
	modification-date="Fri, 31 Oct 2025 07:59:56 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzMDdjNmE4ZmE4NmUwMzQxMDQwZGFhZjYyZTQyMzEwOTJlYzE3NTUz
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogRnJpLCAzMSBPY3QgMjAyNSAxMjo1MDowMSArMDUz
MApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjogdGVzdHN1aXRlOiBmaXhlcyBm
b3IgY29tcGF0aWJpbGl0eSB3aXRoIEdDQyAxNQoKR0NDIDE1IGRlZmF1bHRz
IHRvIGAtc3RkPWdudTIzYCwgY2F1c2luZyB3YXJuaW5ncyBpbiBgdGVzdHN1
aXRlYApkdWUgdG8gb3V0ZGF0ZWQgQyBmdW5jdGlvbiBkZWNsYXJhdGlvbnMu
IFRoaXMgcGF0Y2ggdGhlCmZ1bmN0aW9uIGRlY2xhcmF0aW9ucyB0byBhbGln
biB3aXRoIG1vZGVybiBzdGFuZGFyZHMuCgpTaWduZWQtb2ZmLWJ5OiBUaGly
dW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0
aWNvcmV3YXJlaW5jLmNvbT4KLS0tCiB3aW5zdXAvdGVzdHN1aXRlL3dpbnN1
cC5hcGkvc2htdGVzdC5jIHwgMTQgKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3dpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9zaG10ZXN0
LmMgYi93aW5zdXAvdGVzdHN1aXRlL3dpbnN1cC5hcGkvc2htdGVzdC5jCmlu
ZGV4IGUwYjdhY2Y3ZC4uZmM1NDRjNWZiIDEwMDY0NAotLS0gYS93aW5zdXAv
dGVzdHN1aXRlL3dpbnN1cC5hcGkvc2htdGVzdC5jCisrKyBiL3dpbnN1cC90
ZXN0c3VpdGUvd2luc3VwLmFwaS9zaG10ZXN0LmMKQEAgLTc1LDkgKzc1LDcg
QEAga2V5X3QJc2hta2V5Owogc2l6ZV90CXBnc2l6ZTsKIAogaW50Ci1tYWlu
KGFyZ2MsIGFyZ3YpCi0JaW50IGFyZ2M7Ci0JY2hhciAqYXJndltdOworbWFp
bihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiB7CiAJc3RydWN0IHNpZ2FjdGlv
biBzYTsKIAlzdHJ1Y3Qgc2htaWRfZHMgc19kczsKQEAgLTE3OCw4ICsxNzYs
NyBAQCBtYWluKGFyZ2MsIGFyZ3YpCiB9CiAKIHZvaWQKLXNpZ3N5c19oYW5k
bGVyKHNpZ25vKQotCWludCBzaWdubzsKK3NpZ3N5c19oYW5kbGVyKGludCBz
aWdubykKIHsKIAogCXRzdF9icmttIChUQlJPSywgY2xlYW51cCwKQEAgLTE4
Nyw4ICsxODQsNyBAQCBzaWdzeXNfaGFuZGxlcihzaWdubykKIH0KIAogdm9p
ZAotc2lnY2hsZF9oYW5kbGVyKHNpZ25vKQotCWludCBzaWdubzsKK3NpZ2No
bGRfaGFuZGxlcihpbnQgc2lnbm8pCiB7CiAJc3RydWN0IHNobWlkX2RzIHNf
ZHM7CiAJaW50IGNzdGF0dXM7CkBAIC0yMzUsOSArMjMxLDcgQEAgY2xlYW51
cCgpCiB9CiAKIHZvaWQKLXByaW50X3NobWlkX2RzKHNwLCBtb2RlKQotCXN0
cnVjdCBzaG1pZF9kcyAqc3A7Ci0JbW9kZV90IG1vZGU7CitwcmludF9zaG1p
ZF9kcyhzdHJ1Y3Qgc2htaWRfZHMgKnNwLCBtb2RlX3QgbW9kZSkKIHsKIAl1
aWRfdCB1aWQgPSBnZXRldWlkKCk7CiAJZ2lkX3QgZ2lkID0gZ2V0ZWdpZCgp
OwotLSAKMi41MC4xLndpbmRvd3MuMQoK

--_004_PN3P287MB307716E6892DFD994EE173249FF8APN3P287MB3077INDP_--
