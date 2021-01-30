Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2104.outbound.protection.outlook.com [40.107.94.104])
 by sourceware.org (Postfix) with ESMTPS id D65DB3857811
 for <cygwin-patches@cygwin.com>; Sat, 30 Jan 2021 20:58:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D65DB3857811
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djMagGUMmlokjm84zgezEkspw9bdRZ2kfs/ysVuAfWiicAy4u9lfRuL7tJ1/Y2zpGo1QyOzZ18wBk2fhGm07qSa5wGAK88quQueOe2wze1PgIOANx7w2veYqQ4Ioy5Oj3SkW7EWaglpN9u68+2oAsAJY/ztvAZdk9SxuYQ/Yzr9hlLWfH82RafNnuuuVCeJFr9B2khndHJ9pxsH9OxhkC3U1TxlPbZq7xEbjdfEsY0wVZkHaaSghxR1UYBAtZHvkHAyjqTrhDXyPcPsYBYi+XLQR9NuQkN7DdH1uHUKGHpcNtQg4uzNibxSfjAJobnASHuQJ3Ru6LYnywYhKFh/o1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k3J8hLpnY1NkgMJBCjBxd4RQe62MezpEx6i1Ow/n3A=;
 b=SlyFPa15l6IwSIigauKrzJHDj+MhqtLPKLI2OwHA/6JG+8DNMiCtDiXvEHWzLfE5kdi7sC1OZgDiWy4IP9Fu2/fjduNgzdKDJOyOATaMOBBw9JCq0Yyw/sjUomIEHX0mjyZQoxNnevUBAMCjnVsmAxbPsBFlyMIfgACRuYmQEj/5V/OXPz4QBthI3bzxv9fjpaXDFvGR2XiLWde3h27F3r/6+MCB6m2hHesnneNL5SRkDgELg2xHsm77vrn70oWJvreB0+zqvKeDbnUGgx41FODh4lWzTo1rb3Y7kreyR/DnJJb25alhgHLrLKYLsLKOdDf5bKOe/reG14HfpWDaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB3843.namprd04.prod.outlook.com (2603:10b6:406:bd::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Sat, 30 Jan
 2021 20:58:32 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3805.023; Sat, 30 Jan 2021
 20:58:32 +0000
Subject: Re: [PATCH 0/1] Recognizing native Windows AF_UNIX sockets
To: cygwin-patches@cygwin.com
References: <20210130163436.21257-1-kbrown@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <3adcb542-8f3a-1dc4-20d0-43551f52f67c@cornell.edu>
Date: Sat, 30 Jan 2021 15:58:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210130163436.21257-1-kbrown@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:404:10a::16) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.4] (65.112.130.200) by
 BN6PR13CA0006.namprd13.prod.outlook.com (2603:10b6:404:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8 via Frontend
 Transport; Sat, 30 Jan 2021 20:58:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a4683cf-d21b-4459-c488-08d8c561cd46
X-MS-TrafficTypeDiagnostic: BN7PR04MB3843:
X-Microsoft-Antispam-PRVS: <BN7PR04MB38431DB8FF41C8E1197B501DD8B89@BN7PR04MB3843.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1yfV3A9+0O/fWv0AsvY5mfb0rDXqHk9/2hZMdHJsStrgsUen8cvK3+RCBMPddxrfgICZ8+Q9naxh414TdUidNbcQpC5W4+KuNH6tMcT2zJK0yxgft5G7G3giU52nfZN+lyEo+pc4lx1mraHhA9cgJgRHPXO1Ipb9pGXT+b8j5irkGAQGjYDGl9G77scxMn7ObaVhLs2mVGuiBvuH6ZIa5aR1Y27jcpCWVHoBrOCsZtuVBrZYvrgB0IMhpVjfxNkAVOhYjkpEysObYaxnH+v110ZvYy/VkZzs9a+T+ejimh/GlwELpPY643Dg1NZZ3hEjrcVPvQTgwalvlbJ7g2KxU7nNNZ2NgJiWr1NMFQO3k5QCru8Cnr45BMe7ICg1eO1Q+QSdDm47zmPPmPC+oWYugHu358HkH0Fq6amk0BFKrZJW1uIYWYy1NBYP97ovlOcw15QZ8zhteO2y+7+jnRflQMnJtcjRz22LqUa4t45zpoiZHkzqnpaZ7Of8Sd3UuIrXOGvDjtVZmz9kLxpVpaZloUZHd/a8QX0Fbb+oN/gwYvhMRD3WRHAwk2CVrdyfevj5e2TMyljh6nfns3yBFMLx2gxlWVdwoS2Isz2+6DKXIV2PoxNQwYN5OqWWIF4pGZCtSO7/rQ7q8h8GOJwcS4ldUQFyodjMCotbXHjWbpGVHZlrsO6XBQXtO7ChFYBWPR7RAlqnbuhmhSmgXkIYIjgIthfR+2ROUtbWNLrEwRaAXNCLBjAo76YaR+KkwoPAXdp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(31696002)(478600001)(86362001)(75432002)(53546011)(31686004)(26005)(956004)(2616005)(8936002)(186003)(16526019)(6916009)(966005)(6486002)(36756003)(8676002)(2906002)(16576012)(316002)(786003)(66946007)(66556008)(66476007)(52116002)(83380400001)(5660300002)(45980500001)(43740500002)(460985005)(2480315003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?qRGjFe3wtsAS+etc6MGZhfJTWeoOnVp4/FlCOz7XAXS2x0olLRBMLHhE?=
 =?Windows-1252?Q?SmdraQJrWwIQWju+Iasq221gOzxbM0EbNOdfvVDPZZn7vXm0UxsMgEsA?=
 =?Windows-1252?Q?NqeqLmzzJk9omjoaMCrv7X23PRtRLaOrUkBqciOqwCURgnxJpsiwjYq/?=
 =?Windows-1252?Q?Cep5dV/AEUNXGRN9H41/jTYEZ0D1MBHMyFE0woCqNyoX2FpxFKrA00ee?=
 =?Windows-1252?Q?NilEYeZXqMDLvnQPrxRcjbZ0PBDPxA0CZbMLWlanZ1EdiuH+mPHXl+zV?=
 =?Windows-1252?Q?LfG9CBctLUd87cKC9Fb/dQf2MjDTyGrOzx0nJUg19sX+AFSBI9QpFnOH?=
 =?Windows-1252?Q?IrSnmH1CKh+CoWK+XjdTN2luBwVk5Od5FUe6U1341B95sp580/Cqqz24?=
 =?Windows-1252?Q?pQOwvg2D/vSvrC21RqNnIvxKzzBk8CK9ZO6dL2eM35dnsDKDK8Xug5GI?=
 =?Windows-1252?Q?IrC+/V5nxf7illDMBNY2sEIwYskcZuVchc56q8OAlSAWSjlJWBdCTYMh?=
 =?Windows-1252?Q?L79hxp6zRhrFoyycrPkFB6qwXOFrhSYVS+kJ55U6akhIl+dFNkct6V1W?=
 =?Windows-1252?Q?Xpz921kWHoOi2wb/e6TcnK+JE/c2sEXW2TZN/UFG3Uxs7zoosTYp0PKg?=
 =?Windows-1252?Q?I4fRYNG1JN9wx56aoR1VqkwJ2rNd5fDKwhZRPkaBl69QwCysCzUwxA2x?=
 =?Windows-1252?Q?tf9ypB0cCKoLHImvNlM7gQ4I8hILlW4429TTGJaUGxsbO9xSWBb3P2Nk?=
 =?Windows-1252?Q?eWNgbES63fNJRljZR/kmr7Xa3x/Xk+cddZ+drcOp2JhjzaVnNTEtdgO9?=
 =?Windows-1252?Q?2fEW4+xSVRbvxDOh4iUI9UUD8evGsrowkoohAb4evIypfe4jJ9QqYrJX?=
 =?Windows-1252?Q?AiNgHsnxCOCZRAN5V1/97F/FlYd48vCf0c7oRxg5+JsS/sCbkobGWGvU?=
 =?Windows-1252?Q?U22+yVK5jgoJl0jBPNebG1Qh1CAA1/Nur12/0KAKniXf7RQ1PGUxQOMc?=
 =?Windows-1252?Q?fYdY2HKhBGJcq8xp6VpOJAdB6bURbxsJziN+v7Om61Tq/use2i5cknqL?=
 =?Windows-1252?Q?Sx55qjrBkCpAVgBu+63c2o57PHHUr3918z3YaVR3Z5rmLdHvaVQgVvzf?=
 =?Windows-1252?Q?y1raMDbnhClR+ZnT1q4CvA0T?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4683cf-d21b-4459-c488-08d8c561cd46
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 20:58:32.0841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlahnRN0iM/KLH5ZVg6+yT8OxRfLKBwPucYlMLPoefXrkWjOH9MHRjYcaY9Gd/Q12TuO4GFt2gROg46pswCORw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3843
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Sat, 30 Jan 2021 20:58:37 -0000

On 1/30/2021 11:34 AM, Ken Brown via Cygwin-patches wrote:
> This patch attempts to fix the problem reported here:
> 
>    https://cygwin.com/pipermail/cygwin/2020-September/246362.html
> 
> See also the followup here:
> 
>    https://cygwin.com/pipermail/cygwin/2021-January/247666.html
> 
> The problem, briefly, is that on certain recent versions of Windows
> 10, including 2004 but not 1909, native Windows AF_UNIX sockets are
> represented by reparse points that Cygwin doesn't recognize.  As a
> result, tools like 'ls' and 'rm' don't work.
> 
> I will get access to a machine running 2004 so I can test my patch,
> but I'm posting it now in case someone else wants to test it before I
> can.  To test it, compile and run the program native_unix_socket.c
> appended below, and then try to remove the file foo.sock that it
> creates.  This should fail on W10 2004 without my patch, but it should
> succeed like this with the patch:

I've just tested on W10 20H2.  In Cygwin 3.1.7 I see the problem:

$ ./native_unix_socket.exe
getsockname works
fam = 1, len = 11
offsetof clen = 9
strlen = 8
name = foo.sock

$ ls -l foo.sock
-rw-r----- 1 Unknown+User Unknown+Group 0 2021-01-30 15:51 foo.sock

$ rm foo.sock
rm: remove write-protected regular empty file 'foo.sock'? y
rm: cannot remove 'foo.sock': Permission denied

After I apply the patch, all is well:

$ ./native_unix_socket.exe
getsockname works
fam = 1, len = 11
offsetof clen = 9
strlen = 8
name = foo.sock

$ ls -l foo.sock
-rwxr-xr-x 1 kbrown None 0 2021-01-30 15:52 foo.sock*

$ rm foo.sock

$ ls -l foo.sock
ls: cannot access 'foo.sock': No such file or directory

Ken
