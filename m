Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2125.outbound.protection.outlook.com [40.107.243.125])
 by sourceware.org (Postfix) with ESMTPS id B165C3864877
 for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2020 18:57:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B165C3864877
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkNYLkOejyh9QifFzyPTa5ISQxTr8IDbwFtA29D9Ilebx+Wk4xyhaf6xXoR2NW2qfNSBzZg/rVCmai+3/GIGFUxQtpozxYAB/CB7UAg87hL6erfYvOsoPNCqI6NhPOiw3M0GKHctxL4GJG9RZ+H1kTLh1FkVxlpUkD4FuuJT1X4RYzPn/3w3lOo6wHxBSBnwTgUQaHU40dmXYGSdZQ+GsenogVbSocR2l0uAE5b2pmXaTzCc6/SKjQCBbG2Y3snTHT+P3WMXCPxm84HjrVzr1ZkEvaab+Kb2xt4LGYX8SvRde6AwczI7q7Lhnwhi1jv36mYpZ1bNlKBop2C1B/8trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uWsxfFphXghd25FLIzquJHJtNrvqXWOLORxd4bt+Oo=;
 b=IsbBO/FUla8Ue/NXBopLgPv9UcXdvxuySAJMfRMPgFohoc/oyrM3jpCNu2YB8qxaCP5JORUImU1/nn50hWMbg54jaOT7ysAb5oFDr+v8LH+2OK0c23EjL/Hiojm5JLnavZLGVru8ah967feuPXuroNmG36MwUNnfm8cD/WpDwk/N6Fp2ITKWzOZyi+6F1zSqm1qfAGpgWC73PuAjML3Ucry2Vu2bJad82l19O4KrYJy0icf22VSd8xg2X7ak53N3QVUHAfGbq/oZIFPQPp6rRSK0xZ7SL/zGlplFEDFIl5jJE2D63CTsXYcT8WBJcgRSG3T/jT5CuS1kwCg1Hg6+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5613.namprd04.prod.outlook.com (2603:10b6:208:fd::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 18:57:02 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3348.017; Tue, 8 Sep 2020
 18:57:02 +0000
Subject: Re: [PATCH 2/2] Cygwin: path_conv::check: handle error from
 fhandler_process::exists
To: cygwin-patches@cygwin.com
References: <20200908165048.47566-1-kbrown@cornell.edu>
 <20200908165048.47566-3-kbrown@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <8737d1df-5749-379d-4bf8-950e32ee4dd8@cornell.edu>
Date: Tue, 8 Sep 2020 14:57:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200908165048.47566-3-kbrown@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:610:4d::11) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:fc34:902a:527a:1c90]
 (2604:6000:b407:7f00:fc34:902a:527a:1c90) by
 CH2PR19CA0001.namprd19.prod.outlook.com (2603:10b6:610:4d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Tue, 8 Sep 2020 18:57:01 +0000
X-Originating-IP: [2604:6000:b407:7f00:fc34:902a:527a:1c90]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e99c406-f17c-42a8-30bc-08d85428f84c
X-MS-TrafficTypeDiagnostic: MN2PR04MB5613:
X-Microsoft-Antispam-PRVS: <MN2PR04MB56139517398731C74FAE02F4D8290@MN2PR04MB5613.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+X+Iesj1t4H7lpsMSdLrfMeWWxz7uNe206CWcPfNT/q2IN07RXI9sTagGzmlcWiczzvh7O40tUxQwwTRTEeQaa9Qj01k4j684RPh/vogTk9VJesOYIdzNXrNKEZTV1byp6nXgG7UUF4Ii57cC0TsFmISRH8r0QrvvPP3D1MoMl/ug9+5UKKdFLZPfs4aN/DEHwknOpBQ3m41yzxY+6zZ+8KNCCcRyAzQH7JHPwW9f476ed64ieY/MLDodNo2w+ITF5XQ9z/xCIHget1MvRFB14rf4szvLS0QTGMrLBGoyXlPXh4CYjdbs8nOtz0i9mkbJYcv32Q8k5KmMTOb48EiB9BW2kD3smXT8Ntr33Mv/L3NSSY6OJ0NaX1Xcq6Q+8n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(5660300002)(31686004)(316002)(4744005)(2616005)(36756003)(478600001)(86362001)(75432002)(786003)(8936002)(83380400001)(52116002)(31696002)(16526019)(186003)(2906002)(53546011)(66946007)(6916009)(6486002)(8676002)(66476007)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oS+fhejVblY5L9LsPKfVDQGVtrY3cWlecfTAll06WTOxrTg8x76srrUCiFDUlrI3h+qE7Y7WaAITA3wsKpPxYp40iuGIpc8JQpy6fnGv+JdA4TwQC9GSQJ72ydfNxWKSoGgC0K3GX3q+RTEsm65/PpdPCTblocW3CujSTU4RTHgttd68eNJMfeH/oaGYZ89lrVsFRez1aO53JPJT4QWPKy7L++lpFZoD4wVAATczRiLFpqDvWcq1yIerR1WfuKZxxRX4R6K8bVeBEnCmPnk6pXppLE195XCiBuwY53X8xdo6cS7dj3jxkM0waLc3y003LV3uqNKo3qIDb7gCAy3Fj9I9wX75eqqafiy+oqzwXlqugnrHfb0KCeWZN4VjJcQO+x5CEA4Ms8f/z/2EzImytqa+nxF3zmKPO3wiK+ZUDV+VSLpKXG0vZqmZR7mOQMQJ+SiJFfGUqMAeMQKQYmHR1lTKdvULuf5xPhUx7Abqm/xLqLMzVKDA9KnxCkpDpelM1fmGUKxlcCdQ21gTfQXgQC07qp5UnERJK55G3xw1euXg4o00FSE0yWicJ0ZiwKrUWzxSA6RG7gMLlFu5tY8IcYcHm0gOHbkNExr3S4y3pRnIlXg3qT5nhvM5Nc338sqMfRa2U66bV4xr9BrMPGqmKxTrUF/VTuMBL7Fts3g9HHx2Xa4BiGmFj6/UUp7DEaPZ2psbg2UvbnotX2Ex+ZwOLA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e99c406-f17c-42a8-30bc-08d85428f84c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 18:57:01.9360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noJQ+vc3JBBdMs8sxYWBU1qGvbOL1+AxjmYLo7QWnMqV4ayUeyYt0l8EH5uUByzVB05k9N4kYEuID5oK7QfYVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5613
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Tue, 08 Sep 2020 18:57:05 -0000

On 9/8/2020 12:50 PM, Ken Brown via Cygwin-patches wrote:
> fhandler_process::exists is called when we are checking a path
> starting with "/proc/<pid>/fd".  If it returns virt_none and sets an
> errno, there is no need for further checking.  Just set 'error' and
> return.
> ---
>   winsup/cygwin/path.cc | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index 95faf8ca7..092261939 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -809,6 +809,12 @@ path_conv::check (const char *src, unsigned opt,
>   			  delete fh;
>   			  goto retry_fs_via_processfd;
>   			}
> +		      else if (file_type == virt_none && dev == FH_PROCESSFD)
> +			{
> +			  error = get_errno ();
> +			  if (error)
> +			    return;
> +			}
>   		      delete fh;
>   		    }
>   		  switch (file_type)
> 

There's a missing 'delete fh' above.  I'll send v2 shortly.

Ken
