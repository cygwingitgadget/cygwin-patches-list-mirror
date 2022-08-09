Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2115.outbound.protection.outlook.com [40.107.94.115])
 by sourceware.org (Postfix) with ESMTPS id C9D123856972
 for <cygwin-patches@cygwin.com>; Tue,  9 Aug 2022 19:52:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C9D123856972
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcYkqhEoRtUDMsDEgSuGb8VNWdEXOSbQ98zc6RUzGOBjVDItQv6+q40lx7tNcH5oLgHwEH8p70auwLDVbZpWRaDYgG9LzZR/rT+En79kVAcKnUPS+DM6idsTSwMylbidXclHpj5tvDLc9/ATOrIc/7ZrbmAxxiXO0xvJ6ZifGsioWDDJX27/xldf0HI4SNydFyynl1rmlZysOoLtWNrBnBGF1K0+5GAI296bbtjtijeu7WC+1up0OTlYCWflxEmPmHAPdQ5sfatlq3/rV7QypvmsC/EjOz7Y0j4S9EYLnNCK5Hn3j/uhljcqiP2hBkQ9HIqokEAfz/5YOY1cx36kRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXmZfwKrYtvyu1v1iVDdbdVTnb5uc6tZWT2cIRbVh0E=;
 b=P241iAoboRhA11mg8jVQD9wXrRUd7dZt6oBNaRCrMEUiLKU7Lp0wZaI+SZ6oyuNSXLj1JoS+cGmZ38BaAHkkYxElkzxjg7+j+l+uqFbrvqeNwZZB8CoOczbGh1LyrV1o8iloM4SKJstL1wyjm3oUF5vPCDK3VOwqZnTEb1bQx0En3Y3nAj9SjKhK6LFIF9Aq2WoSbGAihHsALUAlZlTieaYPA26/5pQnMA+9a9uDriXnzZLRmf7rwBZNudbYyxzY355FHQ/8a92PA5+zMCs7bSKXQJrMIo13+/WX5wAnMoAUWCliJHceTkkIRRTWdHdw8DlNaC4APDUychwjGUR+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXmZfwKrYtvyu1v1iVDdbdVTnb5uc6tZWT2cIRbVh0E=;
 b=hlscYRaNkxldqE3PsirElacNka1lOykAMFqpWHu8gTdrd69zo9FLhBP6kUGlswqRWi25B412gmUQRdKBa7g9sc7Y1hdJESKa1OSXkeuyPUzlNH9nSavlrTjd/tGQCzv1wJGvM70V80rKKEysNdRynszHYCaE14nwMKvlhkay0r4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0692.namprd04.prod.outlook.com (2603:10b6:404:d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 19:52:09 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d%2]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 19:52:09 +0000
Content-Type: multipart/mixed; boundary="------------K0b7Ja4o0prxWY0WhiNS3kNy"
Message-ID: <ba223591-0c96-d61c-36df-4f450abb9957@cornell.edu>
Date: Tue, 9 Aug 2022 15:52:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH] Cygwin: fix return value of symlink_info::check
X-ClientProxiedBy: BL0PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:207:3c::30) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e707c53a-8f69-4978-ee5c-08da7a40a4c0
X-MS-TrafficTypeDiagnostic: BN6PR04MB0692:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADKbH2JLzfMG6r3RQxSP/xyM5vY01YwQyWIkWBhpPagKyxudawuPU5m4MzkAOpZ0DJKzrHwDab9CrqoMC1gzeZY5rlHISMy48j/2zyXih8nZdsf7zT4uy8tZ75wCqsXrNrqO5VCEHPliHttb2nlhcVpKe0/aXvwANTusGDvv6GNpUjjAqwBFahmZfdtDzlUXpHWd1l2qP1R0eYsU6IYv6fVdwQZmjn1JcUYnz/H4Gg+uC9sQ+zeTJ5LV5En3hapy4WrDlI8lg2fGTgM1pxguSQt+rGLPXOzzJfhMMqA11VovWfSHCv6bIUG3yCsYuZOqmgokJa+m2QsYxvCN9VmA5oOuf9zdk0VY2q3IQcV7zJTosH5NNy+2i+BXs1OWOfrlPGcQ2vcpHPCcqc4gOmWOADmKbP9eAerrkwEaaHNv304iqhlCuPFp5j3uXvBwRV4KZPEwWvvkDcr1c+PzaQnIkfjOsZOmCGReI2lB581KA+oB4xNGJsFQmIXnT1su01TuuMUpX4Yop0nEewRj+V/YvPUzNj78t58Jr/jBVAZZaer+OkwSdreRIi16suHAD9h329uoqSj+T8Ur/EEPQ0ptUHZf5YjyEWWlp0sVjbNfoXStofrZ51dvZUNkEFmw2WEKp2jwceGAdH/zFyKbrt2MnYitFKJ8u2/gnreVmAwGo1yVAmLhoax9ksLtIbdeNRTY5A308F4h6RCHs7N9/je56OEyX7f2u8Ir3upfvte64fcUikoPojgp/p8UObyArZ2sRwc4vBF5zW8jSRQAJ30Tb8NB2qbSEAxUtPU0IzDSxqiEERZWFoSDLVT+8jj7lRIOm6XMBd8UV1rr9Ab5Z3rCYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(66946007)(66476007)(186003)(2616005)(66556008)(41320700001)(6486002)(8676002)(478600001)(38100700002)(564344004)(31696002)(86362001)(75432002)(36756003)(31686004)(2906002)(5660300002)(8936002)(235185007)(41300700001)(6916009)(786003)(6666004)(33964004)(316002)(6512007)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mll1TzdmRHBmQzR4N3haWUJxOGgydXYzUVFjUGp3WjFDZWNIRjVITWJpT2hV?=
 =?utf-8?B?V0ZBVFp0VFFHdEo4RGl1bEE2bkFDTmtZcEtCdkRVY2pNcjRFNE0rQWdrYUc0?=
 =?utf-8?B?M3UycitDc3FvM0NLd25qNGVGbXdsdEk5TWhFZlNncUFSMWdyckxaNmlMTHRo?=
 =?utf-8?B?SWovSXp3VDRkblhES0E4ZUx0Q0VLZEhNZ0FjcVZDMFNUbmIrQ3BtN0kzY2Ur?=
 =?utf-8?B?S2l1UGlTeUpUeXBWV1B0aFFOMWhNK3pST1ZQNE1VdUJ6RjJrZGF5Y2dqVE9C?=
 =?utf-8?B?d2x1VTJ3MCt4T1ZlSytGSE43ay85dno1SUcyUmQrdm1PdDM2R1FBa0F2d01l?=
 =?utf-8?B?YjFEU1dTQWpQU3ZaWlg2T2RocERURlpZOXZOQTFqRGxsSEJBd1lyeWVEdmRh?=
 =?utf-8?B?YnpEcGRIcGVXTGtIcEZjM0ZyaFlpclZNVFRNYTlLUUhESHpwMjNwYTZrWnNK?=
 =?utf-8?B?eEU3Q0ZONlgrbTFMZGhBYnpleFh4SXMvVGhaMWxIcHlwY3ZBQldyVzcyMnUv?=
 =?utf-8?B?Uy8xUXZNY0RGaFhkZXV4WVlBcXBGYjJVLzZLRnpvTU1NNVZEakpqQzE0eXQ5?=
 =?utf-8?B?VWNHOGtGMGViYTBTcHJPYU5RbzNQbjJ0Qk1MdnFQNXpnRFl3Z3k4L0dnVEUr?=
 =?utf-8?B?UVJ5T3czYVV4dG44a0pFbDJsYmlNWWkxamNWRGtNRGVHL2piTitvM2Rqa2ov?=
 =?utf-8?B?c1VlVEhFMTRibDAwRGlLYW5TUWo1RlVwNGVXVmRWbkJEWkN1VEFnQllMb3o0?=
 =?utf-8?B?MXNFWE9kb1RnWk1SaERoRVFZYVk5L1ZLZWJjWDlsUkZia0JNK09mNk80dHdw?=
 =?utf-8?B?VURzdG9DQktiTnZnMmw5K0hiYkttYlJDRWMrL2VEYW5IbG1wWlQ3NnRyTXNX?=
 =?utf-8?B?ZnZmUWFFVUt1dXdHSW9qODF3eWMvK1lPUEcwdU1LZERNV3NjakRMemZrek1V?=
 =?utf-8?B?UDRxSEUwQ0lKdk1MNHJPUitJSlFyVDlpYzMwLy8zUWNzREVNbWlmdmJHczZF?=
 =?utf-8?B?WFBlOEZJbk5jRDFpZFFKTXlKaE9PZFF3Q2kvaVdzY2JZOTRvdjVCMGJEbTMy?=
 =?utf-8?B?ZHFOY3c4VGVEajRWajhCcjNHQndkLzVSeStaUm9wZGpQRVQvN0pWVk9IVHdP?=
 =?utf-8?B?ZFc5bFFueEVJbWNVMkQwKzBlaCtYSERsdG5TOUZld2g5YkdkSzlWWnEvMmJL?=
 =?utf-8?B?dm9CMEFTbkcxenNKSGFWb1NDaDlLcGpIR2hoU3p3M2FuWTJIS2dlWVcrTmFT?=
 =?utf-8?B?OW9ScUtPK2ppTnlJYkFaZjI2Rk8wVDdlTmJRNGpqc3dwOFQxbUZRRllSMjNa?=
 =?utf-8?B?QTZOOWp6REdhWFpHZVNFY3JCL0VWVTJtVjhYRWRRWmdQK1pYSUFTSHEvR1Zy?=
 =?utf-8?B?azNIY1dvMWdUbHpkYVdKM0IzNGpCVVdYNmpZU2hKQnUxQ3llZmpLWUgvS2k2?=
 =?utf-8?B?VjlyMXFST1BHZDRIWnlwL3c0enA3cmVqRDB6MFFIUkx6R2d4SG81cjRmQXAx?=
 =?utf-8?B?UkxjREdwZjA3RFZJV3JCR0F0aHV0VzFPSHgzcXZjcDNDcWtVT05sMUtkZWZx?=
 =?utf-8?B?K0lzSU5MRlJvWXBiV016VGUxWHkzejhHZlZOWDdDVTVneDBtVkhQcW4xRWY4?=
 =?utf-8?B?V0RUdWg2cWZEaU0wVUFPSER4MUV4OWFRMGc5T0I4ald6bTByRStVWE9JQ05O?=
 =?utf-8?B?ejMreVNKWHhRVm9zbDhnYmhkaUVPSURiTThxaHpKMzlVZkpGUzQwSFNNZGZx?=
 =?utf-8?B?c281VE42NkJXS2FraFVoZ1JrMWJLR3J0REJkK2c1UnR0T25XOGxhWGpjL2Z4?=
 =?utf-8?B?alFybkhQT3hsbXI0cmJvZm5HeXV2T1dab1l1YlRDTDZLOEtlcUZYRVlDSzhE?=
 =?utf-8?B?OWhzK01zcFVtMEtteTlSekcvWVBQeVFtcFdZWWo5djltTCtnTGVMZi9LSXNs?=
 =?utf-8?B?aVJycDFlUktidWZkVFNwVStSTmtma3lvUDVPY0Vnbm1NL1BYNTk0ZTE2VGtP?=
 =?utf-8?B?a1NxWis4RlM2c2VtVzRrcHJPQVIzc1d1aHFSbGJ3dmhYalVzM0JWMTBUN25X?=
 =?utf-8?B?UzhqdkdtcDI0L0lLK3RyVGtuaVRhV2xodGkxaUNOT1U0dWFUZVpHOUZmUStQ?=
 =?utf-8?B?a3JCU2dVQXpKZ1lkNVZwNzhaai9KVXQrb3dFUUM3a0cwVmlkTm1QK0VXbmVT?=
 =?utf-8?Q?GglB/ZcsV8D838aw1398qKED0QIHs7vFvMZE/5zvg7QE?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e707c53a-8f69-4978-ee5c-08da7a40a4c0
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 19:52:09.0230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJf8aSaPIfKsx8vQM+hjMNrMVxl+xEa6ly7rDyzO7W7IypO0joimQrtUehmUMcz7L1+muRACppXIfttNgw604w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0692
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 09 Aug 2022 19:52:13 -0000

--------------K0b7Ja4o0prxWY0WhiNS3kNy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.  Please check my changes to the commentary preceding 
symlink_info::check to make sure I got it right.

I've written the patch against the master branch, but I think it should be 
applied to cygwin-3_3-branch also.

Ken
--------------K0b7Ja4o0prxWY0WhiNS3kNy
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-fix-return-value-of-symlink_info-check.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-fix-return-value-of-symlink_info-check.patch"
Content-Transfer-Encoding: base64

RnJvbSBmZWQwMTgwZDU5ZDgxMDJlMGM2NzE1MzdhMzYwYWJiMTJlODIwNGEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
VHVlLCA5IEF1ZyAyMDIyIDE1OjE0OjA3IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBm
aXggcmV0dXJuIHZhbHVlIG9mIHN5bWxpbmtfaW5mbzo6Y2hlY2sKCkN1cnJlbnRseSBpdCBpcyBw
b3NzaWJsZSBmb3Igc3ltbGlua19pbmZvOjpjaGVjayB0byByZXR1cm4gLTEgaW4gY2FzZQp3ZSdy
ZSBzZWFyY2hpbmcgZm9yIGZvbyBhbmQgZmluZCBmb28ubG5rIHRoYXQgaXMgbm90IGEgc2hvcnRj
dXQuICBUaGlzCmNvbnRyYWRpY3RzIHRoZSBuZXcgbWVhbmluZyBhdHRhY2hlZCB0byBhIG5lZ2F0
aXZlIHJldHVybiB2YWx1ZSBpbgpjb21taXQgMTlkNTljZTc1ZC4gIEZpeCB0aGlzIGJ5IHNldHRp
bmcgInJlcyIgdG8gMCBhdCB0aGUgYmVnaW5uaW5nIG9mCnRoZSBtYWluIGxvb3AgYW5kIG5vdCBz
ZXRpbmcgaXQgdG8gLTEgbGF0ZXIuCgpBbHNvIGZpeCB0aGUgY29tbWVudGFyeSBwcmVjZWRpbmcg
dGhlIGZ1bmN0aW9uIGRlZmluaXRpb24gdG8gcmVmbGVjdAp0aGUgY3VycmVudCBiZWhhdmlvci4K
CkFkZHJlc3NlczogaHR0cHM6Ly9jeWd3aW4uY29tL3BpcGVybWFpbC9jeWd3aW4vMjAyMi1BdWd1
c3QvMjUyMDMwLmh0bWwKLS0tCiB3aW5zdXAvY3lnd2luL3BhdGguY2MgICAgICAgfCAyMiArKysr
KysrKystLS0tLS0tLS0tLS0tCiB3aW5zdXAvY3lnd2luL3JlbGVhc2UvMy4zLjYgfCAgNCArKysr
CiAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vcGF0aC5jYyBiL3dpbnN1cC9jeWd3aW4vcGF0aC5jYwpp
bmRleCAzZTQzNmRjNjUuLjIyN2I5OWQwZiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9wYXRo
LmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vcGF0aC5jYwpAQCAtMzAyNywxOSArMzAyNywxNiBAQCBz
eW1saW5rX2luZm86OnBhcnNlX2RldmljZSAoY29uc3QgY2hhciAqY29udGVudHMpCiAvKiBDaGVj
ayBpZiBQQVRIIGlzIGEgc3ltbGluay4gIFBBVEggbXVzdCBiZSBhIHZhbGlkIFdpbjMyIHBhdGgg
bmFtZS4KIAogICAgSWYgUEFUSCBpcyBhIHN5bWxpbmssIHB1dCB0aGUgdmFsdWUgb2YgdGhlIHN5
bWxpbmstLXRoZSBmaWxlIHRvCi0gICB3aGljaCBpdCBwb2ludHMtLWludG8gQlVGLiAgVGhlIHZh
bHVlIHN0b3JlZCBpbiBCVUYgaXMgbm90Ci0gICBuZWNlc3NhcmlseSBudWxsIHRlcm1pbmF0ZWQu
ICBCVUZMRU4gaXMgdGhlIGxlbmd0aCBvZiBCVUY7IG9ubHkgdXAKLSAgIHRvIEJVRkxFTiBjaGFy
YWN0ZXJzIHdpbGwgYmUgc3RvcmVkIGluIEJVRi4gIEJVRiBtYXkgYmUgTlVMTCwgaW4KLSAgIHdo
aWNoIGNhc2Ugbm90aGluZyB3aWxsIGJlIHN0b3JlZC4KKyAgIHdoaWNoIGl0IHBvaW50cy0taW50
byBDT05URU5UUy4KIAotICAgU2V0ICpTWU1MIGlmIFBBVEggaXMgYSBzeW1saW5rLgorICAgU2V0
IFBBVEhfU1lNTElOSyBpZiBQQVRIIGlzIGEgc3ltbGluay4KIAotICAgU2V0ICpFWEVDIGlmIFBB
VEggYXBwZWFycyB0byBiZSBleGVjdXRhYmxlLiAgVGhpcyBpcyBhbiBlZmZpY2llbmN5Ci0gICBo
YWNrIGJlY2F1c2Ugd2Ugc29tZXRpbWVzIGhhdmUgdG8gb3BlbiB0aGUgZmlsZSBhbnlob3cuICAq
RVhFQyB3aWxsCi0gICBub3QgYmUgc2V0IGZvciBldmVyeSBleGVjdXRhYmxlIGZpbGUuCi0KLSAg
IFJldHVybiAtMSBvbiBlcnJvciwgMCBpZiBQQVRIIGlzIG5vdCBhIHN5bWxpbmssIG9yIHRoZSBs
ZW5ndGgKLSAgIHN0b3JlZCBpbnRvIEJVRiBpZiBQQVRIIGlzIGEgc3ltbGluay4gICovCisgICBJ
ZiBQQVRIIGlzIGEgc3ltbGluaywgcmV0dXJuIHRoZSBsZW5ndGggc3RvcmVkIGludG8gQ09OVEVO
VFMuICBJZgorICAgdGhlIGlubmVyIGNvbXBvbmVudHMgb2YgUEFUSCBjb250YWluIG5hdGl2ZSBz
eW1saW5rcyBvciBqdW5jdGlvbnMsCisgICBvciBpZiB0aGUgZHJpdmUgaXMgYSB2aXJ0dWFsIGRy
aXZlLCBjb21wYXJlIFBBVEggd2l0aCB0aGUgcmVzdWx0CisgICByZXR1cm5lZCBieSBHZXRGaW5h
bFBhdGhOYW1lQnlIYW5kbGVBLiAgSWYgdGhleSBkaWZmZXIsIHN0b3JlIHRoZQorICAgZmluYWwg
cGF0aCBpbiBDT05URU5UUyBhbmQgcmV0dXJuIHRoZSBuZWdhdGl2ZSBvZiBpdHMgbGVuZ3RoLiAg
SW4KKyAgIGFsbCBvdGhlciBjYXNlcywgcmV0dXJuIDAuICAqLwogCiBpbnQKIHN5bWxpbmtfaW5m
bzo6Y2hlY2sgKGNoYXIgKnBhdGgsIGNvbnN0IHN1ZmZpeF9pbmZvICpzdWZmaXhlcywgZnNfaW5m
byAmZnMsCkBAIC0zMDk0LDYgKzMwOTEsNyBAQCByZXN0YXJ0OgogCiAgIHdoaWxlIChzdWZmaXgu
bmV4dCAoKSkKICAgICB7CisgICAgICByZXMgPSAwOwogICAgICAgZXJyb3IgPSAwOwogICAgICAg
Z2V0X250X25hdGl2ZV9wYXRoIChzdWZmaXgucGF0aCwgdXBhdGgsIG1vdW50X2ZsYWdzICYgTU9V
TlRfRE9TKTsKICAgICAgIGlmIChoKQpAQCAtMzM0NSw4ICszMzQzLDYgQEAgcmVzdGFydDoKIAkg
IGNvbnRpbnVlOwogCX0KIAotICAgICAgcmVzID0gLTE7Ci0KICAgICAgIC8qIFJlcGFyc2UgcG9p
bnRzIGFyZSBwb3RlbnRpYWxseSBzeW1saW5rcy4gIFRoaXMgY2hlY2sgbXVzdCBiZQogCSBwZXJm
b3JtZWQgYmVmb3JlIGNoZWNraW5nIHRoZSBTWVNURU0gYXR0cmlidXRlIGZvciBzeXNmaWxlCiAJ
IHN5bWxpbmtzLCBzaW5jZSByZXBhcnNlIHBvaW50cyBjYW4gaGF2ZSB0aGlzIGZsYWcgc2V0LCB0
b28uICovCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy4zLjYgYi93aW5zdXAv
Y3lnd2luL3JlbGVhc2UvMy4zLjYKaW5kZXggMDc4ZTZlNTIwLi4zNjRlMGNiMGQgMTAwNjQ0Ci0t
LSBhL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjMuNgorKysgYi93aW5zdXAvY3lnd2luL3JlbGVh
c2UvMy4zLjYKQEAgLTM1LDMgKzM1LDcgQEAgQnVnIEZpeGVzCiAtIEZpeCBhIHByb2JsZW0gdGhh
dCBwcmV2ZW50ZWQgc29tZSBzeW1ib2xpYyBsaW5rcyB0byAvY3lnZHJpdmUvQywKICAgL2N5Z2Ry
aXZlLy4vYywgL2N5Z2RyaXZlLy9jLCBldGMuIGZyb20gd29ya2luZy4KICAgQWRkcmVzc2VzOiBo
dHRwczovL2N5Z3dpbi5jb20vcGlwZXJtYWlsL2N5Z3dpbi8yMDIyLUp1bHkvMjUxOTk0Lmh0bWwK
KworLSBGaXggYSBwYXRoIGhhbmRsaW5nIGJ1ZyB0aGF0IGNvdWxkIGNhdXNlIGEgbm9uLWV4aXN0
aW5nIGZpbGUgdG8gYmUKKyAgdHJlYXRlZCBhcyB0aGUgY3VycmVudCBkaXJlY3RvcnkuCisgIEFk
ZHJlc3NlczogaHR0cHM6Ly9jeWd3aW4uY29tL3BpcGVybWFpbC9jeWd3aW4vMjAyMi1BdWd1c3Qv
MjUyMDMwLmh0bWwKLS0gCjIuMzcuMQoK

--------------K0b7Ja4o0prxWY0WhiNS3kNy--
