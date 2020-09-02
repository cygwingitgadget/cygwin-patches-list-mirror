Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 by sourceware.org (Postfix) with ESMTPS id B8ACA3972014
 for <cygwin-patches@cygwin.com>; Wed,  2 Sep 2020 16:25:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B8ACA3972014
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 082GOo8Z024070
 for <cygwin-patches@cygwin.com>; Thu, 3 Sep 2020 01:24:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 082GOo8Z024070
X-Nifty-SrcIP: [124.155.38.192]
Date: Thu, 3 Sep 2020 01:25:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
In-Reply-To: <20200902152450.GJ4127@calimero.vinschen.de>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
 <20200902083818.GI4127@calimero.vinschen.de>
 <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
 <20200902152450.GJ4127@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3,
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
X-List-Received-Date: Wed, 02 Sep 2020 16:25:23 -0000

Hi Corinna,

On Wed, 2 Sep 2020 17:24:50 +0200
Corinna Vinschen  wrote:
> On Sep  2 19:54, Takashi Yano via Cygwin-patches wrote:
> > Hi Corinna,
> > 
> > On Wed, 2 Sep 2020 10:38:18 +0200
> > Corinna Vinschen wrote:
> > > On Sep  2 10:30, Corinna Vinschen wrote:
> > > > Ok guys, I'm not opposed to this change in terms of its result,
> > > > but I'm starting to wonder why all this locale code in fhandler_tty
> > > > is necessary at all.
> > > > 
> > > > I see that get_langinfo() calls __loadlocale and performs a lot of stuff
> > > > on the charsets which looks like duplicates of the initial_setlocale()
> > > > call performed at DLL startup.
> > > > 
> > > > If there's anything missing in the initial_setlocale() call which would
> > > > be required by the pseudo tty code?  What exactly is it?  The codepage?
> > > > And why can't we just add the info to cygheap->locale at initial_setlocale()
> > > > time so it's available at exec time without going through all this hassle
> > > > every time?
> > > > 
> > > > Apart from that, all this locale/charset/lcid stuff should be concentrated
> > > > in nlsfunc.cc ideally.
> > > 
> > > get_locale_from_env() and get_langinfo() should go away.  If we just
> > > need a codepage for get_ttyp ()->term_code_page, we should really find a
> > > way to do this from within internal_setlocale().
> > 
> > I looked into internal_setlocale() code, but I could not found
> > the code which handles thecode page. I found the code handling
> > the code page in __set_charset_from_locale() function in nlsfuncs.cc,
> > but it does not return code page itself. Could you please explain
> > more detail of your idea?
> 
> I had none yet :)  I was just musing, without actually thinking about a
> solution.  But I think this isn't very complicated.  Given this is
> inside Cygwin, nothing keeps the function to have a well-defined
> side-effect, as in setting a (not yet existing) member "term_code_page"
> of cygheap->locale.
> 
> Kind of like this:
> 
> diff --git a/winsup/cygwin/cygheap.h b/winsup/cygwin/cygheap.h
> index 8877cc358c39..2b84f4252071 100644
> --- a/winsup/cygwin/cygheap.h
> +++ b/winsup/cygwin/cygheap.h
> @@ -341,6 +341,7 @@ struct cygheap_debug
>  struct cygheap_locale
>  {
>    mbtowc_p mbtowc;
> +  UINT term_code_page;
>  };
>  
>  struct user_heap_info
> diff --git a/winsup/cygwin/nlsfuncs.cc b/winsup/cygwin/nlsfuncs.cc
> index 668d7eb9e778..752f4239d911 100644
> --- a/winsup/cygwin/nlsfuncs.cc
> +++ b/winsup/cygwin/nlsfuncs.cc
> @@ -1298,6 +1298,9 @@ __set_charset_from_locale (const char *locale, char *charset)
>  			    LOCALE_IDEFAULTANSICODEPAGE | LOCALE_RETURN_NUMBER,
>  			    (PWCHAR) &cp, sizeof cp))
>      cp = 0;
> +  /* Store codepage in cygheap->locale so fhandler_tty can switch the
> +     pseudo console to the correct codepage. */
> +  cygheap->locale.term_code_page = cp ?: CP_UTF8;
>    /* Translate codepage and lcid to a charset closely aligned with the default
>       charsets defined in Glibc. */
>    const char *cs;
> 
> Make sense?

I have tried your code, however, it does not work as expected.
It seems that __set_charset_from_locale() is not called.
cygheap->locale.term_code_page is always 0.

I have added following lines into setup_locale() to make sure
to call __set_charset_from_locale() for a test,

  setlocale (LC_ALL, "");
  __set_charset_from_locale (__get_global_locale()->categories[LC_CTYPE], charset);
  get_ttyp ()->term_code_page = cygheap->locale.term_code_page;

however, term_code_page is set to 932 if locale is ja_JP.UTF-8.
In this case term_code_page should be CP_UTF8 (65001).

The code page retrieved in __set_charset_from_locale() is not
based on "UTF-8" but "ja_JP".

Let me consider a while.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
