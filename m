Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::70d])
 by sourceware.org (Postfix) with ESMTPS id 230283834F1A
 for <cygwin-patches@cygwin.com>; Thu, 26 May 2022 19:17:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 230283834F1A
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyCO8vPatr84JIHj/IUnAfU4xSoAadwbkqxdPgnXp6uZu0TzaWJB/w6nyfGT6diWj1q8sRQCHbL6rAB9Obt5R6mN20Fu4f7rOdk5lmg5Tj97hm+k4j34bkQx63Ja2jsslyB90dQjCPqPqmRJE8rH8m25uEDLFc+25hnAex/RzsY1loIlq1FjOFH7U9zh9/Xfa8UkM3yXbXuNTgcghz+L7c2NNDOnT6P/1Y5j+rSS9IFnUbqGnNRDjZt2wjGrUJQ0vMQRlXUi0Nhf5J0cpBI2KQIVR2sdCnlb7Or6ga4gtW7HQ5g3s6r5gDIp1P/PgMOBbaLeVNyoN85RTYEQDL3FWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8e61Q4+eId672dVVec189Rqsn4gv6oUBT+i5IBubM+s=;
 b=UnPTQx9OiiaZiv5iK0DWLMVM+Kc8dTnrY5B1Dnghfcmfz08JrdJyEo+jlqkO3XXe1K7xTjIoFGj8nEi1aoEuLhvVUnuHeZcrNzWUBE9pUjC/qN+UukCft8ekcUr8yq96YGm4W5qQNwY9NvS9SEUFNyjw6dt5QBGRMbzj2si5beWginU2uMV7XPYNhzhXJudzDvst6clt04sg0iEGbaDVzfxdUCCQCF2W4rnA2fP/uERaVzdJWsu4uc8KG8bk8oK9kn7+NmKkCsixovgNOGUpGQVMNLluYyMtjHfxQx1n1azUUs/89ZBTKj954ri4jybRwgv5PpOPh3YmHLozF6HPrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e61Q4+eId672dVVec189Rqsn4gv6oUBT+i5IBubM+s=;
 b=VhvJVqXlWkxWAQW2l2Ni4n4+9KdyUXBAodQ1Ri8jwWik7JwghGSPiar1SWlepl/e8Y9FjjUCF6NF8C7V6geYwKeQ4bb+lfIX+ppDTzTK+l6mfAScJQat0XF2AKNQty1dNgWQGLaqpw+4HM11O08WEUE/oVgjY5OxSTzE5p4OgqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by MN2PR04MB6461.namprd04.prod.outlook.com (2603:10b6:208:1a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 19:17:20 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::ed45:6a5d:b109:673e]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::ed45:6a5d:b109:673e%6]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 19:17:20 +0000
Content-Type: multipart/mixed; boundary="------------2zwMxFugcDVxHlSJutyh0Sb9"
Message-ID: <680ddbf2-db59-83ec-74dc-c3d04a2e6cf6@cornell.edu>
Date: Thu, 26 May 2022 15:17:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH 4/7] Cygwin: remove some 32-bit only path conversion functions
X-ClientProxiedBy: BLAP220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::14) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 353fa559-a5b7-4f5b-845c-08da3f4c5b30
X-MS-TrafficTypeDiagnostic: MN2PR04MB6461:EE_
X-Microsoft-Antispam-PRVS: <MN2PR04MB6461162957F039C852BB2835D8D99@MN2PR04MB6461.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pE1XXsMCPKzge3yPpTyjgcxexNEtRsVORt9j9oW7KraLkUMMs9qKUlYvYs392VXJDds4lX8Fml6YPdCk3dhEPhW+TBg6R+p2o6LjcOwDP0EdB1Klx5E/Eb6+i0+WdSn6tkYSCxW61fsd30vneTfHt8RqE9EdOq8B4z0viDuOF/5uKFWNiTK4plcq7lNmVuSUNxA/WiEOo1U/NbTQ66//euEeGG+5YdaGS/GtEIbMiqps7xqq/eM0Hn+dFoNFCQ1CohH45V5xDZyN5IptxSdetezoonjofw6bHG5LI4aT6wChvw312VjiWfpp0UEzK1BZOAU2pYHvQ5f4+9hqihgw4k1U4kzH1xpbqUmYz/ECMiOzYOrv2JOf6xcSq6Tetq2M94qg6rX9PxHYu8GeyhbIIxH9HfhOIoN69YwyrKdR4HCPfe2VuknOfxf0hEtIi3nrehtUobEe4lliwIzpO1ljun7Yz2lOkEuXiHKJ01ZlaYEy34TvRP5yfiCSy+u0apgIRyXWQUjM3ff05d4SvB9080ragfjwj4LBgMiPQpRdXrkDsspDzb009XyBp90aBzsiEI349pUvpkO6SiwiC99lqOJ7uOm1Z3et7bTByX5asxTl9ghZGizrtH0Bp/P94cRWLZ6+/n3iTuiAVUZA1ezvPs40qfAEYI+ajpNuqMMaqQoAN7Yi+Qtxymy6DpNTXTV6cRcLI5hCk4O3QT2chlj4zAq8RFfL9iIy95zjcTL7b1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(186003)(31696002)(508600001)(33964004)(86362001)(6486002)(2906002)(6506007)(2616005)(235185007)(6512007)(8936002)(19618925003)(786003)(316002)(36756003)(564344004)(66946007)(66476007)(66556008)(8676002)(6916009)(31686004)(75432002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGgyUDdudzNpWnJWNW1HVkJiaHBxSjc5dml6ZmpJa2taeDhiNFFPcVVLcnFJ?=
 =?utf-8?B?V1JPajA2Skw0RHJ3Qm5GSmdRdlNINEhESlhEdXgzQXlzdXhySUdpNUhtNW5N?=
 =?utf-8?B?bysxWGFidTc5MnB6UnZIRTlHTU1UeXlOKy9aeTFpQzRWaUZJbWRMT0lBWlpm?=
 =?utf-8?B?TG43cm5BWlpwYkI2cDNVdWR4UTlPZ1RLV2o0NEhaRTlMbmQ5ZGRnZllkdzhM?=
 =?utf-8?B?SWdXUlQ2eVNlcS9icjFOQnZXbmZwV2xtYnRYd3MyYXJZWExSOW5laDZsR2pu?=
 =?utf-8?B?R0IvdTZucUoyczR0Tkx2L2wzRFl6NWhFS0RqQVNKdCthb2k1TWRaUFVPTFcx?=
 =?utf-8?B?d1Nmdm9iQ25TMll0UGhzN0VFQzdMcTUxVGhNaDZ6d2ludEhZbmhSZjdHQW9s?=
 =?utf-8?B?M1F1R2E0VExCSFZXcklWcEkvQzVmd1A2S1FDTEY4N3R5bHdBVlorUXlFNXhN?=
 =?utf-8?B?QUhJK1ZqN0ZRQXpRRmJEdTJ1L29pS3dvN0V6Y0p0YXdVbHZjL08zSS9YUU04?=
 =?utf-8?B?TmFBS3lYUFFDZWJXRlNBYlFWbnZDaytoSjNla3ZPOFFvdENpMThWaCtqYjhP?=
 =?utf-8?B?QnhLcXdmZHEyTHdnczZEbEV4enJmeEVyZS9UQW1PSHFZVUpDMkk1N0R0ZldU?=
 =?utf-8?B?Qm5ITk5JR3hTZzJHUVlqRlVheVU5d1YzZjlmTHJhNVFKUGlMNTRPZkVaQUxk?=
 =?utf-8?B?dlFvR2hZMUhyeHkyTFRUV1Q1SGFrZjF5ekRXZ1VEL2NPWHlHVms4YWYyeUpM?=
 =?utf-8?B?d1U0N0pXRGhBSlByRU5Sa1hKNGVQVzBsUGY2bzkrQUlkRkduVGlMZnhuSHEv?=
 =?utf-8?B?MWJMbnVUam01ZXlydlhGK21adUdhRlVFRkUvN0hPZWNRQ21CTnJTNkFCK0lP?=
 =?utf-8?B?NkVqdkdDN2pjNUl2azJCbW5wTDh0cjlnYithU2xuZDJ4N0dhUWlEcWxvOGd0?=
 =?utf-8?B?TkRNdGc4Uis3U05iT0cveGw0VXRwUGdndU1IMGVkTm9NSUd6WjNwVEszblBS?=
 =?utf-8?B?Sy92SU1BcWplSkVwOEp0WnZhNVJTKzNyWFJkMFJJMlhGK1NoakNYMkpqbEph?=
 =?utf-8?B?SGQyUXJBdGlQcWJrZlcwaWJja2Q5M0hHSlRhMXVSaUp1VzNmZ3NzNDI5TXNa?=
 =?utf-8?B?cWc5UUd6cXBCRmhsVkU4YlVqeitTTEh1LzlVYXpXWVZZZExXK1l0bm0xQlg0?=
 =?utf-8?B?MzJIOGpjZFR1bHJXcHVMam1MbmtWa0M0OE9HeitzeWk0OXd5K1JIT1poU0Iz?=
 =?utf-8?B?ZjUydGRjNzNlcnF4UnV1UnVjMjVYN0VpQzdpOUdabGxKbUpjbkNha3VjRHl0?=
 =?utf-8?B?WExoakY1RFNWOFo3V2xxVEhlcldVK2pKMGxhYmdQYWdtc2xvRGNsUGdrd2Ru?=
 =?utf-8?B?SkZYcFB6cFdJN0k1L1pVOS9aVzhXZ1BPZFlHZlBxaDZCZ2ZHMGgxaGUwV2t4?=
 =?utf-8?B?elgwUDQ2cExWeHJZTFVkZFY2Tk9tdFRabFN1MGFoc3pRNjVDdnc5NzgzaS96?=
 =?utf-8?B?UTFKQ0x5MzhESnRPT0RMMXJJRFBYY0hKT3V0WUphdzNoTGVXZENSSkNhYnF0?=
 =?utf-8?B?RHV3UEF1Nm5yVkF5WkxwVm9qVThST01FTE5JMlVPd0szaU16MDNTZFROMTRv?=
 =?utf-8?B?TVhmVG1MS1liYUxQNHZSVkhULy9ETWpBNkpYbzAyc3JqTlQ0VDIybFoxL3VZ?=
 =?utf-8?B?cEhnd0h0a1dzUzFrWGpJUzNVOHFtclFaRXJPbmJtYnpGY1RKS0FDeFRJdTRL?=
 =?utf-8?B?QktnZzdIT0lhdWUvcW1kdXZkTmtrQ2VrQmFpVG1xaDVybWxNV090Ui9lS3dO?=
 =?utf-8?B?UVJpK0l3Z2NZdnZNK0tyMjM5dmx3RlhQdmdabmdqdFhuN21UMUNMaC8xT0Jz?=
 =?utf-8?B?QjBXTnNyTDlFUjdZK2JwaGJQUTFVRlBJcUlGaStWVEFGVENDbHgrSkNMM0lO?=
 =?utf-8?B?UElTM2lDRUlHRFNoelRTNHhRcmhoQkJvQUh4UG9OOGRpQ2IzRm03OHlrOStr?=
 =?utf-8?B?MTIwNmtXRVQyMzRnMitTUUlYeGpQa0FOWE82RWsyLzJ2eWRxdnRtZUFQM1Fn?=
 =?utf-8?B?dEgwQ3FmcWo3L1JNR1ZkU055TTRvNkFLOU5RZFpzbFhQNFB3K0IxZytwWC9U?=
 =?utf-8?B?TjI4UEpueTFJaXIyK29zSWNvd2dndC80bmIzNEJGc2JtUmZHaDBDWW9hNjlE?=
 =?utf-8?B?V2pGSVB3OGxGWVNmbjZoNVVhY1lhSFpZUkxrM2lCWFVPQ0poS2wrUjcwWHA1?=
 =?utf-8?B?aWZGOXBzbXNra241OVluWXFGQ1JpK2FzdXBDVDE0dHh1KzhVeDY2OUNVa1hZ?=
 =?utf-8?B?dVlIZUNlL3BqNlhQVDVtWHIrYTVrdGh5eERBWmZsc1MwNTZnQnJjNzBXNEV5?=
 =?utf-8?Q?vvccgUfjsG076AzIDjuEhI/38cqYIuPtrXR2/cqWB1DFM?=
X-MS-Exchange-AntiSpam-MessageData-1: 0V0d510FWNAHtw==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 353fa559-a5b7-4f5b-845c-08da3f4c5b30
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 19:17:20.7723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4++coFY7VM0WsOb6unntbSbiRZtFfR2tXogpjL7a+AapqGlFSRP6Re1poBaAsZeXH/dSqClRSYjfCKhv3zANg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6461
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 26 May 2022 19:17:28 -0000

--------------2zwMxFugcDVxHlSJutyh0Sb9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.
--------------2zwMxFugcDVxHlSJutyh0Sb9
Content-Type: text/plain; charset=UTF-8;
 name="0004-Cygwin-remove-some-32-bit-only-path-conversion-funct.patch"
Content-Disposition: attachment;
 filename*0="0004-Cygwin-remove-some-32-bit-only-path-conversion-funct.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxZGQzMjkxYjIyYTcyZWRjMjM0Yjg5ZTU1YjViZWU5ZWJjYzNmMTU4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
VHVlLCAyNCBNYXkgMjAyMiAxMDoyMDoyMyAtMDQwMApTdWJqZWN0OiBbUEFUQ0ggNC83XSBDeWd3
aW46IHJlbW92ZSBzb21lIDMyLWJpdCBvbmx5IHBhdGggY29udmVyc2lvbiBmdW5jdGlvbnMKCi0t
LQogd2luc3VwL2N5Z3dpbi9pbmNsdWRlL3N5cy9jeWd3aW4uaCAgICAgfCAyMyAtLS0tLS0tLS0K
IHdpbnN1cC9jeWd3aW4vcGF0aC5jYyAgICAgICAgICAgICAgICAgIHwgNjQgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KIHdpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9jeWdsb2FkLmNjIHwg
IDIgLQogMyBmaWxlcyBjaGFuZ2VkLCA4OSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5z
dXAvY3lnd2luL2luY2x1ZGUvc3lzL2N5Z3dpbi5oIGIvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL3N5
cy9jeWd3aW4uaAppbmRleCAwYzNjMmQ2NWQuLjQ5MjNjYWFjYiAxMDA2NDQKLS0tIGEvd2luc3Vw
L2N5Z3dpbi9pbmNsdWRlL3N5cy9jeWd3aW4uaAorKysgYi93aW5zdXAvY3lnd2luL2luY2x1ZGUv
c3lzL2N5Z3dpbi5oCkBAIC0yMCwyOSArMjAsNiBAQCBleHRlcm4gIkMiIHsKIAogI2RlZmluZSBf
Q1lHV0lOX1NJR05BTF9TVFJJTkcgImNZZ1NpR3cwMGYiCiAKLSNpZmRlZiBfX2kzODZfXwotLyog
REVQUkVDQVRFRCBJTlRFUkZBQ0VTLiAgVGhlc2UgYXJlIHJlc3RyaWN0ZWQgdG8gTUFYX1BBVEgg
bGVuZ3RoLgotICAgRG9uJ3QgdXNlIGluIG1vZGVybiBhcHBsaWNhdGlvbnMuICBUaGV5IGRvbid0
IGV4aXN0IG9uIHg4Nl82NC4gKi8KLWV4dGVybiBpbnQgY3lnd2luX3dpbjMyX3RvX3Bvc2l4X3Bh
dGhfbGlzdCAoY29uc3QgY2hhciAqLCBjaGFyICopCi0gIF9fYXR0cmlidXRlX18gKChfX2RlcHJl
Y2F0ZWRfXykpOwotZXh0ZXJuIGludCBjeWd3aW5fd2luMzJfdG9fcG9zaXhfcGF0aF9saXN0X2J1
Zl9zaXplIChjb25zdCBjaGFyICopCi0gIF9fYXR0cmlidXRlX18gKChfX2RlcHJlY2F0ZWRfXykp
OwotZXh0ZXJuIGludCBjeWd3aW5fcG9zaXhfdG9fd2luMzJfcGF0aF9saXN0IChjb25zdCBjaGFy
ICosIGNoYXIgKikKLSAgX19hdHRyaWJ1dGVfXyAoKF9fZGVwcmVjYXRlZF9fKSk7Ci1leHRlcm4g
aW50IGN5Z3dpbl9wb3NpeF90b193aW4zMl9wYXRoX2xpc3RfYnVmX3NpemUgKGNvbnN0IGNoYXIg
KikKLSAgX19hdHRyaWJ1dGVfXyAoKF9fZGVwcmVjYXRlZF9fKSk7Ci1leHRlcm4gaW50IGN5Z3dp
bl9jb252X3RvX3dpbjMyX3BhdGggKGNvbnN0IGNoYXIgKiwgY2hhciAqKQotICBfX2F0dHJpYnV0
ZV9fICgoX19kZXByZWNhdGVkX18pKTsKLWV4dGVybiBpbnQgY3lnd2luX2NvbnZfdG9fZnVsbF93
aW4zMl9wYXRoIChjb25zdCBjaGFyICosIGNoYXIgKikKLSAgX19hdHRyaWJ1dGVfXyAoKF9fZGVw
cmVjYXRlZF9fKSk7Ci1leHRlcm4gaW50IGN5Z3dpbl9jb252X3RvX3Bvc2l4X3BhdGggKGNvbnN0
IGNoYXIgKiwgY2hhciAqKQotICBfX2F0dHJpYnV0ZV9fICgoX19kZXByZWNhdGVkX18pKTsKLWV4
dGVybiBpbnQgY3lnd2luX2NvbnZfdG9fZnVsbF9wb3NpeF9wYXRoIChjb25zdCBjaGFyICosIGNo
YXIgKikKLSAgX19hdHRyaWJ1dGVfXyAoKF9fZGVwcmVjYXRlZF9fKSk7Ci0jZW5kaWYgLyogX19p
Mzg2X18gKi8KLQotLyogVXNlIHRoZXNlIGludGVyZmFjZXMgaW4gZmF2b3Igb2YgdGhlIGFib3Zl
LiAqLwotCiAvKiBQb3NzaWJsZSAnd2hhdCcgdmFsdWVzIGluIGNhbGxzIHRvIGN5Z3dpbl9jb252
X3BhdGgvY3lnd2luX2NyZWF0ZV9wYXRoLiAqLwogZW51bQogewpkaWZmIC0tZ2l0IGEvd2luc3Vw
L2N5Z3dpbi9wYXRoLmNjIGIvd2luc3VwL2N5Z3dpbi9wYXRoLmNjCmluZGV4IDk4ZjdhYTFkYi4u
YmQzZmZkY2U2IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL3BhdGguY2MKKysrIGIvd2luc3Vw
L2N5Z3dpbi9wYXRoLmNjCkBAIC00MDI5LDQwICs0MDI5LDYgQEAgY3lnd2luX2NyZWF0ZV9wYXRo
IChjeWd3aW5fY29udl9wYXRoX3Qgd2hhdCwgY29uc3Qgdm9pZCAqZnJvbSkKICAgcmV0dXJuIHRv
OwogfQogCi0jaWZkZWYgX19pMzg2X18KLQotZXh0ZXJuICJDIiBpbnQKLWN5Z3dpbl9jb252X3Rv
X3dpbjMyX3BhdGggKGNvbnN0IGNoYXIgKnBhdGgsIGNoYXIgKndpbjMyX3BhdGgpCi17Ci0gIHJl
dHVybiBjeWd3aW5fY29udl9wYXRoIChDQ1BfUE9TSVhfVE9fV0lOX0EgfCBDQ1BfUkVMQVRJVkUs
IHBhdGgsIHdpbjMyX3BhdGgsCi0JCQkgICBNQVhfUEFUSCk7Ci19Ci0KLWV4dGVybiAiQyIgaW50
Ci1jeWd3aW5fY29udl90b19mdWxsX3dpbjMyX3BhdGggKGNvbnN0IGNoYXIgKnBhdGgsIGNoYXIg
KndpbjMyX3BhdGgpCi17Ci0gIHJldHVybiBjeWd3aW5fY29udl9wYXRoIChDQ1BfUE9TSVhfVE9f
V0lOX0EgfCBDQ1BfQUJTT0xVVEUsIHBhdGgsIHdpbjMyX3BhdGgsCi0JCQkgICBNQVhfUEFUSCk7
Ci19Ci0KLS8qIFRoaXMgaXMgZXhwb3J0ZWQgdG8gdGhlIHdvcmxkIGFzIGN5Z3dpbl9mb28gYnkg
Y3lnd2luLmRpbi4gICovCi0KLWV4dGVybiAiQyIgaW50Ci1jeWd3aW5fY29udl90b19wb3NpeF9w
YXRoIChjb25zdCBjaGFyICpwYXRoLCBjaGFyICpwb3NpeF9wYXRoKQotewotICByZXR1cm4gY3ln
d2luX2NvbnZfcGF0aCAoQ0NQX1dJTl9BX1RPX1BPU0lYIHwgQ0NQX1JFTEFUSVZFLCBwYXRoLCBw
b3NpeF9wYXRoLAotCQkJICAgTUFYX1BBVEgpOwotfQotCi1leHRlcm4gIkMiIGludAotY3lnd2lu
X2NvbnZfdG9fZnVsbF9wb3NpeF9wYXRoIChjb25zdCBjaGFyICpwYXRoLCBjaGFyICpwb3NpeF9w
YXRoKQotewotICByZXR1cm4gY3lnd2luX2NvbnZfcGF0aCAoQ0NQX1dJTl9BX1RPX1BPU0lYIHwg
Q0NQX0FCU09MVVRFLCBwYXRoLCBwb3NpeF9wYXRoLAotCQkJICAgTUFYX1BBVEgpOwotfQotCi0j
ZW5kaWYgLyogX19pMzg2X18gKi8KLQogLyogVGhlIHJlYWxwYXRoIGZ1bmN0aW9uIGlzIHJlcXVp
cmVkIGJ5IFBPU0lYOjIwMDguICAqLwogCiBleHRlcm4gIkMiIGNoYXIgKgpAQCAtNDIxMSwzNiAr
NDE3Nyw2IEBAIGVudl9QQVRIX3RvX3Bvc2l4IChjb25zdCB2b2lkICp3aW4zMiwgdm9pZCAqcG9z
aXgsIHNpemVfdCBzaXplKQogCQkJCSAgICAgc2l6ZSwgRU5WX0NWVCkpOwogfQogCi0jaWZkZWYg
X19pMzg2X18KLQotZXh0ZXJuICJDIiBpbnQKLWN5Z3dpbl93aW4zMl90b19wb3NpeF9wYXRoX2xp
c3RfYnVmX3NpemUgKGNvbnN0IGNoYXIgKnBhdGhfbGlzdCkKLXsKLSAgcmV0dXJuIGNvbnZfcGF0
aF9saXN0X2J1Zl9zaXplIChwYXRoX2xpc3QsIHRydWUpOwotfQotCi1leHRlcm4gIkMiIGludAot
Y3lnd2luX3Bvc2l4X3RvX3dpbjMyX3BhdGhfbGlzdF9idWZfc2l6ZSAoY29uc3QgY2hhciAqcGF0
aF9saXN0KQotewotICByZXR1cm4gY29udl9wYXRoX2xpc3RfYnVmX3NpemUgKHBhdGhfbGlzdCwg
ZmFsc2UpOwotfQotCi1leHRlcm4gIkMiIGludAotY3lnd2luX3dpbjMyX3RvX3Bvc2l4X3BhdGhf
bGlzdCAoY29uc3QgY2hhciAqd2luMzIsIGNoYXIgKnBvc2l4KQotewotICByZXR1cm5fd2l0aF9l
cnJubyAoY29udl9wYXRoX2xpc3QgKHdpbjMyLCBwb3NpeCwgTUFYX1BBVEgsCi0JCSAgICAgQ0NQ
X1dJTl9BX1RPX1BPU0lYIHwgQ0NQX1JFTEFUSVZFKSk7Ci19Ci0KLWV4dGVybiAiQyIgaW50Ci1j
eWd3aW5fcG9zaXhfdG9fd2luMzJfcGF0aF9saXN0IChjb25zdCBjaGFyICpwb3NpeCwgY2hhciAq
d2luMzIpCi17Ci0gIHJldHVybl93aXRoX2Vycm5vIChjb252X3BhdGhfbGlzdCAocG9zaXgsIHdp
bjMyLCBNQVhfUEFUSCwKLQkJICAgICBDQ1BfUE9TSVhfVE9fV0lOX0EgfCBDQ1BfUkVMQVRJVkUp
KTsKLX0KLQotI2VuZGlmIC8qIF9faTM4Nl9fICovCi0KIGV4dGVybiAiQyIgc3NpemVfdAogY3ln
d2luX2NvbnZfcGF0aF9saXN0IChjeWd3aW5fY29udl9wYXRoX3Qgd2hhdCwgY29uc3Qgdm9pZCAq
ZnJvbSwgdm9pZCAqdG8sCiAJCSAgICAgICBzaXplX3Qgc2l6ZSkKZGlmZiAtLWdpdCBhL3dpbnN1
cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9jeWdsb2FkLmNjIGIvd2luc3VwL3Rlc3RzdWl0ZS93aW5z
dXAuYXBpL2N5Z2xvYWQuY2MKaW5kZXggYWQ0NTk5NjY2Li5mYWFkNWNlMGUgMTAwNjQ0Ci0tLSBh
L3dpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9jeWdsb2FkLmNjCisrKyBiL3dpbnN1cC90ZXN0
c3VpdGUvd2luc3VwLmFwaS9jeWdsb2FkLmNjCkBAIC0xNTIsOCArMTUyLDYgQEAgY3lnd2luOjpj
b25uZWN0b3I6OmNvbm5lY3RvciAoY29uc3QgY2hhciAqZGxsKQogICAvLyBQaWNrIHVwIHRoZSBm
dW5jdGlvbiBwb2ludGVycyBmb3IgdGhlIGJhc2ljIGluZnJhc3RydWN0dXJlLgogICBnZXRfc3lt
Ym9sICgiX19lcnJubyIsIF9lcnJubyk7CiAgIGdldF9zeW1ib2wgKCJzdHJlcnJvciIsIF9zdHJl
cnJvcik7Ci0gIGdldF9zeW1ib2wgKCJjeWd3aW5fY29udl90b19mdWxsX3Bvc2l4X3BhdGgiLCBf
Y29udl90b19mdWxsX3Bvc2l4X3BhdGgpOwotICBnZXRfc3ltYm9sICgiY3lnd2luX2NvbnZfdG9f
ZnVsbF93aW4zMl9wYXRoIiwgX2NvbnZfdG9fZnVsbF93aW4zMl9wYXRoKTsKIAogICAvLyBOb3Rl
IHRoYXQgeW91IG5lZWQgdG8gYmUgcnVubmluZyBhbiBpbnRlcnJ1cHRpYmxlIGN5Z3dpbiBmdW5j
dGlvbiBpZgogICAvLyB5b3Ugd2FudCB0byByZWNlaXZlIHNpZ25hbHMuICBZb3UgY2FuIHVzZSB0
aGUgc3RhbmRhcmQgc2lnbmFsKCkKLS0gCjIuMzYuMQoK

--------------2zwMxFugcDVxHlSJutyh0Sb9--
