Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2119.outbound.protection.outlook.com [40.107.93.119])
 by sourceware.org (Postfix) with ESMTPS id 7A4643858D3C
 for <cygwin-patches@cygwin.com>; Mon, 27 Dec 2021 02:42:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7A4643858D3C
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flIIvT4sb1Eb5lGYrxvx2j1IxHLZSFTRL6h1EqwHnA5s8uQghihi1Lx/+O6yi/RGoLhQsxeTwJZDY6SyjSDvtAa+b4T9SturGHjyil2GzLPqDBd943qL9wOSu9eRmSAomrVJm7eXOSOqtYP1vBz8uJzZ+xHGzDfdtoTifeYDRPgGoPTB7c3D2+xGIO8SfoUlcbf0MNYcPOzt/Wguu7J3gQQy0oECjWoQo5+L+5ZIrl7q5/JXGVZd2IVIWCxeLqY2LDS9joeuUQZ/DK4bFe2ET3bMm9RQDA6IaG565UmW/ETWFY4rut9NfrhYWaStAPx0e0qnZwu1VwxucRkG8QgXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJN23juGUNPE8fphhx0arLQJ1QjjXxVBFIl/j7/SlEo=;
 b=ZPlbLKoYwUeEGck9EOsQH2Km8KzJBpKR1r79/r1QAehkc61johKGgX0se7SBn/cwYhnoqkUxdaAqmm1nGleproUFWIn4IG0J8t7hdDo4tvZkgsruxmhWW0pKzQwCKCvuBghz7JfCWb1nq0m6HgnDdweSst0peGa9nSJZsfkcedQVtd5Wv/UgJRRogX5opf2ikwIbN9Jkj93zGX467Zu9mhB6iHNzddwi2ucGl7Gh6EGLq/0RgsHixN/UasS2jY2ZRVgs/gHjZA4aYYXYgx+o0vYrjJGG13iwOR+qfGCYuBIsjCnOQu31Kh5N9siW1yoXi1QzeRva0hKYUFvOJFXKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJN23juGUNPE8fphhx0arLQJ1QjjXxVBFIl/j7/SlEo=;
 b=GmFyP6ViTiSAqt3y0CekgwySfAqCpSsGzT/1pmIPviUSUYYZrtDEovnm4TbgVz05RcsPuUFyG+qjxBjZwdiD1lIIk0rvVIlksvheS7niGcKjqppod0vNi7bxcbnEZVX2udRTgHBDROdRZP+/crEn04C2iikIatHJiHxEpWife8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB3956.namprd04.prod.outlook.com (2603:10b6:406:c2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Mon, 27 Dec
 2021 02:42:07 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142%6]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 02:42:07 +0000
Message-ID: <a8a83f2a-61fb-4d55-ba9f-9cae88dbc88d@cornell.edu>
Date: Sun, 26 Dec 2021 21:42:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Content-Language: en-US
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <20211225121902.54b82f1bb0d4f958d34a8bb7@nifty.ne.jp>
 <alpine.BSO.2.21.2112241945060.11760@resin.csoft.net>
 <20211225131242.adef568db53d561a6b134612@nifty.ne.jp>
 <alpine.BSO.2.21.2112242101520.11760@resin.csoft.net>
 <20211226021010.a2b2ad28f12df9ffb25b6584@nifty.ne.jp>
 <alpine.BSO.2.21.2112251111580.11760@resin.csoft.net>
 <alpine.BSO.2.21.2112251457480.11760@resin.csoft.net>
 <8172019c-e048-4fe2-79c9-0b3262057d3e@cornell.edu>
 <alpine.BSO.2.21.2112252054310.11760@resin.csoft.net>
 <c7664703-0ec2-388f-64e3-8c46d4590b3e@cornell.edu>
 <d2af0b22-666a-b820-acb0-afc835836372@cornell.edu>
 <317dc73a-fb9d-3937-7354-c79492c1c64c@cornell.edu>
 <alpine.BSO.2.21.2112261331090.11760@resin.csoft.net>
 <b278775d-03d9-6683-ec43-62729bb0054c@cornell.edu>
 <alpine.BSO.2.21.2112261432360.11760@resin.csoft.net>
 <7781155f-d4a1-2e9d-a5c7-2ecc2250a5cf@cornell.edu>
 <alpine.BSO.2.21.2112261520520.11760@resin.csoft.net>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <alpine.BSO.2.21.2112261520520.11760@resin.csoft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:207:3c::33) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd2cff1f-694a-4391-a50f-08d9c8e2796b
X-MS-TrafficTypeDiagnostic: BN7PR04MB3956:EE_
X-Microsoft-Antispam-PRVS: <BN7PR04MB395689B2E2E97DFB7760BF15D8429@BN7PR04MB3956.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvt3E8cZ3Fbpew5UbmSpSb/h4NQrXCRI+Be1RRVoZUfB+A6RgE14UWthqsZbG4E5/TRJBiEidMIx96uVQ43b0fU67xj6XvRP5CRSmSHeOnlFTXFWAZqd0Pt+/FqHgR7UGSnPxYVZ/HKRA2wa3moCYDpPzeb5PY97jYobJYtayiedFOFWvNMcQX7n/K87QF4TAqCVKFrEvEMOrur33Z8F3p5ZBp1+IJ6XqaM25b6zmnSXf/mobYGw7tHq1G4OKEkdpUNEF8DP3GQ1QN1Y85myFKv7qtKrYGrr0dhZgkDzKuJDtx11paEY5pay9FCYpr0AGSQ7Rl/yuZN5qiV36L+mMP7jiIh9ZTZ83hZO1HkBv38iC/0CLaFGErsqcbeqU/G8qGHx3uVlZOgYALBkzp1qJyKG4WjYj96b0TNI9rTgpN86SNx2k1gjFTGrJtam/WHNPnntILPBPk/Q1OQtmwtnDcbWWzkkREJRksx0xhEbH0MjRceV7JLOSfE5kMEkYFmwqOr6zUPKoAd5XRxX0N9e9KjlYd4hd9iQ+nBzMOKx55BtMbdEQmyXzK7S5Z7WpGFeayXIssbYIPOTxShDBmVgPo10+XoBt53N8192NYN6VH6tgsEG1YKqzNChEy5Oip6bFCSa4lJNg8ZG4l2LwsPjvTwmL7K5R1uQr7ypMSO0vMBacVABQD4Hrx4L0J+bWW2hkOtMDrmsZg82hQRDU17YAbuMdrk5h1nsJh/EH7Kn7S0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(38100700002)(4326008)(186003)(6512007)(6486002)(8676002)(31686004)(66946007)(8936002)(86362001)(75432002)(316002)(66556008)(2616005)(53546011)(2906002)(66476007)(4744005)(5660300002)(6506007)(508600001)(36756003)(31696002)(786003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mi9UcEw5ZklwcjdGT05naEpCOUMvbEJLR2hndXVhZDJhTUNJZC9jOTUvNmwx?=
 =?utf-8?B?NWczMSsxaUNRTDlrRVo5dnB3UkZZdWV6Vm55cWdJMG5RcUxwaGg0MFBEa3ZJ?=
 =?utf-8?B?V3VLU3lIb1poMmNyVkt4QmVlYU1XVWFBK2s3MjJSTkJaYmlEYW5hTmV1azBs?=
 =?utf-8?B?MSsrb1JuTTFOWU5valNKOGU1UHZkcWJTeE1UK2JrNi85eHNYRXhQWW9ZamFx?=
 =?utf-8?B?SHlyYS9UNnpkU0NOVkk3ZjdkUTFXNTdIMkpsaTBjc3AyMi80WDVOVGNRVksx?=
 =?utf-8?B?Y1ZRMzBxRWswRFQ5V1Q1eERkbzdWa042R3kwZ0crRStJRDVJUHhVdUt6enFP?=
 =?utf-8?B?RkhneCtGUElDM1NsMHV0Zm91ajJpUTg4RUEra0Q1T1hOMVR0dlkxZmRpZllC?=
 =?utf-8?B?dzBQRWYxK1VlZG52UmFFUXh2K3IyVmJRN1lMTWsxREl6R2F3ZGhkWWtmdlVR?=
 =?utf-8?B?T3l3cHNUVHMrTWpZYVZtZXVHaTNyVUJWME1HVnhmS2ZYVXltZVlVUkl2S0tq?=
 =?utf-8?B?VnB0cE5tcERqcFpqN2hKdXU1TC9tSVhJYytQUExQcCtYS2FQdE9iTlErNzdk?=
 =?utf-8?B?V3ppYThYS1A0UU5Gc1l0RGVaSFQ3ZHZFeDQ4MjZRUFptelppQ1NXM3ZHV2ZE?=
 =?utf-8?B?L0gxOWhnV1M3d3lUZEs5TU45bnQ5V0JTUXZ2R3YvV2ZTN0NjWVVzVktya2tP?=
 =?utf-8?B?b1BuTVhlVzM0cWp3Q05WZW8rbEt2anRTL2F0TXRTWGxDV2xQNlVINlE1V3JV?=
 =?utf-8?B?Mkh4SUFOL0FMZDZ3MDhEdnptU3NUMi9xTUwrNzRuU2NKb1BPSDhyODgxbVdh?=
 =?utf-8?B?M012YTBHUXN4NVF3Q3drNWs1VHY3b2NYcGJRMlQ3YTN3bFFQeWhISWVhYm5U?=
 =?utf-8?B?QWJXZHdUT0QrT0Y0OFdjcUdoZTZtMkNSeFlmOXlSOTA4aTYrNXdLQUxFZlNi?=
 =?utf-8?B?cy9xNDkvR3Y2Y1NRUisralRpc1h4RmNxcmJka2wzU1ZhRlc4azRENDBGWVhM?=
 =?utf-8?B?aXlSVEdjZ3hxeFVxRldFZUxZSkxXYTB2NVNmSUZlTUkzTTFac3FWaG84ZHdH?=
 =?utf-8?B?TEVZRGo2cXM1SGZGYUc2YUtiY05BbElLaTQ3STRUblhoZzhBU3ExMjJhejFs?=
 =?utf-8?B?cG5yUjZ2cG0wRXhFMXdXUkdMdnBIbnc4cFBKWWpiVm5CQml2Tlp1VUVDeHh0?=
 =?utf-8?B?YndPWTVxWHFlOVZEQUZNZFZUZEx0ZmhEampSVy82TXBpTzN0Q0V1aDVYNHhU?=
 =?utf-8?B?R2ozd0F2V0x3dm9YazVuYnJKOFBHLzUvVVp6UDZnWGEyTHZrVWlYWlYxL2I5?=
 =?utf-8?B?ZVgyTEJReHEwSzRSemxUd252dGEyRG4rWElMbUtVQmJZVGNGNysyM3RsTWhY?=
 =?utf-8?B?dFBBOEM5NWx4TzlEbVZLVHp5NzZhYTZCMWtSNnV3K3FKZkI0b3cyK2xLd1hm?=
 =?utf-8?B?OHdtS29HZEtSWmpTOGhnYVZlcmM3MklvT0xHZnhaRS9IZ0tsaEVTdy9uTXNX?=
 =?utf-8?B?MDRicExKbDJlODJkcytaTm5VdDV5N0R4ZmJIdVBFK2dmdDJjTWZ5VEtSYjc3?=
 =?utf-8?B?b3lwd2pWTWdkT3NJWDdUTWY0S3hkenl1aHpLZFJJS1RTRUlLbGFuMmRvU09w?=
 =?utf-8?B?VWZwTHR2d2syOSs0Yk51ek9zK2tkaEJ3S09JdG11alZ3Qkd0bmFkVm1GaDFT?=
 =?utf-8?B?dHkzVmphWlpSTDJ0N0NVMjc0NXpRRTlNMnZMSkZybmZ0UTYrNCtsR1EreWZO?=
 =?utf-8?B?Wld2Vlk2Vk50am5vRzVxd0REV3lQSG1kUUNEQ0Q2WFNEd3Bsa0lZQ2hlMFA5?=
 =?utf-8?B?TWdEbVBlVExVV3hjTGpGdWsyMVcwb3dlaTdtcXNzdVIyL3B4cUYyQkhxWXF5?=
 =?utf-8?B?SlhYVWJaMTdGRE4vRXkrK1Rsb284SHNUSC9uc1ltVUlCVHlaRS80T0RYalRS?=
 =?utf-8?B?cEU1T082Qit6NFdNT29zWXZidmV6aG5tSVEyOEt6clAxd2FldzdVNVRGVzFZ?=
 =?utf-8?B?eW8zT3dIMjNzbXNtKzlDOHVIbXBXOXBpaExxVkJFbUYzY1lJWmdBdk5LYmJ5?=
 =?utf-8?B?NjhmU0ZWblYxSlFnVktTSXZRRnlSTG9XSVR3V2lCZllvSzVYdm1pV3lUOGpM?=
 =?utf-8?B?RkVWRTBiK1JNV3A4VldxVFlyNGxweCtDSytyTEsrcWloTFlDK2gyU0FTblNi?=
 =?utf-8?B?aUFBL1ltUW1zc1JIcG1yTDVESld3bFNpQ3QzRnFBaTNvdmxHcnhMNS8xTVUw?=
 =?utf-8?Q?vJscBrhrNsdIWmS43yQnyJfIUGOZ0mbhlODPtImU30=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2cff1f-694a-4391-a50f-08d9c8e2796b
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 02:42:07.6460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4swmhJeiIN+5mae3J+PkNni5/P1rWvHkfBEpKs2EDN064dEFnOoMM9rvv/wdZzL+uJsMZ6xy2DAsMQJMmgw7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3956
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Mon, 27 Dec 2021 02:42:11 -0000

On 12/26/2021 6:23 PM, Jeremy Drake wrote:
> On Sun, 26 Dec 2021, Ken Brown wrote:
> 
>> On 12/26/2021 5:43 PM, Jeremy Drake wrote:
>>> My loops are still going after an hour.  I know that ARM64 would have hit
>>> the assert before now.
> 
> Well, ARM64 hung up, but didn't hit the assert, so maybe there's some
> *other* issue running around.  Unfortunately gdb doesn't work to attach to
> a process there (it gets confused with the ARM64 DLLs loaded in the
> process).  And WinDbg can't load the symbols for a cygwin dll (cv2pdb
> generally works pretty well for this, but it seems to be confused by the
> split .dbg file for msys-2.0.dll).

Sounds like nothing can be done until it shows up on x86_64.

Ken
