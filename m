Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::715])
 by sourceware.org (Postfix) with ESMTPS id AC19E383600C
 for <cygwin-patches@cygwin.com>; Thu, 26 May 2022 19:17:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AC19E383600C
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDMr6jIcdwk7EW4TahvjCiGC6CjJ4HcmjNiGz+c//+7noIMY2ZC+RvL5HzGw9n3NNO3oLq4nTFk9fg0UPpCl1yy/oepS+4fq5a5xfRRBWlGo/WwrxOSzqqPXc1kDcTNjYIwFGrTM9fQ3DsHvTKGWQsSXOE4+zxCND4iWY7BWcZaYpqntXvKQrdSMcz5sNHvYDkN+AIVJBxACYzentVcbIYPCmLAflBEgFgpVzjPnxu/oabC75SBinwhn0IQUHiEB2lNB6dpeBql4gea0ByiyOfDr4yy2KLlg6dEpTBJqL1DXLZ4+1z2uy7ezf8XdVf4u5g2D4ndwKHt5KyPCg1l/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lfm03wk0Li/MJeSwKaYj741Zu79v7IlKMBtwpzpSmK0=;
 b=iVHRCgHIHSyGKNCf7go0yPhMT6kM/Wr1n2PMM0hq6YUCec3RNrRAw8MzqRcA430IwTS9sU6AbcdqabzbEQ+W96DMtl0/RVwu2WOC4uQxQDHuzaZOBOyLCSPpRtZrZ90rDzkebjrPQw8K7P1kqTaJeaUefp1oH5IVeg8zWNqvtNhqWkAkG1rbNZn6X3TCDVtbN7lLs2wiZ3gxmOrVaGSknBzzEQC7UG71Hkq2Vo6sqolXJiVq4UnHbsMPyn14lh7hJuYvP0T8rDd4R31x0F46yDOU/c2nOaPnW4y4/itrdRnVZ9nkfA6tmITJQ7nX0dOzySNrgVovG9t+RrhuhYBAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lfm03wk0Li/MJeSwKaYj741Zu79v7IlKMBtwpzpSmK0=;
 b=Bn1v1n9GfikTQ+rIwsr2k39JgbD8AuluEHp12lwP5BIF92Vkvbo7NwtCMaDdUaI3Zzq3+0RD9KOprlCAmtIB5QLpCr2G9X7mtvuJ/zLjGwPzeXos6DCAEI54SvLvLvL0C+bF6Bq07/Pp99AoRNs7RIaZih3+CdOYCjjuBs92T6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by MN2PR04MB6461.namprd04.prod.outlook.com (2603:10b6:208:1a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 19:17:35 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::ed45:6a5d:b109:673e]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::ed45:6a5d:b109:673e%6]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 19:17:35 +0000
Content-Type: multipart/mixed; boundary="------------x89ZPMGY4BqkdZldK8FAxx6p"
Message-ID: <fffabfbd-d305-4958-9c1e-f3b00b9097ec@cornell.edu>
Date: Thu, 26 May 2022 15:17:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH 6/7] Cygwin: remove 32-bit only clipboard code
X-ClientProxiedBy: MN2PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:208:120::21) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4e27a89-3ca3-4e52-f6a7-08da3f4c63a9
X-MS-TrafficTypeDiagnostic: MN2PR04MB6461:EE_
X-Microsoft-Antispam-PRVS: <MN2PR04MB646115C5786A9D59D5B28680D8D99@MN2PR04MB6461.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yWa3Ix1bq+JRQN3AJtpg+RbO4TMZTudEcGLAfXhAkrXqpP1o5iw2lnAlyAmYbWwsmKoq6PY0F11RKTeMgq7XMo2HfYUkrRZ0OAXXVQsxITYTesTNaedKYL94C8j5GQYj0PdfEYTnsKybNv1quYsBXwEfmhWr3sZ3zjZHli5es5EHf2zXzksUAoPZ4DMmHot4mTSokliu5Rb2AbRQA/KIfn98Ziz8Be527x41kPlTdna1vBdUffTcTnQ0qoBI/LFOXc9cTWyjUvjdjn3FBu94RKh8oTNVtQNgeLFYCSPLqGf8oGJ+0k4g0j/PZR7mq2QH8YCvxH7ER5IcuUsNxBSKjzZJBFAmj4PFvntuWRlBEHg3dP/U//kxTniheGjq9p8cgDlb+EAscEyOb350EjmDh5lOto8cCJlG8WIE7FU+O3YzAIa5qtD/ZDjIr9Q4e6BRMs3+2HCXoTcX6i7nG/MTl9+7egn+qB+hYJ4oTgdiLHGGFd0+09cyoN/+cOzr+pL8gt5gmZih56fWl6Q7uKua+2eMaQtzKH0vsM/ttE8XI9LTFKWIV8B7A4Piv8IlVqbM+G6i7bw6KiZWcqOGyRk8o/8/7NyIhblSaxw993Q+KCGeFffgtWY40ZZbwTgv8VZfJ0PUo0Y+lgOeaKHfn06uBfMlug+hsZtgaT6wor5/K8Y5BszmdVG4i3A0qJ9fFBv1IeCBLjN+6BXfaDQfjD/7lIejZSn+BCYVqqpuCjknX8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(186003)(31696002)(508600001)(33964004)(86362001)(6486002)(2906002)(6506007)(2616005)(235185007)(6512007)(8936002)(19618925003)(786003)(316002)(36756003)(564344004)(66946007)(66476007)(66556008)(8676002)(6916009)(31686004)(75432002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1BiNkJLdkxuRktFdkRCZVhhT0VkUFNUeDY2VGgxZzR5KzRldTVFV0s4RXBs?=
 =?utf-8?B?SDRSSkFhU2hQamdHcnN3ZDdsZkNWcWh1ZTgxZkNiaksvcnFDVDk4d0piQWVu?=
 =?utf-8?B?M2hTVFRLMFhrODFFYVUrcjV5a3lEelFCemNMV01NS00xTENMemFLWXFRclFz?=
 =?utf-8?B?aGtMeHo0cDkyVDVGZGZjd2MvZ2lCc0pGcW9JLzZjS244WUdDamZRaXc4T1hN?=
 =?utf-8?B?UEViM0RVUlRuay9rTVBzWmpaK0hwRGtoT0lJZURHQWJ1ckQrdlVJMkllVWN2?=
 =?utf-8?B?QkhPZThnTU0wbVZqMDNxVDVQSnN3SlpyM3kzY04zK1VMYXBXdkMzNi9LZUN4?=
 =?utf-8?B?QWwzK1Jyb1hqam9iaDdwL1dFdWxyZlJObG5EcjdnQjNEaDNEOXFjWS9meWhJ?=
 =?utf-8?B?NGhrVXdYZXFRaVk1UXhTWXVyYzBSdEFpM0FkZVU1c1hscEUzNlk3NkdiakQr?=
 =?utf-8?B?d0pUWWVyRVVOMXQ3L0JxVWFxc0RxZzVLSWxUZnVGNEJJU080cjcvTGxXT0FE?=
 =?utf-8?B?OXFGemJ5YnZjbm1CcHhNZkNWcE9DTUVxdkhmalNDMnRhMDU2K1YrMHRnbWh4?=
 =?utf-8?B?ZEcvQnMwY3MvbnRMQmlTMmZKRE5nM3dBSTZnUWIydmNIeTJsNVRQb3YyQnly?=
 =?utf-8?B?SENHWXp6UXRjcUZvQzBWRGhCaFVCdnIyS2tWQTMzb2tLZkU1aURDMGdGRmc3?=
 =?utf-8?B?SGYyRllWTEJiMGlVQ2EzZ0tCN05VZDBSZENMYVVWcUtoWG1DTlZGNmNhQ3dV?=
 =?utf-8?B?SFAzeFNySnhKcnpOa2Y1M2JRNWVGOVpmZTR1Z29vakU4Q0xodnJVRGhMTXMv?=
 =?utf-8?B?UmNvNjN4M1BXU01aT29PNGMrRFhtV1NKZzNzYkIvK2J0YmlQdFl6RERSaTJT?=
 =?utf-8?B?T3VveW1haUVjRGVudnAzYlhHY3VobXZvNW52WlY0UDUweS9uNDgvdUtQa2Iy?=
 =?utf-8?B?UmZnaDlJdXpJekNOcDJqOEU2U2lYd3ZWOGNad3JqR0JEUFV0MzRjYUdoVU1V?=
 =?utf-8?B?MjQ3ZkZacmdJZHNnRGhDazdlWFRIdkFtZmw2cmlwMENLOG1hQkNuc2ZFNEFC?=
 =?utf-8?B?Mjlta3hwZFJYWGo2MHJaRmpwZEZpTEZZQXVkV0VHKzhaNldQWnVMNTdPZ1RQ?=
 =?utf-8?B?ZWNRamlQTGZSMW5MR2d0RWhYcG1sRlZJQ2Q3cHFTRGtnaUdqMGI1bjFUVXQx?=
 =?utf-8?B?ZnB6cFcvWDdhcUQ5czBNRVFJTFZWVWh1bmRJejRPSTNlRVk1c0dIcERjQjFM?=
 =?utf-8?B?ZkF6MlppYkU1cEhrUjZ0V3RFM2NNSjR3K0NkMjlFZjM1eGs5a1VoK09hWnp0?=
 =?utf-8?B?dm5mMnVDRE5nSlNqNnhXYkF1QzVxelZwSmFZVUEwakh2VWxMRHI2N2cxMnp6?=
 =?utf-8?B?SzNWcTFkcC9zQUxuVGEvU1ZXZUhHcVdxb1RTTGV1YmdGUVhNbm9Dd2g5VUVL?=
 =?utf-8?B?R3I0MElheHFtcVJ6bWE3djdiWXNTOEtIYmFvZnBkWFBKNU00V2Q2ckovNkxB?=
 =?utf-8?B?dm51WFRlckpXcEZ0Yk5SSEZLYkMyRDRIK3ZOVVllS0wrak4yeTRLcFN3Wk41?=
 =?utf-8?B?VDg2VHZOTjlrSTRSQWNNMWZ1cEQ1ZEZRQzlNZWxtNWY5UlNlVlRSTGVzSHNm?=
 =?utf-8?B?RmsxR2VjTmZ4MjB4Z0t1RUFxd0E5NWpxblR3bTlMd01RYlVmWU1jRUVWcTlr?=
 =?utf-8?B?b2FNbUJBOG54c1Z0WUIvbWdZclZNY0NLTGpGTURYdkEzU2dRWkRFUUo3SGZt?=
 =?utf-8?B?dXVxU1MyekVPS3hGTGhWejdYVjhCRytFRThQRlo2MW9RUkRXcVArK3BoNFFx?=
 =?utf-8?B?NnVRYzYwWmRVTHZ4dzF5UXgvZG84b3lWNzYxUVU5aERPMHRmQU1NTzNKK2RX?=
 =?utf-8?B?bUxYSVVlUXMrRkd6ZnRSZDlhU1hMVC92cU5LdytMcURsYXJzZFNIRnprcHZh?=
 =?utf-8?B?Q2hmckh5QjMxQWluNEhtSjFEYmxJdUZIb2xxK2RXUFZldGZqS1JSa2hVYTl5?=
 =?utf-8?B?VENyOGI2Y1ZrMUdjZEZUUGFCTHkxYWJnVXpFalY1WXJidUFZSWJxcUxtd2wv?=
 =?utf-8?B?dnRvSjFPYUhOZHZQb3hya3A2eDNSUnpmYWlaaW1QcFpDb2hva0J3YmxSSmVj?=
 =?utf-8?B?ekRtQUhTS29TbzIvanUvMW4vQ0FmNU9DaC8ydE41MXFaempPRlRFL3pNeHFZ?=
 =?utf-8?B?aDlQcEtZamdwcFlQUjFXSElnY1UvR0FwNTRjWHZ6NXdJZWxrODV5TytvRDFa?=
 =?utf-8?B?bmtWbU1OTXB2cEwyWDU5Ulp5TVpMRERIdzh4c2JMRVJrTUM1clg4RnJwcmZI?=
 =?utf-8?B?a3l1OW96bDRnSGIyVk1UNFhYT3JIN3dKUkVnVXh5Y2t3NGZ4dEpjSTYzR3V4?=
 =?utf-8?Q?v5hXdiMAjJTpqqDsCVdPqkJky5fJWo5HI/SI3sIp1YwWF?=
X-MS-Exchange-AntiSpam-MessageData-1: mm0BAGowSEpfOg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e27a89-3ca3-4e52-f6a7-08da3f4c63a9
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 19:17:35.0212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67S1QgDqpTSZVKB/Kd0QJtgzUfyFpSlzRxq9o+FvVCBTw69j0+EncZk2nz0DIsZynNPlQwE8Ys9AuAPHqQY9nA==
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
X-List-Received-Date: Thu, 26 May 2022 19:17:38 -0000

--------------x89ZPMGY4BqkdZldK8FAxx6p
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.
--------------x89ZPMGY4BqkdZldK8FAxx6p
Content-Type: text/plain; charset=UTF-8;
 name="0006-Cygwin-remove-32-bit-only-clipboard-code.patch"
Content-Disposition: attachment;
 filename="0006-Cygwin-remove-32-bit-only-clipboard-code.patch"
Content-Transfer-Encoding: base64

RnJvbSBjZmExNDgzNzBjYjUxYzY4NzRkNTFlZTk3Zjc5ZDA0ZjZlNTQ3Y2E5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
VHVlLCAyNCBNYXkgMjAyMiAxMDoyNTowNiAtMDQwMApTdWJqZWN0OiBbUEFUQ0ggNi83XSBDeWd3
aW46IHJlbW92ZSAzMi1iaXQgb25seSBjbGlwYm9hcmQgY29kZQoKLS0tCiB3aW5zdXAvY3lnd2lu
L2ZoYW5kbGVyX2NsaXBib2FyZC5jYyAgIHwgMTYgLS0tLS0tLS0tLS0tLS0tLQogd2luc3VwL2N5
Z3dpbi9pbmNsdWRlL3N5cy9jbGlwYm9hcmQuaCB8IDIzICsrKystLS0tLS0tLS0tLS0tLS0tLS0t
CiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMzUgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9jbGlwYm9hcmQuY2MgYi93aW5zdXAvY3ln
d2luL2ZoYW5kbGVyX2NsaXBib2FyZC5jYwppbmRleCA5NTE1Nzk1ZTQuLmFlNmRlNDU1MSAxMDA2
NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9jbGlwYm9hcmQuY2MKKysrIGIvd2luc3Vw
L2N5Z3dpbi9maGFuZGxlcl9jbGlwYm9hcmQuY2MKQEAgLTY4LDE0ICs2OCw2IEBAIGZoYW5kbGVy
X2Rldl9jbGlwYm9hcmQ6OnNldF9jbGlwYm9hcmQgKGNvbnN0IHZvaWQgKmJ1Ziwgc2l6ZV90IGxl
bikKICAgICAgIGNsaXBidWYgPSAoY3lnY2JfdCAqKSBHbG9iYWxMb2NrIChobWVtKTsKIAogICAg
ICAgY2xvY2tfZ2V0dGltZSAoQ0xPQ0tfUkVBTFRJTUUsICZjbGlwYnVmLT50cyk7Ci0jaWZkZWYg
X194ODZfNjRfXwotICAgICAgLyogdHMgb3ZlcmxheXMgY2Jfc2VjIGFuZCBjYl9uc2VjIHN1Y2gg
dGhhdCBubyBjb252ZXJzaW9uIGlzIG5lZWRlZCAqLwotI2VsaWYgX19pMzg2X18KLSAgICAgIC8q
IEV4cGFuZCAzMi1iaXQgdGltZXNwZWMgbGF5b3V0IHRvIDY0LWJpdCBsYXlvdXQuCi0gICAgICAg
ICBOT1RFOiBTdGVwcyBtdXN0IGJlIGRvbmUgaW4gdGhpcyBvcmRlciB0byBhdm9pZCBkYXRhIGxv
c3MuICovCi0gICAgICBjbGlwYnVmLT5jYl9uc2VjID0gY2xpcGJ1Zi0+dHMudHZfbnNlYzsKLSAg
ICAgIGNsaXBidWYtPmNiX3NlYyAgPSBjbGlwYnVmLT50cy50dl9zZWM7Ci0jZW5kaWYKICAgICAg
IGNsaXBidWYtPmNiX3NpemUgPSBsZW47CiAgICAgICBtZW1jcHkgKGNsaXBidWYtPmNiX2RhdGEs
IGJ1ZiwgbGVuKTsgLy8gYXBwZW5kIHVzZXItc3VwcGxpZWQgZGF0YQogCkBAIC0xODAsMTQgKzE3
Miw2IEBAIGZoYW5kbGVyX2Rldl9jbGlwYm9hcmQ6OmZzdGF0IChzdHJ1Y3Qgc3RhdCAqYnVmKQog
CSAgJiYgKGhnbGIgPSBHZXRDbGlwYm9hcmREYXRhIChmb3JtYXQpKQogCSAgJiYgKGNsaXBidWYg
PSAoY3lnY2JfdCAqKSBHbG9iYWxMb2NrIChoZ2xiKSkpCiAJewotI2lmZGVmIF9feDg2XzY0X18K
LQkgIC8qIHRzIG92ZXJsYXlzIGNiX3NlYyBhbmQgY2JfbnNlYyBzdWNoIHRoYXQgbm8gY29udmVy
c2lvbiBpcyBuZWVkZWQgKi8KLSNlbGlmIF9faTM4Nl9fCi0JICAvKiBDb21wcmVzcyA2NC1iaXQg
dGltZXNwZWMgbGF5b3V0IHRvIDMyLWJpdCBsYXlvdXQuCi0JICAgICBOT1RFOiBTdGVwcyBtdXN0
IGJlIGRvbmUgaW4gdGhpcyBvcmRlciB0byBhdm9pZCBkYXRhIGxvc3MuICovCi0JICBjbGlwYnVm
LT50cy50dl9zZWMgID0gY2xpcGJ1Zi0+Y2Jfc2VjOwotCSAgY2xpcGJ1Zi0+dHMudHZfbnNlYyA9
IGNsaXBidWYtPmNiX25zZWM7Ci0jZW5kaWYKIAkgIGJ1Zi0+c3RfYXRpbSA9IGJ1Zi0+c3RfbXRp
bSA9IGNsaXBidWYtPnRzOwogCSAgYnVmLT5zdF9zaXplID0gY2xpcGJ1Zi0+Y2Jfc2l6ZTsKIAkg
IEdsb2JhbFVubG9jayAoaGdsYik7CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2luY2x1ZGUv
c3lzL2NsaXBib2FyZC5oIGIvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL3N5cy9jbGlwYm9hcmQuaApp
bmRleCA5MzJmZTk4ZDkuLmUzOTAxZDBjOCAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9pbmNs
dWRlL3N5cy9jbGlwYm9hcmQuaAorKysgYi93aW5zdXAvY3lnd2luL2luY2x1ZGUvc3lzL2NsaXBi
b2FyZC5oCkBAIC0xNywzMyArMTcsMTggQEAgZGV0YWlscy4gKi8KIAogc3RhdGljIGNvbnN0IFdD
SEFSICpDWUdXSU5fTkFUSVZFID0gTCJDWUdXSU5fTkFUSVZFX0NMSVBCT0FSRCI7CiAKLS8qCi0g
KiBUaGUgZm9sbG93aW5nIGxheW91dCBvZiBjeWdjYl90IGlzIG5ldyB3aXRoIEN5Z3dpbiAzLjMu
MC4gIEl0IGFpZHMgaW4gdGhlCi0gKiB0cmFuc2ZlciBvZiBjbGlwYm9hcmQgY29udGVudHMgYmV0
d2VlbiAzMi0gYW5kIDY0LWJpdCBDeWd3aW4gZW52aXJvbm1lbnRzLgotICovCiB0eXBlZGVmIHN0
cnVjdAogewogICB1bmlvbgogICB7Ci0gICAgLyoKLSAgICAgKiBOb3RlIHRoYXQgdHMgYmVsb3cg
b3ZlcmxheXMgdGhlIHN0cnVjdCBmb2xsb3dpbmcgaXQuICBPbiAzMi1iaXQgQ3lnd2luCi0gICAg
ICogdGltZXNwZWMgdmFsdWVzIGhhdmUgdG8gYmUgY29udmVydGVkIHRvfGZyb20gY3lnY2JfdCBs
YXlvdXQuICBPbiA2NC1iaXQKLSAgICAgKiBDeWd3aW4gdGltZXNwZWMgdmFsdWVzIHBlcmZlY3Rs
eSBjb25mb3JtIHRvIHRoZSBzdHJ1Y3QgZm9sbG93aW5nLCBzbwotICAgICAqIG5vIGNvbnZlcnNp
b24gaXMgbmVlZGVkLgotICAgICAqCi0gICAgICogV2UgYXZvaWQgZGlyZWN0bHkgdXNpbmcgJ3N0
cnVjdCB0aW1lc3BlYycgb3IgJ3NpemVfdCcgaGVyZSBiZWNhdXNlIHRoZXkKLSAgICAgKiBhcmUg
ZGlmZmVyZW50IHNpemVzIG9uIGRpZmZlcmVudCBhcmNoaXRlY3R1cmVzLiAgV2hlbiBjb3B5L3Bh
c3RpbmcKLSAgICAgKiBiZXR3ZWVuIDMyLSBhbmQgNjQtYml0IEN5Z3dpbiwgdGhlIHBhc3RlZCBk
YXRhIGNvdWxkIGFwcGVhciBjb3JydXB0ZWQsCi0gICAgICogb3IgcGFydGlhbGx5IGludGVycHJl
dGVkIGFzIGEgc2l6ZSB3aGljaCBjYW4gY2F1c2UgYW4gYWNjZXNzIHZpb2xhdGlvbi4KLSAgICAg
Ki8KLSAgICBzdHJ1Y3QgdGltZXNwZWMgdHM7ICAvLyA4IGJ5dGVzIG9uIDMyLWJpdCBDeWd3aW4s
IDE2IGJ5dGVzIG9uIDY0LWJpdCBDeWd3aW4KKyAgICBzdHJ1Y3QgdGltZXNwZWMgdHM7CiAgICAg
c3RydWN0CiAgICAgewotICAgICAgdWludDY0X3QgIGNiX3NlYzsgIC8vIDggYnl0ZXMgZXZlcnl3
aGVyZQotICAgICAgdWludDY0X3QgIGNiX25zZWM7IC8vIDggYnl0ZXMgZXZlcnl3aGVyZQorICAg
ICAgdWludDY0X3QgIGNiX3NlYzsgIC8vID09IHRzLnR2X3NlYworICAgICAgdWludDY0X3QgIGNi
X25zZWM7IC8vID09IHRzLnR2X25zZWMKICAgICB9OwogICB9OwotICB1aW50NjRfdCAgICAgIGNi
X3NpemU7IC8vIDggYnl0ZXMgZXZlcnl3aGVyZQorICB1aW50NjRfdCAgICAgIGNiX3NpemU7CiAg
IGNoYXIgICAgICAgICAgY2JfZGF0YVtdOwogfSBjeWdjYl90OwogCi0tIAoyLjM2LjEKCg==

--------------x89ZPMGY4BqkdZldK8FAxx6p--
