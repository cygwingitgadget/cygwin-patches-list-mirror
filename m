Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2131.outbound.protection.outlook.com [40.107.236.131])
 by sourceware.org (Postfix) with ESMTPS id D2AC73851C0A
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 13:37:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D2AC73851C0A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUP7lJww8s8rakIfsWPd4dHUGjeEI/DdCXlUb+7dWyaStPQL2duaRU82rJonhQ3uUOOfY14sD71wzgkO4NVI68HJ341ilS9MiOlQ11dpiqG1OHa6eJLilgwWH+XiTwI3m1/I/0JUa7qSH2kwdZ9rcnMwj2WRMj8L/qBxo5W5Ee8jgemW+ezgwpBFms2MITSzRR1vpG7KFy9Wzi+x2BngwCgz4N6MYyNh5TnlJq1PZQ3o0Pe5IsYsnqjViS5Ghr1uMxxHIlAszqYXvsVmCwjku7uKy/81izrZiEtiCVJ16wrViAsy1pFba3slHunMBVOiLM2ZlIzE9Zl+LXM/aEFKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tZ4IXwppmzcOpvNB2heKg4k/+CvuPKRDarDJj5DI2w=;
 b=MVoJ1abfbvHPJ/gfQXqdy/ReHE1eqKDcKXu5qZttlKgY/DDyI3jLo3KhrQMClLg1CKV9/tsQrhepgoN9pAkQWc+ZbBwtofkEfDttFik20i38GobYBiQst9VN5wippNkm6lZZFMgIdiVV2QNhJjvQ5EWZpsS2yicyJkL8DaP3U6YxxjauebFw8HT+5awf4EbABa8OGrA9lQSWF/ETo2vJwHPMdb3Pk55OmmSF5HI68zjZFe9VNSMBWlS4sLc0D4OyZVQytahW6Lxb8sZjMAhj8N83G2wiEf+cg9LGmGmJ/0DJfoEL4KyeRNPOC0adwO2hF+/zXhcZ4uycOJBgpQxkug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB5722.namprd04.prod.outlook.com (2603:10b6:5:166::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 13:37:26 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 13:37:25 +0000
Subject: Re: [PATCH 00/21] FIFO: Support multiple readers
To: cygwin-patches@cygwin.com
References: <20200507202124.1463-1-kbrown@cornell.edu>
 <20200518142519.cb6d805fa92afe4dcb017b02@nifty.ne.jp>
 <20200518143657.4e9f732f5456174348688f69@nifty.ne.jp>
 <912d46fc-3138-f3ec-f4d1-612433d9f128@cornell.edu>
 <cd2e382e-1c32-864a-31a4-8a6b7cfffc08@cornell.edu>
 <20200519102609.a3c2faa4f19ac655126c0680@nifty.ne.jp>
 <20200519151535.b4a97a0173f4d2ad4590d4c1@nifty.ne.jp>
 <21fa9885-0405-10b7-982e-9fa19058070d@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <48b29425-61fa-34c2-4b4a-afaf3c4a1c03@cornell.edu>
Date: Tue, 19 May 2020 09:37:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <21fa9885-0405-10b7-982e-9fa19058070d@cornell.edu>
Content-Type: multipart/mixed; boundary="------------5E84E6E90313BC971FE9961D"
Content-Language: en-US
X-ClientProxiedBy: MN2PR15CA0013.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::26) To DM6PR04MB6075.namprd04.prod.outlook.com
 (2603:10b6:5:127::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:650a:68f2:73c8:4345]
 (2604:6000:b407:7f00:650a:68f2:73c8:4345) by
 MN2PR15CA0013.namprd15.prod.outlook.com (2603:10b6:208:1b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend
 Transport; Tue, 19 May 2020 13:37:25 +0000
X-Originating-IP: [2604:6000:b407:7f00:650a:68f2:73c8:4345]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3974d01-995e-4b9f-e45d-08d7fbf9c456
X-MS-TrafficTypeDiagnostic: DM6PR04MB5722:
X-Microsoft-Antispam-PRVS: <DM6PR04MB57221E6587F65384A71626D8D8B90@DM6PR04MB5722.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14AelSnHx1hvRRKUnq6zG+TYElybJLzfBFmX7BH0PUfXLIksZu4zpCMgkLGajfei6YvsRFd+kjHBw/DWoMiJn9VFXDNQaGPI7ZrInBVzh7dAd5amPhrM2KUaTV7ORh/X+EA4ddq9T9dSKJ16LCTBQjKae/cdfDIYapjkGXczzbiXtFqKFd1Vc44uhN0pRgs1E0GP2ntjIrrRRkg1ie4yDQiMamYmLH9njHigEYD9FLzbsDokC5PvIZRfTdKl0SUTDislsxSm2l4EsfGNEaCDZZ3y8k5cS8flfQ6tSEh416W0uqDA2XNBrDUUpE77QaGHpsZfZVtP+hIJPruSCQqy1YysROImcaOu0hDjIr7b98f9hCccj/NExtAG6ipn8ThSmBdZSQYhqdWDYpdPBh3al8790GZ/tutGSJbIFi8kGunxJpfmHcmQUlyyknas+HKwsKlf73Vksu/rL0mgqFlFmt6o3rjjWbqnr6p9jOsYy/ovrGV3OiP+jZyLbpiww3am
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(75432002)(186003)(316002)(86362001)(786003)(31696002)(16526019)(2616005)(235185007)(478600001)(6916009)(66576008)(66476007)(66556008)(6486002)(66946007)(5660300002)(8676002)(36756003)(8936002)(33964004)(52116002)(53546011)(2906002)(6666004)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bmnYMYwTsZU7r5+fwKSOlZ9TuFfPV36rrmEj8kPmNOxxkcif+B7Ay0nWJc+bErfmf/pA29kD4nD/gxqaCzdFB8smPDJjoYYc0e4HtdH/EpcZNR0YJQPsYrqLrAJcdl9npmve6EeoVtdRxu11ljRJV9T3Z+pq1yEwwkARLrXwCkrHmxs/y0PMDogxjZIyPGkUPM6axThcM00+b8V9uRhvpWZ1noQP86pO21JupVUXapS9cRUeN7HHuO2w4GBvBsgGyRZmciY/AQjcfMJ9FutAqG3WV41jkTP1Yw5Y8Z7W85jVl40q7gMt8V3kOTmZEMbqPD3mDcxHhhDJHrKI774HyzyKqTZJbjkocRcY0LQVHZo6SWHAbfvENisjBL9UYLVaD5JY9uV6wOG/d6rLIcNzg+QMZvOkYYY+3FOAUqJTp5afeZDwCCIQMaOtMbnXb3n4BX0stW9btfeAXvHZYnLdXjSsrLgfSLrGmZrZzgqJ2rWfliEKnA7a6MyM94OgS0X3WyUibRcHegZbQMgqrdwjlYDs4U+02DawA53GxNUixEs=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f3974d01-995e-4b9f-e45d-08d7fbf9c456
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 13:37:25.8350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okvx4S4GvU2WNg9h+Ia6+r/qblUu+IoQpPO/PcpqlJQiTBUl5kjOkxtj/d6+EH8QCShgkSMdMbdt+rOBljY/2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5722
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00, DKIM_INVALID,
 DKIM_SIGNED, GIT_PATCH_0, KAM_DMARC_STATUS, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 19 May 2020 13:37:28 -0000

--------------5E84E6E90313BC971FE9961D
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

On 5/19/2020 8:51 AM, Ken Brown via Cygwin-patches wrote:
> On 5/19/2020 2:15 AM, Takashi Yano via Cygwin-patches wrote:
>> On Tue, 19 May 2020 10:26:09 +0900
>> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
>>> Hi Ken,
>>>
>>> On Mon, 18 May 2020 13:42:19 -0400
>>> Ken Brown via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
>>>> Hi Takashi,
>>>>
>>>> On 5/18/2020 12:03 PM, Ken Brown via Cygwin-patches wrote:
>>>>> On 5/18/2020 1:36 AM, Takashi Yano via Cygwin-patches wrote:
>>>>>> On Mon, 18 May 2020 14:25:19 +0900
>>>>>> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
>>>>>>> However, mc hangs by several operations.
>>>>>>>
>>>>>>> To reproduce this:
>>>>>>> 1. Start mc with 'env SHELL=tcsh mc -a'
>>>>>>
>>>>>> I mean 'env SHELL=/bin/tcsh mc -a'
>>>>>>
>>>>>>> 2. Select a file using up/down cursor keys.
>>>>>>> 3. Press F3 (View) key.
>>>>>
>>>>> Thanks for the report.  I can reproduce the problem and will look into it.
>>>>
>>>> I'm not convinced that this is a FIFO bug.  I tried two things.
>>>>
>>>> 1. I attached gdb to mc while it was hanging and got the following backtrace
>>>> (abbreviated):
>>>>
>>>> #1  0x00007ff901638037 in WaitForMultipleObjectsEx ()
>>>> #2  0x00007ff901637f1e in WaitForMultipleObjects ()
>>>> #3  0x0000000180048df5 in cygwait () at ...winsup/cygwin/cygwait.cc:75
>>>> #4  0x000000018019b1c0 in wait4 () at ...winsup/cygwin/wait.cc:80
>>>> #5  0x000000018019afea in waitpid () at ...winsup/cygwin/wait.cc:28
>>>> #6  0x000000018017d2d8 in pclose () at ...winsup/cygwin/syscalls.cc:4627
>>>> #7  0x000000018015943b in _sigfe () at sigfe.s:35
>>>> #8  0x000000010040d002 in get_popen_information () at filemanager/ext.c:561
>>>> [...]
>>>>
>>>> So pclose is blocking after calling waitpid.  As far as I can tell from looking
>>>> at backtraces of all threads, there are no FIFOs open.
>>>>
>>>> 2. I ran mc under strace (after exporting SHELL=/bin/tcsh), and I didn't see
>>>> anything suspicious involving FIFOs.  But I saw many EBADF errors from fstat 
>>>> and
>>>> close that don't appear to be related to FIFOs.
>>>>
>>>> So my best guess at this point is that the FIFO changes just exposed some
>>>> unrelated bug(s).
>>>>
>>>> Prior to the FIFO changes, mc would get an error when it tried to open 
>>>> tcsh_fifo
>>>> the second time, and it would then set
>>>>
>>>>     mc_global.tty.use_subshell = FALSE;
>>>>
>>>> see the mc source file subshell/common.c:1087.
>>>
>>> I looked into this problem and found pclose() stucks if FIFO
>>> is opened.
>>>
>>> Attached is a simple test case. It works under cygwin 3.1.4,
>>> but stucks at pclose() under cygwin git head.
>>>
>>> Isn't this a FIFO related issue?
>>
>> In the test case, fhandler_fifo::close() called from /bin/true
>> seems to get into infinite loop at:
>>
>> do
>> ...
>> while (inc_nreaders () > 0 && !found);
> 
> Thank you!  I see the problem.  After the popen call, the original 
> fhandler_fifo's fifo_reader_thread was no longer running, so it was unable to 
> take ownership.
> 
> It might take a little while for me to figure out how to fix this.

Actually, I think it's easy.  Please try the two attached patches.  The second 
one is the crucial one for the mc problem, but the first is something I noticed 
while working on this.

I just did a quick and dirty patch for testing purposes.  I still have to do a 
lot of cleanup and make sure the fix doesn't break something else.

Ken

--------------5E84E6E90313BC971FE9961D
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-FIFO-add-missing-reader_opening_unlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Cygwin-FIFO-add-missing-reader_opening_unlock.patch"

From bdc0bd172b09d386a2f15c41e7a764f48748b90c Mon Sep 17 00:00:00 2001
From: Ken Brown <kbrown@cornell.edu>
Date: Tue, 19 May 2020 09:03:59 -0400
Subject: [PATCH 1/2] Cygwin: FIFO: add missing reader_opening_unlock

---
 winsup/cygwin/fhandler_fifo.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index e8a05dfbf..0dc356dfe 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -1047,6 +1047,7 @@ err_close_reader:
   saved_errno = get_errno ();
   close ();
   set_errno (saved_errno);
+  reader_opening_unlock ();
   return 0;
 err_close_cancel_evt:
   NtClose (cancel_evt);
-- 
2.21.0


--------------5E84E6E90313BC971FE9961D
Content-Type: text/plain; charset=UTF-8;
 name="0002-Cygwin-FIFO-don-t-take-ownership-after-exec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-Cygwin-FIFO-don-t-take-ownership-after-exec.patch"

From ce60aa56a573e712ce5d212ca6aa0ddd9781be29 Mon Sep 17 00:00:00 2001
From: Ken Brown <kbrown@cornell.edu>
Date: Tue, 19 May 2020 09:28:30 -0400
Subject: [PATCH 2/2] Cygwin: FIFO: don't take ownership after exec

Proof of concept only.  Needs cleanup and further testing.

There's no need to transfer ownership after exec.  This will happen
automatically, if necessary, when the parent closes.  And canceling
the parent's fifo_reader_thread can cause problems, as reported here
for example:

https://cygwin.com/pipermail/cygwin-patches/2020q2/010235.html
---
 winsup/cygwin/fhandler_fifo.cc | 35 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 0dc356dfe..79f83177f 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -1727,23 +1727,23 @@ fhandler_fifo::fixup_after_exec ()
       fc_handler = NULL;
       nhandlers = shandlers = 0;
 
-      /* Cancel parent's reader thread */
-      if (cancel_evt)
-	SetEvent (cancel_evt);
-      if (thr_sync_evt)
-	WaitForSingleObject (thr_sync_evt, INFINITE);
-
-      /* Take ownership if parent is owner. */
-      fifo_reader_id_t parent_fr = me;
-      me.winpid = GetCurrentProcessId ();
-      owner_lock ();
-      if (get_owner () == parent_fr)
-	{
-	  set_owner (me);
-	  if (update_my_handlers (true) < 0)
-	    api_fatal ("Can't update my handlers, %E");
-	}
-      owner_unlock ();
+      // /* Cancel parent's reader thread */
+      // if (cancel_evt)
+      // 	SetEvent (cancel_evt);
+      // if (thr_sync_evt)
+      // 	WaitForSingleObject (thr_sync_evt, INFINITE);
+
+      // /* Take ownership if parent is owner. */
+      // fifo_reader_id_t parent_fr = me;
+      // me.winpid = GetCurrentProcessId ();
+      // owner_lock ();
+      // if (get_owner () == parent_fr)
+      // 	{
+      // 	  set_owner (me);
+      // 	  if (update_my_handlers (true) < 0)
+      // 	    api_fatal ("Can't update my handlers, %E");
+      // 	}
+      // owner_unlock ();
       /* Close inherited cancel_evt and thr_sync_evt. */
       if (cancel_evt)
 	NtClose (cancel_evt);
@@ -1755,6 +1755,7 @@ fhandler_fifo::fixup_after_exec ()
 	api_fatal ("Can't create reader thread sync event during exec, %E");
       /* At this moment we're a new reader.  The count will be
 	 decremented when the parent closes. */
+      me.winpid = GetCurrentProcessId ();
       inc_nreaders ();
       new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
     }
-- 
2.21.0


--------------5E84E6E90313BC971FE9961D--
