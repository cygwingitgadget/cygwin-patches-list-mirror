Return-Path: <SRS0=0tR4=ZI=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 23BB03857BA5
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 12:40:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 23BB03857BA5
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 23BB03857BA5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750855238; cv=none;
	b=RXGpCtjXwJAXYJmWQr0MPcmXjg636ODNLLq2xsYrVSCC+VpcV5XnJmU5d9EqbzS0N1ET6MgPR7/42H8/UqpZWBecJb1pqJ/KYyR4hgPXaOdhtc4tXaFB4bWFc6R3JHv/H+GF+66a5HIgxNyqGEf1ZdKq1Lf7M8E6oBRzwq+sX5U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750855238; c=relaxed/simple;
	bh=VjF0yPB4Fo2kQmTUKNYt8kd8OT9cGREcxEmPWmLic5k=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=T92DIIbQzuNycmzvOaYkUpQSsxeKmZCQ1tvXMhxGIkHLBtZFzl76RR11/HHnMRTNrxaTA9O4pxepvyDhgZWuk6VXJUedsJgG6yOfWDVzGb3YXNvOQbG4zQNxNRccwiK6YthF8r+G2EDsV8yZwZvXPApf7XFPucDoJDBl96VdIqw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 23BB03857BA5
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=rM6suZ+5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750855231; x=1751460031;
	i=johannes.schindelin@gmx.de;
	bh=6uz37dcSRa4cpTg7+9GVW/08+dR/JQ9X2xIZvMx55BU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rM6suZ+5rQEq/r0ULoXUtMuDp9EFH9D4X6zpfi7OVDlfXI5tn4zOoh3RimSVOhsZ
	 ypoWqf7JqUDZ9DVYnhS5wdXcrUmIHDQJWkRnX/fAUngRoVWwCYxK6QW73t90A7LLc
	 VNePe7BOAWT9OvpigD/ucTV8+lS6S1ZCTOD7+dxVDioJscc81AyWGqAjLXsGU0V7R
	 N5tcBhPCfOGzJx8+yzcuj3tnwk4IeMeei6WlX3o8+5Yq2JEzbq0SzAOfdUBvt96Mc
	 trLTNRWrQW2k6IoKJgPLMPCr7rrcXSPUWL646dgfFkFE+5letrbKbj9t+B7ktEApO
	 9F7i27V+GbP0oOQZHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.172]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9Q6-1umtkR1bsa-00v7BR; Wed, 25
 Jun 2025 14:40:31 +0200
Date: Wed, 25 Jun 2025 14:40:29 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Fix unexpected blocking mode change by
 pipe_data_available()
In-Reply-To: <20250625105931.1522-1-takashi.yano@nifty.ne.jp>
Message-ID: <5fca3b50-4c06-fdf2-05ec-a698822f9891@gmx.de>
References: <20250625105931.1522-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-933796739-1750855231=:4560"
X-Provags-ID: V03:K1:4ypTC4/0j6pzaZEg6Xy0IPs7p7pen+sqUseWoKYC+SxA96CHjpX
 IuxZva5V66QBWyjIu+cLf8UAt5gCTNZeXaw9zhSQE0i1xpb4bEIev3F4WI8D+VlcbuG4RWE
 IuuzCogbfuCk+3D9x86bDF69w9Zpp5UqYg0DEG3Zg1IjZN50QvIsTn/xUsw1XOxZuq8rPVq
 hRLuce00CIMzZlY+t93sA==
UI-OutboundReport: notjunk:1;M01:P0:cW5DWYZmaRc=;XmUujWI3KC1XlLcyPsG3Rh+C1nE
 hfKupKkSRC770Vfc5n3lmpDyDsg5COn3wapc+7+VkYeorTuUc1qox/7sZGAvks+smj6ho5qOr
 jg5/0boPgStBXpu3v58ZOVjtlXWtPNGBqFhTTNW8zHtsINhW4hwCijGj7nqw2cYQS5pUtWaC1
 YMnRMxGkAvBpbVRLwRbcbLtaypy8RB0CxgjR/s+q435rC6rZoKoyQrY2OxvRrYtUdDdmj9Jln
 LoLvtZczaPnQOS6H2Whi7L3BaLxtSmZM0Oxv+gemp92I71HfFEz17FtPvi1JNEOpCc9VP4Zaj
 mZD47MHnT0YHFz5lACCVpVOTNLQgUjmzM9HpRmbycKhZcXIN9YQXhwFu2M+FjxJXONPd0Cohm
 Stksa9WEsK+U87J+olPmwlKdE23oFoG6qFWe3cWc6VWr0f3h77JGn+eSTCpycSHt86GiFt+9N
 7IhCUGBKP+YMNQNIk0eFKC48v3mhPgOO06fkEqcPDJPO3oK7mw4WVy2SkFL86WA+ZTk4r1I7N
 pUu+CW+Hu4NVixFW6n46EqTTHR2QtdO+0RH3vU8LyW4DwcP7OCavcOPHzKueNzKm9s43wnbrL
 xNn8f2NckjAYraOJGOILbMorDGgpLRNB+MMGcHjY2+Y/nlk1kOYHBOOjWKrTo2TUxwOrf8x+/
 8DoUIuWJcYq9auueessnC13YfD2+JZXGIyFwDRQG0cvJXq9wi83kdToxoOBBQsUWCpI2CFVnm
 m0oMGU2TGxOab6b/KZuV4JvpE8GCaAYwn+A8QLBE01EdqGagzLt8Mox1oC2RGJ9jUB6FuspA/
 CbPierlZOTF2VKcFTY9pupp9dG8cXWjyqCCbs/QOWzrTgIPDjfTjJiJIDI54CuBmu/Bcz9f/2
 VCbht5X575ErJwd0QTtItCAU0cVG7ZLt8VKlYEWSHm4jO/a0m0NiT5WDIkw4Mwg9ieY6Y5rhe
 D9Vu4JT9mN97fv6UW920ENYICbFVtydadTpsIDCRZMN0d5qBCalW9vE6wSud0qw3AR+rZPpJV
 UTrj/wmT8sd74FPab0MLlDmARJfA2BphSRNAOkyFeH4UAyRsxXQ+nIjFFlk3ybIu1NxsW80YG
 ooSUeadKnvzW8L7eExTxgWYSbn+lh9DXHF/tZAjHlCPYYF7NQfpIumul8BQ5LOs58FEZhf7fN
 S3lULZtvgjWLIpf4e+W7FZ5Lpx3EQlgBeQBsybHBsvPis5a5hrq806sH+DjyxiiWtayVmjv7w
 uwo5Lg74B389+/I8Ttb2QNsji3inzWIkq2UjI2fAr1Ph48ATEIF/ip86h5BdKKYroi0rcZ4sw
 /8yrOvTXs81i8L+fTqk2ZYuy4dQm6cexydxj9U6Kf1/2WCfp2OjO6b/zpHCciTruDd83Pkc2f
 IYr7PE2RRSO4+jHxdEU0+XtnL3yFTqAIv712241QzT9FxRwgGdzepsjv8G8eS+JfYxMJHdI44
 r2R9QglVo6vBFXd0/vNQb7SK/58Fp1yXx+1Si0NAPy+7GbsYPsN/dLuh1obcS53nZzv1Olk5s
 TQ+cLxkzUkXSEX4OqsFXnlSCz2/zdbNeZe2QmQrrhnsOGAPeXbLNDje/WkE0NYHkwBF3NraqJ
 HFqKfTCSrWEAriSFdKVzuOR/OcnYVDaR0u3mPqNcpaUAnoQZvy2BmkG7qAd6dBMCqDGXXO6sk
 4uXhzdHOSBUGTY/AGJHLKT/g61h/WPhH6vesxGHxJ7EhM92ms3/hifOMEtYS+fQmfeQht93yG
 6S/M1VpraUGWxAgDBJhhptMUZKzz0wwdaDsowMpvRnsSlURTZPxziEfLjEVFxlKRkofl1v/W0
 6W+HZY7eTf6p/P4VggrWoxVTOWnvnVKA2fo0WlKAA5A7UeUF+tlBXmxbKkcmHkHwr6x0y5ARx
 FdWoascUe5ppUYaIpneTN+a5D9f/wv3/cbJa69OyDyIhxmMcn3XKsKuBZW99sx2v/aWd6zAYU
 jNBAO53k3+XLLSjZtwoV8dZEpo/1PmIsjKsSHK9U1AqcBkNmXibAwp2rOpgp1YWisJ8nSSKdz
 +o2Zl1S80lgvshTGi4Qub799urSAYdbh655ZjR8+2rbLLYqRSF0ybyKdFi/Xhc/WTZ+X16SQf
 YtRMXbICw5AjKQrbRUQMsaA8RHy5oAyAc1p8Z5hD+WVozZC9wVi2Z3zMNt8FtOMMTGf/uYf6d
 RLvj3r00VwYMRsuHSztBIavv2V8L+OwUV2RtvNLIIWhLR+5k6lGLbpxbPAB44FBf8ya/h1P/k
 bh26bi5yqrJffsCUJUdnlrSj/IF3G+DwVJLqkx/ITmKJD7CmSz1j2V63blRhrKGAQWLQ9gNXu
 gsakQ5rz8b+7Q1E5ctb7BXenaCp+N9v0fhJv2nzy2Bj1tZv5c79rWG7TBtP2AP/NRkWyUZwK7
 08tb97g4CjMKGU+bMAxEBSKbmbmscBjn7rqMUFhsw1nuWKq0dlTwemNSvitb5yGG1HRhW0orQ
 MQqjHFsAWPtOK/Cp/iFS0J4UvX2Ha1DuyKOgK+vWn0yGjGLUimA+X5SHdyoVXXiNDKkC+MblL
 6E56Qp+IKi8dnRHS/u5cqgEg+hZYF5i3CUx104cAOf9cMdLXkYT0udPqqKTRjqjN7jRNXKBFU
 8pzvYy6/3VUf4s9JR21AXzAq4wLPFZVY8rqHt6qRhRRtvN8blaFMRc95T1ta+49m4EdvIdQb0
 Q9EN62gwkYxnT3250NPfqEkE54NByOq5096sLl+smu93IIm8a4r5Cg+aJaroYqFZvJ9SoSke5
 +A3aYjBAU2o6eLaQioarxUy1kp31lsIYwti1VCgCDEaejUSQI5fOdmfRZoIRCWtMcqMGLhw60
 +Cu6HvaI3jndv87ZpsXyRe5jAvA/fBhMqDF5f8BYiSti4muILaV4KPpYacKx1TgqM2zganU5H
 h6CYD/yvVGndr/smP9y4w5jUIcx1ML37m4YQxrIKqMWauWtaZAHxBnhDP0yeyMbA9SIQjyK2+
 hIRiuO1C0Fdkm/ZfpsOt9v7da2mLC1JdiJJ4QzP2IAql4Fwu8Vum5JCnME6UIk1cm2FclqiR8
 u8USNmX1lvpNFbuR2YiN7iyfUHEIsDCEzoXv7MYSHNp7Ok77+0x4EIuI0cN2SKaxrT84qwAAZ
 oOEcrTgnhnvflpS05+oa4vJPXugwITfPq9BUBpLh5uQV4LnpoovBm7eu35TbG1Fkaup5+dD7/
 lAln2HTv/oeGynv8xz9pZW5RzhaMWxDrxS9NLz4GNhXuBoCNBYVAZCQJbV/Wkqwju0w3TFmcJ
 2zKH5mJsZBULDFLOawnnI5HXAtAzv2snuKqhgAOPTlQnP55r1XDMhkp61kvFx0npxAgTAzJlE
 4JBGBbSuUxNoQg9/Ik3hv9IeKLkLW/lubb23QsrITklMc5BJTz08R9OXbFZVcYKfs3VMpnp3T
 tb+MlQt6t8CJoT5aHMHEm8VMH7kIZM1yZfB7pwIf4T8ciEOBYRLHls/k9C487uGtSvCzLGG/+
 9v8I6fuyr7OXrCaNzfpngREtCRHsy3VmhOJbx1vO8k+taINAoA+T85+bOJ8F3bm1ZUSvlqBYE
 8pFdDsBNnU3KO9ixl7rNiNVMOP4DiniHHKzmFYaORa9a0GXOru9sgllC7HXh2reD2aKn9c1ie
 FAmA5OyK0K+sdSVrElzil/GRaNy1TyEGRxhSG/jcFk7x1gmoWRi2eBhaQ==
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-933796739-1750855231=:4560
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, 25 Jun 2025, Takashi Yano wrote:

> pipe_data_available() is called in the raw_write() and if the pipe
> is real_non_blocking_mode in raw_write(), the pipe mode can be
> accidentally reverted to blocking mode in some cases by calling
> pipe_data_available().

Okay, let's unpack this a bit, because in the current form, the commit
message is inadequate.

So `pipe_data_available()` is called in `raw_write()`. But when?

Looking at the code, it seems that it is only called in the code that
works around Windows-specific behavior that is different from what Linux
does, by reducing the number of bytes to write after a failed attempt.

The most crucial point (which _must_ be mentioned in the commit message!)
is that `pipe_data_available()` =E2=80=94 despite its name suggesting that=
 it is
purely an accessor =E2=80=94 is a _mutator_! That is, under certain circum=
stances
(when `NtQueryInformationFile()` failed to figure out the pipe's buffer
size) it temporarily flips the mode to non-blocking. According to the code
comment in `select.cc`, which should at least partially be recapitulated
in this patch's commit message, this mode flipping is done solely to find
out whether a read is pending).

Never mind that it tries to flip the mode whether the pipe is in blocking
mode or not (and 7ed9adb356 (Cygwin: pipe: Switch pipe mode to blocking
mode by default, 2024-09-05) keeps mum about the reasons, too) it always
flips the mode "back" to blocking.

> With this patch, pipe_data_available() reffers current real blocking
> mode, and restores the pipe mode to the current state.

This fails to answer the obvious question whether the method of mode
flipping works in either direction to find out whether a read is pending
on the other side. In fact, it is not even clear to me whether you
verified that this is so, or whether you found documentation saying that
it behaves this way.

And since this purportedly fixes a bug, the question begs itself whether
there should not be a new test case in the test suite to prevent
regressions.

> Fixes: 7ed9adb356df ("Cygwin: pipe: Switch pipe mode to blocking mode by=
 default")
> Reported-by: Andrew Ng (@github)

No, Andrew's handle is not `@github`. And the actual reference is missing
and needs to be added:
https://github.com/git-for-windows/git/issues/5682#issuecomment-2997428207

> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pipe.cc          |  2 --
>  winsup/cygwin/local_includes/fhandler.h |  3 +++
>  winsup/cygwin/select.cc                 | 11 ++++++-----
>  3 files changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pip=
e.cc
> index 4f23bd38c..ea0a8d807 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -326,7 +326,6 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
>        ULONG_PTR nbytes_now =3D 0;
>        ULONG len1 =3D (ULONG) (len - nbytes);
>        DWORD select_sem_timeout =3D 0;
> -      bool real_non_blocking_mode =3D false;

I'll go ahead and take this as a belated answer to my question why
`real_non_blocking_mode` isn't a class attribute. It now is!

> =20
>        FILE_PIPE_LOCAL_INFORMATION fpli;
>        status =3D NtQueryInformationFile (get_handle (), &io,
> @@ -453,7 +452,6 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size=
_t len)
>      return 0;
> =20
>    ssize_t avail =3D pipe_buf_size;
> -  bool real_non_blocking_mode =3D false;
> =20
>    /* Workaround for native ninja. Native ninja creates pipe with size =
=3D=3D 0,
>       and starts cygwin process with that pipe. */
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index 3d9bc9fa5..04e2ca4c3 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -1203,6 +1203,7 @@ class fhandler_pipe_fifo: public fhandler_base
>   protected:
>    size_t pipe_buf_size;
>    HANDLE pipe_mtx; /* Used only in the pipe case */
> +  bool real_non_blocking_mode; /* Used only in the pipe case */
>    virtual void release_select_sem (const char *) {};
> =20
>    IMPLEMENT_STATUS_FLAG (bool, isclosed)
> @@ -1212,6 +1213,8 @@ class fhandler_pipe_fifo: public fhandler_base
> =20
>    virtual bool reader_closed () { return false; };
>    ssize_t raw_write (const void *ptr, size_t len);
> +
> +  friend ssize_t pipe_data_available (int, fhandler_base *, HANDLE, int=
);
>  };
> =20
>  class fhandler_pipe: public fhandler_pipe_fifo
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index bb141b065..32c73fd0c 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -644,22 +644,23 @@ pipe_data_available (int fd, fhandler_base *fh, HA=
NDLE h, int mode)
>  	reader is currently trying to read the pipe and it is pending.
>  	In the latter case, the fact that the reader cannot read the data
>  	immediately means that the pipe is empty. In the former case,
> -	NtSetInformationFile() in set_pipe_non_blocking(true) will fail
> -	with STATUS_PIPE_BUSY, while it succeeds in the latter case.
> +	NtSetInformationFile() in set_pipe_non_blocking(!orig_mode) will
> +	fail with STATUS_PIPE_BUSY, while it succeeds in the latter case.
>  	Therefore, we can distinguish these cases by calling set_pipe_non_
>  	blocking(true). If it returns success, the pipe is empty, so we
>  	return the pipe buffer size. Otherwise, we return 0. */
>        if (fh->get_device () =3D=3D FH_PIPEW && fpli.WriteQuotaAvailable=
 =3D=3D 0)
>  	{
> +	  bool orig_mode =3D ((fhandler_pipe *) fh)->real_non_blocking_mode;
>  	  NTSTATUS status =3D
> -	    ((fhandler_pipe *) fh)->set_pipe_non_blocking (true);
> +	    ((fhandler_pipe *) fh)->set_pipe_non_blocking (!orig_mode);
>  	  if (status =3D=3D STATUS_PIPE_BUSY)
>  	    return 0; /* Full */
>  	  else if (!NT_SUCCESS (status))
>  	    /* We cannot know actual write pipe space. */
>  	    return 1;
> -	  /* Restore pipe mode to blocking mode */
> -	  ((fhandler_pipe *) fh)->set_pipe_non_blocking (false);
> +	  /* Restore pipe mode to original blocking mode */
> +	  ((fhandler_pipe *) fh)->set_pipe_non_blocking (orig_mode);
>  	  /* Empty */
>  	  fpli.WriteQuotaAvailable =3D fpli.InboundQuota;
>  	}

Okay, this diff makes sense to me, with the information I cobbled together
from doing half an hour of research. It should not take half an hour for
every reader to be able to understand the reasoning, though.

Please rework the commit message.

Ciao,
Johannes

--8323328-933796739-1750855231=:4560--
