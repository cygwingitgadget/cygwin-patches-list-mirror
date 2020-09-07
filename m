Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id B7007393C853
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 09:54:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B7007393C853
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 0879sidk009063
 for <cygwin-patches@cygwin.com>; Mon, 7 Sep 2020 18:54:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 0879sidk009063
X-Nifty-SrcIP: [124.155.38.192]
Date: Mon, 7 Sep 2020 18:54:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200907185445.557d29d868856787e3c0f5b2@nifty.ne.jp>
In-Reply-To: <20200907090823.GF4127@calimero.vinschen.de>
References: <20200904124400.GQ4127@calimero.vinschen.de>
 <20200904235016.9c34d04e809b5ad9f2bdfdf3@nifty.ne.jp>
 <20200904192235.GW4127@calimero.vinschen.de>
 <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
 <20200905201506.8bbca09f51a2b2b06135affa@nifty.ne.jp>
 <20200905231516.c799225e61b2b96bf05f65a6@nifty.ne.jp>
 <20200906175703.5875d4dd6140d9f6812cf2a9@nifty.ne.jp>
 <20200906191530.32230a99bf23d3c6f21beb41@nifty.ne.jp>
 <20200907010413.53ef9a9b727e8f971ca6b2ea@nifty.ne.jp>
 <20200907134558.3e1cd8bd4070991b856f58bb@nifty.ne.jp>
 <20200907090823.GF4127@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 07 Sep 2020 09:55:02 -0000

On Mon, 7 Sep 2020 11:08:23 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Sep  7 13:45, Takashi Yano via Cygwin-patches wrote:
> >  #if 0 /* Let's try this if setting codepage at pty open time is not enough */
> > -  if (!cygheap->locale.term_code_page)
> > -    cygheap->locale.term_code_page = __eval_codepage_from_internal_charset ();
> > +  if (!get_ttyp ()->term_code_page)
> > +    get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset (NULL);
> >  #endif
> 
> *If* we revert back to using setup_locale, these #if blocks would
> go away.
> 
> > -__eval_codepage_from_internal_charset ()
> > +__eval_codepage_from_internal_charset (const WCHAR *envblock)
> >  {
> > -  const char *charset = __locale_charset (__get_global_locale ());
> > +  const char *charset;
> > +  __locale_t *loc = NULL;
> > +  if (__get_current_locale ()->lc_cat[LC_CTYPE].buf)
> > +    charset = __locale_charset (__get_current_locale ());
> > +  else
> > +    {
> > +      char locale[ENCODING_LEN + 1] = {0, };
> > +      if (envblock)
> > +	{
> > +	  const WCHAR *lc_all = NULL, *lc_ctype = NULL, *lang = NULL;
> > +	  for (const WCHAR *p = envblock; *p != L'\0'; p += wcslen (p) + 1)
> > +	    if (wcsncmp (p, L"LC_ALL=", 7) == 0)
> > +	      lc_all = p + 7;
> > +	    else if (wcsncmp (p, L"LC_CTYPE=", 9) == 0)
> > +	      lc_ctype = p + 9;
> > +	    else if (wcsncmp (p, L"LANG=", 5) == 0)
> > +	      lang = p + 5;
> > +	  if (lc_all && *lc_all)
> > +	    snprintf (locale, ENCODING_LEN + 1, "%ls", lc_all);
> 	    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 	    sys_wcstombs (locale, ENCODING_LEN + 1, lc_all);
> 
> OTOH, if you read these environment vars right from our current POSIX
> env, you don't have to convert from mbs to wcs at all.  Just call
> getenv("LC_ALL"), etc.  After all, envblock is just the wide char
> copy of our current POSIX env.

IIUC, envblock is not a copy of environment if exec*e() is used.
In this case, getenv() cannot retrieve the new environment values
passed to exec*e(). This is needed by the test case bellow.

  int pm = getpt();
  if (fork()) {
    [do the master operations]
  } else {
    char *env[] = {"LANG=ja_JP.SJIS", ...., NULL};
    setsid();
    ps = open(ptsname(pm), O_RDWR);
    close(pm);
    dup2(ps, 0);
    dup2(ps, 1);
    dup2(ps, 2);
    close(ps);
    execle("/bin/tcsh", "/bin/tcsh", "-l", NULL, env);
  }

> > +	  else if (lc_ctype && *lc_ctype)
> > +	    snprintf (locale, ENCODING_LEN + 1, "%ls", lc_ctype);
> > +	  else if (lang && *lang)
> > +	    snprintf (locale, ENCODING_LEN + 1, "%ls", lang);
> > +	}
> > +      if (!*locale)
> > +	{
> > +	  const char *env = __get_locale_env (_REENT, LC_CTYPE);
> > +	  strncpy (locale, env, ENCODING_LEN);
> > +	  locale[ENCODING_LEN] = '\0';
> > +	}
> > +      loc = duplocale (__get_current_locale ());
> > +      __loadlocale (loc, LC_CTYPE, locale);
> > +      charset = __locale_charset (loc);
> > +    }
> 
> Oh, boy, this is really a lot.  I have some doubts this complexity is
> really necessary.  It's a bit weird to go to such great lengths for
> native applications.  Still, why not just do this once in the process
> creating the pty rather than trying on every execve?

This is executed just once for a pty. Because
__eval_codepage_from_internal_charset() is called only when
get_ttyp ()->term_code_page is not set yet.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
