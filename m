Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id 404403846402
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 11:24:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 404403846402
Received: from Express5800-S70 (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 10IBNlNU012562
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 20:23:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 10IBNlNU012562
X-Nifty-SrcIP: [122.249.67.108]
Date: Mon, 18 Jan 2021 20:23:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: pty: Prevent pty from changing code page of
 parent console.
Message-Id: <20210118202349.b0d9035855eddf53488143d9@nifty.ne.jp>
In-Reply-To: <20210118102340.GO59030@calimero.vinschen.de>
References: <20210115083213.676-1-takashi.yano@nifty.ne.jp>
 <20210115083213.676-5-takashi.yano@nifty.ne.jp>
 <20210118102340.GO59030@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 18 Jan 2021 11:24:16 -0000

Hi Corinna,

On Mon, 18 Jan 2021 11:23:40 +0100
Corinna Vinschen wrote:
> I'm going to push patches 1 - 3.  In terms of patch 4 I have a few
> questions:
> 
> On Jan 15 17:32, Takashi Yano via Cygwin-patches wrote:
> > @@ -2185,7 +2185,7 @@ private:
> >    bool send_winch_maybe ();
> >    void setup ();
> >    bool set_unit ();
> > -  static bool need_invisible ();
> > +  static bool need_invisible (bool force=false);
> 
> Please add spaces, i. e., force = false
> 
> > +static DWORD
> > +get_console_process_id (DWORD pid, bool match)
> > +{
> > +  DWORD tmp;
> > +  DWORD num, num_req;
> > +  num = 1;
> > +  num_req = GetConsoleProcessList (&tmp, num);
> > +  DWORD *list;
> 
> So, assuming num_req is 1 after the call, shouldn't that skip the
> rest of the code?
> 
> > +  while (true)
> > +    {
> > +      list = (DWORD *)
> > +	HeapAlloc (GetProcessHeap (), 0, num_req * sizeof (DWORD));
> > +      num = num_req;
> > +      num_req = GetConsoleProcessList (list, num);
> > +      if (num_req > num)
> > +	HeapFree (GetProcessHeap (), 0, list);
> > +      else
> > +	break;
> > +    }
> > +  num = num_req;
> > +
> > +  tmp = 0;
> > +  for (DWORD i=0; i<num; i++)
> > +    if ((match && list[i] == pid) || (!match && list[i] != pid))
> > +      /* Last one is the oldest. */
> > +      /* https://github.com/microsoft/terminal/issues/95 */
> 
> Given that, wouldn't it make more sense to count backwards, from
> num - 1 to 0, from a performance perspective?

Thanks for the advice. I will submit the revised patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
