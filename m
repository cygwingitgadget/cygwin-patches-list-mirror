Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2092.outbound.protection.outlook.com [40.107.94.92])
 by sourceware.org (Postfix) with ESMTPS id 1C737385840A
 for <cygwin-patches@cygwin.com>; Sat,  9 Oct 2021 14:19:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1C737385840A
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j71lgLAVSkpKuGRQ4Qo9yPwEJ6eg9/npG6+OTh8yQRsFdoz3KY3jyBSPuRCrojYcSZenQSK50WQxMbhHNxXav48Ul0tjh6nFIvv34/JuMdio5Dbz2McaAXP/EWPE42Sk6ckmMa+fBqbETVBW/BK0eGUH4bsCUsuwn8tQc1oN9DBLJRe70qQF2QGf5hAHzSNbqm+S6eVv6t7LssqHcbt/cbOY8lKy0gyg9uDZx8PDIiD0dRzyeosJBqvfDSXf3wzmgNa/aD3zL1RscA2afLCRV2zXF3Tiipv3SZw+7Pn4Q81O0J7wnOrCftFNsbJLjOKps1Df61cSUwAeX1sR+yxb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMfkoVP0VOxebautE5fi06RaOFvxL/hXiL3j5d7nr0k=;
 b=cfVOeMzetfY1ZfPq4KtgWcICPy3MRv1WCw3yRI9WCFMtwa++t5KPDQET3vGSZUQcF2Z+sPIKFMziaGCwDtx7XZRdKzVujvKZv5IbyAaj12s5Vl1hBNAEX2pq1yKmPpd+cn3gP2BD8fGd0pcRkhpVBSSFoC+KzUyMgCGbPEa5TCid29i7Z15RloA+vetJHimug+XA/m057wFNpFUhlZk3DSPhRz0lVkm1ifmqRSkiEngQdweaImsVbSmAhhivOKJYLkVmiLysX7PzG9a3jk4zB1WlWHhLPuomN62NHQGqL9imw0gMmgFB4fLzd4+2gAKNzdVde/vn0/rJDd9tpv4FiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMfkoVP0VOxebautE5fi06RaOFvxL/hXiL3j5d7nr0k=;
 b=REzCi7/3TBDY0ir4p5ImtdcM1qoIOiX0ahrRP2EtcF1WDVFQYzZt+7FP7aKqw3n93HCztiCT9AbHsOWsQm4rJKHAJ4nHMARg9+8rVDsxeyYSQejUiq1t6DrtOz/X3WYstPOFZB6LquPIAMblUSYLfAmqfg0yoyRadiE3CrsdLnU=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB4305.namprd04.prod.outlook.com (2603:10b6:406:f9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Sat, 9 Oct
 2021 14:19:21 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::d1a8:b6b3:dfd1:b093]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::d1a8:b6b3:dfd1:b093%6]) with mapi id 15.20.4566.026; Sat, 9 Oct 2021
 14:19:21 +0000
Subject: Re: [PATCH] Cygwin: Make native clipboard layout same for 32- and
 64-bit
To: cygwin-patches@cygwin.com
References: <20211007052237.7139-1-mark@maxrnd.com>
 <20211008185210.cac713f28dea727a1467cf94@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <29514de9-0d19-0d22-b8e1-3bfbce11589b@cornell.edu>
Date: Sat, 9 Oct 2021 10:19:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211008185210.cac713f28dea727a1467cf94@nifty.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:610:b0::18) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
Received: from [192.168.1.211] (74.69.128.111) by
 CH0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:b0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.22 via Frontend Transport; Sat, 9 Oct 2021 14:19:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 839e74c9-ed5d-4713-9785-08d98b2fc9d5
X-MS-TrafficTypeDiagnostic: BN7PR04MB4305:
X-Microsoft-Antispam-PRVS: <BN7PR04MB4305AE5FCA75FEC3EDC5E7FCD8B39@BN7PR04MB4305.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:238;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RUAwyKDCd6Hd3uI6HXyeDoOOhOp/lVhe5kJen0BGvJiJuwBAp+n6efAdt3cpQR2jdHyky7EEMYgc4siQu9WubW+8agdKIjiDYPeXoGMjhJnOX4FLBt+LMQfhW6B5jVw87RXcsmzUiKkFdtKn0AdOYMgCWaDDb3NyaL6VP9kYILaImFJ2AeMmkzw+oDNs2jy95wMVK/SmNglL5cgGHktii7Ncv8xbDqkdhdeJsGkDJ210QOWXebzWZSurIXzShxgEy7A37+xceE4ZCw+9rWStcMYAjDoesqngXVUfRHyY/RLaNbr8DXtc1h/mqvanMrUQixoxZkr4wt45u6NspBB1FLFYRNwTujjGiyawwaXlBwMrtjFN/nDsJHfUfX8bAfAZNTlHdjf94575K8Inu0zWI7HauS5Vs7JGZv1W9bUQANPU1IK4jPbcUssXT+j9mRaBRj0zo64v4M+Cpiw4ycb6H88jBBVMPrqTBGJsD3OGzERxA3eZcbLndFyIUvHGisG6kcH0ZHhpfGkokn5fOE1Ujd16BOx5Vrmg1S+EyotYU/5ACQ4ZNyGdhHvXaV/VeldSEXc7dIP/JocqGZ0TOffcdp/8cULgSQoR9kb7nhBrNm1rhTt+Q7DFiPGzyLPovQQoEU65rlkvZgT8sQu1UMVk/v+SuVn3FsxXgUApNIh/90vvMk3QsyJOp15pYAKGvDdkqSVOO8gxbJuibC6CAJpHWe4xYc11D2DnS2giND2xaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(75432002)(6916009)(38100700002)(66476007)(16576012)(66556008)(316002)(786003)(31696002)(86362001)(66946007)(2616005)(5660300002)(8676002)(26005)(8936002)(36756003)(186003)(83380400001)(2906002)(508600001)(956004)(6486002)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?+QFXnjrgzK9/q3Tot9hCk0u6m1ssAB4m1qBLlI0ygjkrlA7AjqkxB3Kd?=
 =?Windows-1252?Q?VU9EiDxROhq9N/UsuEX7ro1tHZAeCOPVBzo3knEiVLEQ9ezWSEsKVuq8?=
 =?Windows-1252?Q?TA/gVAGRmzM5yM0DN/g0OWTMCDLwpGvEdy+4dDAbr5Shr4h2+kjXGJ6s?=
 =?Windows-1252?Q?oMtmWkNa0wiu4RFeHwz5Stsd5iBqDlIPC1GI8urrFBrOlUl94EiXEDAp?=
 =?Windows-1252?Q?vO3HOy+WI1GrGOYnEMTIRuuPt5qThI30S1SFQjNv/gipqBMgbTul7wgu?=
 =?Windows-1252?Q?VQVjWT7ThvC1eJNl8dEXn18VnUzjgCjh78+47zky/Nixk+vmVMHbx/zw?=
 =?Windows-1252?Q?YNzLcs36tJh+cpXS1HG84ItegpScOcdj1wL1hxoyr6DqyUJiyznCiKBd?=
 =?Windows-1252?Q?guegHyTOX7pULV5W48sIatf6BHhRVRTL1muupAgfmKun/UpNRgBdmSzO?=
 =?Windows-1252?Q?fPYjjk79ppgHtXxloB0mLZyAHQfl2NZJ6fLWVGKP1hESUEC88zqg2LHs?=
 =?Windows-1252?Q?1oTZBznNRbwTYc/EkBSx0/VGooyJquz0Jv3EMRl+LoZnFVZKD/7m9dG7?=
 =?Windows-1252?Q?Z3FhubDBuFxr4wL9LL41kPvhQHbRvyTTRwYgqoO1YuIsm93AvrTozCGx?=
 =?Windows-1252?Q?iibviw3rLp/PGzuF5i4WtH7U9w3cmRQ5hhX70JD1yPg8YVdDi6cpf/qO?=
 =?Windows-1252?Q?zeSLLwK/6umqtWqZxopghB4xY4YOwdWiO6sJqfPEijUab60RyIF73BYZ?=
 =?Windows-1252?Q?1EMtBhgXTgeExp6xbvV4hitCm0IbEPN9xI+yxjFKQz1o/A2uo/tj45J5?=
 =?Windows-1252?Q?+pUlPRdDydfYn2X3B/EBFES9Co3BeojsHVmWmtaKSlpOvcTAIATA+zz2?=
 =?Windows-1252?Q?AT5sZky/m+WHCeMyUKPQuKAQI/4QrO4d0Y8N/89US5CicCCdWpIdLfZH?=
 =?Windows-1252?Q?EwFdgFvBsSMH/LykcEbcuY9Jd/lQZ77BOowBiDKpn3elFp1bR8QHxIsK?=
 =?Windows-1252?Q?sTYNfLerqRso8u/oCtNann9FXujH5oSycb/cgX/q411zr47EVI0q95FG?=
 =?Windows-1252?Q?zpPOrPHAOzP8MeaGyrLSdDX7s6IVVtgrbniA/koQuOWeHhwwOO9OpQ+l?=
 =?Windows-1252?Q?SS6nKh70jdmG9YPfXxaOw6HHOdniuf+iezvNz3RUy1lKjCwDeu4K7k+V?=
 =?Windows-1252?Q?FV0o/LZhFN4FpUbf77bR/lflrKNgTylIqHoMd9sI07+2vwkc/I9XlEkP?=
 =?Windows-1252?Q?m7lHr5BJkKMh4nioAFFbRSQVx9gS73IHHKD1O4tbSG39wVWg4Qrsq6m/?=
 =?Windows-1252?Q?Il2gPPbul+LZ1CLMp9nfQYtG/POYlu0ujzEK4tgYJU98pNWBfF1pOIvA?=
 =?Windows-1252?Q?7i9Laza2YfxLXnIACBRsZIoUFOfWIXaBRJvtPIQ1lCpcXzHqJcY9e0Dh?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 839e74c9-ed5d-4713-9785-08d98b2fc9d5
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2021 14:19:21.7346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+m9FxSQ3TsFtDUdD9OSBrLU7UZo/R5BtQQ2LRYzJPUWte/C2dKnVHnsb7ME/90rn8w6vKV7OGf8Oz39Zl0kOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4305
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, NICE_REPLY_A, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sat, 09 Oct 2021 14:19:25 -0000

On 10/8/2021 5:52 AM, Takashi Yano wrote:
> How about simply just:
> 
> diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
> index ccdb295f3..d822f4fc4 100644
> --- a/winsup/cygwin/fhandler_clipboard.cc
> +++ b/winsup/cygwin/fhandler_clipboard.cc
> @@ -28,9 +28,10 @@ static const WCHAR *CYGWIN_NATIVE = L"CYGWIN_NATIVE_CLIPBOARD";
>   
>   typedef struct
>   {
> -  timestruc_t	timestamp;
> -  size_t	len;
> -  char		data[1];
> +  uint64_t tv_sec;
> +  uint64_t tv_nsec;
> +  uint64_t len;
> +  char data[1];
>   } cygcb_t;

The only problem with this is that it might leave readers scratching their heads 
unless they look at the commit that introduced this.  What about something like 
the following, in which the code speaks for itself:

diff --git a/winsup/cygwin/fhandler_clipboard.cc 
b/winsup/cygwin/fhandler_clipboard.cc
index ccdb295f3..028c00f1e 100644
--- a/winsup/cygwin/fhandler_clipboard.cc
+++ b/winsup/cygwin/fhandler_clipboard.cc
@@ -26,12 +26,26 @@ details. */

  static const WCHAR *CYGWIN_NATIVE = L"CYGWIN_NATIVE_CLIPBOARD";

+#ifdef __x86_64__
  typedef struct
  {
    timestruc_t  timestamp;
    size_t       len;
    char         data[1];
  } cygcb_t;
+#else
+/* Use same layout. */
+typedef struct
+{
+  struct
+  {
+    int64_t tv_sec;
+    int64_t tv_nsec;
+  }            timestamp;
+  uint64_t     len;
+  char         data[1];
+} cygcb_t;
+#endif

  fhandler_dev_clipboard::fhandler_dev_clipboard ()
    : fhandler_base (), pos (0), membuffer (NULL), msize (0)
@@ -74,7 +88,14 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, 
size_t len)
         }
        clipbuf = (cygcb_t *) GlobalLock (hmem);

+#ifdef __x86_64__
        clock_gettime (CLOCK_REALTIME, &clipbuf->timestamp);
+#else
+      timestruc_t ts;
+      clock_gettime (CLOCK_REALTIME, &ts);
+      clipbuf->timestamp->tv_sec = ts.tv_sec;
+      clipbuf->timestamp->tv_nsec = ts.tv_nsec;
+#endif
        clipbuf->len = len;
        memcpy (clipbuf->data, buf, len);

@@ -179,7 +200,14 @@ fhandler_dev_clipboard::fstat (struct stat *buf)
           && (hglb = GetClipboardData (format))
           && (clipbuf = (cygcb_t *) GlobalLock (hglb)))
         {
+#ifdef __x86_64__
           buf->st_atim = buf->st_mtim = clipbuf->timestamp;
+#else
+         timestruc_t ts;
+         ts.tv_sec = clipbuf->timestamp->tv_sec;
+         ts.tv_nsec = clipbuf->timestamp->tv_nsec;
+         buf->st_atim = buf->st_mtim = ts;
+#endif
           buf->st_size = clipbuf->len;
           GlobalUnlock (hglb);
         }

Ken
