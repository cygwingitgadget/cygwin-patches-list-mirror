Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id E4258385783C
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 09:08:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E4258385783C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MJm8H-1jzSdM1dVp-00KCzb for <cygwin-patches@cygwin.com>; Mon, 07 Sep 2020
 11:08:25 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B2B44A83A8F; Mon,  7 Sep 2020 11:08:23 +0200 (CEST)
Date: Mon, 7 Sep 2020 11:08:23 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200907090823.GF4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907134558.3e1cd8bd4070991b856f58bb@nifty.ne.jp>
X-Provags-ID: V03:K1:lbJ1NYvY0F7D7WqKjls1HQbTrww2dNUVD2gUYyNMQs2cIm8WP0C
 rFgcDI4KSs2AcJ/i2iSgSGXWLYW86JkzfoAu6MGGZ6ZxhGBufBCF3tOxHuurN7nTSXzKccQ
 vAjOvJZdlq8/+1FsOCXJM5msEzjWLuWDCjb0j8v3rWFOX0ahMB2si4RpT/oiBOnuVrwhFSE
 aQsZc7G8VbmL563cMBoPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K0yvlmzsIQM=:c8QLYJg/Wue+WVzrNH5Eut
 MAyULedbzGOcFPoa3E7ypfBpGOlUAmxeVuQeHajBLSrDHv801QHshwJU1STTEJTDkQXQAx6GD
 /b8Gh8fctBcj582KDK3mBYK/4PYAkb+eGqx1BUW9AJvvTg7sdfvDrHSzTxO0izVzwJuVyysmT
 VE2MRPNGGg/kw4L7kRCah+a2WaLN/4tmmpKheV7ZSFFg2gJlUHhgE6iqZhBLIoKYuPgaCBSue
 y9SPMrGxSAtLf1nTGOaZvqHSP1fbVsCo9Wlvjj8QpACIOW89L5laBN8vpFmjefi9PSDdwcxll
 IoiDeK4PUFPVbbQxS9WPmVmA8REz1cLBKPQkAiRyRDCAJGYBGuUKChMam4kF6pmQZfHKl/szm
 PXrohUhTsNqvCi35GYomJDccwNBea/1I3FhW8nuDszDTQfqvXItPQ40GcCAgFABIL1d6j1COn
 BO+HNlpwFJDzOrgOTjIxN6YGcQgUh7JA7cQrMJZzw2nA/Hc94CXFFQEAtl5bOr4XZ5PrR5wzs
 OssjjhE0jeUf/ocoDzxKJu39zBm/yDjcYrUTrLNuhWVi+49QIU6UuXLvXooY0dxA8jukVTIQ2
 6glNPzWqq8hyhPUgdEq+noXMILHDt8j8u6v/4L1/1AV5lXFDuhrL5tYYi3SWQytFbDvhsQZSW
 ozQsRot28o0sYmbkPCvfJb9OKXy1L4/JDBXKgams5wWUXz3F34S6UXqdVEpJpNgt+1mXnrGMl
 9xJL3wXgznAN1ysqU3xXkmbdyihRxWePxoyK90gVcW/jxmE9ninKyBpX+osLpoEb5WKNoE9Js
 0m9C2qKt+G3zPEMssDLNUhbEy/3RDwoVhBV/1ovkFRjXNcZwxxzmnELvih49xrJE0NTJppMV1
 kQTwSY2WJhOrsmry9F3A==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 07 Sep 2020 09:08:28 -0000

Hi Takashi,

On Sep  7 13:45, Takashi Yano via Cygwin-patches wrote:
>  #if 0 /* Let's try this if setting codepage at pty open time is not enough */
> -  if (!cygheap->locale.term_code_page)
> -    cygheap->locale.term_code_page = __eval_codepage_from_internal_charset ();
> +  if (!get_ttyp ()->term_code_page)
> +    get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset (NULL);
>  #endif

*If* we revert back to using setup_locale, these #if blocks would
go away.

> -__eval_codepage_from_internal_charset ()
> +__eval_codepage_from_internal_charset (const WCHAR *envblock)
>  {
> -  const char *charset = __locale_charset (__get_global_locale ());
> +  const char *charset;
> +  __locale_t *loc = NULL;
> +  if (__get_current_locale ()->lc_cat[LC_CTYPE].buf)
> +    charset = __locale_charset (__get_current_locale ());
> +  else
> +    {
> +      char locale[ENCODING_LEN + 1] = {0, };
> +      if (envblock)
> +	{
> +	  const WCHAR *lc_all = NULL, *lc_ctype = NULL, *lang = NULL;
> +	  for (const WCHAR *p = envblock; *p != L'\0'; p += wcslen (p) + 1)
> +	    if (wcsncmp (p, L"LC_ALL=", 7) == 0)
> +	      lc_all = p + 7;
> +	    else if (wcsncmp (p, L"LC_CTYPE=", 9) == 0)
> +	      lc_ctype = p + 9;
> +	    else if (wcsncmp (p, L"LANG=", 5) == 0)
> +	      lang = p + 5;
> +	  if (lc_all && *lc_all)
> +	    snprintf (locale, ENCODING_LEN + 1, "%ls", lc_all);
	    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	    sys_wcstombs (locale, ENCODING_LEN + 1, lc_all);

OTOH, if you read these environment vars right from our current POSIX
env, you don't have to convert from mbs to wcs at all.  Just call
getenv("LC_ALL"), etc.  After all, envblock is just the wide char
copy of our current POSIX env.

> +	  else if (lc_ctype && *lc_ctype)
> +	    snprintf (locale, ENCODING_LEN + 1, "%ls", lc_ctype);
> +	  else if (lang && *lang)
> +	    snprintf (locale, ENCODING_LEN + 1, "%ls", lang);
> +	}
> +      if (!*locale)
> +	{
> +	  const char *env = __get_locale_env (_REENT, LC_CTYPE);
> +	  strncpy (locale, env, ENCODING_LEN);
> +	  locale[ENCODING_LEN] = '\0';
> +	}
> +      loc = duplocale (__get_current_locale ());
> +      __loadlocale (loc, LC_CTYPE, locale);
> +      charset = __locale_charset (loc);
> +    }

Oh, boy, this is really a lot.  I have some doubts this complexity is
really necessary.  It's a bit weird to go to such great lengths for
native applications.  Still, why not just do this once in the process
creating the pty rather than trying on every execve?

>      case 'I': /* ISO-8859-x */
> -      codepage = strtoul (charset + 9, NULL, 10);
> +      codepage = strtoul (charset + 9, NULL, 10) + 28590;

Oops, I just fixed that in my original patch already.


Corinna
