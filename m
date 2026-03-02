Return-Path: <SRS0=kRW9=BC=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id C7CAB4BA23E6
	for <cygwin-patches@cygwin.com>; Mon,  2 Mar 2026 13:24:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C7CAB4BA23E6
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C7CAB4BA23E6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772457888; cv=none;
	b=rrkZwLXgt3n8NtfmufukR6a0VcDnbIszbZfRixPfMS50b2hAKg9Dao9h/AU4aeMmM6WncfkSQP/Wu4bomMNc/w914SGSP5bsa6m05rW3egwFwDCZ8HTE90OQc5u0khA7m/66I0BCJRvTnZZFIi5Bvc1wgjYlpWZmDpBPUpkHbbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772457888; c=relaxed/simple;
	bh=RylBSIbnw55R0W1klYyc/Dp+/TarSPfM0ycjrRJz80M=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=OgJpbrWTVbU9lkjTta0klEaE+XrrG4T7ZUmfdOKr4rgWS63w39b6lcNSn5YrujC1ZfH6N480unlD4ZWJGgiZiDq/ih6sNUux3RjUrh2AD25ZhacHQR1vC7JJwIv5d9MTi/d3wwSp5flcLI2ZfrleOCHftmQ5C3fEpalr21YeflY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C7CAB4BA23E6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=YB9H5nqE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772457881; x=1773062681;
	i=johannes.schindelin@gmx.de;
	bh=jHZVMqEzF4a3DL+jxszpEUo8ikicjnmKgfIQgFJ354Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YB9H5nqEE7cqrn/U99w6hG3Gvg4pml07ahdDD99jL4YwTMUQVzCVNgjMRvil1x50
	 eD6wDbIl7I9wDBcUFgVjtCOhAmRLOXycliRzc33NlR7TngqWqB4/x1OkPJ6nkpzMC
	 CC6axw/TxA/rsf6mDaPBclfjbpo3GKaifvxiCvuW/yjmxdrMzqaWUdz3t98a/tZa5
	 3gA6U3rSAgVsHw5YIhcYj4ZCDQxhnCLzrcYCUaiA80jSJcJIt/Q82PD9j6U27i5Fk
	 iWdJzMQsPb0Kw/66toP5S+AH5enQHkR/5KBb2nJ5XhvvzG3bEMxKVSaDCMa/eUhik
	 M+3ZYyeThlaNiP9/5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1vS8Hx1KU4-00qRrb; Mon, 02
 Mar 2026 14:24:41 +0100
Date: Mon, 2 Mar 2026 14:24:39 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Fix handling of data after CSI6n
 response
In-Reply-To: <20260228090107.2529-1-takashi.yano@nifty.ne.jp>
Message-ID: <b783d055-4785-4bff-c924-eaa67c0f502c@gmx.de>
References: <20260228090107.2529-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UkxXQGY2cFUxNsXhar7QbMyPq9MiRMNqtVTfEpyddf27KgeVFDO
 txXUY+FP0h3Dp7OxyimK8E4G6pUSmB2pWzIGZnB5yaqyBco3d0u/eoqVcGO9ptKttlL9ztn
 StplnAx+4eXJhHjHV3+4G0uDpXjqedEa4MaQrcmPtixUop/K2YT5uO+CEDLgItnn30ifPYB
 4InLlYdT6p9CqBSiLXlOg==
UI-OutboundReport: notjunk:1;M01:P0:cjSVEDRMRuU=;8FiccIfUO1AzntWAnzLgZu6VAyI
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 28 Feb 2026, Takashi Yano wrote:

> Previously, CSI6n was not handled correctly if the some sequences
> are appended after the response for CSI6n. Especially, if the
> appended sequence is a ESC sequence, which is longer than the
> expected maximum length of the CSI6n response, the sequence will
> not be written atomically.
>=20
> Moreover, when the terminal's CSI 6n response and subsequent data
> (e.g. keystrokes) arrive in the same write buffer, master::write()
> processes all of it inside the pcon_start loop and returns early.
> Bytes after the 'R' terminator go through per-byte line_edit() in
> that loop instead of falling through to the `nat` pipe fast path
> or the normal bulk `line_edit()` call. Due to this behaviour,
> the chance of code conversion to the terminal code page for the
> subsequent data in `to_be_read_from_nat_pipe()` case, will be lost.
>=20
> Fix this by breaking out of the loop when 'R' is found and letting
> the remaining data fall through to the normal write paths, which
> are now reachable because `pcon_start` has been cleared.
>=20
> Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Heh, I would have been fine with a mere Reviewed-by ;-)

> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/pty.cc | 47 +++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 22 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 838be4a2b..34a87c6dc 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2137,6 +2137,8 @@ fhandler_pty_master::close (int flag)
>  ssize_t
>  fhandler_pty_master::write (const void *ptr, size_t len)
>  {
> +  size_t towrite =3D len;
> +
>    ssize_t ret;
>    char *p =3D (char *) ptr;
>    termios &ti =3D tc ()->ti;
> @@ -2160,6 +2162,7 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
> =20
>        DWORD n;
>        WaitForSingleObject (input_mutex, mutex_timeout);
> +      towrite =3D 0;

I originally suggested to initialize `towrite` to 0 instead of `len`
above.

The reason why it needs to be initialized to `len`, and only be zeroed
inside the `if (get_ttyp ()->pcon_start)` block is that you are using
`towrite` instead of `len` in the "fall-through" block _after_ the `if
(get_ttyp ()->pcon_start)` block, which you now fall through if the `R`
was encountered.

And you use `towrite` instead of `len` there in that fall-through block in
the UTF-8/code page conversion, but you still use the original `len` as
return value from that method as well as for the `line_edit()` fall-back.

I found this a bit hard to follow.

Wouldn't it be easier to introduce a new variable `size_t orig_ret =3D len=
`
instead of `towrite`, return `orig_ret` instead of len (and using it in
the `line_edit()` call, too), and then adjust `len` instead of assigning
`towrite`?

>        for (size_t i =3D 0; i < len; i++)
>  	{
>  	  if (p[i] =3D=3D '\033')
> @@ -2171,32 +2174,33 @@ fhandler_pty_master::write (const void *ptr, siz=
e_t len)
>  	    }
>  	  if (state =3D=3D 1)
>  	    {
> -	      if (ixput < wpbuf_len)
> -		wpbuf[ixput++] =3D p[i];
> -	      else
> +	      if (ixput =3D=3D wpbuf_len)
>  		{
>  		  if (!get_ttyp ()->req_xfer_input)
>  		    WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
>  		  ixput =3D 0;
> -		  wpbuf[ixput++] =3D p[i];
>  		}
> +	      wpbuf[ixput++] =3D p[i];

Okay, this is correct, a simple refactoring. But it does distract from the
purpose of the patch a bit (and makes reviewing slightly more confusing
than necessary), as it is unrelated.

>  	    }
>  	  else
>  	    line_edit (p + i, 1, ti, &ret);
>  	  if (state =3D=3D 1 && p[i] =3D=3D 'R')
>  	    state =3D 2;
> -	}
> -      if (state =3D=3D 2)
> -	{
> -	  /* req_xfer_input is true if "ESC[6n" was sent just for
> -	     triggering transfer_input() in master. In this case,
> -	     the responce sequence should not be written. */
> -	  if (!get_ttyp ()->req_xfer_input)
> -	    WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
> -	  ixput =3D 0;
> -	  state =3D 0;
> -	  get_ttyp ()->req_xfer_input =3D false;
> -	  get_ttyp ()->pcon_start =3D false;
> +	  if (state =3D=3D 2)
> +	    {
> +	      /* req_xfer_input is true if "ESC[6n" was sent just for
> +		 triggering transfer_input() in master. In this case,
> +		 the response sequence should not be written. */
> +	      if (!get_ttyp ()->req_xfer_input)
> +		WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
> +	      towrite =3D len - i - 1;
> +	      ptr =3D p + i + 1;
> +	      ixput =3D 0;
> +	      state =3D 0;
> +	      get_ttyp ()->req_xfer_input =3D false;
> +	      get_ttyp ()->pcon_start =3D false;
> +	      break;
> +	    }

Okay, that makes sense to me, in case we reach state 2, we want to change
`towrite` and no longer `return len` below, but instead move on to writing
the remainder to the `nat` pipe. It is a bit unfortunate that this
refactor makes the diff a bit harder to read than I like.

Thank you!
Johannes

>  	}
>        ReleaseMutex (input_mutex);
> =20
> @@ -2220,8 +2224,8 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>  	    }
>  	  get_ttyp ()->pcon_start_pid =3D 0;
>  	}
> -
> -      return len;
> +      if (towrite =3D=3D 0)
> +	return len;
>      }
> =20
>    /* Write terminal input to to_slave_nat pipe instead of output_handle
> @@ -2233,15 +2237,14 @@ fhandler_pty_master::write (const void *ptr, siz=
e_t len)
>  	 is activated. */
>        tmp_pathbuf tp;
>        char *buf =3D (char *) ptr;
> -      size_t nlen =3D len;
> +      size_t nlen =3D towrite;
>        if (get_ttyp ()->term_code_page !=3D CP_UTF8)
>  	{
>  	  static mbstate_t mbp;
>  	  buf =3D tp.c_get ();
>  	  nlen =3D NT_MAX_PATH;
> -	  convert_mb_str (CP_UTF8, buf, &nlen,
> -			  get_ttyp ()->term_code_page, (const char *) ptr, len,
> -			  &mbp);
> +	  convert_mb_str (CP_UTF8, buf, &nlen, get_ttyp ()->term_code_page,
> +			  (const char *) ptr, towrite, &mbp);
>  	}
> =20
>        for (size_t i =3D 0; i < nlen; i++)
> --=20
> 2.51.0
>=20
>=20
