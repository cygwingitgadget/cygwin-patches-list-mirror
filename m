Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 by sourceware.org (Postfix) with ESMTPS id DFBBA397200B
 for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2020 12:34:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DFBBA397200B
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id 08ACY0oY008133
 for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2020 21:34:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 08ACY0oY008133
X-Nifty-SrcIP: [124.155.38.192]
Date: Thu, 10 Sep 2020 21:34:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200910213403.0e876be50bc2d1bbd2da0979@nifty.ne.jp>
In-Reply-To: <20200910091500.388ab2f6796a4abce57a3cd2@nifty.ne.jp>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200904190337.cde290e4b690793ef6a0f496@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009040822000.56@tvgsbejvaqbjf.bet>
 <20200905000302.9c777e3d2df4f49f3a641e42@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009072309070.56@tvgsbejvaqbjf.bet>
 <20200908171648.e65665caebb643ce99910fa3@nifty.ne.jp>
 <20200909072123.GX4127@calimero.vinschen.de>
 <20200910091500.388ab2f6796a4abce57a3cd2@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 10 Sep 2020 12:34:42 -0000

On Thu, 10 Sep 2020 09:15:00 +0900
Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> Hi Corinna,
> 
> On Wed, 9 Sep 2020 09:21:23 +0200
> Corinna Vinschen wrote:
> > On Sep  8 17:16, Takashi Yano via Cygwin-patches wrote:
> > > On Mon, 7 Sep 2020 23:17:36 +0200 (CEST)
> > > Johannes Schindelin wrote:
> > > > Hi Takashi,
> > > > 
> > > > On Sat, 5 Sep 2020, Takashi Yano wrote:
> > > > 
> > > > > On Fri, 4 Sep 2020 08:23:42 +0200 (CEST)
> > > > > Johannes Schindelin wrote:
> > > > > >
> > > > > > On Fri, 4 Sep 2020, Takashi Yano via Cygwin-patches wrote:
> > > > > >
> > > > > > > On Tue, 1 Sep 2020 18:19:16 +0200 (CEST)
> > > > > > > Johannes Schindelin wrote:
> > > > > > > [...]
> > > > `LANG=en_US.UTF-8` (meaning your patches force their console applications'
> > > > output to be interpreted with code page 437) and therefore for those
> > > > users, things looked fine before, and now they don't.
> > > > 
> > > > Note that I am not talking about developers who develop said console
> > > > applications. I am talking about users who use those console applications.
> > > > In other words, I am talking about a vastly larger group of affected
> > > > people.
> > > > 
> > > > All of those people (or at least a substantial majority) will now have to
> > > > be told to please disable Pseudo Console support in v3.2.0 because they
> > > > would have to patch and rebuild those console applications that don't call
> > > > `SetConsoleOutputCP()`, and that is certainly unreasonable to expect of
> > > > the majority of users. Not even the `cmd /c chcp 65001` work-around (that
> > > > helps with v3.1.7) will work with v3.2.0 when Pseudo Console support is
> > > > enabled.
> > > 
> > > In the case where pseudo console is disabled, the patch I proposed in
> > > https://cygwin.com/pipermail/cygwin-patches/2020q3/010548.html
> > > will solve the issue. I mean apps which work correctly in cygwin 3.0.7
> > > work in cygwin 3.2.0 as well with that patch.
> > > 
> > > OTOH, in the case where pseudo console is enabled, non-cygwin apps which
> > > work correctly in command prompt, work in cygwin 3.2.0 as well.
> > > 
> > > It is enough for all, isn't it?
> > > 
> > > You may think that all non-cygwin apps which work in cygwin 3.0.7 must
> > > work in cygwin 3.2.0 even when pseudo console is enabled, but it is
> > > against the purpose of the pseudo console support. The goal of pseudo
> > > console support is to make non-cygwin apps work as if it is executed in
> > > command prompt.
> > > 
> > > By the way, you complained regarding garbled output of the program which
> > > outputs UTF-8 string regardless of locale.
> > > https://cygwin.com/pipermail/cygwin-developers/2020-August/011951.html
> > > However, many Japanese programmers, for example, make programs which
> > > output SJIS (CP932) string regardless of locale.
> > > 
> > > Why do you think the former must work while the latter deos not have to?
> > > Is there any reasonable reason other than backward compatibility?
> > 
> > Is that still a concern with the latest from master?  There's
> > a snapshot for testing, Johannes.
> 
> We are still discussing about that.
> https://github.com/msys2/MSYS2-packages/issues/1974
> 
> > Takashi, does the patch from
> > https://cygwin.com/pipermail/cygwin-developers/2020-August/011951.html
> > still apply to the latest from master?  Question is, shouldn't the
> > Windows calls setting the codepage be only called if started from
> > child_info_spawn::worker for non-Cygwin executables?
> 
> I'd propose the patch:
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 37d033bbe..95b28c3da 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1830,7 +1830,11 @@ fhandler_pty_slave::setup_locale (void)
>    extern UINT __eval_codepage_from_internal_charset ();
> 
>    if (!get_ttyp ()->term_code_page)
> -    get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
> +    {
> +      get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
> +      SetConsoleCP (get_ttyp ()->term_code_page);
> +      SetConsoleOutputCP (get_ttyp ()->term_code_page);
> +    }
>  }
> 
>  void
> 
> However, Johannes insists setting codepage for non-cygwin apps
> even when pseudo console is enabled, which I cannot agree.
> 
> Actually, I hesitate even the patch above, however, it seems to
> be necessary for msys apps in terms of backward compatibility.

I found that output of Oracle java.exe and javac.exe are garbled
if the patch above is applied. This is because java.exe and javac.exe
output SJIS code unconditionally in my environment.

OTOH, rust-based program such as cargo and ripgrep output UTF-8
unconditionally. node.js also seems to output UTF-8 string by
default.

I think there is no way for both apps to work properly if pseudo
console is disabled. As far as I tested, both of them works when
pseudo console is enabled. IMHO, the best way to achieve maximum
compatibility, is enabling pseudo console, which is disabled in
MSYS2 by default.

As for the case with pseudo console disabled:

If backward compatibility is important, we should apply the patch
above. If compatibility with the behaviour in command prompt is
important, we should leave the codepage to the system default.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
