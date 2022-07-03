Return-Path: <kbrown@cornell.edu>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2109.outbound.protection.outlook.com [40.107.220.109])
 by sourceware.org (Postfix) with ESMTPS id 4A6F6385740F
 for <cygwin-patches@cygwin.com>; Sun,  3 Jul 2022 18:37:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4A6F6385740F
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTt0clnZOtndRcBprSEJOfKTr5A+pbihSc2O/roUhIhGBROWJPbeuLzfS3CIMTdmxnbdRMdfbRKreb6kP7jVxlEom3L0cgStCAjJe8YRtIJ8p07Qm2y1Nx/4ZCXVjXSepvsY1YWi421vCQr6Yy6Ki6nHdRC+z2c5Mm3oYFDEfMddLIvgvgjhSCKkC1Sf1N9MMEH+93KwThIRrMVSMWysTbusI++ZfK35ZLA7d7GezP2jlv/B+9wDmMCucaZ85lwmL29YlEIEyHgZdxt+7i0BHVVj/4/aTgd3vaGFhAPNvuDZ6l0HnGyIfeaEvIrChHzjtnJXq0l1nbyPhY0v4e6/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIHNsE4n7zxSSdX8uAVr+xzsohMUvNQ0EiU189Agams=;
 b=MMaZAJWeVdikwsP5WDC23VFtNFMGBvu4fHSq2V1T5T5A33FvY8+M3rCIUfADVQ7gdUbOjNMCGD22AqqEcrWf55RDfOMYnstLrVHaYyhJ4wNsburgwNH/y0k2q59/GB27VJFbr97ib6whhZvo8z8T47SXONIxgLJjxnq32qsgeO73mdfy4s+7+Q4YEri98zLOZa8BYhS1WPILc5e+8NvR8WzRrG5p8r1QMLZ/uIAZSURi31kO3GKxZlgv3oKE56h3TGM39i23xMXFIn828N2WQL4qjNoFdOYInXjx1HmQbpgEerTrMP0qKBJ7xDcTurOEE3YMYvdP29t3LzYC16/Otg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIHNsE4n7zxSSdX8uAVr+xzsohMUvNQ0EiU189Agams=;
 b=gzkxgxeWaeJSDVScrVJCvKnTRwbkLpYPE91WlJcMfdQV2AN5q9q+az+zBgQTtqncvL4J6YMIMo37YOb3iWZje4mrVPU6mx8ufEbqFig5o5Cdbwu7hc7TIYczIGPDGpnWHq4Cdih8Yo0+GS3gTiV6e8dT77mQXfF6C/bXHhwYEPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6017.namprd04.prod.outlook.com (2603:10b6:408:53::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Sun, 3 Jul
 2022 18:37:24 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d%2]) with mapi id 15.20.5395.020; Sun, 3 Jul 2022
 18:37:24 +0000
Content-Type: multipart/mixed; boundary="------------KT9h92IcBsig05SuKbtYqnDs"
Message-ID: <c16697ba-b02f-ffd1-7422-fa22443e7895@cornell.edu>
Date: Sun, 3 Jul 2022 14:37:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH] Cygwin: implement getfacl(1) for socket files
X-ClientProxiedBy: BL0PR02CA0123.namprd02.prod.outlook.com
 (2603:10b6:208:35::28) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2243b1a2-1b76-40af-97f3-08da5d231248
X-MS-TrafficTypeDiagnostic: BN8PR04MB6017:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11V8LTeZGW5jl5wVcwaibD2sIq0iDY2iIzbq3aP++D0I+lrol5i/bQo9PvJ7vNah5+uoAnsatWDz55k0LhDtYmvm0pR8Qp/Jo3yPkxcG8u/6QE/ph8WYDtyZwgVniM3dQMNDILrDVwDX3giuDKivj8H2fUrYpUfhyJ+zS4zm+j2KoG0wjITqCagEUUMulNDI+URrqw637Y/twVloyxnhpi/5nYOIQxWqBrZBUt/0vdC5Iu/FQ0mkPzsVM/sqjD2jYwM52c/lDZytvV8DeKqtJTF084db0YnmwruLtmfDxzdlCAySrNrZInGyO/9XhTWU+k/0DoizCm8Bcujjkuk1rlJklgue0BYQs7cXX8C21iT1Rkj45NSqdL4n9Va1NndxkLpUF/DOyECZDG+/mTwUEJ1GFRuKmsOPu/BZHEMdmeViQg06wBKbHi2gkQPG5qzEnvVzQoDB60zWpItbA6rVCrDQQ1QDEW5nPUvXFJxNx570zNDCwjeFi7yPuSYRugygHXWo0kmd99CWMyyC2I/i4Sj1BiQJiOcgyO/E4CubBPbpeF2IA4AdZW4Ux+VxIFr7dcHbASdPiROqiJEHf4x5+coydptPLYbPo72dyyzdN119dFT2k46B3niJir1HCS6UrBFHdjwQ9js5+cKowL3pgKRTDm2KcuU5NbmMO8AYGO62auEaaVuVy+2Ltg4vpx3q74sxpj5IeMlNcp0z5o66uqNxtYbICuihBtNIQs2TCntYwwuOoU5iiEWX3QF0Af2ieuPphAB9jK1D96MeX5RbRgtysZVeUAK1Rm4POX66Wal1lLNcYWGtn977gLQDfO5qTnMVSMWgytX+pQiYbK7yxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(6916009)(235185007)(33964004)(316002)(786003)(6512007)(6666004)(31696002)(41320700001)(86362001)(8936002)(6486002)(478600001)(66946007)(6506007)(8676002)(66476007)(66556008)(564344004)(75432002)(186003)(36756003)(19618925003)(2906002)(38100700002)(2616005)(31686004)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzE2dVpoSVVpMWJhbFZWYTFHM3dGem5ZOURCVERvdlQ1cHBEdGNIeGFnNVll?=
 =?utf-8?B?anE3RE02U1ZyeG1UdlZGNjBDOG12YzM2V0lPZmhjUHA2OVoxTUUwY3lPYU9t?=
 =?utf-8?B?THFYejNHcGl4QlQwTGUyTzRXNitqZ2pKbGxjbldTaSsrUGxIOXhsdStiWEFu?=
 =?utf-8?B?UlRhL3BUaU1CRXgxOWZ1S0tRbVViT1N6S2M3NDhmekJFRml6RThnUlB3cjNO?=
 =?utf-8?B?QjI2RWVpMnpPZE8yK3dTaXUrQ2ZIeVlDWFlVRGNWeG8rMFNVNEl5TW9yd3BJ?=
 =?utf-8?B?NmFDR3pvMFEwbm9LbVlhQUxrZWNqeDFLb1J3VUczYWlKSytzTWFRRmxPN1cw?=
 =?utf-8?B?ajc0TTdBVXRWM3pMRVFvdG1IdmxOb0NvVlAweTJiOWM4SUNKTVlJcXJPRDdl?=
 =?utf-8?B?QllmMU1pdXdqVmRSRHlBOG1zY1F6d0liR2xZYTdqcEFOZ2JSckVGN2xmQ0VG?=
 =?utf-8?B?b2tac2I2OWtQOFFCWlJveTJnaktEZWhjKzF0TithOWdvSmV6RDA1ZlVMVG8y?=
 =?utf-8?B?WlExWmdQMjR1aTd3dy84L0Z5aVd4NnhHcSt5M3hoeXhyeS9iYjRGSFY2ckJJ?=
 =?utf-8?B?UzdkcEdZbE5sUXN0UG5lOENnMTcyWkNncWdjZHNWbFpvZlBSUEd0ZjR5UStH?=
 =?utf-8?B?NHBoa2J6VFp2MVRMZE5YUzJLcmdaQ2ROOTdzSkZCTXExT0lJUlF0K294UXp5?=
 =?utf-8?B?bmlRRGtOMHhqN0Nhb3lwaENwM3FhMVFkYzZPbmwycHdMNGdPTDlGb2JJaWsy?=
 =?utf-8?B?SlhTbm9hZCs0V21iRm00eVRjVXBXM2hORiswbjRUVTVDVWZSSXdScHJtVXRK?=
 =?utf-8?B?MnhnYzg3dUFlbDlUcGk1aStBWGdYcGpUZ1VRcnpuaHJOTjZKOWNjWDNrSHZq?=
 =?utf-8?B?SXFHRVg4S0l5SnNKMzBLTCtHc2FzVllaZzlWVTVCQ1BtN2dPVzhRNXZoS1FP?=
 =?utf-8?B?eXNjb053a3lMM0lpekM3RklWb2g2RFdoay9veFoxa08zTGgrbEN6d1hCaU5M?=
 =?utf-8?B?S3ZZK3czZkV2bCtvZ0xJZUVzTVN4VVJ2TlY3WE1NM01YS1ZPK3Vqa29tZmty?=
 =?utf-8?B?eENhemFjMGRYMWVBY1VjQythblVFY3VIL2VQNEFaTlFBeUtaOWVvVHBZN2lB?=
 =?utf-8?B?NUVRMkgyTnMvWjlQbkc4S2JNRHRQWGt1ZzVuZks5OW1wZGVyakc0eG5LV2FU?=
 =?utf-8?B?N2d6eXhOZG9hR1hBaVJieU1xT1NlUkdwNWNNSE4vQ1dDQ2daWldxVE9hazc2?=
 =?utf-8?B?alZTMlptRXJuNkw2SG1yTjlvZ2RsNUJYMXBxM3Zwamw4Z3o5aHJ1RHFxLzRQ?=
 =?utf-8?B?eEJaUmxTanc5UG1WSmljM3lxalRSZ2dGckNxSU5BUTdNT3phdXRtVTRiZkJz?=
 =?utf-8?B?cXY3V3ZieTk5T3RscTlWTGdwaEZTVlhndjVQWHFsZDVaczNmbnl5RndKWGxE?=
 =?utf-8?B?SnBqaEZGUVo2WUhxeVNXMFJPcXVHd0xvWCs3a1RQVEdHVkNDbTJBL0lhdXhl?=
 =?utf-8?B?Zm9SN0Jra3dwTlJjN0NvK0ZoK3dOSEV3cGJGaDQzcmVLbk1zN0hWS2wzSEtU?=
 =?utf-8?B?UHVTSkVmYVZYeE1QTXlMbjZEeTMrNkZMckU1N1EzT0x1Z2Q3NzdpODdHUGh0?=
 =?utf-8?B?NnVWb2swRm1YeXVOV01wYzFRMU5zVmVJZ1FoczlUZjV3UllITlhhT1BCMmZB?=
 =?utf-8?B?eVVjckZhc0FlcDFBL2Z3blNySVBZNHBJMEdVTHJ4L2doVXQ3aHIvVTJ5T3hJ?=
 =?utf-8?B?SmlGRUhCcm5jYTIvK1Z2WVdPUFN2MGl4Z015Z3V4VjZZQXdtL08zbzV0Vm5t?=
 =?utf-8?B?TkJGdm8xUDNVcVhiMUlWZjlxYzJOOUpxTzBnRWdKbEQxczlEd3dYR3RnMmhX?=
 =?utf-8?B?TUQzTGsrNlJjakF4ZUlQMFpwUzRlR3A3RTUvTktRSlJlcWpmTHJGV3dSWndB?=
 =?utf-8?B?WlVCYmI4bTRPeFE5bElXTjhiQktxSWZvOHo1QlVKbkU3cjMzZVE1eUZpYjdL?=
 =?utf-8?B?ei9MSmp1V0xOaUZJS2MzaXk5bTM2VHVlTEN6VFdWSXpVYTh0OER2VlE5K2VL?=
 =?utf-8?B?aVBpMnVhYXZzMElPMUZwZS9QOFJqRHRTUUt3TG01R0d2SDBXNTZCVXpWT2RH?=
 =?utf-8?B?QlExdmlrdmhxWnArU3BmZTdNMlRDZnYxclU4VExsTU4zUTVWUjFpNmhzcCtv?=
 =?utf-8?Q?lNxvbsU/uZVx224JqtIJ0rJr8t5lQKWJdPCnpzsGl+Sq?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2243b1a2-1b76-40af-97f3-08da5d231248
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 18:37:23.9738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XL8CK//+9VOEatLQGA8lop/w05/fYUtMH2FkIRAPbNNi+RzwneVZ3buCs/TOUBkab9zsV82VmSMUEi+tA8bvqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6017
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Sun, 03 Jul 2022 18:37:29 -0000

--------------KT9h92IcBsig05SuKbtYqnDs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.
--------------KT9h92IcBsig05SuKbtYqnDs
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-implement-getfacl-1-for-socket-files.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-implement-getfacl-1-for-socket-files.patch"
Content-Transfer-Encoding: base64

RnJvbSAyOGNkMjlkOTlmZTZkMWE1NGM4ZGFkMDQ4NTRiZGExMDc0MzczN2QzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
U2F0LCAyIEp1bCAyMDIyIDE1OjEyOjQwIC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBp
bXBsZW1lbnQgZ2V0ZmFjbCgxKSBmb3Igc29ja2V0IGZpbGVzCgpEbyB0aGlzIGJ5IGRlZmluaW5n
IHRoZSBhY2xfZ2V0IG1ldGhvZCBmb3IgdGhlIGZoYW5kbGVyX3NvY2tldF9sb2NhbAphbmQgZmhh
bmRsZXJfc29ja2V0X3VuaXggY2xhc3Nlcy4gIEFsc28gZGVmaW5lIGFjbF9zZXQgZm9yIHRoZXNl
CmNsYXNzZXMuCgpQYXJ0aWFsbHkgYWRkcmVzc2VzOiBodHRwczovL2N5Z3dpbi5jb20vcGlwZXJt
YWlsL2N5Z3dpbi8yMDIyLUp1bHkvMjUxNzY4Lmh0bWwKLS0tCiB3aW5zdXAvY3lnd2luL2ZoYW5k
bGVyLmggICAgICB8ICA0ICsrCiB3aW5zdXAvY3lnd2luL3JlbGVhc2UvMy4zLjYgICB8ICAzICsr
CiB3aW5zdXAvY3lnd2luL3NlY19wb3NpeGFjbC5jYyB8IDc2ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDgzIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyLmggYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVy
LmgKaW5kZXggZDVlYzU2YTZkLi5jYjVlMDhmYTMgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4v
ZmhhbmRsZXIuaAorKysgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyLmgKQEAgLTg2MSw2ICs4NjEs
OCBAQCBjbGFzcyBmaGFuZGxlcl9zb2NrZXRfbG9jYWw6IHB1YmxpYyBmaGFuZGxlcl9zb2NrZXRf
d3NvY2sKICAgaW50IGZjaG1vZCAobW9kZV90IG5ld21vZGUpOwogICBpbnQgZmNob3duICh1aWRf
dCBuZXd1aWQsIGdpZF90IG5ld2dpZCk7CiAgIGludCBmYWNsIChpbnQsIGludCwgc3RydWN0IGFj
bCAqKTsKKyAgc3RydWN0IF9fYWNsX3QgKmFjbF9nZXQgKHVpbnQzMl90KTsKKyAgaW50IGFjbF9z
ZXQgKHN0cnVjdCBfX2FjbF90ICosIHVpbnQzMl90KTsKICAgaW50IGxpbmsgKGNvbnN0IGNoYXIg
Kik7CiAKICAgLyogZnJvbSBoZXJlIG9uOiBDTE9OSU5HICovCkBAIC0xMTQzLDYgKzExNDUsOCBA
QCBjbGFzcyBmaGFuZGxlcl9zb2NrZXRfdW5peCA6IHB1YmxpYyBmaGFuZGxlcl9zb2NrZXQKICAg
aW50IGZjaG1vZCAobW9kZV90IG5ld21vZGUpOwogICBpbnQgZmNob3duICh1aWRfdCBuZXd1aWQs
IGdpZF90IG5ld2dpZCk7CiAgIGludCBmYWNsIChpbnQsIGludCwgc3RydWN0IGFjbCAqKTsKKyAg
c3RydWN0IF9fYWNsX3QgKmFjbF9nZXQgKHVpbnQzMl90KTsKKyAgaW50IGFjbF9zZXQgKHN0cnVj
dCBfX2FjbF90ICosIHVpbnQzMl90KTsKICAgaW50IGxpbmsgKGNvbnN0IGNoYXIgKik7CiAKICAg
Lyogc2VsZWN0LmNjICovCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy4zLjYg
Yi93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy4zLjYKaW5kZXggNDRhN2JjZjlkLi5iMTg2OTE0Mjgg
MTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjMuNgorKysgYi93aW5zdXAvY3ln
d2luL3JlbGVhc2UvMy4zLjYKQEAgLTI2LDMgKzI2LDYgQEAgQnVnIEZpeGVzCiAtIEZpeCBhIGNv
bnNvbGUgcHJvYmxlbSB0aGF0IHRoZSB0ZXh0IGxvbmdlciB0aGFuIDEwMjQgYnl0ZXMgY2Fubm90
CiAgIGJlIHBhc3RlZCBjb3JyZWN0bHkuCiAgIEFkZHJlc3NlczogaHR0cHM6Ly9jeWd3aW4uY29t
L3BpcGVybWFpbC9jeWd3aW4vMjAyMi1KdW5lLzI1MTc2NC5odG1sCisKKy0gRG9uJ3QgZXJyb3Ig
b3V0IGlmIGdldGZhY2woMSkgaXMgY2FsbGVkIG9uIGEgc29ja2V0IGZpbGUuCisgIFBhcnRpYWxs
eSBhZGRyZXNzZXM6IGh0dHBzOi8vY3lnd2luLmNvbS9waXBlcm1haWwvY3lnd2luLzIwMjItSnVs
eS8yNTE3NjguaHRtbApkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zZWNfcG9zaXhhY2wuY2Mg
Yi93aW5zdXAvY3lnd2luL3NlY19wb3NpeGFjbC5jYwppbmRleCBlN2U1YTljM2UuLmMyZGFhMzMw
OSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9zZWNfcG9zaXhhY2wuY2MKKysrIGIvd2luc3Vw
L2N5Z3dpbi9zZWNfcG9zaXhhY2wuY2MKQEAgLTYzMyw2ICs2MzMsNDQgQEAgZmhhbmRsZXJfZGlz
a19maWxlOjphY2xfZ2V0IChhY2xfdHlwZV90IHR5cGUpCiAgIHJldHVybiBhY2w7CiB9CiAKK2Fj
bF90CitmaGFuZGxlcl9zb2NrZXRfbG9jYWw6OmFjbF9nZXQgKGFjbF90eXBlX3QgdHlwZSkKK3sK
KyAgaWYgKCFkZXYgKCkuaXNmcyAoKSkKKyAgICAvKiBhY2xfZ2V0X2ZkIG9uIGEgc29ja2V0LiAq
LworICAgIHJldHVybiBmaGFuZGxlcl9iYXNlOjphY2xfZ2V0ICh0eXBlKTsKKworICAvKiBhY2xf
Z2V0X2ZkIG9uIGEgc29ja2V0IG9wZW5lZCB3aXRoIE9fUEFUSCBvciBhY2xfZ2V0X2ZpbGUgb24g
YQorICAgICBzb2NrZXQgZmlsZS4gKi8KKyAgaWYgKGdldF9mbGFncyAoKSAmIE9fUEFUSCkKKyAg
ICB7CisgICAgICBzZXRfZXJybm8gKEVCQURGKTsKKyAgICAgIHJldHVybiBOVUxMOworICAgIH0K
KyAgZmhhbmRsZXJfZGlza19maWxlIGZoIChwYyk7CisgIHJldHVybiBmaC5hY2xfZ2V0ICh0eXBl
KTsKK30KKworI2lmZGVmIF9fV0lUSF9BRl9VTklYCithY2xfdAorZmhhbmRsZXJfc29ja2V0X3Vu
aXg6OmFjbF9nZXQgKGFjbF90eXBlX3QgdHlwZSkKK3sKKyAgaWYgKCFkZXYgKCkuaXNmcyAoKSkK
KyAgICAvKiBhY2xfZ2V0X2ZkIG9uIGEgc29ja2V0LiAqLworICAgIHJldHVybiBmaGFuZGxlcl9i
YXNlOjphY2xfZ2V0ICh0eXBlKTsKKworICAvKiBhY2xfZ2V0X2ZkIG9uIGEgc29ja2V0IG9wZW5l
ZCB3aXRoIE9fUEFUSCBvciBhY2xfZ2V0X2ZpbGUgb24gYQorICAgICBzb2NrZXQgZmlsZS4gKi8K
KyAgaWYgKGdldF9mbGFncyAoKSAmIE9fUEFUSCkKKyAgICB7CisgICAgICBzZXRfZXJybm8gKEVC
QURGKTsKKyAgICAgIHJldHVybiBOVUxMOworICAgIH0KKyAgZmhhbmRsZXJfZGlza19maWxlIGZo
IChwYyk7CisgIHJldHVybiBmaC5hY2xfZ2V0ICh0eXBlKTsKK30KKyNlbmRpZgorCiBleHRlcm4g
IkMiIGFjbF90CiBhY2xfZ2V0X2ZkIChpbnQgZmQpCiB7CkBAIC03NjUsNiArODAzLDQ0IEBAIGZo
YW5kbGVyX2Rpc2tfZmlsZTo6YWNsX3NldCAoYWNsX3QgYWNsLCBhY2xfdHlwZV90IHR5cGUpCiAg
IHJldHVybiByZXQ7CiB9CiAKK2ludAorZmhhbmRsZXJfc29ja2V0X2xvY2FsOjphY2xfc2V0IChh
Y2xfdCBhY2wsIGFjbF90eXBlX3QgdHlwZSkKK3sKKyAgaWYgKCFkZXYgKCkuaXNmcyAoKSkKKyAg
ICAvKiBhY2xfc2V0X2ZkIG9uIGEgc29ja2V0LiAqLworICAgIHJldHVybiBmaGFuZGxlcl9iYXNl
OjphY2xfc2V0IChhY2wsIHR5cGUpOworCisgIC8qIGFjbF9zZXRfZmQgb24gYSBzb2NrZXQgb3Bl
bmVkIHdpdGggT19QQVRIIG9yIGFjbF9zZXRfZmlsZSBvbiBhCisgICAgIHNvY2tldCBmaWxlLiAq
LworICBpZiAoZ2V0X2ZsYWdzICgpICYgT19QQVRIKQorICAgIHsKKyAgICAgIHNldF9lcnJubyAo
RUJBREYpOworICAgICAgcmV0dXJuIC0xOworICAgIH0KKyAgZmhhbmRsZXJfZGlza19maWxlIGZo
IChwYyk7CisgIHJldHVybiBmaC5hY2xfc2V0IChhY2wsIHR5cGUpOworfQorCisjaWZkZWYgX19X
SVRIX0FGX1VOSVgKK2ludAorZmhhbmRsZXJfc29ja2V0X3VuaXg6OmFjbF9zZXQgKGFjbF90IGFj
bCwgYWNsX3R5cGVfdCB0eXBlKQoreworICBpZiAoIWRldiAoKS5pc2ZzICgpKQorICAgIC8qIGFj
bF9zZXRfZmQgb24gYSBzb2NrZXQuICovCisgICAgcmV0dXJuIGZoYW5kbGVyX2Jhc2U6OmFjbF9z
ZXQgKGFjbCwgdHlwZSk7CisKKyAgLyogYWNsX3NldF9mZCBvbiBhIHNvY2tldCBvcGVuZWQgd2l0
aCBPX1BBVEggb3IgYWNsX3NldF9maWxlIG9uIGEKKyAgICAgc29ja2V0IGZpbGUuICovCisgIGlm
IChnZXRfZmxhZ3MgKCkgJiBPX1BBVEgpCisgICAgeworICAgICAgc2V0X2Vycm5vIChFQkFERik7
CisgICAgICByZXR1cm4gLTE7CisgICAgfQorICBmaGFuZGxlcl9kaXNrX2ZpbGUgZmggKHBjKTsK
KyAgcmV0dXJuIGZoLmFjbF9zZXQgKGFjbCwgdHlwZSk7Cit9CisjZW5kaWYKKwogZXh0ZXJuICJD
IiBpbnQKIGFjbF9zZXRfZmQgKGludCBmZCwgYWNsX3QgYWNsKQogewotLSAKMi4zNi4xCgo=

--------------KT9h92IcBsig05SuKbtYqnDs--
