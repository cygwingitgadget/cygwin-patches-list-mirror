Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2100.outbound.protection.outlook.com [40.107.243.100])
 by sourceware.org (Postfix) with ESMTPS id DBD123840C34
 for <cygwin-patches@cygwin.com>; Tue,  9 Jun 2020 11:04:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DBD123840C34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg2ZCsHZ2WMEa4RsZgFymIU/77NBUZGzuYsoQzNWTb23lhZPXG/fI/2WdCic4pBlD9jq/zr5vEnYTybE/iA7EHHEW3cqJaB7IQx4Q5SaC0RH8v5S7+zKXwdg5gBzOaZb19unoXAPn5pxvK/fmcWWlim/+tuMlV23Ml3gtmS/z1qkKT6XhGAPlezktSZ+HyqhiriWzVRoi8yR6ttCN36TSrvYLR3mOaYLnGjcjKrWY00iFN/eOO5R0Fms3YoyXE707GvE8Tupqy+/f3Qna8YgP6NvdTxHS5MR7sJgi6XWW+MmHh9RL9gHbLOlEttgDDh7M78IjLUV5CU0grHGB68Sog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVi2IXU+31lo2MHoG6zABcAdziWEQy1Bd+l797YQIvU=;
 b=hHiPDxBYlv2lMqZ9y5a3w8YLqJXruFgmXOScRGQcxZG0j4ztDuUrDiK9hzlUxlZQ3v0kopNrsUjdT23z6+X0CqoN4Zo6BYst0LG15sN4vYCllZ+NzofnssxfPoQ7jenqRERAIltLM+OKRnSTIFQL3ndXqxibS45pciCcskr8VQABtc7xq+pSpzAEfirkdjgvsnGGMzAIS1jCsLAkF+r2LVlJjL7HbaaOa3ADR/CEf/KWblZFW8JSDqQXShpwVCBHf30WTK9L6ZJp8Ajd5blqEMwQC/dk1BRDQG3c5vHIb1R5pvnuDHsNsrKxXxgiNdKd5BDX9L7KIC1rT6WpDhZ3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5696.namprd04.prod.outlook.com (2603:10b6:208:fd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Tue, 9 Jun
 2020 11:04:19 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::ecf5:cc00:84d8:bb6a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::ecf5:cc00:84d8:bb6a%7]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 11:04:19 +0000
Subject: Re: [PATCH v3] Cygwin: pty: Fix screen distortion after less for
 native apps again.
To: cygwin-patches@cygwin.com
References: <20200604014319.1954-1-takashi.yano@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <39c60066-485e-0c6b-7299-b5160598a887@cornell.edu>
Date: Tue, 9 Jun 2020 07:04:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200604014319.1954-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:1147:7d51:7b1e:cfcd]
 (2604:6000:b407:7f00:1147:7d51:7b1e:cfcd) by
 MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 11:04:19 +0000
X-Originating-IP: [2604:6000:b407:7f00:1147:7d51:7b1e:cfcd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6251286-41fc-4236-7544-08d80c64dba8
X-MS-TrafficTypeDiagnostic: MN2PR04MB5696:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5696AA660384727407DC077FD8820@MN2PR04MB5696.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UznDAGJSe9602OHZA8N/XUJ8PN2uNZzCd+gSwKmtaDL8vh9kloES1oM6Kns8HpH9hXGBNpy+5QmTLAVDVvW4CRYPYbGnb5Io3nvgv5R/7HpuL85369OFiwUddbb5mJtCML2m4/a1m078W5LMIRblGO/C1en6qFhxndAAucYOLiI6dgjrJNrj/8JJU8Qn0t4FFviFSKESVP+SmFaUMtZlOVjdsc17qxWsgZni3SxxIhk++YjmpKoW4J4wUCKWzFuBOCRjVYnhAI3waWg14oS1Zr5XNcGIq+QkTAchzoI3RJ/qr21/GxcRXttIUjl5JeFJovaTpjLH2chLxt3yxDwMEG9bdtWwpKYaT+OaVssiG5fofbkCDYT+wTgGyKtgwLlm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(16526019)(6916009)(8676002)(53546011)(2906002)(186003)(83380400001)(31696002)(86362001)(31686004)(75432002)(8936002)(52116002)(5660300002)(66476007)(2616005)(478600001)(316002)(786003)(6486002)(36756003)(66946007)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: i9V00MX5VgH1Q66zrgc030sZe94hkYWbkIUJNHQRYbRkNlYPe659Fp7e32Mxby3E1JiXlQgYRm3u+wU7IWeJTU5aUns+0+2eW6I7o0YupcHeRotjOk3swxipBicfMwmukEph2rNTwyoWvfYr8083VVejtURVuopBfxHt2oV5F1XOTePGOqAs4Ypt8JZAXL0OtcxPNuAuEROGRkzP6qh96cNGffFAhkMlax3J5N+9zMLK7zjSXFsoRBbGiQc4Bs9aYWHMfGadSTJGO9CqMQYHRyfwBl3dvV2VJzdC2v2HrmatRp4mC+rAyFB4Uz9xTsXXQu1Ajyz42Kk4STAg37GySAmHPjEjcKPG7VX74VjUnveF3lZFPzmqP8FRJjZ5IFjLATh/jd9IFirDhDHSl920pyLEdq/d5sjk5yAPl9PlBxIWRxqF3lEK1vpHId3x67FNZ86GM7rWp1DdJzEzNfDxlU6H9vSkBnFtJR7C/CpzBb+m3pLmqookAJeYGGeFtii0elBzMfMur81SX6H7RfAjQ4dUJoiRLnrjm7O+7LxId/gXGanwenN4lgnDqmvhe6Xc
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e6251286-41fc-4236-7544-08d80c64dba8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 11:04:19.7136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOJmzLA78eiWHID1U9ZEwshHyeI2AsuMv0YS+mi5/9//C0NL7Oc276l9JvMQ3AAdC3jka4WDvjRdFVDSkHrEuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5696
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Tue, 09 Jun 2020 11:04:23 -0000

On 6/3/2020 9:43 PM, Takashi Yano via Cygwin-patches wrote:
> - Commit c4b060e3fe3bed05b3a69ccbcc20993ad85e163d seems to be not
>    enough. Moreover, it does not work as expected at all in Win10
>    1809. This patch essentially reverts that commit and add another
>    fix. After all, the cause of the problem was a race issue in
>    switch_to_pcon_out flag. That is, this flag is set when native
>    app starts, however, it is delayed by wait_pcon_fwd(). Since the
>    flag is not set yet when less starts, the data which should go
>    into the output_handle accidentally goes into output_handle_cyg.
>    This patch fixes the problem more essentially for the cause of
>    the problem than previous one.
> ---
>   winsup/cygwin/fhandler.h      |  1 -
>   winsup/cygwin/fhandler_tty.cc | 49 +++++++++++------------------------
>   winsup/cygwin/tty.cc          |  7 ++++-
>   winsup/cygwin/tty.h           |  1 -
>   4 files changed, 21 insertions(+), 37 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index 4035c7e56..c6ce6d8e1 100644
> --- a/winsup/cygwin/fhandler.h
> +++ b/winsup/cygwin/fhandler.h
> @@ -2354,7 +2354,6 @@ class fhandler_pty_slave: public fhandler_pty_common
>     void setup_locale (void);
>     void set_freeconsole_on_close (bool val);
>     void trigger_redraw_screen (void);
> -  void wait_pcon_fwd (void);
>     void pull_pcon_input (void);
>     void update_pcon_input_state (bool need_lock);
>   };
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index bcc7648f3..126249d9f 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1277,6 +1277,7 @@ fhandler_pty_slave::set_switch_to_pcon (int fd_set)
>   {
>     if (fd < 0)
>       fd = fd_set;
> +  acquire_output_mutex (INFINITE);
>     if (fd == 0 && !get_ttyp ()->switch_to_pcon_in)
>       {
>         pull_pcon_input ();
> @@ -1286,13 +1287,13 @@ fhandler_pty_slave::set_switch_to_pcon (int fd_set)
>         get_ttyp ()->switch_to_pcon_in = true;
>         if (isHybrid && !get_ttyp ()->switch_to_pcon_out)
>   	{
> -	  wait_pcon_fwd ();
> +	  get_ttyp ()->wait_pcon_fwd ();
>   	  get_ttyp ()->switch_to_pcon_out = true;
>   	}
>       }
>     else if ((fd == 1 || fd == 2) && !get_ttyp ()->switch_to_pcon_out)
>       {
> -      wait_pcon_fwd ();
> +      get_ttyp ()->wait_pcon_fwd ();
>         if (get_ttyp ()->pcon_pid == 0 ||
>   	  !pinfo (get_ttyp ()->pcon_pid))
>   	get_ttyp ()->pcon_pid = myself->pid;
> @@ -1300,6 +1301,7 @@ fhandler_pty_slave::set_switch_to_pcon (int fd_set)
>         if (isHybrid)
>   	get_ttyp ()->switch_to_pcon_in = true;
>       }
> +  release_output_mutex ();
>   }
>   
>   void
> @@ -1314,12 +1316,14 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
>       return;
>     if (do_not_reset_switch_to_pcon)
>       return;
> +  acquire_output_mutex (INFINITE);
>     if (get_ttyp ()->switch_to_pcon_out)
>       /* Wait for pty_master_fwd_thread() */
> -    wait_pcon_fwd ();
> +    get_ttyp ()->wait_pcon_fwd ();
>     get_ttyp ()->pcon_pid = 0;
>     get_ttyp ()->switch_to_pcon_in = false;
>     get_ttyp ()->switch_to_pcon_out = false;
> +  release_output_mutex ();
>     init_console_handler (true);
>   }
>   
> @@ -1372,7 +1376,7 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len,
>   	  p0 = (char *) memmem (p1, nlen - (p1-buf), "\033[?1049h", 8);
>   	  if (p0)
>   	    {
> -	      p0 += 8;
> +	      //p0 += 8;
>   	      get_ttyp ()->screen_alternated = true;
>   	      if (get_ttyp ()->switch_to_pcon_out)
>   		do_not_reset_switch_to_pcon = true;
> @@ -1384,7 +1388,7 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len,
>   	  p1 = (char *) memmem (p0, nlen - (p0-buf), "\033[?1049l", 8);
>   	  if (p1)
>   	    {
> -	      //p1 += 8;
> +	      p1 += 8;
>   	      get_ttyp ()->screen_alternated = false;
>   	      do_not_reset_switch_to_pcon = false;
>   	      memmove (p0, p1, buf+nlen - p1);
> @@ -1504,8 +1508,9 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
>   
>     reset_switch_to_pcon ();
>   
> -  bool output_to_pcon =
> -    get_ttyp ()->switch_to_pcon_out && !get_ttyp ()->screen_alternated;
> +  acquire_output_mutex (INFINITE);
> +  bool output_to_pcon = get_ttyp ()->switch_to_pcon_out;
> +  release_output_mutex ();
>   
>     UINT target_code_page = output_to_pcon ?
>       GetConsoleOutputCP () : get_ttyp ()->term_code_page;
> @@ -2420,8 +2425,6 @@ fhandler_pty_master::close ()
>   	    }
>   	  release_output_mutex ();
>   	  master_fwd_thread->terminate_thread ();
> -	  CloseHandle (get_ttyp ()->fwd_done);
> -	  get_ttyp ()->fwd_done = NULL;
>   	}
>       }
>   
> @@ -2903,17 +2906,6 @@ fhandler_pty_slave::set_freeconsole_on_close (bool val)
>     freeconsole_on_close = val;
>   }
>   
> -void
> -fhandler_pty_slave::wait_pcon_fwd (void)
> -{
> -  acquire_output_mutex (INFINITE);
> -  get_ttyp ()->pcon_last_time = GetTickCount ();
> -  ResetEvent (get_ttyp ()->fwd_done);
> -  release_output_mutex ();
> -  while (get_ttyp ()->fwd_done
> -	 && cygwait (get_ttyp ()->fwd_done, 1) == WAIT_TIMEOUT);
> -}
> -
>   void
>   fhandler_pty_slave::trigger_redraw_screen (void)
>   {
> @@ -2967,12 +2959,14 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
>   	    {
>   	      DWORD mode = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
>   	      SetConsoleMode (get_output_handle (), mode);
> +	      acquire_output_mutex (INFINITE);
>   	      if (!get_ttyp ()->switch_to_pcon_out)
> -		wait_pcon_fwd ();
> +		get_ttyp ()->wait_pcon_fwd ();
>   	      if (get_ttyp ()->pcon_pid == 0 ||
>   		  !pinfo (get_ttyp ()->pcon_pid))
>   		get_ttyp ()->pcon_pid = myself->pid;
>   	      get_ttyp ()->switch_to_pcon_out = true;
> +	      release_output_mutex ();
>   
>   	      if (get_ttyp ()->need_redraw_screen)
>   		trigger_redraw_screen ();
> @@ -3258,19 +3252,9 @@ fhandler_pty_master::pty_master_fwd_thread ()
>       {
>         if (get_pseudo_console ())
>   	{
> -	  /* The forwarding in pseudo console sometimes stops for
> -	     16-32 msec even if it already has data to transfer.
> -	     If the time without transfer exceeds 32 msec, the
> -	     forwarding is supposed to be finished. */
> -	  const int sleep_in_pcon = 16;
> -	  const int time_to_wait = sleep_in_pcon * 2 + 1/* margine */;
>   	  get_ttyp ()->pcon_last_time = GetTickCount ();
>   	  while (::bytes_available (rlen, from_slave) && rlen == 0)
>   	    {
> -	      acquire_output_mutex (INFINITE);
> -	      if (GetTickCount () - get_ttyp ()->pcon_last_time > time_to_wait)
> -		SetEvent (get_ttyp ()->fwd_done);
> -	      release_output_mutex ();
>   	      /* Forcibly transfer input if it is requested by slave.
>   		 This happens when input data should be transfered
>   		 from the input pipe for cygwin apps to the input pipe
> @@ -3342,7 +3326,6 @@ fhandler_pty_master::pty_master_fwd_thread ()
>   	  /* OPOST processing was already done in pseudo console,
>   	     so just write it to to_master_cyg. */
>   	  DWORD written;
> -	  acquire_output_mutex (INFINITE);
>   	  while (rlen>0)
>   	    {
>   	      if (!WriteFile (to_master_cyg, ptr, wlen, &written, NULL))
> @@ -3353,7 +3336,6 @@ fhandler_pty_master::pty_master_fwd_thread ()
>   	      ptr += written;
>   	      wlen = (rlen -= written);
>   	    }
> -	  release_output_mutex ();
>   	  mb_str_free (buf);
>   	  continue;
>   	}
> @@ -3695,7 +3677,6 @@ fhandler_pty_master::setup ()
>         errstr = "pty master forwarding thread";
>         goto err;
>       }
> -  get_ttyp ()->fwd_done = CreateEvent (&sec_none, true, false, NULL);
>   
>     t.winsize.ws_col = 80;
>     t.winsize.ws_row = 25;
> diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
> index efdae4697..4cb68f776 100644
> --- a/winsup/cygwin/tty.cc
> +++ b/winsup/cygwin/tty.cc
> @@ -244,7 +244,6 @@ tty::init ()
>     pcon_pid = 0;
>     term_code_page = 0;
>     need_redraw_screen = true;
> -  fwd_done = NULL;
>     pcon_last_time = 0;
>     pcon_in_empty = true;
>     req_transfer_input_to_pcon = false;
> @@ -307,6 +306,12 @@ tty::set_switch_to_pcon_out (bool v)
>   void
>   tty::wait_pcon_fwd (void)
>   {
> +  /* The forwarding in pseudo console sometimes stops for
> +     16-32 msec even if it already has data to transfer.
> +     If the time without transfer exceeds 32 msec, the
> +     forwarding is supposed to be finished. pcon_last_time
> +     is reset to GetTickCount() in pty master forwarding
> +     thread when the last data is transfered. */
>     const int sleep_in_pcon = 16;
>     const int time_to_wait = sleep_in_pcon * 2 + 1/* margine */;
>     pcon_last_time = GetTickCount ();
> diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
> index 7d6fc8fef..920e32b16 100644
> --- a/winsup/cygwin/tty.h
> +++ b/winsup/cygwin/tty.h
> @@ -105,7 +105,6 @@ private:
>     pid_t pcon_pid;
>     UINT term_code_page;
>     bool need_redraw_screen;
> -  HANDLE fwd_done;
>     DWORD pcon_last_time;
>     bool pcon_in_empty;
>     bool req_transfer_input_to_pcon;
> 

Pushed.  Thanks.

Ken


