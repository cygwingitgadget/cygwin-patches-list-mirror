Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id 8C7A9385141E
 for <cygwin-patches@cygwin.com>; Wed,  9 Sep 2020 08:06:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8C7A9385141E
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 08985toA006521
 for <cygwin-patches@cygwin.com>; Wed, 9 Sep 2020 17:05:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 08985toA006521
X-Nifty-SrcIP: [124.155.38.192]
Date: Wed, 9 Sep 2020 17:06:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix input charset for non-cygwin apps with
 disable_pcon.
Message-Id: <20200909170606.8b3641a6ac397074f7a0ed35@nifty.ne.jp>
In-Reply-To: <20200908184247.GQ4127@calimero.vinschen.de>
References: <20200908095757.2042-1-takashi.yano@nifty.ne.jp>
 <20200908184247.GQ4127@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Wed, 09 Sep 2020 08:06:31 -0000

Hi Corinna,

On Tue, 8 Sep 2020 20:42:47 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Sep  8 18:57, Takashi Yano via Cygwin-patches wrote:
> > - If the non-cygwin apps is executed under pseudo console disabled,
> >   multibyte input for the apps are garbled. This patch fixes the
> >   issue.
> > ---
> >  winsup/cygwin/fhandler_tty.cc | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> > index 6de591d9b..afaa4546e 100644
> > --- a/winsup/cygwin/fhandler_tty.cc
> > +++ b/winsup/cygwin/fhandler_tty.cc
> > @@ -271,8 +271,17 @@ fhandler_pty_master::accept_input ()
> >    bytes_left = eat_readahead (-1);
> >  
> >    HANDLE write_to = get_output_handle ();
> > +  char *buf = NULL;
> >    if (to_be_read_from_pcon ())
> > -    write_to = to_slave;
> > +    {
> > +      write_to = to_slave;
> > +      size_t nlen;
> > +      buf = convert_mb_str (GetConsoleCP (), &nlen,
> > +			    get_ttyp ()->term_code_page,
> > +			    (const char *) p, bytes_left);
> > +      p = buf;
> > +      bytes_left = nlen;
> > +    }
> 
> How big are chances that the string in p is larger than 32767 chars?
> 
> I'd like to see convert_mb_str use a tmp_pathbuf buffer instead of
> calling HeapAlloc/HeapFree every time.  That also drops the mb_str_free
> entirely.
> 
> Isn't there a problem anyway with calling convert_mb_str?  Consider
> a write call which stops in the middle of a multibyte char, the
> second half only sent with the next write call.  convert_mb_str
> only allows to convert complete multibyte chars, and the caller does
> not keep something like an mbstate_t around, which would allow
> continuation of split multibyte chars.

Thanks for the advice. I will submit a series of patches which
reflect your advice.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
