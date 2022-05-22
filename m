Return-Path: <kbrown@cornell.edu>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::70f])
 by sourceware.org (Postfix) with ESMTPS id 81DF9383D838
 for <cygwin-patches@cygwin.com>; Sun, 22 May 2022 16:18:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 81DF9383D838
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eE+JedeMGZgb/v50/EJNqqjJDywTYPAcHVMXeuM3gQlfmHT562Iex2C0ia4d9r8n9zofSiJRc4cJkRRTmEhGHvURBD0kJ6mQB+8D80Qduxc4a1P9o1WxpBTkGcS5uqO6GEQVgLN53B7LfY5ocAPAHD7iwC3mGLiz5dkf47j2IYQH8bfq+bCJkSBgP6HlYgsGbwYjMY162fPLMuwztU5JxOCcJfOhHDcCMKDYR8HMA7WzRRLzbZhCjjl2bqsEXd4MIv2CRMJq+8yPH9Rx7rs3tyJPq4x0YhOeeq55odU/PmE7j5jFW9WB2dpQReWbaxYHciLeqpeq6a/nKRcbUSNi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydhMoPe2srWnTCgzgjnQ+L14X1OOlVlPe45d64fC3TM=;
 b=bJTtqzC/sCluAzrIlDFEJDr9m1goRf6gUcmamIz3BjnHKtmmFimbVxNLLk2Fx5TGaOXcV7T22fZuo9y2Oh0Wl/W8lgjy3p2gZvQ/RMQemX+RH582vx64QKMKJ/z1S/iWbeKiuvL5bjXvSVWNrtoImgvwdADyJkFr0oK5ncqv3lg0+G9dglS6zyGFUzFKmv1ud5eyALgieORkU0AGUI8QfFapi2k0Vr/fQdE6nFXFS106gMMG18pAVRmIp+BeDxTNHiV6B6lfVU6hW5thPu1LB4Wa5GZ7DbDKY5Yu5e73fq1U56ymW0bzm8y6ZrVCxdJkzE7NLMydNl/qKGkOdfxX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydhMoPe2srWnTCgzgjnQ+L14X1OOlVlPe45d64fC3TM=;
 b=dLPkJAgrdOtD/jpIN3Xdng63zGSlUOiIlR+lhAbuRSLV8p5Kj9zP8cxBe16XmcdYHqMNPLkiMNgk3bkttECMcmNHyfmDWBvtsaJ60P0xdhUNRjkGvYYAF9H1b/LVCHRzZWRXRRxo8W/kcHJQ/xJep3GoV4xzHS7eu2RKZo/GbRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by CY4PR04MB1161.namprd04.prod.outlook.com (2603:10b6:903:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Sun, 22 May
 2022 16:18:39 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::ed45:6a5d:b109:673e]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::ed45:6a5d:b109:673e%6]) with mapi id 15.20.5273.022; Sun, 22 May 2022
 16:18:39 +0000
Content-Type: multipart/mixed; boundary="------------0GP0h5wcXGvFhj4kPRLvlxLF"
Message-ID: <0d40096f-322f-64b5-da20-c7ac64c5c97e@cornell.edu>
Date: Sun, 22 May 2022 12:18:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH] Cygwin: fix mknod (64-bit only)
X-ClientProxiedBy: MN2PR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:208:23e::28) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31bd69c1-f76b-43b3-ad87-08da3c0ebb07
X-MS-TrafficTypeDiagnostic: CY4PR04MB1161:EE_
X-Microsoft-Antispam-PRVS: <CY4PR04MB11616FFD604D6014803C130DD8D59@CY4PR04MB1161.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6kxW5/kREKlSMcpDa08Ax4YECoy02MU75c650UbZsE7BD1buHZ7xCRF3ESb/upKfvRDLL4fMek2oXkD2npjOLrFD1Jl1jAkhgZ53jKekVFfkFxYfY8y3kOv/NsxNh2hq1k9czYXaV/nNeue7VDbtDLt9KnAM/WtIAW/eg/zk08fAxRuXH6TXx9+jnhg/cDrxk19apw/KW6feHDyyTK5pUowPQmZrsj8DZVww78GRNc7YE9o42RiaNnXIjNdaLCXiMktkbkq0A3mCutrynUHllEtyltYyOD6B2hTWp6dP/Cw6ByHBAbgBNpmMf5opOzmuEreGKoIllixuIXnZSCmmBvgJkEwWyJbF0qcf/ymjcLAPZ6iZODASVdT6u8uhtjHhFV2Hka5z0ejwiEF3RZKPdm+yMil26Y1KH8tWsy1li4HdwQY7SmYIyKaXmaDXkGsiM/ytAY1S4YlLo2Y4oUQL0TQH+lkFLVuYQxbfMd0Nak6KMHmjHmYtWlvoj8pD5DbHX4sHMct345nHxm5xF8DsQaicNGUa0atlJdgyB+OQsCowBg2cPLxE3Lovy4yTfJkTAs3ckBkiY0k8jBGawHqYLWfebmsPAswU2bTRtcfvOje56C/hmERYEyC0bE0aHjUDoAFTMg8l6SqsEDCEBdQoxXSCEDGJQEy1rndHwF3ILhgLLXHzVpXZNiY9yoCGiDcQ4fvQRIScu03czYikS1w56cGrtmzXVnNZMagmnt6USx4RSEnWukWSatZM4MrZDrG/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(235185007)(5660300002)(38100700002)(66556008)(8676002)(66946007)(66476007)(31696002)(8936002)(86362001)(75432002)(2906002)(6512007)(33964004)(186003)(6916009)(6486002)(508600001)(6506007)(316002)(786003)(2616005)(564344004)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlY0a2tHUC9XSGNqMGVLNGgrbEtjZE5MeGJqYTlkMDFNdGlVVGtSUmNrSVVY?=
 =?utf-8?B?d3ZpQmI3YmNLVUNnelZ1c1VMT0c1NUl3WHdmNnV1TEt3ZjBETzh0Ym9TanM0?=
 =?utf-8?B?YUU3TmpvYnpjb0JJOTNBcy9IVXNLWXVvaGhZMnF4ZVlpazlxdzhlcWdicUNm?=
 =?utf-8?B?Q0NWNFg5cTY0elNxQWtGQ25wRFpjL1JDTkJhdWExTnhCT1gyZ1FTK3ZmNUNz?=
 =?utf-8?B?R2luOGhyZ0YrTVBncUYvc3RNZzNsMW5RanRQemtLaE1MbXJ6RFRua3N0S3RG?=
 =?utf-8?B?ZmJXYTI0bzB0VVBlcHM3eG9vK2wyajBWR0hlSDF6VVM0dWhGR2tCNllZRko0?=
 =?utf-8?B?M0xuOGt2bTVUQklsZ2w2RTB6ZDhEOXdGeVF3cjdpS3A3cGlQODUvWlZ4b2dB?=
 =?utf-8?B?MG5scmNZVllhY1ZqR0RSOVpzQ3RDandDeDBkZXZUK2sxZ0ZndG5zd2lIM1hZ?=
 =?utf-8?B?VS9WaStXWmwzK1htVzBiMTVPKzNZRVdwUVZSUDE2VjVuMkgzdEZxcWtHMTFr?=
 =?utf-8?B?M3U4YVJoOThVd1NXajdjQlVIVkhPUmdUMUttWFhmK2srdnA0ZmVsVWV0U3Nn?=
 =?utf-8?B?ZnVBbFVhTTBZN1ZKY3NFaldrQ1RtMDZPSXdXT0psdm84RXNYdTd5VEp6TnVn?=
 =?utf-8?B?dEVGZGduQXRqdjExT2ZmVVViSk1sVHpFdXBPU0YwK0xEM2J5T3JCTzNhalNu?=
 =?utf-8?B?YkluTzc5N2txa2JCUkQvR1pzRGIwVGlNdnpUVHU5WkJhNWd4ZjJHTUpoUzI0?=
 =?utf-8?B?N0RBMkUxVWRvOGRNeVdPWFdpR1VJWHpwaHg2cDZxV21ScVpPZTVldVBrTk1m?=
 =?utf-8?B?d3NqRnRXRStZditJL3ovTElBa0JzS1VaSmROTGw4Zy96alY2SFU3bTNMek9Z?=
 =?utf-8?B?R1NxbTRUNTZxZTVFTVB3ZzhXV1ZIQmQxME1JbTlQOXVveVdWT1FrSFRYRXJq?=
 =?utf-8?B?Z283N0lvbjBESXYxcmxUM1JqcXpTTU82YXptTmFJWmk3SDNvRVNDUHNsRTJy?=
 =?utf-8?B?eTNXdVVjbDY3K3ZLN1JiT2lQZEFvMFozRjBGMVNHTm5wUU00OFM1WmlnM09T?=
 =?utf-8?B?VUtwamRoV0lHUXQ3VnYxTUdzRkdza3lnQVh6dzhIckRmczA1UU4vRm1zczRp?=
 =?utf-8?B?ZVJWWkhoYWk5ajZGUENyVitqa2xzbzQ3RXR5cTdQUkZ2WDlFRU9qSVl0eEZZ?=
 =?utf-8?B?Vjh6d1E2b3dHOGRJcXFGR0lIcUxhVXFYbEdXUEtDcDhwbDJsWFViZ0RMakJO?=
 =?utf-8?B?MTZCRGhRUEd4dnVFek5LMVZpOGdKSmZ5NzMyU2U5dHozenBmOGk2bjdIOWQx?=
 =?utf-8?B?eFRGYlpaU29kRGZiZ0FibDZhWURmT0FVdlcxLzByTUwxWjRZM2JXdS9hVkd0?=
 =?utf-8?B?bWxlZ2V0UkZTNC9QMGVwK1lZTHRRVzJEK2tFU2lsTzkvalhjOTUwS3pBWkNz?=
 =?utf-8?B?T3Z3cFhkazkxcTduU3BMV2xoVkFLZ3VEb0pzNWFWYUZTQzZqZjNIMW5DNFo5?=
 =?utf-8?B?aWxnbVc2OXlvWHNxTGcweXpQdm1sbU5keDRld1ZjM2lhNml3Z1RIZis4OUwx?=
 =?utf-8?B?eit5Y0R5TU5oUG1kUWE2UHpmQ2pBL3p0L0sySTZzS3ZINCtENk5rK2xIMW1Z?=
 =?utf-8?B?dHE3Tk9SYWRsVXp1YXM5TkpQc2dLN0tmQ2xoMnVxemtqcVFnVGxYTFpsM0tl?=
 =?utf-8?B?QlF0R0FmZ3JYMzJZK0NlbE5VQUJtejNTSS91K09EZTg4RHhTZTFjcitkUDVB?=
 =?utf-8?B?TitaS3JJNTNDVUI5aUErN1pUWEdMVlNBYzROOXZsd3JHZ0VrSmlLc0tMOW1o?=
 =?utf-8?B?cE12alVhZU1wY0NrcEx5bjFLQzc2ckhUVW9wcTZsb201N2xvaUFMYnorSmR0?=
 =?utf-8?B?Ny9QUHVUaSt0amt3ZW5ySU82R2ZMenJpZjFFY0JjOWdHdFAzSUNuVno2ckVW?=
 =?utf-8?B?a3cyWlAxK3BWbitDVlplcmRMaWpQT3JCbyt0ZDBRbnRuZFNrUWhwWmVyeGN2?=
 =?utf-8?B?bk5JaWhSS21JMUdmb3grY0wwdGpXeExNUFdSWmc1VGxvaE5jVWROa01Hb2RG?=
 =?utf-8?B?QU93R1VuVUFZclF4OTNaNjcxSFdud0wzZ3FDd28wbXJBN3AzUDlhQmwxd0c3?=
 =?utf-8?B?NmxYS0dpU3NmVWplOGJwZ012NGF3ZVIrNHY4U1dzc3N4aE9pUTV5YXp3Qitw?=
 =?utf-8?B?TXBrYVhhRWFIZkVKU2RRQzg5SEVweHdGK09iMVN4STVPYW5EbjRpTlhQbHFp?=
 =?utf-8?B?RStNUjJkQXdCU1FQSmNyY0ZtalJBbEQxT1o2c3Nab0ZEZ3J6TnI3WjJlelNx?=
 =?utf-8?B?endaWDVFU3lpZ3pZRDgyaFhjSUZ4cGYvK0tGK090YUx6Zm1nY0dPS2NIYmh0?=
 =?utf-8?Q?yL00pDxi2Oh1cYwpDPz0/8v+QqNG44jrSXa4HBP1N/4ZY?=
X-MS-Exchange-AntiSpam-MessageData-1: E0aoJeCP+tmmBQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bd69c1-f76b-43b3-ad87-08da3c0ebb07
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 16:18:39.2803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwEq8x3N0jd1jE9wdwoXAuJbS5OpAXncCBZNDfgwwpDrUJMBdzJxsgTsH0tGbJTtVL97I/vnm/jEhu1orR5R3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1161
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 SPF_HELO_PASS, SPF_PASS, TXREP,
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
X-List-Received-Date: Sun, 22 May 2022 16:18:45 -0000

--------------0GP0h5wcXGvFhj4kPRLvlxLF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.  I'll push it in a few days if no one sees anything wrong with it.

Ken
--------------0GP0h5wcXGvFhj4kPRLvlxLF
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-fix-mknod-64-bit-only.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-fix-mknod-64-bit-only.patch"
Content-Transfer-Encoding: base64

RnJvbSA1NGNmYzcwZmYzYTU0OGQ4NjFjYjU5YWM2YjIwODRjYzZiNzkxZWMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
U3VuLCAyMiBNYXkgMjAyMiAxMTo0Mzo0NCAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjog
Zml4IG1rbm9kICg2NC1iaXQgb25seSkKClRoZSBjdXJyZW50IGRlZmluaXRpb24gb2YgbWtub2Qg
aW4gc3lzY2FsbHMuY2MgaGFzIGEgdGhpcmQgYXJndW1lbnQgb2YKdHlwZSBfX2RldjE2X3QgaW5z
dGVhZCBvZiBkZXZfdC4gIEZpeCB0aGlzIG9uIDY0LWJpdCBDeWd3aW4gYnkKZXhwb3J0aW5nIG1r
bm9kIGFzIGFuIGFsaWFzIGZvciBta25vZDMyLiAgKFRoZXJlIGlzIG5vIHByb2JsZW0gb24KMzIt
Yml0IGJlY2F1c2UgbWtub2QgaXMgcmVkaXJlY3RlZCB0byBta25vZDMyIHZpYSBORVdfRlVOQ1RJ
T05TIGluCk1ha2VmaWxlLmFtLikKCkFkZHJlc3NlczogaHR0cHM6Ly9jeWd3aW4uY29tL3BpcGVy
bWFpbC9jeWd3aW4tZGV2ZWxvcGVycy8yMDIyLU1heS8wMTI1ODkuaHRtbAotLS0KIHdpbnN1cC9j
eWd3aW4vcmVsZWFzZS8zLjMuNiB8IDMgKysrCiB3aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjICAg
fCA0ICsrKysKIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
d2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuMy42IGIvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuMy42
CmluZGV4IDZkNzIyNDMzZi4uMTM1ZjMzMTU1IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL3Jl
bGVhc2UvMy4zLjYKKysrIGIvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuMy42CkBAIC03LDMgKzcs
NiBAQCBCdWcgRml4ZXMKIC0gRml4IGtpbGxwZyBmYWlsaW5nIGJlY2F1c2UgdGhlIGV4ZWMnaW5n
IGFzIHdlbGwgYXMgdGhlIGV4ZWMnZWQKICAgcHJvY2VzcyBhcmUgbm90IGluIHRoZSBwaWRsaXN0
IGZvciBhIGJyaWVmIG1vbWVudC4KICAgQWRkcmVzc2VzOiBodHRwczovL2N5Z3dpbi5jb20vcGlw
ZXJtYWlsL2N5Z3dpbi8yMDIyLU1heS8yNTE0NzkuaHRtbAorCistIEZpeCBta25vZCAoNjQtYml0
IG9ubHkpLCB3aG9zZSBkZWZpbml0aW9uIGRpZG4ndCBtYXRjaCBpdHMgcHJvdG90eXBlLgorICBB
ZGRyZXNzZXM6IGh0dHBzOi8vY3lnd2luLmNvbS9waXBlcm1haWwvY3lnd2luLWRldmVsb3BlcnMv
MjAyMi1NYXkvMDEyNTg5Lmh0bWwKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vc3lzY2FsbHMu
Y2MgYi93aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjCmluZGV4IDNhNjUyYzRmNC4uMzQ0ZDFkMzI5
IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjCisrKyBiL3dpbnN1cC9jeWd3
aW4vc3lzY2FsbHMuY2MKQEAgLTM0OTAsMTEgKzM0OTAsMTUgQEAgbWtub2QzMiAoY29uc3QgY2hh
ciAqcGF0aCwgbW9kZV90IG1vZGUsIGRldl90IGRldikKICAgcmV0dXJuIC0xOwogfQogCisjaWZk
ZWYgX19pMzg2X18KIGV4dGVybiAiQyIgaW50CiBta25vZCAoY29uc3QgY2hhciAqX3BhdGgsIG1v
ZGVfdCBtb2RlLCBfX2RldjE2X3QgZGV2KQogewogICByZXR1cm4gbWtub2QzMiAoX3BhdGgsIG1v
ZGUsIChkZXZfdCkgZGV2KTsKIH0KKyNlbHNlCitFWFBPUlRfQUxJQVMgKG1rbm9kMzIsIG1rbm9k
KQorI2VuZGlmCiAKIGV4dGVybiAiQyIgaW50CiBta2ZpZm8gKGNvbnN0IGNoYXIgKnBhdGgsIG1v
ZGVfdCBtb2RlKQotLSAKMi4zNi4xCgo=

--------------0GP0h5wcXGvFhj4kPRLvlxLF--
