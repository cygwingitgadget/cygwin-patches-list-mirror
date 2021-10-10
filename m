Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2134.outbound.protection.outlook.com [40.107.244.134])
 by sourceware.org (Postfix) with ESMTPS id E16C93858D28
 for <cygwin-patches@cygwin.com>; Sun, 10 Oct 2021 13:00:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E16C93858D28
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cV7wDKqI0DUGLPqbf/WZu6/cUsxewNCrSsg/kj6i96Ys23SxMlyn6Y0HyuDl9ZzEK8QbL/ybY60OG+itLlX+wJTlLl7Hn+RyMZJ8GA9uMwHDyzenbLzdQHCQQloehY/nGlm4FUBQXOFU1zehCH6FxthwYvrGATilOxtFUEazKyyBfdwgU5LE2WAFlxTrMj+Jj4yC3L/aptQ0QJIpE+qtiV7zeGf6JZI3dH6+cXQIx8IYWkzqPpsrx7chc8qDI3/yIMsmqkcpJjGy9fB59Yb8W9SVbpa938pr6XmPAdSY18Fi28oIv3D4yw4nVjwg+FQGL3FsaRn+WnA5IqzG8SB2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACU/tqQ2opZ8CQ9RX8c1+qvCBqq9OqJ1bu9h9jZVuh8=;
 b=FoNBXmo4TtCHNP/7++4FqOny7S6NGpEECW+zHLOjq/e/amqIHQ59J0tKsANDHKjoObhNbYcqORKyrlGiLT4tredIjuz3ZkKTDbFjznpKDdQK14EsRbU+PdrZlDGBLyv2gmztYLYGwamrLLeQhPZ19Vc2ccKQ6kVtrGzBR8E+Xb/OdQjfdZ5bMgNc9rxKK4mkAKRyBpuxw+Bt8vH7OJhBZiHN7knfwuzbbjLC6EbWcr971Z6E0FqUmNI1k7Q5zKoLCleGtNF5gNNM4RkV9lvMf/cLrAVH2rGRjeuh8hgtnuW9xIx8D2SQnqz0Sq+HkhARchhM0HzacyyuVOboG18Now==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACU/tqQ2opZ8CQ9RX8c1+qvCBqq9OqJ1bu9h9jZVuh8=;
 b=Un5rZusM0lbhXdaye4UOtjOiGKDyJ8d4PxzC3SisyZN7BpyWclZgtuSzODHMCdy2ujamzp0lwmfe35FSv9FlRV8RH395nhf7Un8T2YHqJI/J0xfztQLa3wbIkZSXH3yy6P5y9Ai7Gm/+/mVkLswo/1VUo/RKdOupIeHBap5mjwE=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB4399.namprd04.prod.outlook.com (2603:10b6:805:30::12)
 by SN6PR04MB5005.namprd04.prod.outlook.com (2603:10b6:805:92::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Sun, 10 Oct
 2021 13:00:00 +0000
Received: from SN6PR04MB4399.namprd04.prod.outlook.com
 ([fe80::5cb0:1b84:d153:2fa9]) by SN6PR04MB4399.namprd04.prod.outlook.com
 ([fe80::5cb0:1b84:d153:2fa9%7]) with mapi id 15.20.4587.025; Sun, 10 Oct 2021
 12:59:59 +0000
Subject: Re: [PATCH] Cygwin: pty: Fix handle leak regarding attach_mutex.
To: cygwin-patches@cygwin.com
References: <20211010004953.801-1-takashi.yano@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <fc4efc2e-4dbd-0c69-18ad-231344e07810@cornell.edu>
Date: Sun, 10 Oct 2021 08:59:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211010004953.801-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::32) To SN6PR04MB4399.namprd04.prod.outlook.com
 (2603:10b6:805:30::12)
MIME-Version: 1.0
Received: from [192.168.1.211] (74.69.128.111) by
 BL1P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Sun, 10 Oct 2021 12:59:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cc6d897-df22-4360-d7a2-08d98beddda7
X-MS-TrafficTypeDiagnostic: SN6PR04MB5005:
X-Microsoft-Antispam-PRVS: <SN6PR04MB500589D22DD96E9722A82929D8B49@SN6PR04MB5005.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xHAWxDxBrpIrMwtTI6ZePUZDodxBstSpBREGUeM5bV6u+RPYBKiTaysRugNGkUcUVklzPVWW/J59F/ha+ayWrGmZ6SSun/R+84GYthN7ZVaO/Zo5EWKqTcmHYFMeGHNd8DWlQhKpeMKGfYsC3cFpClV61g4FiXLgCQJ3YzSv4qD2KkoNS211O/weSaR5RARcy6t89iFtPZ3y2MYinmI6nzoPszN8bqQZUsc50OZB2SwOtsqRRCwDhqVK+4GimUTC2H9Jpn57Q7C519Uq11S8FhOgCmrlCxE1xFP9CBzQg0bEJPqUIM0A8dr1giUhF7711dyHs/Sr8WgAnMyTx8hqoLuNmmT84/2AAUqQpXTDkZVWjdCDJt1OVfpG5Wks+Upz0yWXGsHWKE2wuKWVD/KiJ0QW16v91oAZ8YoweEf3hOBFDmoXJeJC/LozvExZeTPeHgNggbb9lR7Jf70IG3JqmPvD+bytc/XSe/QqVb6sY24ZdVvNt+52ZGYC1a4Ki8ozi0eajPXF371Fyl4Z/RP+DOIn32kCSfF7yI17AUWuRSS709mRjpkMClAF2o013rrsR7WDUAS4Tw9gnu3TfxAk+euKpn4GJRB9mrMISZf/WfaD38SqsBznl41zUE6kNsoVJUjAO+m29ej99VCph9kFlsPK/dJtRozpraEEf6EvTWEgPUMqgeTHmcZGTRgniwpzpP5TWK0Ii8WuWvAT03wqi7gJI8TuLxMoa+3H42CAfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR04MB4399.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(2906002)(86362001)(75432002)(316002)(16576012)(786003)(508600001)(8676002)(83380400001)(36756003)(8936002)(6916009)(6486002)(66946007)(5660300002)(2616005)(66476007)(66556008)(38100700002)(956004)(186003)(31686004)(53546011)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?o/4DvPwAKA2XPlkzOU4wDe82GGceILnipgM8HGmuMQiWE4E6lf9YI5vz?=
 =?Windows-1252?Q?d92WkdCvmagQpCowp6Nb7TJks/s/8geFGs+9eeYgSCo5pbt3qFu6uM3q?=
 =?Windows-1252?Q?A5yvO8z68FomtUVWPTNkmA6wuUonpFy1LIVGIEy+6OzVY1GWLzKI5vel?=
 =?Windows-1252?Q?wlXh+JakbVzZtJgh/vCKodXFdGMNR5h22p3IHiy7RI/bGYhaKDEPZa2Y?=
 =?Windows-1252?Q?q3pRqHrJM0jqnn0FwWd5oF/4kqLq34SFEHaVfW+3lQvJ8rAiYzb+HZlb?=
 =?Windows-1252?Q?nFIYpylKVg5qMuDuuJyD557tBabvVS4e8GCnmNT65RscFoQpGDiwXR6C?=
 =?Windows-1252?Q?o4jQMjfiXDBXMjc9dHdw0Gn0zBydKCJlBLtlY8LF2G8llfFfDu28N1QM?=
 =?Windows-1252?Q?Nuu3nVjMo/JHBVPdycF0ImVM8Cq1V72K3/KDW/OQ0PuuMO/943aVWMcB?=
 =?Windows-1252?Q?QmGrCV594OwEE96h+MxZiBQMIVb5NHj8tSFXaqPL65EZng4ADg9j8Jtt?=
 =?Windows-1252?Q?+rfJO3i7PoH4ZHaVV9xnzntsXE9MOkRMvIuB5FJLQiC5rGD0ApEpTxqU?=
 =?Windows-1252?Q?hO8LFsZ/8ioqG++C1xV1l8ZHYRJJWyYJ6/Tfn1IAMH++5pwV84l1MTJq?=
 =?Windows-1252?Q?5vNFaTWAEJz4MQbxS0hkUXbeVKPMjOZHuv8LVZNrOfjyIvnq0NYERG0W?=
 =?Windows-1252?Q?gmMPyyla+Fyty/3P71h7+HRSb4dyUhLgagPiu9BtYbqkfyt53bugg0/g?=
 =?Windows-1252?Q?Pc7xljObV2VdLbR4nBy2K82R/dVtZGfGGIPeg4jvqbe3lO1W26k/oXfQ?=
 =?Windows-1252?Q?JVuJVADuVqU57ETH+aha63cn1E415nPnXAwRu+VsNeuLSOdCseVYeAmx?=
 =?Windows-1252?Q?1HOrwgcIDTIiFFdHlzOxKxr1MjI3fKWJM7Nbcb7j2H1wbi2S/4Di3faC?=
 =?Windows-1252?Q?f+pEH6vR1I/l8tPX7K6t/TLZP7b1MsOgRHsx+4cmtfuNBfESCDksFDld?=
 =?Windows-1252?Q?69LcnVgOQ1mvLbwPmdii4SoPC93hUU06Jmfzm3a8LBlbk36aO2EhsWRI?=
 =?Windows-1252?Q?QViCpjohscXafFwS/uK6R1eCyQWRB3jPwtE36Jof4dtpQraJ85QgvOE4?=
 =?Windows-1252?Q?lqR9kWmNV+hWB25zxerPdIlt7knvZPcKO27871mEBp0l99UbPi8C7QO+?=
 =?Windows-1252?Q?EAMEsEnudGZJTd4FyWmvvkWdYGIHr0Ps15gKLd75HaDhL4ddj6idS6AH?=
 =?Windows-1252?Q?Vs/wuietG8e0fFCmUQhk6BEhq4ZkeLfow3NdoHAiNOUr/FSjxUmWxLSw?=
 =?Windows-1252?Q?6LKS4pBIrmoFeT//Jz8CrsiRzMyH/xM5qpHI7rFnu0T4gsX92FLs0+lV?=
 =?Windows-1252?Q?6pUaRboN5t1MrFM14H9uXuuGtXi7L42tBgP6mbPfOGyIrz1V2lnkywZG?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc6d897-df22-4360-d7a2-08d98beddda7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4399.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2021 12:59:59.3749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28GQeVdofTs6OO3FmqSaBl/tpYrCw7dqIvchaMw8BxVagdDYZYx1+TuoZL3Q8FjEZ3YIc3NYAUTgklI5pHrjPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5005
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sun, 10 Oct 2021 13:00:04 -0000

On 10/9/2021 8:49 PM, Takashi Yano wrote:
> - If the process having master pty opened is forked, attach_mutex
>    fails to be closed when master is closed. This patch fixes the
>    issue.
> ---
>   winsup/cygwin/fhandler_console.cc | 2 +-
>   winsup/cygwin/fhandler_tty.cc     | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> index ee862b17d..aee5e8284 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -57,7 +57,7 @@ fhandler_console::console_state NO_COPY *fhandler_console::shared_console_info;
>   bool NO_COPY fhandler_console::invisible_console;
>   
>   /* Mutex for AttachConsole()/FreeConsole() in fhandler_tty.cc */
> -HANDLE NO_COPY attach_mutex;
> +HANDLE attach_mutex;
>   
>   static inline void
>   acquire_attach_mutex (DWORD t)
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 823dabf73..f523dafed 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -57,7 +57,7 @@ struct pipe_reply {
>   };
>   
>   extern HANDLE attach_mutex; /* Defined in fhandler_console.cc */
> -static LONG NO_COPY master_cnt = 0;
> +static LONG master_cnt = 0;
>   
>   inline static bool pcon_pid_alive (DWORD pid);
>   
> @@ -2042,10 +2042,10 @@ fhandler_pty_master::close ()
>   	    }
>   	  release_output_mutex ();
>   	  master_fwd_thread->terminate_thread ();
> -	  if (InterlockedDecrement (&master_cnt) == 0)
> -	    CloseHandle (attach_mutex);
>   	}
>       }
> +  if (InterlockedDecrement (&master_cnt) == 0)
> +    CloseHandle (attach_mutex);
>   
>     /* Check if the last master handle has been closed.  If so, set
>        input_available_event to wake up potentially waiting slaves. */

Pushed.  Thanks.

Ken
