Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id E4F7B38460A3
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 10:23:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E4F7B38460A3
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MacWq-1ldXbI106U-00c6HQ for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 11:23:42 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D39E8A8093E; Mon, 18 Jan 2021 11:23:40 +0100 (CET)
Date: Mon, 18 Jan 2021 11:23:40 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: pty: Prevent pty from changing code page of
 parent console.
Message-ID: <20210118102340.GO59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115083213.676-1-takashi.yano@nifty.ne.jp>
 <20210115083213.676-5-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115083213.676-5-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:L+3/Mov5T+x5P1MLHXs1EmzyUbYOZ3MUHVdXjE2H0BFSNSWqm/H
 vY1VapKJGT+7y4EOsHWP764CC/Eovy/gPEp3z9L0FsaF9o9mknOGgkz74uarD/L5NaoeI+f
 WDIRQyB787Ta5/126FA5DKhHluFoCiX1d9YAy61n+mb9DcgrnXE1GB7Rnn6G1OArARv9fLN
 Ty7UrpSd4OmdOEMIUsRxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iX8CgF28l5k=:rXRYZsfj4mFEm4VnZ2D8Ov
 auGtvekco9lz0vMPqTBkk8xtPhPRfFkWQ/CbDCw1tOrcMqpqlrQi+V/HVsmJiJL8aeG6FyQiN
 eJNIurOhI0Kf74IL75yE5BlO43IqH9ugD6HSWvooVFs6ZYghYqmfftxIUxdCrNsNAD0UoOcJ3
 OIBPc9UsumH//kLFA0f4YqyJyGzYX1x7CbbjSoL869A/4rHxL/HniSjHY0NIn7O5c9cWR74Wa
 GqCUH1mUZh9H+Gl7MjPMRCyroh8cTHOKpUHmw1uXtPt+BVfPAJpqclrCsXWcYCO7a1pnrrSnN
 k6KFZ5MASy8SsXYkys3BMuFoT238AIpx4to/oZesijhguZtELHb7Pa0hkH7P+Y1+jIEkXuf/L
 c4CEwlzvRwfB228FiuOxNmxTdev+NUHu44M8G5yROvYbala1ZaQoqnmYaUY2RAWMj1lFFPdqW
 F5KnoaNjTA==
X-Spam-Status: No, score=-100.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 18 Jan 2021 10:23:45 -0000

Hi Takashi,


I'm going to push patches 1 - 3.  In terms of patch 4 I have a few
questions:

On Jan 15 17:32, Takashi Yano via Cygwin-patches wrote:
> @@ -2185,7 +2185,7 @@ private:
>    bool send_winch_maybe ();
>    void setup ();
>    bool set_unit ();
> -  static bool need_invisible ();
> +  static bool need_invisible (bool force=false);

Please add spaces, i. e., force = false

> +static DWORD
> +get_console_process_id (DWORD pid, bool match)
> +{
> +  DWORD tmp;
> +  DWORD num, num_req;
> +  num = 1;
> +  num_req = GetConsoleProcessList (&tmp, num);
> +  DWORD *list;

So, assuming num_req is 1 after the call, shouldn't that skip the
rest of the code?

> +  while (true)
> +    {
> +      list = (DWORD *)
> +	HeapAlloc (GetProcessHeap (), 0, num_req * sizeof (DWORD));
> +      num = num_req;
> +      num_req = GetConsoleProcessList (list, num);
> +      if (num_req > num)
> +	HeapFree (GetProcessHeap (), 0, list);
> +      else
> +	break;
> +    }
> +  num = num_req;
> +
> +  tmp = 0;
> +  for (DWORD i=0; i<num; i++)
> +    if ((match && list[i] == pid) || (!match && list[i] != pid))
> +      /* Last one is the oldest. */
> +      /* https://github.com/microsoft/terminal/issues/95 */

Given that, wouldn't it make more sense to count backwards, from
num - 1 to 0, from a performance perspective?


Thanks,
Corinna
