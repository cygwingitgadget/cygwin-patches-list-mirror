Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2132.outbound.protection.outlook.com [40.107.96.132])
 by sourceware.org (Postfix) with ESMTPS id 26CDD3857C7F
 for <cygwin-patches@cygwin.com>; Thu, 11 Nov 2021 14:10:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 26CDD3857C7F
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/p9eDk+jde31CbkAR2uWTYyqQrjVh8KiAxxTjZ7wuPPeVxLPMEwUqWHYLoF4IDZJYf/ux2hcobTnojSZrOsWe2rFV7o5H3oLmDbb9IJlH0sGrz+ZX63utTPIEhd8o+/CTpFhgrMSKc29nFSdCaFdpEeD83jVNfWVU2vM6Ng4O42F6NCBf+QL+rjoYZETAQdCoD8220NmSK1C6ryhvucM83jxXwBMasaN8/ox2bzlpimgOSkwyw3goI4+MLVvN9XwwUxrWbA2R8kNK7VhdQpVRIJQoLycTqrJpsyyi5g38Nq+liRYWzkQeVUnFvv0LWYOkHJkipj0GzrvMDI4qQK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hCegSp76Tg/1I+p4nHXX7CL+Vkahnrd5DCdhcL38gM=;
 b=BPB+KyJ6sl1N2WWHMIcBvbQA4Q+NEfz2Yn1ITH+KbjXr4nEVxIzNzu/I68fhASAr9Khy2mNVmEy7NDIkgbSsEG8D2Vb80uujJDNGrQ9cUQI/3/zWErGquuTZh1UJA2pxeT7rJ28+eGAPdnImeJ8MyaF3oMkh/QXxAs0tfdfGYO559Vo+1WEaBZfpz/vbK2WSEHNWI6OSc4wVmESnO7Pq0BH3ex/E43VZmvmrWA5ttfszzsRXisLzDtpTBZDnf8lnlWXTSGsW4fUQaNbNraoFJAsIjvdlbr+igQSgVYclkkVgo4b7Npnetg/8WxerweD09lsIVDE6a2bZ85ITLZqLwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hCegSp76Tg/1I+p4nHXX7CL+Vkahnrd5DCdhcL38gM=;
 b=U3B29MYfKqdth/bEJOXNzoW4leqzhGGKcd4ERl9r3zvyKC4+vRNikrBXDQUwVK+q9fXED76c7inVn2uku4f6XpXUovauzXRTP4XcW5bvSM38eAPWQ4NOvAxJWw3a4fCil+LFhQ92bCudt8sjhlakF6MQehVE0zm/d/JM6L5H2uE=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0355.namprd04.prod.outlook.com (2603:10b6:404:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 11 Nov
 2021 14:10:35 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::88c4:79c5:1eb1:b969]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::88c4:79c5:1eb1:b969%7]) with mapi id 15.20.4669.018; Thu, 11 Nov 2021
 14:10:35 +0000
Message-ID: <981e78c7-fefc-e145-2d2f-b293266161d0@cornell.edu>
Date: Thu, 11 Nov 2021 09:10:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/2] Fix a bad case of absolute path handling
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20211110203253.2933679-1-corinna-cygwin@cygwin.com>
 <f6a4f67f-1db4-4e53-7907-c7a7dcfbde79@cornell.edu>
 <YYzmt2ZY5UbhMyHB@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <YYzmt2ZY5UbhMyHB@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:610:76::11) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
Received: from [IPV6:2603:7081:7e3f:3419:94c9:84b2:5199:a24c]
 (2603:7081:7e3f:3419:94c9:84b2:5199:a24c) by
 CH0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:76::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16 via Frontend Transport; Thu, 11 Nov 2021 14:10:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6ca7311-4e00-4357-cbb4-08d9a51d0780
X-MS-TrafficTypeDiagnostic: BN6PR04MB0355:
X-Microsoft-Antispam-PRVS: <BN6PR04MB0355BA19F50866D9CDD5F7D1D8949@BN6PR04MB0355.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16UbCnKG+ZcA54zB5/cAqcL5GMv+tk21ZkBIEBsuDLjKHwKAT31B8ujeFyw7qgNCOksTRn8ELl9/RSYILBDaTfYlGdCfCH5+XtWnp5J3ScLPKVkQ0O+OcTpuezDq4zNU5aFDNF1CrUjcm2VCQgcUyXcurQCdr/krwjsVJg8dTc6ilFOFhYCUrV/bTCKWXj0BhOZ3iCjEcTQAWRzF3nOGMTXE5QIRsiXKKq3tx4sFFgI1UwIZEGIee33AZ7Q3gSqRHt+i1O3/VWY/7DddDt7QWk/98m7IxTt1HrN9gVZHc4eiepDZ4VHybF35pa3JJ6jgVFp2+4qrKYOlTVKuZSk+cMszQLVswrVLlyHoUyeAGGvHDahiy82WbHTtVpqRciEAbwzXp+X9l9Bkyh0znJs+aA6wX2dY+f+Ez1N3caikjKIiJrXRK6tskIJWcm++iUoLqIRl92AWCEBh3cxT9YU/PAgmi/g/viRY+v+VDFLWgwv8VWUljxfscWsC69/0Xi3aRGcIIjI67ZykqUjzQxU7bqIOqCZ/uzrJH+ASspSnFCj1qB47ge1TWncNqNIg6ghu9msT6itp25Jf2jG4wxhoZ2VinUwgx6zPPOyBaUi7JU2p6xOfNs3FlzZ3o5KMod8bHisT8RtktsSaZmUFlUlU+BswvlNHyVtXYl9s85eOqOh8Nqdus32TK8yDiBE0xbf3CgcyUQ9uu6d9WWaZ96D5CMVmbUmOn/yjDeYIZ8be9fY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(2616005)(786003)(316002)(53546011)(36756003)(5660300002)(508600001)(6486002)(83380400001)(75432002)(66946007)(66476007)(66556008)(86362001)(8936002)(31696002)(8676002)(6916009)(31686004)(38100700002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3BTelFTUU95NEVvQU9aVVFCazRocThNZTIveTY0NUFwdG1PNThrTkVJUDNB?=
 =?utf-8?B?V0twRHNndkM0R1NkU1lybFY3blJkbHZBUHYyM0RBcUpnNTZiS2IrSjNwTWFE?=
 =?utf-8?B?YTcyWFhyckFQUXBISXZ1a0kzc0lrdGMzZzB4VlQ4NERxRFBwalBCdXNPSXFh?=
 =?utf-8?B?bmt2R0p0QUJUM1ZRVzdzclJYamdCSEZUdG51aEY4b2FzcWVpcWYvNnpwTno5?=
 =?utf-8?B?TFNwdFRjTDFaTUlmdy8vRE5icEl4OTJKdlFaR1l0NmFZUU1PRkNUbHBiUmUv?=
 =?utf-8?B?N1NBSGFPOFpsZ0hWbHhNQXFOaTQ1a3B3RlI2WVZTQU1NRDhrNHdMUDBNRmd5?=
 =?utf-8?B?a1ZKcm9EbU45V3dlQnoxYTRBekNDd0xmWkUyM0RIVDU4R2FNbnZyMkY4Z3Nw?=
 =?utf-8?B?MENqdUpzalc5S2gzRGlFemtqUmhlUm51dlRqeHJ0cFhKSEo4dGdxdkVGTGla?=
 =?utf-8?B?ZjBtWC94b3RXRkUxdHRSd3RER0RQS09PMDJLck9qT1V1MjdVcEkvdzdta1Rw?=
 =?utf-8?B?empMUGFsYVExZk84aWxBWTJzUmYwZzZpM2x2c0htbzhDUWo0NFVINGZXSTBh?=
 =?utf-8?B?WGxBOThCSy9oZU1GaGFyTXpiQnI3TVZrK0lFMzZoVVRSOVM5VDFybHF6cnBP?=
 =?utf-8?B?YUdVZUw2eGxPWGE2Ukt5RTZiemFmeldpeWxqc043UGppQ3FYc1VESFRuVXVM?=
 =?utf-8?B?SWJUS0VGc0xHdkRHRnVWN2JoTDVGeEJpaWNoL2NmcVBRaDFHM3Y5MXVFNVJW?=
 =?utf-8?B?ZnprMVd6UTBtZGVldTRRRU03MzFaNjl2Q3RJYVlQWWJseVRHUE9oZlY5bmc0?=
 =?utf-8?B?QTgzcXRoWDJZZzhWOWNTUUJhZzZsdUkwN3QvUEJYRGhlR2tmMVNkdW5hZnhN?=
 =?utf-8?B?S1FQMHlmOXhnVnRtMnFld0Z3OGRCaTI1NTZVNTFKV01uT1U2ODl2Mis0dFZu?=
 =?utf-8?B?QVd0TEJWTTd0NXluaG83MS9YbTVSRHRjQVlNMzYrUWFYc1Q1ZDhVR0M3b2Fk?=
 =?utf-8?B?SG9nVmZLTmYxMEN4VlJRcUJNTUdhYkFLd0dyalhkamVRdnFzWjErWDYxQkRL?=
 =?utf-8?B?enRoK01FcittenBnU0h4bXdaY3dqZWtyRUkrMHdmMnpJc2dXMyt5LzZsWnBY?=
 =?utf-8?B?aHUzUVZHaWlNVkU5bExDVmhabWZ6d1NaQ3U5bzZzdG03SWs3M0hMVHFCRU1X?=
 =?utf-8?B?SktuQ0RsOHE3WG9YTFFmSGNqSFZ0Qm5BZzNsZmZGWjRaeTRCR3FaWHM2RHRF?=
 =?utf-8?B?bGlLdnBvS3FPb2NDWFc5MERuckI4Q1FHcDJ4K05KbnJZZ0RMVzNuMkh0UkZH?=
 =?utf-8?B?RnhOOVdnc3dPSkhnU3RZN3lZSUlFVzlTQjdaODhTT2I2T0wvbEVOQlQwaE5S?=
 =?utf-8?B?MFhtN0tlU2JXMjNZMFNmQXdqV2JlR1JYVVZwdU1FcHA0V2JGY3FkbkUwbTB1?=
 =?utf-8?B?em5NVnhlRExwd3hDWFh5Ykl0bVpwNFgrSUhVQnRhblZzcjB1TG9EUmJnYU9p?=
 =?utf-8?B?THEyeWVERjBNQlpUWmNtQXhLSE5WYmdHOXlNZDc0OW9lTmtwaS9VakRKV2Iw?=
 =?utf-8?B?eFpSM2ZtSVpMVXlNS0VvL0QrdWtud1RSSStzajZna09vdzkzRUpkT0w3bTAz?=
 =?utf-8?B?V2R6aVJIbEV3ZzBmUk9CUFJKN3ZKOGJOU0U2bk5CUTlDaWFXUXZJdnFWd01Q?=
 =?utf-8?B?V1RTNW5KV1JwejVoa1hlZHEvK25YRkM0VU5OOGZVNHIvODdKV2RrQWJLejNC?=
 =?utf-8?B?MzMyMGRVRk40VGVoWUpCNlVqR200VkdEWXhrOFU2TktqTnRtemltdmdsN0R3?=
 =?utf-8?B?Z1Ntd2lyZVJKb0ZxOGhjcWJjTGpFTWxMalI3TVRud3RWU3RmWnNkb3JmSjVC?=
 =?utf-8?B?TmZORTBqMFFmVWpGeVNhOWREU3RlZ0hSL1ZYNCtkRDlNaXloZWFBYUgvaDBw?=
 =?utf-8?B?MDdjNURHTWxVZm5LZ0FXWjZmaDJkQitYeTdoK0laUWxYRFNPd1I0bzQ4Q0ZI?=
 =?utf-8?B?a29LOXVkZkZYWko0MDFZYjhzajRHeDhxa3BzcW1VdEl0VnR3dDV5cVhxN3Jy?=
 =?utf-8?B?NTBiYTRlYUNHZUl0VnhQdjFVN0xIR29jRlQ0b0lraGNuQnVSTE4wQkphdlhz?=
 =?utf-8?B?U1dpOVpFbmRDZWM5VlU5UjlSK2VtNGJyR3kyTi90ODBGaktNT1VCQStWRUNL?=
 =?utf-8?B?aDJLMXdSWHBaQ3IrU3dMckVKRS9iWW9scGRGcUYzOGhNanpRT3BYcHZVWG9C?=
 =?utf-8?Q?o2EJxNXCwlY5HZgHISl7UngnVpwH6eV3A6Q3B2lS40=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ca7311-4e00-4357-cbb4-08d9a51d0780
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 14:10:34.9430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjrOhIiAfDkhXH2HrAsABDt2Ju9HTsHdQ9aYaLlxRzvc5NBS1myrNOBsmfRumU/BoDbwrQMh9MDpM6IzcaqKBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0355
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER, NICE_REPLY_A,
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
X-List-Received-Date: Thu, 11 Nov 2021 14:10:37 -0000

On 11/11/2021 4:47 AM, Corinna Vinschen wrote:
> On Nov 10 17:22, Ken Brown wrote:
>> I can't immediately think of anything.  But is it really impossible to phase
>> out DOS path support over a period of time?  We could start with a HEADS-UP,
>> asking for comments, then a deprecation announcement, then something like
>> the old dosfilewarning option, then a more forceful warning that can't be
>> turned off, and finally removal of support.  This could be done over a
>> period of several years (not sure how many).
> 
> Yeah, we might try again.  Just not over years, we'll probably lose
> track over time.  I'd appreciate a shorter period with a chance to see
> the end.
> 
> The problem is that people are probably using DOS paths all the time.
> Makefiles and scripts mixing Cygwin and DOS tools come to mind.

So maybe an RFC email would be useful rather than a HEADS-UP, just to see how 
widespread it is.

> For the time being, I wonder if we could start with isabspath being
> always strict so at least X: isn't an abspath at all.

Sounds reasonable.

>> We could also put lines like
>>
>>    # C:/ on /c type ntfs (binary,posix=0)
>>
>> into the default /etc/fstab.
> 
> Commented out, you mean?  Just as hint?

Yes.

>  We could do that.  Personally I
> don't like these shortcuts, I rather use a shorter cygdrive prefix, like
> /mnt, but I see how this could convince people.  Scripts with mixed
> tools will always be a problem, though.

Ken
