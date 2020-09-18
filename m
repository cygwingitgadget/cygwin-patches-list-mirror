Return-Path: <kbrown@cornell.edu>
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690106.outbound.protection.outlook.com [40.107.69.106])
 by sourceware.org (Postfix) with ESMTPS id 5F5B239540F0
 for <cygwin-patches@cygwin.com>; Fri, 18 Sep 2020 11:59:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5F5B239540F0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDOfIN6ykCoWLPZ58Wjw/Oid+ZcLgKnfgoA4ImCJEVWEn/n6uTCqD28jK1IyC6craJaAqE+fVQJhy1NfsLWgmWyd6SB43UkwrVd2qVSjSwQfdumz/Lay01TKpnrgLuVTulFEfH1sxs9LrHqVEXZQTeZmB0IhOUZsBDnNSh9ffRc/pAphY9Vx3riny0LO8W3EgZIbxiXZMdiraO/Sbta27nvKXcl24r9hybUj7kulrtMfyj8iS532f19bSIdOWeXx8l6a8Gq0/x5o+kVN7JwKZ9NMKXqiW3Br4KKDq2A2+pGzzsLLCRhl3GZ5TH/7k0zIYrkvpQfnt31KoIn20wYwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9i6/5qx0eSiYeppzue2+HXL2qRDJX5edNu3GIvvBWMI=;
 b=bX1CBpgbZqM/7SXRKoQV6wupqO9yDtIjku2KsIff+rp0MHRifZ4Y/7ByN2qpmNPGEy7h/h1jWd00YoeLIIymg8xNNsioMRIOVenEa8eMnL39vF1IxmeDdLXP7dWaD1/0rcl5kJ/iY7+RxdRRsls13910Z+braZnwLjpPrw20cBsyqM5CHx0zt6SyW2u+Wg9/+a/nsjKiUexWX6CTWDfMpRz+PVuR3/dmr2vUYUN52FBxnOcMwZqowpQeB8LXI9hDjoPfxCtFC1giX6bwmjYh5mrs8OVVs5qJxd21jN/rUBptQ6eEtEcmvL2hJjrZe/oZKXbrR/CDGa+Jtqx2xkg2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6158.namprd04.prod.outlook.com (2603:10b6:208:d9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Fri, 18 Sep
 2020 11:59:10 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3348.019; Fri, 18 Sep 2020
 11:59:10 +0000
Subject: Re: [PATCH v2] winsup/doc/faq-what.xml: FAQ 1.2 Windows versions
 supported
To: cygwin-patches@cygwin.com
References: <20200918025335.43795-1-Brian.Inglis@SystematicSW.ab.ca>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <ea6c7db5-5c8c-6e5c-d9be-6ffa50f2d236@cornell.edu>
Date: Fri, 18 Sep 2020 07:59:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200918025335.43795-1-Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:610:4e::18) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 CH2PR02CA0008.namprd02.prod.outlook.com (2603:10b6:610:4e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Fri, 18 Sep 2020 11:59:10 +0000
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10394626-b719-4ca7-72df-08d85bca40f1
X-MS-TrafficTypeDiagnostic: MN2PR04MB6158:
X-Microsoft-Antispam-PRVS: <MN2PR04MB6158E7085313CF876413E032D83F0@MN2PR04MB6158.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Xu4dwBaOIPdPzpig+z+e+S0+TKnbvHeY8UlaPsL7wYn1GIza7iCsYpI8XoOAGOpRtppD6DV2gUyhML4Q+SnDiiNlrhqGRX02KcRHaFtXEHFRazg7ItndjVd6k4D4XyN+gMsaq4L0oSpnxAY0ZoePtif2T4lTZI4PK3WR9Qk9XxWUv2N2kuSQnVIZl4pi7MLorKkl9PjEZjGbpu0L9LwSBjOe1bWuJQUa8AMn4cLr37UcgnPIVCDBMoEH5WvPMrZpmzeDHRi9326NZsgBx2izzgov5fsjB4hYkHjIScpYODIjLR5JiLusB9lFHXFqY8L9qHrwwooO0eWognKoHeUXcReRi0M1btRFbBUdicBOK1eFdC7lTWz11SYDegdJVAx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(26005)(5660300002)(478600001)(52116002)(75432002)(2616005)(956004)(53546011)(83380400001)(36756003)(31686004)(31696002)(86362001)(8676002)(6916009)(6486002)(2906002)(66946007)(16526019)(186003)(66476007)(786003)(316002)(16576012)(66556008)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lfiX+uNOaSzSDGOPRBHN2wSYP8Ypxg9hj8gnSLm96n/8vK/BZ3utKQ56L92EOv16/qG21wx3hDqhJ7tdizSRNEyxwJOtD/FaQcOuzox77DLTNQtJGlH1oM+URQmj+HanMJHJJ/ncLiIU32wePfM19M07fEW792UBMgKqNWnvXR6IE6wziT56zra9T8C+y1g2WTObuQjn43BvEVNRM2l2/hCcjhE8KpDSfL31B22RQGXH/20KP5ZV8oZuWy3hkK0iDe2f/HsULtrP07ibCFgDlOvmJLNv3EXoCm/rkyCEkfyaRpFUekFutSFj1eyxgZcu9U+lrd/ofb8jMfCJ/UhQPLSzdYdp/YNsvqSQW9d+IwB1BGtFG7hbTZqNbOo1ijEMVSZSeEZ0f9cfVCShR9L1UMKYVvj1fN0DphATI4nA6PMY/saP2NQz36k1e9lURkg+18EutpHc5crt/7vnkMGZ2B8Kqjmxrrd+r/Arz8Y1nwGZC9qMMBjreV46VXt+g6Ij590uftEunoUO7s7/gZ0HkpUWRzKST6wtQOtUSewS5brRY58izGTlJOa4+eWH72kDmhah/lpr3VmuSYem88GA1pWKOMlpRgHhD55d7Qcqk5ipejswiCeIlvltW2ND3cENlDszsDpDiZlJpRxMMVmmAQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 10394626-b719-4ca7-72df-08d85bca40f1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 11:59:10.5581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYjNFLx9EShhBzwbMIMoF4zBrIRGaJ66J9NrCUUqjhatpLIklT3CixuBmu4YjAHoV42lxItdvPyT2fzPbqxbfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6158
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 NICE_REPLY_A, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Fri, 18 Sep 2020 11:59:14 -0000

On 9/17/2020 10:53 PM, Brian Inglis wrote:
> enumerate Vista, 7, 8, 10 progression to be clear, and earliest server 2008;
> add 8.1, exclude S mode, add Cygwin32 on ARM, specify 64 bit only AMD/Intel
> ---
>   winsup/doc/faq-what.xml | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/winsup/doc/faq-what.xml b/winsup/doc/faq-what.xml
> index ea8496ccbc65..77ba1c5fdd9c 100644
> --- a/winsup/doc/faq-what.xml
> +++ b/winsup/doc/faq-what.xml
> @@ -30,12 +30,12 @@ They can be used from one of the provided Unix shells like bash, tcsh or zsh.
>   <question><para>What versions of Windows are supported?</para></question>
>   <answer>
>   
> -<para>Cygwin can be expected to run on all modern, released versions of Windows.
> -State January 2016 this includes Windows Vista, Windows Server 2008 and all
> -later versions of Windows up to Windows 10 and Windows Server 2016.
> +<para>Cygwin can be expected to run on all modern, released versions of Windows,
> +from Windows Vista, 7, 8, 8.1, 10, Windows Server 2008 and all
> +later versions of Windows, except Windows S mode due to its limitations.
>   The 32 bit version of Cygwin also runs in the WOW64 32 bit environment on
> -released 64 bit versions of Windows, the 64 bit version of course only on
> -64 bit Windows.
> +released 64 bit versions of Windows including ARM PCs,
> +the 64 bit version of course only on 64 bit AMD/Intel compatible PCs.
>   </para>
>   <para>Keep in mind that Cygwin can only do as much as the underlying OS
>   supports.  Because of this, Cygwin will behave differently, and

Pushed.  Thanks.

Ken
