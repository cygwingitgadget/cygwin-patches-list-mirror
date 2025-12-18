Return-Path: <SRS0=Z/EC=6Y=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 437034BA2E05
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 09:04:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 437034BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 437034BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766048662; cv=none;
	b=V8c/7BI2QE094tGsxvwqy2zjbesZQrGmF2d8t5A9GQRc5AC8ujk1msiqSaj9yvfp3JITSrDZmN9/ESH7FeQTXkT52QzAJrCqDjcf4Y+HBQXhilJHJ5MUv5/Xpnda20mOuPkn33btby57KaNt2Zkk+1bLGhKDSjQ+mW0jmMz4tls=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766048662; c=relaxed/simple;
	bh=OZalERg0nyy3C3My23m7yYyAV7wcVXPAVgcxqlO5fKw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=PoCAWj2gc/lnKopsK4atMciKVjNoB+OrMolRl89LrWZSlglor+NAR6FP1Gcy9y/N3gh0a9YSPS128uyClRjwfoNgFJ2GZKnrdXC5lRn8PgooT3t3rW0wYtiCMe5npFko8Rmu2LnA6CBgn58GsgGyOyq8MFcP57dokpNOguEH5p8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 437034BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=HZfvdPC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766048655; x=1766653455;
	i=johannes.schindelin@gmx.de;
	bh=X8ccM4Nsk5Na7AALywnLlbMThkwMaW51PHRfaDFf4pg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HZfvdPC4LHDzLQDOY0p82AuYNpwxev3EENnspxudBjpr0AA0mX+OIWONZDqy4sIR
	 4xjWkUCg31ojfUMYacDBYxcYvcpEuc/pUK+QpjqMMf2W/yS51hsmH9c5wev0Ezazr
	 C36hGtcAZLdS5+eoTT7LJgv2eweLh+1C0myUVTQKRI5OJuXSV+6r6Xz/ndmSLqBVh
	 s3PE+K5pljXRtY15Z8KWwK2wfzDHcdgUX3Ui62vyxvZu73WpTBMTQcJmIS22CbHTs
	 p0kWiwO50CcmQfUZCymz+F7bwxBSapKP49XkMNpXd2tNxfhoSJu5zzbS20k3wits5
	 kR5fuAjIdTx/8v6utg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.212]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63RQ-1w30jf0A3M-015qZy; Thu, 18
 Dec 2025 10:04:15 +0100
Date: Thu, 18 Dec 2025 10:04:13 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Corinna Vinschen <corinna@vinschen.de>
Subject: Re: [PATCH v2 2/2] Cygwin: pty: Add new workaround for rlwrap in
 pcon enabled mode
In-Reply-To: <20251218072722.1634-3-takashi.yano@nifty.ne.jp>
Message-ID: <44b4f408-477d-f179-61ce-716c06e99495@gmx.de>
References: <20251218072722.1634-1-takashi.yano@nifty.ne.jp> <20251218072722.1634-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I7H//SfFEJ6J6lRFbQGmGO1Tf3umUVlvSci6T/vLnIHwhTUVrQx
 VNxqyay7PCJ6asmazt2hJsMl56Cikwaz3XYNmT75sFhOIj8qFm5Afp+sZLpm/tU7NyFSkh5
 7dCgBNVq9s25kmGlAI8r/0/PS3AZZykKJhIzTXBdTxKArRgm/ZG+QcoYgoigNxSfppl2Rlr
 D+uObtiLEUPEUXCCmaTMA==
UI-OutboundReport: notjunk:1;M01:P0:cSqyIxLiS2k=;3XbVZq1jAlivE0ua0lt9wnDa443
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 18 Dec 2025, Takashi Yano wrote:

> In Windows 11, the command "rlwrap cmd" outputs garbaged screen.
> This is because rlwrap treats text between NLs as a line, while
> pseudo console sometimes omits NL before "CSIm;nH". This issue
> does not happen in Windows 10. This patch fixes the issue by
> adding CR NL before "CSIm:nH" into the output from the pseudo
> console if the OS is Windows 11.
>=20
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pty.cc         | 44 +++++++++++++++++++++++++++
>  winsup/cygwin/local_includes/wincap.h |  2 ++
>  winsup/cygwin/wincap.cc               | 11 +++++++
>  3 files changed, 57 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 3b0b4f073..7acedc165 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2775,6 +2775,50 @@ fhandler_pty_master::pty_master_fwd_thread (const=
 master_fwd_thread_param_t *p)
>  	    else
>  	      state =3D 0;
> =20
> +	  /* Workaround for rlwrap in Win11. rlwrap treats text between
> +	     NLs as a line, however, pseudo console in Win11 somtimes
> +	     omits NL before "CSIm;nH". This does not happen in Win10. */
> +	  if (wincap.has_pcon_omit_nl_before_cursor_move ())
> +	    {
> +	      state =3D 0;

The pattern of the first two `for()` loops in this function is to reset
both `state` and `start_at` (even if the `/* Remove OSC Ps ; ? BEL/ST */`
loop seems not to reset either, which might be a bug). Should `start_at`
be re-set to 0 here, too?

> +	      for (DWORD i =3D 0; i < rlen; i++)
> +		if (state =3D=3D 0 && outbuf[i] =3D=3D '\033')
> +		  {
> +		    start_at =3D i;
> +		    state++;
> +		    continue;
> +		  }
> +		else if (state =3D=3D 1 && outbuf[i] =3D=3D '[')
> +		  {
> +		    state++;
> +		    continue;
> +		  }
> +		else if (state =3D=3D 2
> +			 && (isdigit (outbuf[i]) || outbuf[i] =3D=3D ';'))
> +		  continue;
> +		else if (state =3D=3D 2 && outbuf[i] =3D=3D 'H')
> +		  {
> +		    /* Add omitted CR NL before "CSIm;nH". However, when the
> +		       cusor is on the bottom-most line, adding NL might cause
> +		       unexpected scrolling. To avoid this, add "CSI H" before
> +		       CR NL. */
> +		    const char *ins =3D "\033[H\r\n";
> +		    const int ins_len =3D strlen (ins);
> +		    if (rlen + ins_len <=3D NT_MAX_PATH)

How can we avoid this problem when running out of buffer space?

Ciao,
Johannes

> +		      {
> +			memmove (&outbuf[start_at + ins_len],
> +				 &outbuf[start_at], rlen - start_at);
> +			memcpy (&outbuf[start_at], ins, ins_len);
> +			rlen +=3D ins_len;
> +			i +=3D ins_len;
> +		      }
> +		    state =3D 0;
> +		    continue;
> +		  }
> +		else
> +		  state =3D 0;
> +	    }
> +
>  	  if (p->ttyp->term_code_page !=3D CP_UTF8)
>  	    {
>  	      size_t nlen =3D NT_MAX_PATH;
> diff --git a/winsup/cygwin/local_includes/wincap.h b/winsup/cygwin/local=
_includes/wincap.h
> index 2416eee1d..0496d807e 100644
> --- a/winsup/cygwin/local_includes/wincap.h
> +++ b/winsup/cygwin/local_includes/wincap.h
> @@ -34,6 +34,7 @@ struct wincaps
>      unsigned has_con_broken_tabs				: 1;
>      unsigned has_user_shstk					: 1;
>      unsigned has_alloc_console_with_options			: 1;
> +    unsigned has_pcon_omit_nl_before_cursor_move		: 1;
>    };
>  };
> =20
> @@ -92,6 +93,7 @@ public:
>    bool	IMPLEMENT (has_con_broken_tabs)
>    bool	IMPLEMENT (has_user_shstk)
>    bool	IMPLEMENT (has_alloc_console_with_options)
> +  bool	IMPLEMENT (has_pcon_omit_nl_before_cursor_move)
> =20
>    void disable_case_sensitive_dirs ()
>    {
> diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
> index 91caefe9b..f94b9f60b 100644
> --- a/winsup/cygwin/wincap.cc
> +++ b/winsup/cygwin/wincap.cc
> @@ -33,6 +33,7 @@ static const wincaps wincap_8_1 =3D {
>      has_con_broken_tabs:false,
>      has_user_shstk:false,
>      has_alloc_console_with_options:false,
> +    has_pcon_omit_nl_before_cursor_move:false,
>    },
>  };
> =20
> @@ -56,6 +57,7 @@ static const wincaps  wincap_10_1507 =3D {
>      has_con_broken_tabs:false,
>      has_user_shstk:false,
>      has_alloc_console_with_options:false,
> +    has_pcon_omit_nl_before_cursor_move:false,
>    },
>  };
> =20
> @@ -79,6 +81,7 @@ static const wincaps  wincap_10_1607 =3D {
>      has_con_broken_tabs:false,
>      has_user_shstk:false,
>      has_alloc_console_with_options:false,
> +    has_pcon_omit_nl_before_cursor_move:false,
>    },
>  };
> =20
> @@ -102,6 +105,7 @@ static const wincaps wincap_10_1703 =3D {
>      has_con_broken_tabs:true,
>      has_user_shstk:false,
>      has_alloc_console_with_options:false,
> +    has_pcon_omit_nl_before_cursor_move:false,
>    },
>  };
> =20
> @@ -125,6 +129,7 @@ static const wincaps wincap_10_1709 =3D {
>      has_con_broken_tabs:true,
>      has_user_shstk:false,
>      has_alloc_console_with_options:false,
> +    has_pcon_omit_nl_before_cursor_move:false,
>    },
>  };
> =20
> @@ -148,6 +153,7 @@ static const wincaps wincap_10_1803 =3D {
>      has_con_broken_tabs:true,
>      has_user_shstk:false,
>      has_alloc_console_with_options:false,
> +    has_pcon_omit_nl_before_cursor_move:false,
>    },
>  };
> =20
> @@ -171,6 +177,7 @@ static const wincaps wincap_10_1809 =3D {
>      has_con_broken_tabs:true,
>      has_user_shstk:false,
>      has_alloc_console_with_options:false,
> +    has_pcon_omit_nl_before_cursor_move:false,
>    },
>  };
> =20
> @@ -194,6 +201,7 @@ static const wincaps wincap_10_1903 =3D {
>      has_con_broken_tabs:true,
>      has_user_shstk:false,
>      has_alloc_console_with_options:false,
> +    has_pcon_omit_nl_before_cursor_move:false,
>    },
>  };
> =20
> @@ -217,6 +225,7 @@ static const wincaps wincap_10_2004 =3D {
>      has_con_broken_tabs:true,
>      has_user_shstk:true,
>      has_alloc_console_with_options:false,
> +    has_pcon_omit_nl_before_cursor_move:false,
>    },
>  };
> =20
> @@ -240,6 +249,7 @@ static const wincaps wincap_11 =3D {
>      has_con_broken_tabs:false,
>      has_user_shstk:true,
>      has_alloc_console_with_options:false,
> +    has_pcon_omit_nl_before_cursor_move:true,
>    },
>  };
> =20
> @@ -263,6 +273,7 @@ static const wincaps wincap_11_24h2 =3D {
>      has_con_broken_tabs:false,
>      has_user_shstk:true,
>      has_alloc_console_with_options:true,
> +    has_pcon_omit_nl_before_cursor_move:true,
>    },
>  };
> =20
> --=20
> 2.51.0
>=20
>=20
