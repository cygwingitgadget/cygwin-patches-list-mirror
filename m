Return-Path: <kbrown@cornell.edu>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::722])
 by sourceware.org (Postfix) with ESMTPS id E7FA83858D39
 for <cygwin-patches@cygwin.com>; Fri,  8 Oct 2021 17:30:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E7FA83858D39
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKKSKDtGdy+c5lk5w4VEK5kxDqiIuD8I6NXk3+rU09djWkjksb0GadZ9qzXlLMauHM/OmaSOQex8XGTss1CNkPaFeLa3gs5vD7ThPPVoNlxlckx+wyxvI+aEMoSxZi8TJa394Yut/St/vRADHTQr158jQ0+j0OPs754/l4aLkUv8gZWmDskr9IGRPGy7YQu5DyyjjwStuLEmYx66rXyvIiW5W5IsIxmPIxnd72H2106cXGMORKeu8+np3eCjTk1lVgkhOOKSFPV4zhu1Iz/iIah5cnLCkhOWNlIpD03renB+AhuEpQN5BPlOqI4MfAicEEfBNx1AHjZO/HybscvDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4+q9kjJhmfzPtv5bT/YqgP6KcrbA31vlkdXqjp3oCE=;
 b=PTX3I+B9eVrjl+vmZAOYNCu3Tmkk7NblT+TI6mXRuj7cZMtJEXeTRcSIWc/ij2QNnp3HGRQQucFPqA1K5YEBKCSzFmCniE2uKRXx9ShLVWrRSNGN7Pz9aD8uqmCLXA3P1Moo+OxFr/ixPPG7+2rDSg7KDr3mSFb+TKdRpG3qGOTLfdGyeYr6TIriiZpTaBxj1TN6Y2LE1FEWYI3cPNtcS6zFlRRK4ghLTLE5O6JovjrTgDh5lO93/ncfs9zOvuqsXkvXPYtgP4rtwNrFui5Pm45o/z9jIEkampnpLnbKDU1Hnbiq8NpPPcdrq8+bPPGZuymmULVlRTsshTIxcLIl2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4+q9kjJhmfzPtv5bT/YqgP6KcrbA31vlkdXqjp3oCE=;
 b=eG/BAjd5+N7pJvEzdR/CRmd/IlPoD9pgBfzI3ASX0U9M7igftFP51HE3RAFp+/umn0RFeW57pvtqvQ0VIgBjhBCFWNzEJBLwsAFR6Ylm8L9MxWVt2nHzx/9pZoZdEt7x1kLq35LTa4lhMFk2escupdVoXk1amd8uIIiF1Uo5ZAQ=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB4399.namprd04.prod.outlook.com (2603:10b6:805:30::12)
 by SN6PR04MB4542.namprd04.prod.outlook.com (2603:10b6:805:ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Fri, 8 Oct
 2021 17:30:37 +0000
Received: from SN6PR04MB4399.namprd04.prod.outlook.com
 ([fe80::5cb0:1b84:d153:2fa9]) by SN6PR04MB4399.namprd04.prod.outlook.com
 ([fe80::5cb0:1b84:d153:2fa9%7]) with mapi id 15.20.4587.022; Fri, 8 Oct 2021
 17:30:35 +0000
Subject: Re: [PATCH] Cygwin: pty: Fix master closing error regarding
 attach_mutex.
To: cygwin-patches@cygwin.com
References: <20211008162854.1085-1-takashi.yano@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <b7b9fe3f-a547-1e6a-d35f-9ed462e28946@cornell.edu>
Date: Fri, 8 Oct 2021 13:30:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211008162854.1085-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:610:5a::23) To SN6PR04MB4399.namprd04.prod.outlook.com
 (2603:10b6:805:30::12)
MIME-Version: 1.0
Received: from [192.168.1.211] (74.69.128.111) by
 CH2PR08CA0013.namprd08.prod.outlook.com (2603:10b6:610:5a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Fri, 8 Oct 2021 17:30:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed4e87d8-89aa-4fcf-2692-08d98a815687
X-MS-TrafficTypeDiagnostic: SN6PR04MB4542:
X-Microsoft-Antispam-PRVS: <SN6PR04MB4542EF4663EC88F90AF1F1EAD8B29@SN6PR04MB4542.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+3qv1s3Sx+OpTEsp3IDqWqAA+tZ8xhhnF5w/92MJnq1ihZrg6aSJuuAFY0fSJSQ9rPBYW3umxINUOmHEr3lrDBlEuN6zDkf9JAxRDhLrmaoof7KAUwj8BNwFhJN2j9GPDGZj063SmQGio+y43sl+JMwPzFO6yLH2QWHGkC6OWVQk5TV9LlkLmDDVVNRcN5pxctJs2lLLELMrGvONCvzN7KxkRrRhpxSuY8BxFfOjAxL+EIbINh+0bODNkKQVEdxB1S2rqtA4yqs2YaEqofOniT2VIpCsjshimGudQKRTv/R4r+8VEGFVpboMXFGPGuYZaYgiNiJCdpFS3UkOxe9NK8CKyLBydfd7/IEMcVgzDLXammBP8m13z9PiI0zdBYZRQ6Jj8OEnQw6NVN/N3fW1BIZ2obUXoYBPXESr/3uhnoXf4h0zrT39/SaDz4RKYX38DnfvVE2wxYpAbqeZThMnB3vdi3KgUKYt8Z9LENIqtQpnHaC2skIK3m6tJVlK+iQV/kU0+aktRvg6DZX2r4/KIED+UD6kr3fHLXMs22vMonyiyQUN+FVii5rMuKn5zupLgDRHQZ5Tev+Fr0myoqewa7gEpHkJ3yXNVPXMA1R/bF/1urqr/n9qoFIcdmyFDLfnRUmBcERYu9Qq4sMhWn6xUo22o1+6AtqrcXvtPVoJEdUKSYs+r41d1fGqNETVFVXAy1hhocS4zadZSjw1FxzjOuZYE1UGo+PKevoG4zkfB9CerRIvlKFtttQm2kdEaMVMrjwh9enVq4fZjyNOc6GTnNu+fB21CURoM8zZK/zoxz7bzVEqoo1yokOYegHcMcYkr2WHr/70GK6zYIhcvaNFiWDI9Wnh5oOsary+XRPPvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR04MB4399.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(66476007)(2616005)(966005)(508600001)(26005)(6916009)(16576012)(31696002)(956004)(66556008)(66946007)(786003)(83380400001)(316002)(38100700002)(75432002)(5660300002)(186003)(2906002)(86362001)(31686004)(53546011)(36756003)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?RiqpLpuQyhtO3n7X7fsG652q70n1xTsWUMIii2tPodOu9VlQN8kHVEoV?=
 =?Windows-1252?Q?mJPnwLlJ/JKcoIdmGqC8e4LFbbkSIHR2iQ3OdBpH2+ZvZtYO/b03rpGB?=
 =?Windows-1252?Q?7eUgDXhEBsh6zitIMqaf8Kc/TFynX7Cmks80oIWEhlMlo6sHMLMuDjJ+?=
 =?Windows-1252?Q?HW3YyLvExDOQJDJDGtJlOOdZPSY/jcNQ5lOYIZ4/2QALEwRHhTwWkL6P?=
 =?Windows-1252?Q?f6TzgaiftGYHAJr7fR9mRJbaREomIhiFKERfNOS+4orT2KkvzJFVgtKN?=
 =?Windows-1252?Q?iLsGfLrbF5+xl7KNjGO4Kft3Hx9m7FRZ2tC6jCqK3bdNYgeRrdSp9/5E?=
 =?Windows-1252?Q?plnwFe+7B02qI+IEV/SKNeYorHfS9RBQacxFcnxsRpldeq63xkVX0lhe?=
 =?Windows-1252?Q?WATbV7JJ6bY7i6iL4y8H5eAfnzL0kijXUBPwHRxudRH6jsOg740uwccD?=
 =?Windows-1252?Q?ZlTmA52dlsAdOqnSDUSqOc+sTigzy19G9BA67VAdo86okF14wEqpa9Hn?=
 =?Windows-1252?Q?2E6kOUZeM9MezWjzqCIgA/kHMir7xdoYMrG9nHOlY0Rzh0L1EzTgsyzS?=
 =?Windows-1252?Q?4ruThD1DfVaJTEmeipiTEufS0iPVNAKCfA856E4em1rDEC7vX+S+xhF6?=
 =?Windows-1252?Q?xXyMQMmkzXgzifb4wOE0ku1bEYeuQHH6aPrjCy7A4vp8VbvVDvedHg2x?=
 =?Windows-1252?Q?HbYjEX1edQw5Km9PBx7K6X9elXkAYtyne/U3fDzAzrHG6QpKoUDvRtSx?=
 =?Windows-1252?Q?Rnf9/9lXAmnXDawFgkbEff1qCiwp+G2HoSC9yovDZOl33ji6xrV9LnfW?=
 =?Windows-1252?Q?pKVB/7Hjbof29TTApxqMQrZblFp+mI4q+JPgoAoL2k6BocbAQMoi2cNW?=
 =?Windows-1252?Q?PVVa9Hmc85BEIP+rqT6A2OtgMgvu/N/WfzpwBScd43Bs4Gz5O9E38YDe?=
 =?Windows-1252?Q?vkFO35erc2T2ZnBNZev5M/r7VflapsgsZpp/7Hj8kryNyAN5vjsC5Ks1?=
 =?Windows-1252?Q?7GTcP4W8J57m90xi/wqjwaom669KB9VXHhwfjnu2SqOTXa5empcKVkws?=
 =?Windows-1252?Q?ZE6KSwEuHIWZTJNmQCyoonFG4qBMpPYmKeOwcSYzqXspTEmZUC3SXyKw?=
 =?Windows-1252?Q?mpcv/o0SmQzM0N4bAYIujtLbQmBo5sLgY81BA98KCfsmmwxYHw7YULPb?=
 =?Windows-1252?Q?WYi7XjkhaMP2Wcx4MSImI37IT4ANBOtVFF7Av45pnFdTxPZXgODcdkTY?=
 =?Windows-1252?Q?p+lFKK8bHOYQiONekhPz2VrAMXEBNUl1PQ4P915cVeq57w9/fR7xnJ0b?=
 =?Windows-1252?Q?z1WCHbVKC83imf3vMykexlIAO/roaWQ8UCCzcVghPutqt1FrfmXCyuTV?=
 =?Windows-1252?Q?ImkZE0IR7AF2w9wT9do6ogmSorWBQk/8qhkQrlOoX/rSQKsHrqlcBedr?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4e87d8-89aa-4fcf-2692-08d98a815687
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4399.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 17:30:35.8067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIYLMDUB3EdQfkxU3KzHdC3v/T5M2Jp2RkcridXcoWvt03A7p0p1pKsL8x+HW9Y59gD9snkjY+w5Akt+Xz/RnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4542
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Fri, 08 Oct 2021 17:30:45 -0000

On 10/8/2021 12:28 PM, Takashi Yano wrote:
> - If two or more pty masters are opened in a process, closing master
>    causes error when closing attach_mutex. This patch fixes the issue.
> 
> Addresses:
> https://cygwin.com/pipermail/cygwin-developers/2021-October/012418.html
> ---
>   winsup/cygwin/fhandler_tty.cc | 7 +++++--
>   winsup/cygwin/release/3.3.0   | 3 +++
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 05fe5348a..823dabf73 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -57,6 +57,7 @@ struct pipe_reply {
>   };
>   
>   extern HANDLE attach_mutex; /* Defined in fhandler_console.cc */
> +static LONG NO_COPY master_cnt = 0;
>   
>   inline static bool pcon_pid_alive (DWORD pid);
>   
> @@ -2041,7 +2042,8 @@ fhandler_pty_master::close ()
>   	    }
>   	  release_output_mutex ();
>   	  master_fwd_thread->terminate_thread ();
> -	  CloseHandle (attach_mutex);
> +	  if (InterlockedDecrement (&master_cnt) == 0)
> +	    CloseHandle (attach_mutex);
>   	}
>       }
>   
> @@ -2876,7 +2878,8 @@ fhandler_pty_master::setup ()
>     if (!(pcon_mutex = CreateMutex (&sa, FALSE, buf)))
>       goto err;
>   
> -  attach_mutex = CreateMutex (&sa, FALSE, NULL);
> +  if (InterlockedIncrement (&master_cnt) == 1)
> +    attach_mutex = CreateMutex (&sa, FALSE, NULL);
>   
>     /* Create master control pipe which allows the master to duplicate
>        the pty pipe handles to processes which deserve it. */
> diff --git a/winsup/cygwin/release/3.3.0 b/winsup/cygwin/release/3.3.0
> index 2f7340ac5..2df81a4ae 100644
> --- a/winsup/cygwin/release/3.3.0
> +++ b/winsup/cygwin/release/3.3.0
> @@ -71,3 +71,6 @@ Bug Fixes
>     in ps(1) output.
>     Addresses: https://cygwin.com/pipermail/cygwin/2021-July/248998.html
>                https://cygwin.com/pipermail/cygwin/2021-August/249124.html
> +
> +- Fix pty master closing error regarding attach_mutex.
> +  Addresses: https://cygwin.com/pipermail/cygwin-developers/2021-October/012418.html

Pushed.  Thanks.

Ken
