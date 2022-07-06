Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2128.outbound.protection.outlook.com [40.107.93.128])
 by sourceware.org (Postfix) with ESMTPS id C5B213858D28
 for <cygwin-patches@cygwin.com>; Wed,  6 Jul 2022 20:25:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C5B213858D28
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRlim7BBd8Ql3Sw5KocrFEYa7HrBAbQs/XlXh+/glYIi+vPmDrnf9BX+K9nKHJI+N1OuUAo4jNnaIsSX1OmelzDiO86TgDNiJe3aKSXzpOeU6xEQ6xjSJfDsf2S3VG4sYQ2YfurDwt+hHRQyvOkgYj5l3hv9x7a/GBKUZ1/BglsNoI4i9qMTHabaqwSFQuwN+htzvdkfuBwrDxqRnIGIjKCSzoPJ9XPOgOUt0cyjuVocwuqBsLmeDVTLA3XmG6aQdsEA1SMszCJDpFL131Xi9kyabR+uGeefwLZ56qt04/JUkn6xSyU9mqynmKBAwd2q3hAxf6P8hHelELxuuPmUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twgrd1qgHrxDcIk+9wV6s8uxwXK/UvuxYUQm3rIgCxw=;
 b=lNInFsYNy8HD6hkOlWBrdcw8R+6f2pB6FUFidfTLimPZ3lRqHw+zKVZLUSnPbqL3CIHbt8k9YQb7NIhmkuNo6N9tw0itcrpuYeavHTa8mapv6TEgjHEdrNSk5awJabj9NjvRNivbZRAXiBRgfkubpKCzySMpygsyI6sBaDRHFeqCpN3aqpF4Aa7vP6FoiXbxvj+ITIdR/a+xtDz3fljUcl+km9iy4fO0yRMhOh+I+u8f8oNrQSL/wjA6Aw5WSpRlGKgjtYv+r8L3l7JI7D+xCiPS9PRlRLqMV0Mt3/srhN0lOqeyjnsrz98z1ObbrJs5BwwKuiXXX5vaEc6pDwOEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twgrd1qgHrxDcIk+9wV6s8uxwXK/UvuxYUQm3rIgCxw=;
 b=PYAaZSmW7/Om9s7Jjdx7GUUGen6E4wLeWyxLWSK43231ILoa3FcBgCImnPYitNDPFnTnf7fbTuqdd2f0HM8ULdFGfjnyUnXEwWx7EFcu/um5owwkMpw9RDeTqSroX+N4AqBufa0LWxrs9i+ueSSZX2KOwaDxzOs4BsUx7t/1Nb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by PH0PR04MB7191.namprd04.prod.outlook.com (2603:10b6:510:1c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 20:25:29 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d%2]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 20:25:29 +0000
Content-Type: multipart/mixed; boundary="------------0N3ngHEclM0iwDCiLHg1hIg0"
Message-ID: <efb21775-c0c5-768f-e1fd-d38145fb2f0b@cornell.edu>
Date: Wed, 6 Jul 2022 16:25:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH] Cygwin: redefine some macros for Linux compatibility
X-ClientProxiedBy: MN2PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:208:236::11) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6139fce-e38e-404e-d1c9-08da5f8dab38
X-MS-TrafficTypeDiagnostic: PH0PR04MB7191:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFW1ys544rvUQC4Sjf0fvxYX//Bk6GiFhh5sVtD/DN86frSplfotsMHxNKgLwFHIiJ5W6X1BU8aQ5GgnbiRn+iVkLDrN/8e/6IWKsKsxPtcd3cIeC1m2K6rp7TrIeG8pX35QDkvloZkvfAMTbgQgsSIwfq4pIhdAEvevQoiEfJBGKeBLOFJjEmVS0DQDN0QQ7ZKxuC6QA98Qem49uigTPHFPTvQxwMzoeG2rKlU6kZL75E32hB71284bhGplow4i0MMt7hdbIdQfAKRWrWgBCW3Ca4GwJEysW9gOKbGrBs6XT/fY398vHTY1hMZacYhjBBi4ZgOFx3DBgUdxRKhLQGB/y29ffiPOH9VTqGxSClVsIYvrU7Xgtodf1WknMHqY7rx594MEBp2Zwnrl+hNGERlNzU9kEsOvvAJo2FywhlsL11VbrNsgWr1yBw7xSnezBuOGqA7F3+vpIFLWtQNQVpuZZjCaBdCEGnEqB6V3SplepTQo3vjxtDNA71sXF2bMGbfXmNGBdhwenbVpzuGuIZvLTC+Y4dg/n37q6qWjK6e9CFl2U+E7zi52+qJXxCC5vDc1cSPcEGaNkw3BhixNa4cqA59nCxX0V+h16odl5MuyVwkRhFNHGoFsVncKMcV9Xc0+PohknK5C1WTgMkdor+ze0dhLVkjIeL6qd1qeYkNv9IyOxMbAebZ4428UHyS5sybLFxI9k4Jd76owAhjo8K1D986BQUIKDwdMp2U+Irjc+zLiZ0BWKcNSDylF8cnFeJAdb/lrwD2A+SBvJWRzhm8HUIuNBm3zkW66u6s7+twFrwtXdPtWoZaz5a7OMZq49ecvq7qkIkH5f4LwSbsYdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(41300700001)(8936002)(478600001)(31696002)(86362001)(6486002)(5660300002)(235185007)(2906002)(38100700002)(75432002)(316002)(786003)(66946007)(2616005)(36756003)(66476007)(186003)(66556008)(8676002)(83380400001)(41320700001)(33964004)(6512007)(31686004)(6506007)(6916009)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1d1RW02bXJwWVlMRmtDY1hBYWg4Wk14Vnc4UlFmT2h2ckZmZXhOSEpEUVRL?=
 =?utf-8?B?N3Q2YjlEbFJhSlpjdGRtSGFpbFhtUE1Yc0h2Z0kzUDNVOG1BMzV2d2NmYU41?=
 =?utf-8?B?K1RvY2pBMklKSUcrUFJHM21GbHpLUE16VEVpcGhtdlFYSjFZclFucm0yN2ls?=
 =?utf-8?B?Y3daVDVuRDRFZ2Viay90U2t4a3FpUlVhUlc3dXRTalBFS0ppcGJWMEpoRjdX?=
 =?utf-8?B?eU4wVjlDSWpKVi82LzNSZkZPSlpXTVloWXUxSjJlTElGREc3VVZlWlNLZ3F6?=
 =?utf-8?B?ZHNPKzN0WGNnY0lLMjd2OG9mRmxFNVVEeXBxZGovcXlTckg0TisxQ3RwRFBq?=
 =?utf-8?B?bFpGOTltM0NTaHlreWM2eURxdHQ2andIckdOTHVHMWtlWXBDK2RiZ3ZMckg4?=
 =?utf-8?B?emRXRTYwNzcwMmtKZ2xvd1FnT2t0K0JCeTcvVTZCdmRtRFRRTTBtZ2UxSVUz?=
 =?utf-8?B?MGcxM2h1dG5ZbU5CTmZtZjhLSk43ZmF6NXpPV0Z1MnpjekRiWEFkSVR4VUlG?=
 =?utf-8?B?QzQ1a2RuN2Y0Nkdnc2hBb25abU52c2dDeUJNUnRZRHl0ZmV2Q1dWSE9mRENk?=
 =?utf-8?B?ZkxQaUs3cHNsSkFmU0h3QlgrSFFNRXlkMXpyTTBZQkZWNFpmZ3JsWFNGczNF?=
 =?utf-8?B?SDVNR2VRdE5Oa2luRlUwYnZkeXJBT2VVdVYrMlorMWtlQ2w5dCtOajNFc2tp?=
 =?utf-8?B?L0ZHcEQ0aERocGNQdzRyUkphbldjeCtJWlBYc2hhVjNrZjB2UlN2eURTQWU2?=
 =?utf-8?B?WFFWOWhtZnl5alVPOE10c005UHJaUnN0RWJPU3ZHSmtvNUl3U2VOYVZvYm1L?=
 =?utf-8?B?SHRUeHdFcnNTbmlpK3N2SjJYN3ZTVEs2RUc2b0FxRUdIK1NuSGJPWHlTREpt?=
 =?utf-8?B?QkROaFNSVEQrSVJvTWFVdlhLcDBNUUdMSkhqeXdSWVZyaE1ZUTlzOWU3NFFs?=
 =?utf-8?B?U3J4MkFXZ2VzK2RqeitwVGRxbU5vMlVjT25nQlNabmNjZVhGY1I1YytKN0xI?=
 =?utf-8?B?L3A5NmdqZGlHa0NTcXM1RDN4RVFZN041Zmt3YlM2TmtEQVFiZ013aFVNNUl2?=
 =?utf-8?B?MTdjV0cxcHdMNnRnRDYvNTUyWk5JRjAvQ3RpYTFrZ2IwdmdYZzFHUWQ2aElT?=
 =?utf-8?B?Tmt4dEZTcnFmclVGTTMvbDdFQkVML3VEUjk3RC81S2NEeVNhMi82Um4zaDYw?=
 =?utf-8?B?OHU0KzFzYjlKcjQraDdrTHFsZjRGdmxkUFl0UWJmelZkOTZBUElDZlNRdzFq?=
 =?utf-8?B?MkxRVFJCQjZ5SW1YbWc2UHZlZ2crQ2piUDlYeWRsQXNjK0pTekZYVUlQT3ox?=
 =?utf-8?B?NEp6WnhJbzNySWp6NUxwczdaZjhxN1dkR3NSUmRTOUU3SzdVN1lNYzIyQ3oz?=
 =?utf-8?B?NDVHNVRqak1jOGdWWURLZDYrVDVsNHZJc1hJTHNEOVUyamFNeWcvRXRZUDZo?=
 =?utf-8?B?bjBpbXphRzVCTnJFd3Z4MFdwVXRvYythdVhqR0xRbmhpTFJ4UFdLU2hlRkt5?=
 =?utf-8?B?a1U3ZmJsR2lnS0lwTy81TUF5NXhaSGNWS0NoclRmSVpLNU9LblFNZDFOdzIx?=
 =?utf-8?B?TFoyYTg1bjRndHlRdXdhd2NNZWRyc0p1VUNPWlVYakpJMmN5a3Q5U1o4bldW?=
 =?utf-8?B?VDk3cXVBUTdZaXFZeW1rWkg0c0Focnp3b3ZjOUsvTGJsMVd4NEVVVG5EVm4x?=
 =?utf-8?B?eG9GTHlaNWYxdHdFNGpPN3U5WUlOYStqVXEzdDFNMTlrQVBTVDM2MHNoV0ho?=
 =?utf-8?B?a3doZXFWRityLzJweVo0b0JGbDhkRzNaa3BLSTBZVThNYlc5NE1KL2NGNnJY?=
 =?utf-8?B?VlA4OFpmTjhyZlpqbTBocC9uYzdQRjdqOFlqK280aXV1ZHpvYzNQSC85SXpL?=
 =?utf-8?B?a3EySG9yclpaTExnYVZhd2kvTnFFbDZTQ201eS9ERGx2dTFVdHFnQzRKb2ts?=
 =?utf-8?B?Y2xlSU0rZml2TjZLbzhKOERCOHNSbzZiMjVNY3lYNXg0RTFlNy9MejRYYW4r?=
 =?utf-8?B?RGN5eUZsODJ2RUpYRE53YnFtMkpTRDY4K3dDaWRIRjB3SitUbVprMWg5dmlI?=
 =?utf-8?B?NERHcStPa1V4L05hdGFhQjM4amtyL3g3bTBYeGswV3UzbkhvVlhPc0NxU2RB?=
 =?utf-8?B?NUtGWkdFdWw2d2RSQzJDdWZ5NTBOamcrcHlqSnhOS25vVkZnMmR0aHBvbHNv?=
 =?utf-8?Q?ONVoIkx6H4loI29ANwY2mtViOZfrVyVqP/MuCFvX0G0N?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a6139fce-e38e-404e-d1c9-08da5f8dab38
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:25:29.5564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHdiPNLPHhFHdqdUzZGrnfq6RczXpl9nJr8fDBC9UTrPQCZZg2XZO9dC6Y+HmJe3Ube26Vt42jhYfL2QMnoMfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7191
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
X-List-Received-Date: Wed, 06 Jul 2022 20:25:33 -0000

--------------0N3ngHEclM0iwDCiLHg1hIg0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.

I wasn't sure whether the API bump was warranted for such a trivial change.  But 
the fact is that some programs compiled prior to the patch will behave 
differently if they are recompiled after the patch.  For example, emacs limits 
the number of open subprocesses to FD_SETSIZE, so this number will change when 
emacs is recompiled for Cygwin 3.4.0.  Is that a good enough reason to bump the API?

Ken
--------------0N3ngHEclM0iwDCiLHg1hIg0
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-redefine-some-macros-for-Linux-compatibility.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-redefine-some-macros-for-Linux-compatibility.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSA2ZDZjMWVkMzU2ZTNlOGYzOWFhOWI2NDQ3OTgyZjNmY2NiZGFiZmFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
V2VkLCA2IEp1bCAyMDIyIDE0OjQzOjE2IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBy
ZWRlZmluZSBzb21lIG1hY3JvcyBmb3IgTGludXggY29tcGF0aWJpbGl0eQoKRGVmaW5lIEZEX1NF
VFNJWkUgKDxzeXMvc2VsZWN0Lmg+KSB0byBiZSAxMDI0IGJ5IGRlZmF1bHQsIGFuZCBkZWZpbmUK
Tk9GSUxFICg8c3lzL3BhcmFtLmg+KSB0byBiZSBPUEVOX01BWCAoPT0gMzIwMCkgYnkgZGVmYXVs
dC4KClJlbW92ZSB0aGUgY29tbWVudCBpbiA8c3lzL3NlbGVjdC5oPiB0aGF0IEZEX1NFVFNJWkUg
c2hvdWxkIGJlID49Ck5PRklMRS4KCkJ1bXAgQVBJIG1pbm9yLgoKQWRkcmVzc2VzOiBodHRwczov
L2N5Z3dpbi5jb20vcGlwZXJtYWlsL2N5Z3dpbi8yMDIyLUp1bHkvMjUxODM5Lmh0bWwKLS0tCiBu
ZXdsaWIvbGliYy9pbmNsdWRlL3N5cy9zZWxlY3QuaCAgICAgICB8IDEwICsrKysrKystLS0KIHdp
bnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vdmVyc2lvbi5oIHwgIDMgKystCiB3aW5zdXAvY3ln
d2luL2luY2x1ZGUvc3lzL3BhcmFtLmggICAgICB8ICA0ICsrKy0KIHdpbnN1cC9jeWd3aW4vcmVs
ZWFzZS8zLjQuMCAgICAgICAgICAgIHwgIDQgKysrKwogd2luc3VwL2RvYy9uZXctZmVhdHVyZXMu
eG1sICAgICAgICAgICAgfCAgNSArKysrKwogNSBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ld2xpYi9saWJjL2luY2x1ZGUvc3lz
L3NlbGVjdC5oIGIvbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvc2VsZWN0LmgKaW5kZXggYTVjZDZj
M2ZlLi45M2QwYjc5YmYgMTAwNjQ0Ci0tLSBhL25ld2xpYi9saWJjL2luY2x1ZGUvc3lzL3NlbGVj
dC5oCisrKyBiL25ld2xpYi9saWJjL2luY2x1ZGUvc3lzL3NlbGVjdC5oCkBAIC0yNSwxMCArMjUs
MTQgQEAgdHlwZWRlZglfX3NpZ3NldF90CXNpZ3NldF90OwogICogU2VsZWN0IHVzZXMgYml0IG1h
c2tzIG9mIGZpbGUgZGVzY3JpcHRvcnMgaW4gbG9uZ3MuCiAgKiBUaGVzZSBtYWNyb3MgbWFuaXB1
bGF0ZSBzdWNoIGJpdCBmaWVsZHMgKHRoZSBmaWxlc3lzdGVtIG1hY3JvcyB1c2UgY2hhcnMpLgog
ICogRkRfU0VUU0laRSBtYXkgYmUgZGVmaW5lZCBieSB0aGUgdXNlciwgYnV0IHRoZSBkZWZhdWx0
IGhlcmUKLSAqIHNob3VsZCBiZSA+PSBOT0ZJTEUgKHBhcmFtLmgpLgorICogc2hvdWxkIGJlIGVu
b3VnaCBmb3IgbW9zdCB1c2VzLgogICovCi0jaWZuZGVmCUZEX1NFVFNJWkUKLSNkZWZpbmUJRkRf
U0VUU0laRQk2NAorI2lmbmRlZiBGRF9TRVRTSVpFCisjIGlmZGVmIF9fQ1lHV0lOX18KKyMgIGRl
ZmluZSBGRF9TRVRTSVpFCTEwMjQKKyMgZWxzZQorIyAgZGVmaW5lIEZEX1NFVFNJWkUJNjQKKyMg
ZW5kaWYKICNlbmRpZgogCiB0eXBlZGVmIHVuc2lnbmVkIGxvbmcJX19mZF9tYXNrOwpkaWZmIC0t
Z2l0IGEvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dpbi92ZXJzaW9uLmggYi93aW5zdXAvY3ln
d2luL2luY2x1ZGUvY3lnd2luL3ZlcnNpb24uaAppbmRleCA2ZjY1YTEyOTkuLmE1ZDM4ZjM3YSAx
MDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dpbi92ZXJzaW9uLmgKKysrIGIv
d2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dpbi92ZXJzaW9uLmgKQEAgLTUxNywxMiArNTE3LDEz
IEBAIGRldGFpbHMuICovCiAgICAgICAgcHRocmVhZF9yd2xvY2tfY2xvY2tyZGxvY2ssIHB0aHJl
YWRfcndsb2NrX2Nsb2Nrd3Jsb2NrLAogICAgICAgIHNlbV9jbG9ja3dhaXQsIHNpZzJzdHIsIHN0
cjJzaWcuCiAgIDM0MjogUmVtb3ZlIGNsZWFudXBfZ2x1ZS4KKyAgMzQzOiBDaGFuZ2UgRkRfU0VU
U0laRSBhbmQgTk9GSUxFLgogCiAgIE5vdGUgdGhhdCB3ZSBmb3Jnb3QgdG8gYnVtcCB0aGUgYXBp
IGZvciB1YWxhcm0sIHN0cnRvbGwsIHN0cnRvdWxsLAogICBzaWdhbHRzdGFjaywgc2V0aG9zdG5h
bWUuICovCiAKICNkZWZpbmUgQ1lHV0lOX1ZFUlNJT05fQVBJX01BSk9SIDAKLSNkZWZpbmUgQ1lH
V0lOX1ZFUlNJT05fQVBJX01JTk9SIDM0MgorI2RlZmluZSBDWUdXSU5fVkVSU0lPTl9BUElfTUlO
T1IgMzQzCiAKIC8qIFRoZXJlIGlzIGFsc28gYSBjb21wYXRpYml0eSB2ZXJzaW9uIG51bWJlciBh
c3NvY2lhdGVkIHdpdGggdGhlIHNoYXJlZCBtZW1vcnkKICAgIHJlZ2lvbnMuICBJdCBpcyBpbmNy
ZW1lbnRlZCB3aGVuIGluY29tcGF0aWJsZSBjaGFuZ2VzIGFyZSBtYWRlIHRvIHRoZSBzaGFyZWQK
ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9zeXMvcGFyYW0uaCBiL3dpbnN1cC9j
eWd3aW4vaW5jbHVkZS9zeXMvcGFyYW0uaAppbmRleCA2M2RlNzI2ZTYuLjc0MjU5OWI4YiAxMDA2
NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL3N5cy9wYXJhbS5oCisrKyBiL3dpbnN1cC9j
eWd3aW4vaW5jbHVkZS9zeXMvcGFyYW0uaApAQCAtMTcsNyArMTcsOSBAQAogLyogTWF4IG51bWJl
ciBvZiBvcGVuIGZpbGVzLiAgVGhlIFBvc2l4IHZlcnNpb24gaXMgT1BFTl9NQVguICAqLwogLyog
TnVtYmVyIG9mIGZkcyBpcyB2aXJ0dWFsbHkgdW5saW1pdGVkIGluIGN5Z3dpbiwgYnV0IHdlIG11
c3QgcHJvdmlkZQogICAgc29tZSByZWFzb25hYmxlIHZhbHVlIGZvciBQb3NpeCBjb25mb3JtYW5j
ZSAqLwotI2RlZmluZSBOT0ZJTEUJCTgxOTIKKyNpZiAhZGVmaW5lZCBOT0ZJTEUgJiYgZGVmaW5l
ZCBPUEVOX01BWAorIyBkZWZpbmUgTk9GSUxFICAgICAgICAgT1BFTl9NQVgKKyNlbmRpZgogCiAv
KiBNYXggbnVtYmVyIG9mIGdyb3VwczsgbXVzdCBrZWVwIGluIHN5bmMgd2l0aCBOR1JPVVBTX01B
WCBpbiBsaW1pdHMuaCAqLwogI2RlZmluZSBOR1JPVVBTCQlOR1JPVVBTX01BWApkaWZmIC0tZ2l0
IGEvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuNC4wIGIvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMu
NC4wCmluZGV4IGYzMTA5MTJjOS4uMDhkMjhkNTEwIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2lu
L3JlbGVhc2UvMy40LjAKKysrIGIvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuNC4wCkBAIC0yNSw2
ICsyNSwxMCBAQCBXaGF0IGNoYW5nZWQ6CiAgIHRoZSBjdXJyZW50IGRpcmVjdG9yeSBhcyBMaW51
eCBkb2VzLgogICBBZGRyZXNzZXM6IGh0dHBzOi8vY3lnd2luLmNvbS9waXBlcm1haWwvY3lnd2lu
LzIwMjItSnVuZS8yNTE3MzAuaHRtbAogCistIFRoZSBkZWZhdWx0IHZhbHVlcyBvZiBGRF9TRVRT
SVpFIGFuZCBOT0ZJTEUgYXJlIG5vdyAxMDI0IGFuZCAzMjAwLAorICByZXNwZWN0aXZlbHkuCisg
IEFkZHJlc3NlczogaHR0cHM6Ly9jeWd3aW4uY29tL3BpcGVybWFpbC9jeWd3aW4vMjAyMi1KdWx5
LzI1MTgzOS5odG1sCisKIAogQnVnIEZpeGVzCiAtLS0tLS0tLS0KZGlmZiAtLWdpdCBhL3dpbnN1
cC9kb2MvbmV3LWZlYXR1cmVzLnhtbCBiL3dpbnN1cC9kb2MvbmV3LWZlYXR1cmVzLnhtbAppbmRl
eCAwMTQ5YTAyN2EuLjQ2ZGMwMjhmMSAxMDA2NDQKLS0tIGEvd2luc3VwL2RvYy9uZXctZmVhdHVy
ZXMueG1sCisrKyBiL3dpbnN1cC9kb2MvbmV3LWZlYXR1cmVzLnhtbApAQCAtMzMsNiArMzMsMTEg
QEAgSGFuZGxlIFVEUF9TRUdNRU5UIGFuZCBVRFBfR1JPIHNvY2tldCBvcHRpb25zLgogVGhlIHN0
ZGlvIGlucHV0IGZ1bmN0aW9ucyBubyBsb25nZXIgdHJ5IGFnYWluIHRvIHJlYWQgYWZ0ZXIgRU9G
LgogPC9wYXJhPjwvbGlzdGl0ZW0+CiAKKzxsaXN0aXRlbT48cGFyYT4KK1RoZSBkZWZhdWx0IHZh
bHVlcyBvZiBGRF9TRVRTSVpFIGFuZCBOT0ZJTEUgYXJlIG5vdyAxMDI0IGFuZCAzMjAwLAorcmVz
cGVjdGl2ZWx5LgorPC9wYXJhPjwvbGlzdGl0ZW0+CisKIDwvaXRlbWl6ZWRsaXN0PgogCiA8L3Nl
Y3QyPgotLSAKMi4zNi4xCgo=

--------------0N3ngHEclM0iwDCiLHg1hIg0--
