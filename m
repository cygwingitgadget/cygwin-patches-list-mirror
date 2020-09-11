Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 by sourceware.org (Postfix) with ESMTPS id AFEF2396E428
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 18:38:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org AFEF2396E428
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id 08BIbuKm017565
 for <cygwin-patches@cygwin.com>; Sat, 12 Sep 2020 03:37:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 08BIbuKm017565
X-Nifty-SrcIP: [124.155.38.192]
Date: Sat, 12 Sep 2020 03:37:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add workaround for ISO-2022 and ISCII in
 convert_mb_str().
Message-Id: <20200912033758.d3e898332cb37f8b69f43bd4@nifty.ne.jp>
In-Reply-To: <20200912023843.58ef0f3134d6aea5359c27c0@nifty.ne.jp>
References: <20200911105401.153-1-takashi.yano@nifty.ne.jp>
 <20200911120840.GH4127@calimero.vinschen.de>
 <20200911213515.98a88ca7f186ede9bf8fc106@nifty.ne.jp>
 <20200911140601.GK4127@calimero.vinschen.de>
 <20200912010504.586a156f1712f61c3c696d40@nifty.ne.jp>
 <20200912023843.58ef0f3134d6aea5359c27c0@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Fri, 11 Sep 2020 18:38:13 -0000

On Sat, 12 Sep 2020 02:38:43 +0900
Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> On Sat, 12 Sep 2020 01:05:04 +0900
> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > On Fri, 11 Sep 2020 16:06:01 +0200
> > Corinna Vinschen wrote:
> > > On Sep 11 21:35, Takashi Yano via Cygwin-patches wrote:
> > > > Hi Corinna,
> > > > 
> > > > On Fri, 11 Sep 2020 14:08:40 +0200
> > > > Corinna Vinschen wrote:
> > > > > On Sep 11 19:54, Takashi Yano via Cygwin-patches wrote:
> > > > > > - In convert_mb_str(), exclude ISO-2022 and ISCII from the processing
> > > > > >   for the case that the multibyte char is splitted in the middle.
> > > > > >   The reason is as follows.
> > > > > >   * ISO-2022 is too complicated to handle correctly.
> > > > > >   * Not sure what to do with ISCII.
> > > > > > ---
> > > > > >  winsup/cygwin/fhandler_tty.cc | 9 +++++++--
> > > > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> > > > > > index 37d033bbe..ee5c6a90a 100644
> > > > > > --- a/winsup/cygwin/fhandler_tty.cc
> > > > > > +++ b/winsup/cygwin/fhandler_tty.cc
> > > > > > @@ -117,6 +117,9 @@ CreateProcessW_Hooked
> > > > > >    return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
> > > > > >  }
> > > > > >  
> > > > > > +#define IS_ISO_2022(x) ( (x) >= 50220 && (x) <= 50229 )
> > > > > > +#define IS_ISCII(x) ( (x) >= 57002 && (x) <= 57011 )
> > > > > > +
> > > > > >  static void
> > > > > >  convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
> > > > > >  		UINT cp_from, const char *ptr_from, size_t len_from,
> > > > > > @@ -126,8 +129,10 @@ convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
> > > > > >    tmp_pathbuf tp;
> > > > > >    wchar_t *wbuf = tp.w_get ();
> > > > > >    int wlen = 0;
> > > > > > -  if (cp_from == CP_UTF7)
> > > > > > -    /* MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > > > > > +  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
> > > > > > +    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > > > > > +       - ISO-2022 is too complicated to handle correctly.
> > > > > > +       - FIXME: Not sure what to do for ISCII.
> > > > > >         Therefore, just convert string without checking */
> > > > > >      wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
> > > > > >  				wbuf, NT_MAX_PATH);
> > > > > > -- 
> > > > > > 2.28.0
> > > > > 
> > > > > I'd prefer to not handle them at all.  We just don't support these
> > > > > charsets, same as JIS, EBCDIC, you name it, which are not ASCII
> > > > > compatible.  Let's please just drop any handling for these weird
> > > > > or outdated codepages.
> > > > 
> > > > What do you mean by "just drop any handling"? 
> > > > 
> > > > Do you mean remove following if block?
> > > > > > +  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
> > > > > > +    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > > > > > +       - ISO-2022 is too complicated to handle correctly.
> > > > > > +       - FIXME: Not sure what to do for ISCII.
> > > > > >         Therefore, just convert string without checking */
> > > > > >      wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
> > > > > >  				wbuf, NT_MAX_PATH);
> > > > In this case, the conversion for ISO-2022, ISCII and UTF-7 will
> > > > not be done correctly.
> > > > 
> > > > Or skip charset conversion if the codepage is EBCDIC, ISO-2022
> > > > or ISCII? What should we do for UTF-7?
> > > 
> > > Nothing, just like for any other of these weird charsets.  Cygwin never
> > > supported any charset which wasn't at least ASCII compatible in the
> > > 0 <= x <= 127 range.  Just ignore them and the possibility that a
> > > user chooses them for fun.
> > > 
> > > > What should happen if user or apps chage codepage to one of them?
> > > 
> > > Garbage output, I guess.  We shouldn't really care.
> > 
> > Do you mean a patch attached?
> > 
> > Please try:
> > (1) Open mintty with "env CYGWIN=disable_pcon mintty".
> > (2) Start cmd.exe in that mintty.
> > (3) Try chcp such as
> >     37 (EBCDIC),
> >     65000 (UTF-7),
> >     50220 (ISO-2022),
> >     and 57002 (ISCII).
> > (4) Execute dir or some other commands in cmd.exe.
> > 
> > For 65000, 50220 adn 57002, even the prompt will be broken.
> > Are the results as you expected?
> > 
> > If pseudo console is enabled, all the above are work without
> > problem. With the previous patch, the results was sane even
> > if pseudo console is disabled.
> 
> How about the patch attached?
> I think this is safer than previous patch.

I have revised this patch to fit current git head, and submit
to cygwin-patches@cygwin.com.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
