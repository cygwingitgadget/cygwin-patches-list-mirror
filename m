Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2091.outbound.protection.outlook.com [40.107.223.91])
 by sourceware.org (Postfix) with ESMTPS id 9637F3858D28
 for <cygwin-patches@cygwin.com>; Tue, 23 Nov 2021 16:22:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9637F3858D28
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBZaLFTRzzIYO+FjzIcah7/+5bPh8sn+Dqt35cvfBkynJ5ezI2l9YPz/agsYoLgAPyEJsgoZ2RSSm4zYUGIrYlFE9dRpYEV+r3XPgNAGdVa+FPRpRAQaLJKAH5NeRvJo2Ww1rJGsiUwDcz11gqvtNGki7l2vdopnIczkmBBfkVdBjChIkiHTBSuGkwMOJunNgxPKrJt/LzJcuhd+Kgcn43Ng8RAuagiGo4sKcbS9NQbnJnicWbM0ZT/dqn8XBAaCgbm2WkYxyCDeedu4oQbm6yPGHVCtB6z27INWxSvsRjkboKKqMQMch/KKL1yCNIkrbaUvtZj+uFWQ7a5Cexr0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5pc7jRhokfkQshgBH0b0IzQJ33OY3qEX1GNweZnQic=;
 b=b/5xnHLlLdCJPP5ozFq9aYNm7IeNun0EtDHdGPYznsmZonm3aDWjsv3tD1JCYrXOqoHM2nklp80aH6Pll73fYO1wiw1luC3cuM79VTLkmu7Nr7Yj21xiiRGPSlh8Wd9h5bIoLP1/Vj/oKn/dxW5Ti/9jLtAlzB3o2Ayp7C2gCHTTLXZK0Vp2znDI/xMHmKWGMySuTo1b5KRReMXQ3HusbX/mz5PW7DYkENe4+GOU9USAIZGiA/SaUGzZkspXEZ/SeBPvwbD5kqlpPbmh+WGkX4yuYS2ze+z2yyxpznXemHXoYg0IaLrjS6W7z0El6UxHWPMaQE6Haz7qs6YuyhCmug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5pc7jRhokfkQshgBH0b0IzQJ33OY3qEX1GNweZnQic=;
 b=bozQnSkE1Hf74axiybqzA5PYMIprUUq6GECbCE6OhJnHj3+elDv0hrsE7kDtmdUaseZvpXVUkU7QEdQno39RbGSk2WX3eEhMDTFuh5GEbOS9NCCvVrA/GX8H2cKtJQdJkjcFEy02SfwVmwSCHN1rLzYTkDJwz/lHMX6I5ATbDLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0659.namprd04.prod.outlook.com (2603:10b6:404:da::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 16:22:27 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::88c4:79c5:1eb1:b969]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::88c4:79c5:1eb1:b969%7]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 16:22:27 +0000
Content-Type: multipart/mixed; boundary="------------bqqBtILn7FVK60IzNC9R9jYX"
Message-ID: <782a2928-cd87-70b2-f559-781fd92d921a@cornell.edu>
Date: Tue, 23 Nov 2021 11:22:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH] Cygwin: fhandler_pipe::raw_read: fix handle leak
X-ClientProxiedBy: MN2PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:208:23b::22) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
Received: from [192.168.1.211] (74.69.128.111) by
 MN2PR11CA0017.namprd11.prod.outlook.com (2603:10b6:208:23b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Tue, 23 Nov 2021 16:22:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36e76db4-05e9-4168-b5c2-08d9ae9d70bd
X-MS-TrafficTypeDiagnostic: BN6PR04MB0659:
X-Microsoft-Antispam-PRVS: <BN6PR04MB06595E69E67A948F09FF582ED8609@BN6PR04MB0659.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRz3NZFuDW0u0xYyrTZEA+JXqlkgTSBDXX5LWeRkDcVYvieywuV/WcDf1LXiQruzzQ09h502tlaAZJqowbIFa0p6HhCoI5zEN9gzvZjHv0FGdZXxSqgZuX+9S3EUCgcFimabl9i2MSJ5+fqyP2sYq+S0Y8vu7gSm8XUTKxXGdnfUt8HErwFUlOJWw0VX+5I3dNvIOb0YshltWePrQa8tnAdm1/8EcgetWOHIANGCw5i4i7Z97T8Am3EXxCDprRvE4wLrvlJIozkMx/IA4xiZSjuv0yxvoRgQL4ZhEGhT3NlS9DFF+N3fE/PLQEMAxeSGfMLgV0jGqhCw39W/BWwK0mqAiIOwdT1fBkWXrc8uuAmkHyp//99S9qYEzqVAfZSMTz+24IceGv2RenGRibefDEWhADOyiVA6kZXFFV56wEmAnHRTcGjJEkBbEf8rKUdkjNOlhU7URMtX4UVJ4Gc58fV0f03iydw86OVo3K0+z3LGY0kq1anOd7uVBsebCBfy26yLW+fgnF4weFQqTTMYGtJ+znW0D6ewGp5GBx86bYNQ4EZLRDJmzZgNsUNNrS2Qbd5OJDxT/bcMmFIHbQb/qgzmLUaOPTLb/t8n7sr70kXxYPLoUWF261AlrtzM1cjziavR21InnJq6mIO3asZXKSmaD8q5+YkOtIKXSq64eeU+VRb/2dksftblgCfqxDB05ozhrBQSo5bNEVxqu/4RhqjcR+48FtO8b9xIUxk8Jh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(6486002)(86362001)(2906002)(66476007)(31686004)(19618925003)(564344004)(186003)(8676002)(66946007)(31696002)(2616005)(36756003)(6916009)(786003)(508600001)(8936002)(16576012)(33964004)(316002)(75432002)(38100700002)(235185007)(956004)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0Y5YUlZNFRoc0p5R0dMbnZIdnFkM3JoWGJtdnRpQVlaclNyU2lkM2d4T0Zo?=
 =?utf-8?B?WEhEeFA0ZVJZYUlibnBSZ3h4UlYzYjZxcmkzV3Jvc0g2bXFlZEZvYnBudEJD?=
 =?utf-8?B?blYrOWtKM3Z2akxGc2YwdEdVbzgxbnVuRFgrdDBzK3BhQm9yUU1NODlNWmUr?=
 =?utf-8?B?NmFIZjg2amd5Qlgzd2ZOdzRjdmNSM0lRN0twY3JGT0hLb1BLc0JIRDNpK2dK?=
 =?utf-8?B?U25qeU1GUjJFb0F4czFET1ZpVjBlVU42eFIyQ1JjVUhVc1o1bUZjQmkxWEk4?=
 =?utf-8?B?bm1jdmNZZWxoRjhITnJiRTZSckNZZ1pjbWJHOE5DYnNZRi9uajRIK3I1ZUtl?=
 =?utf-8?B?S1ZOeWozKzB2emY5cHMrUGVuNlVoT3lJQVlqSWh1NDBJUFovQ0NDWTNjcUJU?=
 =?utf-8?B?NUU4cmNUTkE3U3FvVTJiYlVlZ1BZYmUxVDBuVlZQVTRjZWJQMXluaENQSmov?=
 =?utf-8?B?TWt0RWZrMklSQldRb040Z0YrWXR0dllNWjRhVFI4SWc2M1VvL3crZEhiakxu?=
 =?utf-8?B?Q2htNGZNcm1vd084UUNHaGZpUGtoUTFsNVZLOFpZN0NZME01TVBNaWxPSmJG?=
 =?utf-8?B?S3JQU1I4Mm9FaEZ2RjFSN2doc0ZnVms0RkM3RzM0dlpRbkp2RDNKT1hFNENY?=
 =?utf-8?B?MHo2bGxQNHBqY2dVeklVM01IVGpQcFU2WVQwaGtURVdlZDZCSVQrRWxDRnFt?=
 =?utf-8?B?SU1xTmxkTnhPVXRySS9xTEp6MmtYb0hMczNVc2M5T1hiTlVVdmROMFNRc3Zj?=
 =?utf-8?B?Vkt3SzRGY1lZN1AzOU9idWhqTlVrTlM0NUt3YkgyZWt2MVpQeWR2bUxGcTRL?=
 =?utf-8?B?VENibUJJT01xWnYrdnVBME9tdUt6c2FoSjNaY2NCZ25SUkZKZnJuVHRVdUdS?=
 =?utf-8?B?OHJTVGdKbjJDTTlYTWdKMjlxTDM3SWhiNjBRRU40YVFDZkRFZC80c3BxVjU5?=
 =?utf-8?B?VDVUSUJpS25MbmtERTRUSWZxWXM5c0FYR2FFZ1ltUWZtVk9qK2J5RU5LZW5D?=
 =?utf-8?B?L1JaY2x1eXRLL2pnNDFMZHZpL2NXc1FScmpqQ0dFU25jVUErY1VNY2F6M2J6?=
 =?utf-8?B?ZTh4ZG13MkZkSXQ1VFIwLzJIZ1FHNlRESk8yZU1aczBvSTNDelBZRG83aWsx?=
 =?utf-8?B?U0VkWmpxbk9BN1BvM1Urb2dKZlpjNjVSbitHeTU5ODd6b2tBaUhtK0Nib2VN?=
 =?utf-8?B?OFhMYkcwVjRZYTZ3LzVDU2tqVlpiWDBwYlYrZmdaOHhwUVRocFZrVWRrRnlz?=
 =?utf-8?B?YzhOUHdhNjJFVDZTeWg4SWF5RUVBS2ZnMnZjZzdkMFo2dUoxS0ZBOS9JRldp?=
 =?utf-8?B?amNQVTNXekJtSUdYSkRSeGdMTU5NNWpKcW1xUUVmMStYOTZqWVNYQ1dUeVFR?=
 =?utf-8?B?Q21PbDVKODI0ZStTVyt4ZWtjajQrQnZCV1gyUTFrd01GM2g5b3lqS1pISGk4?=
 =?utf-8?B?MHRQSm40K01ZYzdJZmNKbyszaU5yV3l2elE2dW9PNVN0YW43SksxQ3p4UHIw?=
 =?utf-8?B?ekg4WDNWMi9kV1ZFNjVVV3BhZWZ2ZWF5dnpsWTBIcDlka0lWWlM0eDh3bnBw?=
 =?utf-8?B?dHVFZGoyZmNCZkh1QkZNc2Q1Ny8yazA5cjVoWXZOQnJzWTdPcVhBNld2b2Yx?=
 =?utf-8?B?NngyL2oxLzMxZytWOG1kOVQyNmdlZFhxR0RoeGQyZERhQXFhY3BzQ1cxcGZr?=
 =?utf-8?B?VWIvdXVoMmowTFlIazYxeVdRTy9PR2poR2xtVVB5dGJYc2VVQlhqUllXNDBV?=
 =?utf-8?B?dkJSZFhMdWtPSUVYTW03d3oxSjA5ZnllVDhlZStCUlFMQzFqdEc4emxINUdH?=
 =?utf-8?B?TDl1b2tJSnZqNC9mUGlZOWFFRDBCejhXWkZVUU1QeExGSXRQVnhRY3JFWWJ6?=
 =?utf-8?B?Nk4yaFkrMFpRV3M1UGxqZ2FwWEhsY0loV1lwNDM4T1EwNFlSLzBHRks0dTdt?=
 =?utf-8?B?bWIyUGp5RkkzTUJ4RGxqQUhWdTVtdTg0WUo0S2JKQzR2SXIzRWo5UXNycVJJ?=
 =?utf-8?B?STZBaUVqWUcvT0NaazNpcURtWnB0UDNLRVlybjN2TlhWa3dzV1ZzT2hwSjlx?=
 =?utf-8?B?NkRxRmhaWlJhVldISmJwQ0d3K1Zqc0hsaEsxdk1HMFdSYW9RcTBDajlZd1hr?=
 =?utf-8?B?cEpDaTFyNzE5bVZxUHN1Q0RqUmhZWmNqWHdBeGdBNHZ6MEJIYk14QW9zVlZI?=
 =?utf-8?Q?FNg1httrK/tRuTzExyXZqZs=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e76db4-05e9-4168-b5c2-08d9ae9d70bd
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 16:22:27.5024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtORexEQzKvCvGRu49tDorPJoEpttT+7p7qArfiM855WpxjywApEp2k/bmAI59GiwczvVlCVak/jD41zTalyXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0659
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Tue, 23 Nov 2021 16:22:32 -0000

--------------bqqBtILn7FVK60IzNC9R9jYX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.
--------------bqqBtILn7FVK60IzNC9R9jYX
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-fhandler_pipe-raw_read-fix-handle-leak.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-fhandler_pipe-raw_read-fix-handle-leak.patch"
Content-Transfer-Encoding: base64

RnJvbSA2ZDM0YjYyY2I4ZTE5MjA3MWUxOTM1MTZjMjM0MTk4NTRjM2I0MTI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
VHVlLCAyMyBOb3YgMjAyMSAxMDoxMzo0MyAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjog
ZmhhbmRsZXJfcGlwZTo6cmF3X3JlYWQ6IGZpeCBoYW5kbGUgbGVhawoKU2xpZ2h0bHkgcmVhcnJh
bmdlIHRoZSBjb2RlIHRvIGF2b2lkIHJldHVybmluZyB3aXRob3V0IGNsb3NpbmcgdGhlCmV2ZW50
IGhhbmRsZS4KLS0tCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3BpcGUuY2MgfCAxNiArKysrKysr
KystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfcGlwZS5jYyBiL3dpbnN1cC9j
eWd3aW4vZmhhbmRsZXJfcGlwZS5jYwppbmRleCAzY2JkNDM0YjcuLjUxOTViMjgwNyAxMDA2NDQK
LS0tIGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9waXBlLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4v
ZmhhbmRsZXJfcGlwZS5jYwpAQCAtMjg0LDEzICsyODQsNiBAQCBmaGFuZGxlcl9waXBlOjpyYXdf
cmVhZCAodm9pZCAqcHRyLCBzaXplX3QmIGxlbikKICAgaWYgKCFsZW4pCiAgICAgcmV0dXJuOwog
Ci0gIGlmICghKGV2dCA9IENyZWF0ZUV2ZW50IChOVUxMLCBmYWxzZSwgZmFsc2UsIE5VTEwpKSkK
LSAgICB7Ci0gICAgICBfX3NldGVycm5vICgpOwotICAgICAgbGVuID0gKHNpemVfdCkgLTE7Ci0g
ICAgICByZXR1cm47Ci0gICAgfQotCiAgIERXT1JEIHRpbWVvdXQgPSBpc19ub25ibG9ja2luZyAo
KSA/IDAgOiBJTkZJTklURTsKICAgRFdPUkQgd2FpdHJldCA9IGN5Z3dhaXQgKHJlYWRfbXR4LCB0
aW1lb3V0KTsKICAgc3dpdGNoICh3YWl0cmV0KQpAQCAtMzE0LDYgKzMwNywxNSBAQCBmaGFuZGxl
cl9waXBlOjpyYXdfcmVhZCAodm9pZCAqcHRyLCBzaXplX3QmIGxlbikKICAgICAgIGxlbiA9IChz
aXplX3QpIC0xOwogICAgICAgcmV0dXJuOwogICAgIH0KKworICBpZiAoIShldnQgPSBDcmVhdGVF
dmVudCAoTlVMTCwgZmFsc2UsIGZhbHNlLCBOVUxMKSkpCisgICAgeworICAgICAgX19zZXRlcnJu
byAoKTsKKyAgICAgIGxlbiA9IChzaXplX3QpIC0xOworICAgICAgUmVsZWFzZU11dGV4IChyZWFk
X210eCk7CisgICAgICByZXR1cm47CisgICAgfQorCiAgIHdoaWxlIChuYnl0ZXMgPCBsZW4pCiAg
ICAgewogICAgICAgVUxPTkdfUFRSIG5ieXRlc19ub3cgPSAwOwotLSAKMi4zMy4wCgo=

--------------bqqBtILn7FVK60IzNC9R9jYX--
