Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 by sourceware.org (Postfix) with ESMTPS id DBE713987401
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 12:35:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DBE713987401
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 08BCZ8ZD018645
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 21:35:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 08BCZ8ZD018645
X-Nifty-SrcIP: [124.155.38.192]
Date: Fri, 11 Sep 2020 21:35:15 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add workaround for ISO-2022 and ISCII in
 convert_mb_str().
Message-Id: <20200911213515.98a88ca7f186ede9bf8fc106@nifty.ne.jp>
In-Reply-To: <20200911120840.GH4127@calimero.vinschen.de>
References: <20200911105401.153-1-takashi.yano@nifty.ne.jp>
 <20200911120840.GH4127@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 11 Sep 2020 12:35:44 -0000

Hi Corinna,

On Fri, 11 Sep 2020 14:08:40 +0200
Corinna Vinschen wrote:
> On Sep 11 19:54, Takashi Yano via Cygwin-patches wrote:
> > - In convert_mb_str(), exclude ISO-2022 and ISCII from the processing
> >   for the case that the multibyte char is splitted in the middle.
> >   The reason is as follows.
> >   * ISO-2022 is too complicated to handle correctly.
> >   * Not sure what to do with ISCII.
> > ---
> >  winsup/cygwin/fhandler_tty.cc | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> > index 37d033bbe..ee5c6a90a 100644
> > --- a/winsup/cygwin/fhandler_tty.cc
> > +++ b/winsup/cygwin/fhandler_tty.cc
> > @@ -117,6 +117,9 @@ CreateProcessW_Hooked
> >    return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
> >  }
> >  
> > +#define IS_ISO_2022(x) ( (x) >= 50220 && (x) <= 50229 )
> > +#define IS_ISCII(x) ( (x) >= 57002 && (x) <= 57011 )
> > +
> >  static void
> >  convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
> >  		UINT cp_from, const char *ptr_from, size_t len_from,
> > @@ -126,8 +129,10 @@ convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
> >    tmp_pathbuf tp;
> >    wchar_t *wbuf = tp.w_get ();
> >    int wlen = 0;
> > -  if (cp_from == CP_UTF7)
> > -    /* MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > +  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
> > +    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > +       - ISO-2022 is too complicated to handle correctly.
> > +       - FIXME: Not sure what to do for ISCII.
> >         Therefore, just convert string without checking */
> >      wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
> >  				wbuf, NT_MAX_PATH);
> > -- 
> > 2.28.0
> 
> I'd prefer to not handle them at all.  We just don't support these
> charsets, same as JIS, EBCDIC, you name it, which are not ASCII
> compatible.  Let's please just drop any handling for these weird
> or outdated codepages.

What do you mean by "just drop any handling"? 

Do you mean remove following if block?
> > +  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
> > +    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > +       - ISO-2022 is too complicated to handle correctly.
> > +       - FIXME: Not sure what to do for ISCII.
> >         Therefore, just convert string without checking */
> >      wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
> >  				wbuf, NT_MAX_PATH);
In this case, the conversion for ISO-2022, ISCII and UTF-7 will
not be done correctly.

Or skip charset conversion if the codepage is EBCDIC, ISO-2022
or ISCII? What should we do for UTF-7?

What should happen if user or apps chage codepage to one of them?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
