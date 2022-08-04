Return-Path: <kbrown@cornell.edu>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2138.outbound.protection.outlook.com [40.107.92.138])
 by sourceware.org (Postfix) with ESMTPS id 41CD73856947
 for <cygwin-patches@cygwin.com>; Thu,  4 Aug 2022 12:00:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 41CD73856947
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsgSiYI+JXYXopeM5geJdpXVjrrGK4HYB8RgLiB7pjvro06Yx/McE7pW7xFo95RMRDzwUEjFcVlYqxa6Ep9uAIKktWgM9Vwkea7wOVeIlZows78ZRLIf+vlT6Yu/d7fnHewjiapJ84DbLq0XYADGPWcqC9iqzyUUu2ZJkTzrgFFJha2KGISc4bFlq5vngAcBg/bGhVggnRGEusvNp8SB9mopvVllgBpBmoDKqH9pFFt9nuhWIito5TDjuK4Oc1SSTwcwXvAQYazecvbZevYTKkgUtuaB+mcK6rZuYwp3Jm5hsxzZDoVpAbw6M3fQaDpWCKurkHHFtf2Q8jizlm4gMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLSCN1GL6YfVfsEo2rV+vp2W0s4rxo6s7nQdx3q+SqQ=;
 b=oYW8riNEc9PLdE3bI5OpiXuxk/so8nL78nDv9MWOsh5oBekFgrWzdGZoDLereR0opOn5zfGLLHKeg5DBuZUwJ/uQhLTmnBDuIWNAnpVLfMroRYwjqcsQ7NYdEYYXZ/PCfb3huclCdAbfbtDdO/7yQapQm7m/7W7HoIAhdHGFLt/X2nkJyOkB20THlaw5b3kE1MM807GuTCyJBUaBaQV4XleOqqkeQR+fp6ZDNWLvHZIJJxeJ4evYuCkP6omwDN7pZ1xyBh0VuK6+PJ06aUGAfYL3gkN/EeFL8QfQzk2ZPbqJm1vP261FFeuJd4B5U+XOznOcuM84mBq16KAa2Yo3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLSCN1GL6YfVfsEo2rV+vp2W0s4rxo6s7nQdx3q+SqQ=;
 b=FKHFnYslkAZv/dPNpTe8pPBEuGnlqDsg5Mevvt4rFmfJQF3k6hBZfFni+zwKUcRXiUHLDGmLMe8J97p7BdKEauEws9jj4NCVHeoUmnS9jLE3fT/0tcqnwNJIUjYEq0cu6hUdBZ4n/nN/C0XcTnaWxF8Wc7hd/5spiModfLVl5Jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by CH2PR04MB6492.namprd04.prod.outlook.com (2603:10b6:610:6e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 12:00:35 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d%2]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 12:00:35 +0000
Content-Type: multipart/mixed; boundary="------------oPjQi5icNyqpBRhs6hrjQH0a"
Message-ID: <59f6be7b-73ee-4b96-64c5-f31e0bd475a0@cornell.edu>
Date: Thu, 4 Aug 2022 08:00:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH] Cygwin: syscalls.cc: remove ".dll" from,
 blessed_executable_suffixes
X-ClientProxiedBy: BL1PR13CA0409.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::24) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdb44ef9-9ab7-4671-b57e-08da7610efd1
X-MS-TrafficTypeDiagnostic: CH2PR04MB6492:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOBmaDY5SWHX1u0Q06MWERihR8Gz9uIXUfXMWUJNeBNGsVnTD8BcqIddwMct1wq+08ojpNRTi8vZvhQgQiwnaR/Jagx7uLQA8cPN2rLuLgfA54gmEByXMRsrgjDYXg7QJyPI5KIfbZoyHRcHPxAJNzJ+RI7FKgPyGURDcrvO9a0fFH7jd1Y08eBes3mmuuz5Y5QATarHR5ShBBgTtwcqi/klvUK0yqOSsbw8wDrQmMl5P1Bl7YcEumUfYVNYSLsVDJclkTmOp8UrWv9w9to/uvzWIpwzh1MAknb1edig4wDRFkMHZFpI8f4IEXcFbzQYq2BEy6iy3/JMgvE6FjYofoOwFAt/U+4Cz4OaodGm3jDFyIjZJrw2bgkLTT2QyoSaJkaNVXG7wIIf0hUBgeNpIe2jxa9WveFvLCHXMxJumTZVqsl3qENFb2kjSsM0Ao9OHhS5zf8zYpntHVEL0EeCwOx3jhxkLLvCYag/vtp/aiVVBNhEAzBZYyceTxParYdPzJfpfoKtURbl40vecGFFcZ6eKn1ZTnOk3KRaDAfyVPKtNGsS7iKVxVF9K3wcuv0LpJzJz9VhBga5Xmb6P7rsNloeA6DbBaNpHTrBNmSjiP3/Ft0uGFUKaccjhfE4sXiKSI7y5QQkG/oNpkxMHDB04MHb/IgH4chmqAE1/Wbntd4L+JHp23QFmN1E6sk5HGod8WZCnQjqSJc+nSTcVtb45Ee3DEzZLC4KG8CeehLFRu3eR3pjpElAAWtpI2VbVIc2kndj3jFVBzCyAmaALmW+HXO5XLvx5RcG4v3zDjDXgZGzCyTotaJS/0EPWf5cnXYZvTsOFYBdRfhknaWTQflJQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(786003)(316002)(6916009)(6486002)(38100700002)(564344004)(31696002)(86362001)(31686004)(2906002)(36756003)(2616005)(8936002)(66946007)(8676002)(41320700001)(235185007)(66476007)(66556008)(6512007)(186003)(6506007)(478600001)(5660300002)(41300700001)(75432002)(6666004)(33964004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVZLUkF0cmZERmJQK0lYcEt2Ylo3d1pYRlRWRmJKSlFyZ2N6dU9zNW1SMDR1?=
 =?utf-8?B?bGZLWlI1dEhHblU2V0NsVjRFb3Z6WTJkU1BFMWwvZjFUN3VIM0xhVXJoVldn?=
 =?utf-8?B?R08yQlJZY0RXcE9kVTIvSENPdytGR2wxSzJ2aCtXVDdaUStzTjRDbU13eCtN?=
 =?utf-8?B?Zm9kU0JOQllRa1NCbGJ4Z3dzcW90YWZSeFJGbEdVWnZnYW92T3dnQnEwcVVI?=
 =?utf-8?B?Sk0vSmJaWUpGYi9zdlpMK09uNzFQS1RyR0JObExabkxpL0RyV21XTlFJN3hU?=
 =?utf-8?B?Y0ROZ09hRHkvaTl1UFloMGV6bWtZMDJYckR6dlR5cDBhcExQS093NG0zL2Qv?=
 =?utf-8?B?QW80eXErcFpENlY5RDZsRGo5ZHEybkl3WC82YVpTeHIyMHh2OC9zNGZaQlFT?=
 =?utf-8?B?Zy9keUxZSlR6RUM5ZlR2dVlvOFJxQUNzREJZZ0d4cWw2T1M2Zkw2K2dXdDkz?=
 =?utf-8?B?Qk4rY2xpY3JmeHF1VjZ0WkcybnA2dEdBU2tQaStRRXVGcjZvYitGZUd3b0JJ?=
 =?utf-8?B?eHUxOGhJSlJJcExwMjUxZENDejRmQStZMG1nMWJDUVEzRFVZdXd1d2h5a1Bo?=
 =?utf-8?B?eE9TTWNadks3UEdaajFzVE01SjhtVkxON1QyR2FPY1BqMGp6bm1PeHBhTnpu?=
 =?utf-8?B?Z0lkU2RtdWkvRlNUMFVuQnJaeDk3UVVnWk5UNzZPL3RsNzU4UHRNR09BNXFZ?=
 =?utf-8?B?aU56TFl2VmZ4T1VBc1M3NXYvaFN5OXhKWExyYlJXS1h3RWIvNDBvYlhSWHB1?=
 =?utf-8?B?QytJS2hTZ3BzYSttQlUxa2NhbGNSeWEyYk8zV2dhNHB2dS90YzlUQVM5TStq?=
 =?utf-8?B?M1YxbUtXMGNyaVJJdzdKKy9BZnJWU3MwVTI2aTV3WUZmU1BtbWhLZmx4OEZm?=
 =?utf-8?B?REYzVGlkanB5VXNvUWNsS3VMZk1yRTZjNzUwOWhXTWdHUGJPZFM3aTJyY3R2?=
 =?utf-8?B?TUpKc21KWjBSVHprb1pMTGxQb1YvOGtWRmIxdFYwMmZmZDZqZWNWdVdrQ0VU?=
 =?utf-8?B?RzN1b0VSc2YycTQ1ZVR1V3dBbUpxcmdhcjg3MmhBZlJycDNQYmRmenpTWmgr?=
 =?utf-8?B?VXl2UEg3Ty9YWlJ2MkhTQW55cWhGT2dXSzNVRWdTWVlCbml5VFBtT3YwYVJK?=
 =?utf-8?B?QnN4OTdkcnJoR2ZxT1lIcFFqMlVaUHNRMHRzalNUdmFtd09ycGJaeW5UWm5F?=
 =?utf-8?B?U1hSYU1RZ1BmQmdBVnhGSENxUTJuZWtFZHcvOENSK1AvVUtlYmVKc1E5WVQr?=
 =?utf-8?B?aVpJSmU1ZjhJR0NXSS9TbGtTRW1JTXVkNURwVmRSZDB1djJOWDB4MDJhUkQr?=
 =?utf-8?B?cmRNVlF0S0YydWFYNFpUMzhpcGU1Vlh5ZXpEVFJ3ejRsWDFSWTg4QnF6RXlj?=
 =?utf-8?B?WFNFL3VqZGIrQ0tMWHE2S2hrdzZQTU9vV2lZSEpxcFcyTnJWenAwV2dzcjJY?=
 =?utf-8?B?Z0RXOEExc2M0UEtxNDhjM1c0aGZtMGRJWDBvV1E4eU80ZnVlOXdWU0ZGMWd0?=
 =?utf-8?B?Y0lDWU1DWFFNSlU3WWJWSURkMlV3NzNrZ0gyWlZhM0JVcG5GdnJyMTFTVEpy?=
 =?utf-8?B?azQzaFY2YWxqSDV1b1Z5ZlB2SUE1b245UUxhblpia1hwOWNlbng0cmNyaEpQ?=
 =?utf-8?B?MmVGd0c5eTZtakRQMGJNN2llcmtzTTA4OW5XUmF3N1Q2WjExaG0zc0NESHZJ?=
 =?utf-8?B?T3NIcFAwR0hFcUN0VE1pSVpsWVpJZFNtSUI3NGZ1MnlwK0Z1VkdETU5KTmlG?=
 =?utf-8?B?TWRiUmVyd1cvOXgyUU4rZVhFaXhiWlJ4dkVYNFM4QWRWWU9QQkpGREEzNjVU?=
 =?utf-8?B?b3hnSTJPalI5c2c1NlQ3eVFSbGlCYi92QVVsaWFiY2ZaZ0lVcFIwVjROODQ4?=
 =?utf-8?B?a1pWZGkwbjM2N3VFU1R2bUVNODV2Q0MvQUNLaldBTFBSd2kyODRjaFZrSHFP?=
 =?utf-8?B?a3RKdVlaQ0RVSnVtNkxFQnF0QzlsQVVMblZLU0VWVXcveVpKLzRWbFl0dFFO?=
 =?utf-8?B?a1hHaGpIZTNjc0pJRUtzTTVrcGlYRVdNYUw5WDNsWlkvZTRadVlKM0xhLzVt?=
 =?utf-8?B?MTVLa05xb0xBMnN6UFZrSXpRT1F6V1JHVVlTNXErdHhEVjRNNlBMQXk1SmRi?=
 =?utf-8?B?bXdkV25FOEh5UHhwdFZsRlFOYjJabmljb0RoMWdydHZITDFqeFhQcFZZZXRE?=
 =?utf-8?Q?ksao0glaV6ve97g4MO2FgQBUhMXdIm6WM8GQUsjZTkME?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb44ef9-9ab7-4671-b57e-08da7610efd1
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 12:00:34.9835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AaTSBbLgbi1gfgXqX2i8fKNp7dEi6jrKdSR7bgJXvcDMaMHNvzaqvFru9UIZcvq7/HFTHKKNLhQGgksNdm/bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6492
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.6
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
X-List-Received-Date: Thu, 04 Aug 2022 12:00:43 -0000

--------------oPjQi5icNyqpBRhs6hrjQH0a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.  I'm not 100% sure of this since it does change behavior (but in 
a weird case).

Ken
--------------oPjQi5icNyqpBRhs6hrjQH0a
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-syscalls.cc-remove-.dll-from-blessed_executab.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-syscalls.cc-remove-.dll-from-blessed_executab.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5N2EyZmMwZDA3YzhmOTA0NWI3MzcxNmFjNWEwNWY5NzJkNWJkNzVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
V2VkLCAzIEF1ZyAyMDIyIDE2OjQ1OjIzIC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBz
eXNjYWxscy5jYzogcmVtb3ZlICIuZGxsIiBmcm9tCiBibGVzc2VkX2V4ZWN1dGFibGVfc3VmZml4
ZXMKClRoaXMgcmV2ZXJ0cyBjb21taXQgZDllOWM3YjVhNy4gIFRoZSBsYXR0ZXIgYWRkZWQgIi5k
bGwiIHRvIHRoZQpibGVzc2VkX2V4ZWN1dGFibGVfc3VmZml4ZXMgYXJyYXkgYmVjYXVzZSBvbiAz
Mi1iaXQgV2luZG93cywgdGhlCkdldEJpbmFyeVR5cGUgZnVuY3Rpb24gd291bGQgcmVwb3J0IHRo
YXQgYSA2NC1iaXQgRExMIGlzIGFuCmV4ZWN1dGFibGUsIGNvbnRyYXJ5IHRvIHRoZSBkb2N1bWVu
dGF0aW9uIG9mIHRoYXQgZnVuY3Rpb24uCgpUaGF0IGFub21hbHkgZG9lcyBub3QgZXhpc3Qgb24g
NjQtYml0IFdpbmRvd3MsIHNvIHdlIGNhbiByZW1vdmUgIi5kbGwiCmZyb20gdGhlIGxpc3QuICBS
ZXZlcnRpbmcgdGhlIGNvbW1pdCBkb2VzLCBob3dldmVyLCBjaGFuZ2UgdGhlCmJlaGF2aW9yIG9m
IHRoZSByZW5hbWUoMikgc3lzY2FsbCBpbiB0aGUgZm9sbG93aW5nIHVubGlrZWx5IHNpdHVhdGlv
bjoKU3VwcG9zZSB3ZSBoYXZlIGFuIGV4ZWN1dGFibGUgZm9vLmV4ZSBhbmQgd2UgbWFrZSB0aGUg
Y2FsbAoKICByZW5hbWUgKCJmb28iLCAiYmFyLmRsbCIpOwoKUHJldmlvdXNseSwgZm9vLmV4ZSB3
b3VsZCBiZSByZW5hbWVkIHRvIGJhci5kbGwuICBTbyBiYXIuZGxsIHdvdWxkCnRoZW4gYmUgYW4g
ZXhlY3V0YWJsZSB3aXRob3V0IHRoZSAuZXhlIGV4dGVuc2lvbi4gIFRoZSBuZXcgYmVoYXZpb3Ig
aXMKdGhhdCBmb28uZXhlIHdpbGwgYmUgcmVuYW1lZCB0byBiYXIuZGxsLmV4ZS4gIFtFeGNlcHRp
b246IElmIHRoZXJlCmFscmVhZHkgZXhpc3RlZCBhbiBleGVjdXRhYmxlIChub3QgYSBETEwhKSB3
aXRoIHRoZSBuYW1lIGJhci5kbGwsIHRoZW4KLmV4ZSB3aWxsIG5vdCBiZSBhcHBlbmRlZC5dCi0t
LQogd2luc3VwL2N5Z3dpbi9nbG9iYWxzLmNjICB8IDEgLQogd2luc3VwL2N5Z3dpbi9zeXNjYWxs
cy5jYyB8IDYgLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvd2luc3VwL2N5Z3dpbi9nbG9iYWxzLmNjIGIvd2luc3VwL2N5Z3dpbi9nbG9iYWxzLmNj
CmluZGV4IGU4MTQ3Y2I1Yy4uZTkwOWQwZjhmIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2ds
b2JhbHMuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9nbG9iYWxzLmNjCkBAIC0xMjAsNyArMTIwLDYg
QEAgY29uc3QgaW50IF9fY29sbGF0ZV9sb2FkX2Vycm9yID0gMDsKICAgZXh0ZXJuIFVOSUNPREVf
U1RSSU5HIF9SREFUQSByb191X2VtcHR5ID0gX1JPVSAoTCIiKTsKICAgZXh0ZXJuIFVOSUNPREVf
U1RSSU5HIF9SREFUQSByb191X2xuayA9IF9ST1UgKEwiLmxuayIpOwogICBleHRlcm4gVU5JQ09E
RV9TVFJJTkcgX1JEQVRBIHJvX3VfZXhlID0gX1JPVSAoTCIuZXhlIik7Ci0gIGV4dGVybiBVTklD
T0RFX1NUUklORyBfUkRBVEEgcm9fdV9kbGwgPSBfUk9VIChMIi5kbGwiKTsKICAgZXh0ZXJuIFVO
SUNPREVfU1RSSU5HIF9SREFUQSByb191X2NvbSA9IF9ST1UgKEwiLmNvbSIpOwogICBleHRlcm4g
VU5JQ09ERV9TVFJJTkcgX1JEQVRBIHJvX3Vfc2NyID0gX1JPVSAoTCIuc2NyIik7CiAgIGV4dGVy
biBVTklDT0RFX1NUUklORyBfUkRBVEEgcm9fdV9zeXMgPSBfUk9VIChMIi5zeXMiKTsKZGlmZiAt
LWdpdCBhL3dpbnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MgYi93aW5zdXAvY3lnd2luL3N5c2NhbGxz
LmNjCmluZGV4IGU2ZDY4Y2MwNy4uNTk5YjJiNzkzIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2lu
L3N5c2NhbGxzLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MKQEAgLTIxMzMsMTIg
KzIxMzMsNiBAQCBudF9wYXRoX2hhc19leGVjdXRhYmxlX3N1ZmZpeCAoUFVOSUNPREVfU1RSSU5H
IHVwYXRoKQogICBzdGF0aWMgY29uc3QgUFVOSUNPREVfU1RSSU5HIGJsZXNzZWRfZXhlY3V0YWJs
ZV9zdWZmaXhlc1tdID0KICAgewogICAgICZyb191X2NvbSwKLSAgICAmcm9fdV9kbGwsCS8qIE1l
c3N5LCBtZXNzeS4gIFBlciBNU0ROLCB0aGUgR2V0QmluYXJ5VHlwZSBmdW5jdGlvbiBpcwotCQkg
ICBzdXBwb3NlZCB0byByZXR1cm4gd2l0aCBFUlJPUl9CQURfRVhFX0ZPUk1BVC4gaWYgdGhlIGZp
bGUKLQkJICAgaXMgYSBETEwuICBPbiA2NC1iaXQgV2luZG93cywgdGhpcyB3b3JrcyBhcyBleHBl
Y3RlZCBmb3IKLQkJICAgMzItYml0IGFuZCA2NC1iaXQgRExMcy4gIE9uIDMyLWJpdCBXaW5kb3dz
IHRoaXMgb25seSB3b3JrcwotCQkgICBmb3IgMzItYml0IERMTHMuICBGb3IgNjQtYml0IERMTHMs
IDMyLWJpdCBXaW5kb3dzIHJldHVybnMKLQkJICAgdHJ1ZSB3aXRoIHRoZSB0eXBlIHNldCB0byBT
Q1NfNjRCSVRfQklOQVJZLiAqLwogICAgICZyb191X2V4ZSwKICAgICAmcm9fdV9zY3IsCiAgICAg
JnJvX3Vfc3lzLAotLSAKMi4zNy4xCgo=

--------------oPjQi5icNyqpBRhs6hrjQH0a--
