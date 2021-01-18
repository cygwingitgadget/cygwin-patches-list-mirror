Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 74B1E385782C
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 12:39:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 74B1E385782C
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MrQR7-1lmyIr0M9n-00oWYZ for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 13:39:02 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 59E55A80988; Mon, 18 Jan 2021 13:39:01 +0100 (CET)
Date: Mon, 18 Jan 2021 13:39:01 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/5] Cygwin: pty: Prevent pty from changing code page
 of parent console.
Message-ID: <20210118123901.GB59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210118112447.1518-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210118112447.1518-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:ed38/zFiIBXkiT3k7BCz3+Bhc/XNkQXv30b7qz9JkMQjvOpllY3
 tSlQos0XWXmPrdO3EXC5BJ8kECpZzEJBfu/t/ROhEWvbjO9SxyMW4nmtaXUbcDOsVIth+bD
 tbz/uFdqq1NF2qE+OpJbpxpUYF5rL/JWWqPUex4pZCXr/PSwER5GnZlXYcoZEnSUW78SQjO
 w4VBawbF63Kga2bgwZb5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pun7cASZs4Y=:CPOJNZ/ihz0ePFOlF4mecW
 BJrlgcKwAg0nf/DHAZYmPv09byDmB7/JxZZd4WmI1mvgUT1P7k8gLWihzXNdDmx2aF+bhAVYC
 f8xG1w4KqpF3ZIGzYj8L99wz7TvnX4e/Af6mjVDG5TJUquDmAIwFQke5JWAefGYwu9z72f4u8
 5FajFNnB4ZqVoUp8IWsBWB9de8VgLIBiybXuOfL4okfGAY9utMACekf3AzGO9C94elNRsQxI/
 KW94Fy6w2W/YZB1BHDDfFLIoT3/XxJE3XBwHn5bjOalZgFLy3Qef+eDUc++7WKwhKET4Cle8i
 ilk37cmrLrXaeeObNQ/nGbWwSpBelZ81VJGUO5E3Xjhl1BZxJ/firfSJnN+hXDKTmtbLhKW3O
 Ly0MzfFxSuHycPiqb1QC+m8MVF9Ay6TVunrm487oMNABIwp1x4ItxNZjfC8x/ibSB5UyNU1tl
 DkjXVjU9CA==
X-Spam-Status: No, score=-100.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 18 Jan 2021 12:39:05 -0000

Hi Takashi,

On Jan 18 20:24, Takashi Yano via Cygwin-patches wrote:
> @@ -59,6 +59,46 @@ struct pipe_reply {
>    DWORD error;
>  };
>  
> +extern HANDLE attach_mutex; /* Defined in fhandler_console.cc */
> +
> +static DWORD
> +get_console_process_id (DWORD pid, bool match)
> +{
> +  DWORD list1;
> +  DWORD num, num_req;
> +  num = 1;
> +  num_req = GetConsoleProcessList (&list1, num);
> +  DWORD *list;
> +  if (num_req == 1)
> +    list = &list1;
> +  else
> +    while (true)
> +      {
> +	list = (DWORD *)
> +	  HeapAlloc (GetProcessHeap (), 0, num_req * sizeof (DWORD));
> +	num = num_req;
> +	num_req = GetConsoleProcessList (list, num);
> +	if (num_req > num)
> +	  HeapFree (GetProcessHeap (), 0, list);
> +	else
> +	  break;
> +      }
> +  num = num_req;
> +
> +  DWORD res = 0;
> +  /* Last one is the oldest. */
> +  /* https://github.com/microsoft/terminal/issues/95 */
> +  for (int i = (int) num - 1; i >= 0; i--)
> +    if ((match && list[i] == pid) || (!match && list[i] != pid))
> +      {
> +	res = list[i];
> +	break;
> +      }
> +  if (num > 1)
> +    HeapFree (GetProcessHeap (), 0, list);
> +  return res;
> +}

Sorry if I'm slow, but I was just mulling over this code snippet again,
and I was wondering if we couldn't do without the HeapAlloc loop.
Assuming you use a tmp_pathbuf here, you'd have space for 16384
processes per console.  Shouldn't that be more than enough?  I.e.

static DWORD
get_console_process_id (DWORD pid, bool match)
{
  tmp_pathbuf tp;
  DWORD *list = (DWORD *) tp.w_get ();
  const DWORD num = NT_MAX_PATH * sizeof (WCHAR) / sizeof (DWORD);
  DWORD res = 0;

  num = GetConsoleProcessList (&list, num);

  /* Last one is the oldest. */
  /* https://github.com/microsoft/terminal/issues/95 */
  for (int i = (int) num - 1; i >= 0; i--)
    if ((match && list[i] == pid) || (!match && list[i] != pid))
      {
	res = list[i];
	break;
      }
  return res;
}


What do you think?

Corinna
