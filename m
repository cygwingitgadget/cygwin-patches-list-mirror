Return-Path: <SRS0=92HC=ZK=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 8F3683858C50
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 10:25:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8F3683858C50
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8F3683858C50
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751019921; cv=none;
	b=UPK5rqjU1mzzJm0g77Nrpp157aiU2zg5qnWcK8O81i9r+AdMItuQWdv+63jy/dH6kdxLrZeAq6jMAsyfgPShu2oEq8EyW3ew3HP/8M6aa6cgOTfdn7Ycm5U+WnuRLlwWZqDvx2+LpKh7lKX2g+3loA+iL65296znqCIrDKs8HpY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751019921; c=relaxed/simple;
	bh=LnP2su7yAYoTo21nF0XpZVEUlU/SkJaxvk/5HZL3CAs=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=X2zKWOkdiff+sy9H1Wb9iOych1A1QI5BWII822uphXQQ/VEnfX0Xb6MsR1V3E44x7zXoWQ64ha9PHBVwYSn+M3u2bOwXIwEMeZ4NlN+HiNuBU3F9g3zFiHyjI/zr+Br5e8XuSP7mm75j9z1ZeUxIEilQugLr9XqnEPklzStvyxc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8F3683858C50
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=N2Lgtcsy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751019920; x=1751624720;
	i=johannes.schindelin@gmx.de;
	bh=RENw3wsZLw/CBuJOhgdaXyM87yYuEOG5JMySdJepIzs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N2LgtcsyRzKK5LIPdl4np5Ywg1DSBpH1jYvhf9yJbeigYjXskEbF8XuOKiwxDH/L
	 aVAJYIHQaV7av/PsrHZ7zdxLhYEONZpDaSAk1A5i6vytZSf6+pwbCVRrSWQSH0sT+
	 NR7Ry6dD8caGndeoSYi127/NGW2dBJyI2mt1nR3WpTaGpyGV/6/SFXve9xW0/OBgU
	 sQEYKWkH+E0zAySeOfYDf1BVK7A0zy0nQhm3+5yjU/3HuHkkTR439xVx8TzNFmuI+
	 JLfEyApgd+uyV1WDEcSrkjYrJkT4IDOcWgwIfekZDCc41I87WOa7LKVdYgxqba4CS
	 MxRehz+vWlwTPRm/Cw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.172]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfJd-1ujCsZ16qd-00sMoR; Fri, 27
 Jun 2025 12:25:20 +0200
Date: Fri, 27 Jun 2025 12:25:18 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Fix SSH hang with non-cygwin pipe reader
In-Reply-To: <20250627100607.430-1-takashi.yano@nifty.ne.jp>
Message-ID: <1a3de144-cbdb-87c8-d6e9-4ba3ae61765e@gmx.de>
References: <20250627100607.430-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KJBW1eUxzq/UHAD3Yx8Bl/vLj5akHfL4bJb6HA5Ka9CwkDZoxAb
 nzk1M9+8Mi1UVeyMbey+KxB6o9gJSMW0r91YfRQH1unuxJ4p0r+5vhVIz/fMZ7oFoRF8hhq
 ZW74Kg/pXTf4rD6wuw+6aJW09R8vyzyzN6kqP9ithFQb5gF2hezr9i91VeDyB3J0f1zHu5X
 OnHN2qbOdjdNSi47dRoQQ==
UI-OutboundReport: notjunk:1;M01:P0:DTgQezq8DP4=;t52VntkNDoC1O5NPnxgkxje5xI7
 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
 Pw==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 27 Jun 2025, Takashi Yano wrote:

> If ssh is used with non-cygwin pipe reader, ssh some times hangs.
> This happens when non-cygwin git (Git for Windows) starts cygwin
> ssh. The background of the bug is as follows.
>=20
> Before attempting to NtWriteFile() in raw_write() in non-blocking
> mode, the amount of writable space in the pipe is checked by calling
> NtQueryInformationFile with FilePipeLocalInformation parameter.
> The same is also done by pipe_data_available() in select.cc.
>=20
> However, if the read side of the pipe is simultaneously consuming
> data, NtQueryInformationFile() returns less value than the amount
> of writable space, i.e. the amount of writable space minus the size
> of buffer to be read. This does not happen when the reader is a
> cygwin app because cygwin read() for the pipe attempts to read
> the amount of the data in the pipe at most. This means NtReadFile()
> never enters a pending state. However, if the reader is non-cygwin
> app, this cannot be expected. As a workaround for this problem,
> the code checking the pipe space temporarily attempts to toggle
> the pipe-mode. If the pipe contains data, this operation fails
> with STATUS_PIPE_BUSY indicating that the pipe is not empty. If
> it succeeds, the pipe is considered empty. The current code uses
> this technic only when NtQueryInformationFile() retuns zero.
>=20
> Therefore, if NtQueryInformationFile() returns 1, the amount of
> writable space is assumed to be 1 even in the case that e.g. the
> pipe size is 8192 bytes and reader is pending to read 8191 bytes.
> Even worse, the current code fails to write more than 1 byte
> to 1 byte pipe space due to the remnant of the past design.
> Then the reader waits for data with 8191 bytes buffer while the
> writer continues to fail to write to 1 byte space of the pipe.
> This is the cause of the deadlock.
>=20
> In practice, when using Git for Windows in combination with Cygwin
> SSH, it has been observed that a read of 8191 bytes is occasionally
> issued against a pipe with 8192 bytes of available space.
>=20
> With this patch, the blocking-mode-toggling-check is performed
> even if NtQueryInformationFile() returns non-zero value so that
> the amount of the writable space in the pipe is always estimated
> correctly.

Good explanation, thank you for improving your commit message writing
skill.

> Also, pipe_data_available() returns PDA_UNKNOWN rather than 1 when the
> pipe space estimation fails so that select() and raw_write() can perform
> appropriate fallback handling.

This looks unrelated? Would this not rather be in a separate patch, to
make it substantially easier to review for correctness?

> Addresses: https://github.com/git-for-windows/git/issues/5682
> Fixes: 7ed9adb356df ("Cygwin: pipe: Switch pipe mode to blocking mode by=
 default")
> Reported-by: Vincent-Liem (@github), Johannes Schindelin <johannes.schin=
delin@gmx.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pipe.cc        | 30 ++++++-----
>  winsup/cygwin/local_includes/select.h |  3 ++
>  winsup/cygwin/select.cc               | 77 ++++++++++++++-------------
>  3 files changed, 60 insertions(+), 50 deletions(-)

Unfortunately, this is scary large for a critical and urgent bug fix, and
follows the pattern of that chain of bug fixes introducing regressions
that need bug fixes I mentioner earlier.

I have run out of time to review this large patch properly this week,
which is a bummer because now Git for Windows users have to wait even
longer for a fix, but it is what it is. I will review this as soon as I
can allot the time for that review.

Ciao,
Johannes

P.S.: One thing that strikes me as immediately concerning is this part:

> -	  if (avail < 1)	/* error or pipe closed */
> +	  if (avail =3D=3D PDA_UNKNOWN && real_non_blocking_mode)
> +	    avail =3D len1;

That means that the next loop iteration will call `NtWriteFile()` with
`len1` bytes (`len1` now being identical to `avail`), even if `len1` can
be substantially larger than `PIPE_BUF` (in my tests, it got stuck at
`len1 =3D=3D 2097152` in some instances), which is highly likely to be
undesirable.

I am sure that there are more easily-missed issues like this one lurking
elsewhere in this large patch.

>=20
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pip=
e.cc
> index e35d523bb..7e2c1861b 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -491,14 +491,14 @@ fhandler_pipe_fifo::raw_write (const void *ptr, si=
ze_t len)
>  				       FilePipeLocalInformation);
>        if (NT_SUCCESS (status))
>  	{
> -	  if (fpli.WriteQuotaAvailable !=3D 0)
> +	  if (fpli.WriteQuotaAvailable =3D=3D fpli.InboundQuota)
>  	    avail =3D fpli.WriteQuotaAvailable;
> -	  else /* WriteQuotaAvailable =3D=3D 0 */
> +	  else /* WriteQuotaAvailable !=3D InboundQuota */
>  	    { /* Refer to the comment in select.cc: pipe_data_available(). */
>  	      /* NtSetInformationFile() in set_pipe_non_blocking(true) seems
>  		 to fail with STATUS_PIPE_BUSY if the pipe is not empty.
> -		 In this case, the pipe is really full if WriteQuotaAvailable
> -		 is zero. Otherwise, the pipe is empty. */
> +		 In this case, WriteQuotaAvailable indicates real pipe space.
> +		 Otherwise, the pipe is empty. */
>  	      status =3D fh->set_pipe_non_blocking (true);
>  	      if (NT_SUCCESS (status))
>  		/* Pipe should be empty because reader is waiting for data. */
> @@ -506,9 +506,14 @@ fhandler_pipe_fifo::raw_write (const void *ptr, siz=
e_t len)
>  		fh->set_pipe_non_blocking (false);
>  	      else if (status =3D=3D STATUS_PIPE_BUSY)
>  		{
> -		  /* Full */
> -		  set_errno (EAGAIN);
> -		  goto err;
> +		  if (fpli.WriteQuotaAvailable =3D=3D 0)
> +		    {
> +		      /* Full */
> +		      set_errno (EAGAIN);
> +		      goto err;
> +		    }
> +		  avail =3D fpli.WriteQuotaAvailable;
> +		  status =3D STATUS_SUCCESS;
>  		}
>  	    }
>  	}
> @@ -650,9 +655,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size=
_t len)
>  	  if (io.Information > 0 || len <=3D PIPE_BUF || short_write_once)
>  	    break;
>  	  /* Independent of being blocking or non-blocking, if we're here,
> -	     the pipe has less space than requested.  If the pipe is a
> -	     non-Cygwin pipe, just try the old strategy of trying a half
> -	     write.  If the pipe has at
> +	     the pipe has less space than requested.  If the pipe has at
>  	     least PIPE_BUF bytes available, try to write all matching
>  	     PIPE_BUF sized blocks.  If it's less than PIPE_BUF,  try
>  	     the next less power of 2 bytes.  This is not really the Linux
> @@ -660,12 +663,13 @@ fhandler_pipe_fifo::raw_write (const void *ptr, si=
ze_t len)
>  	     in a very implementation-defined way we can't emulate, but it
>  	     resembles it closely enough to get useful results. */
>  	  avail =3D pipe_data_available (-1, this, get_handle (), PDA_WRITE);
> -	  if (avail < 1)	/* error or pipe closed */
> +	  if (avail =3D=3D PDA_UNKNOWN && real_non_blocking_mode)
> +	    avail =3D len1;
> +	  else if (avail =3D=3D 0 || !PDA_NOERROR (avail))
> +	    /* error or pipe closed */
>  	    break;
>  	  if (avail > len1)	/* somebody read from the pipe */
>  	    avail =3D len1;
> -	  if (avail =3D=3D 1)	/* 1 byte left or non-Cygwin pipe */
> -	    len1 >>=3D 1;
>  	  else if (avail >=3D PIPE_BUF)
>  	    len1 =3D avail & ~(PIPE_BUF - 1);
>  	  else
> diff --git a/winsup/cygwin/local_includes/select.h b/winsup/cygwin/local=
_includes/select.h
> index 43ceb1d7e..afc05e186 100644
> --- a/winsup/cygwin/local_includes/select.h
> +++ b/winsup/cygwin/local_includes/select.h
> @@ -143,5 +143,8 @@ ssize_t pipe_data_available (int, fhandler_base *, H=
ANDLE, int);
> =20
>  #define PDA_READ	0x00
>  #define PDA_WRITE	0x01
> +#define PDA_ERROR	-1
> +#define PDA_UNKNOWN	-2
> +#define PDA_NOERROR(x)	(x >=3D 0)
> =20
>  #endif /* _SELECT_H_ */
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index bb141b065..050221a9f 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -601,7 +601,7 @@ pipe_data_available (int fd, fhandler_base *fh, HAND=
LE h, int mode)
>        if (mode =3D=3D PDA_READ
>  	  && PeekNamedPipe (h, NULL, 0, NULL, &nbytes_in_pipe, NULL))
>  	return nbytes_in_pipe;
> -      return -1;
> +      return PDA_ERROR;
>      }
> =20
>    IO_STATUS_BLOCK iosb =3D {{0}, 0};
> @@ -618,46 +618,49 @@ pipe_data_available (int fd, fhandler_base *fh, HA=
NDLE h, int mode)
>  	 access on the write end.  */
>        select_printf ("fd %d, %s, NtQueryInformationFile failed, status =
%y",
>  		     fd, fh->get_name (), status);
> -      return (mode =3D=3D PDA_WRITE) ? 1 : -1;
> +      return (mode =3D=3D PDA_WRITE) ? PDA_UNKNOWN : PDA_ERROR;
>      }
>    if (mode =3D=3D PDA_WRITE)
>      {
>        /* If there is anything available in the pipe buffer then signal
> -        that.  This means that a pipe could still block since you could
> -        be trying to write more to the pipe than is available in the
> -        buffer but that is the hazard of select().
> -
> -        Note that WriteQuotaAvailable is unreliable.
> -
> -        Usually WriteQuotaAvailable on the write side reflects the spac=
e
> -        available in the inbound buffer on the read side.  However, if =
a
> -        pipe read is currently pending, WriteQuotaAvailable on the writ=
e side
> -        is decremented by the number of bytes the read side is requesti=
ng.
> -        So it's possible (even likely) that WriteQuotaAvailable is 0, e=
ven
> -        if the inbound buffer on the read side is not full.  This can l=
ead to
> -        a deadlock situation: The reader is waiting for data, but selec=
t
> -        on the writer side assumes that no space is available in the re=
ad
> -        side inbound buffer.
> -
> -	Consequentially, there are two possibilities when WriteQuotaAvailable
> -	is 0. One is that the buffer is really full. The other is that the
> -	reader is currently trying to read the pipe and it is pending.
> -	In the latter case, the fact that the reader cannot read the data
> -	immediately means that the pipe is empty. In the former case,
> -	NtSetInformationFile() in set_pipe_non_blocking(true) will fail
> -	with STATUS_PIPE_BUSY, while it succeeds in the latter case.
> -	Therefore, we can distinguish these cases by calling set_pipe_non_
> -	blocking(true). If it returns success, the pipe is empty, so we
> -	return the pipe buffer size. Otherwise, we return 0. */
> -      if (fh->get_device () =3D=3D FH_PIPEW && fpli.WriteQuotaAvailable=
 =3D=3D 0)
> +	 that.  This means that a pipe could still block since you could
> +	 be trying to write more to the pipe than is available in the
> +	 buffer but that is the hazard of select().
> +
> +	 Note that WriteQuotaAvailable is unreliable.
> +
> +	 Usually WriteQuotaAvailable on the write side reflects the space
> +	 available in the inbound buffer on the read side.  However, if a
> +	 pipe read is currently pending, WriteQuotaAvailable on the write side
> +	 is decremented by the number of bytes the read side is requesting.
> +	 So it's possible (even likely) that WriteQuotaAvailable is less than
> +	 actual space available in the pipe, even if the inbound buffer is
> +	 empty. This can lead to a deadlock situation: The reader is waiting
> +	 for data, but select on the writer side assumes that no space is
> +	 available in the read side inbound buffer.
> +
> +	 Consequentially, there are two possibilities when WriteQuotaAvailable
> +	 is less than pipe size. One is that the buffer is really not empty.
> +	 The other is that the reader is currently trying to read the pipe
> +	 and it is pending.
> +	 In the latter case, the fact that the reader cannot read the data
> +	 immediately means that the pipe is empty. In the former case,
> +	 NtSetInformationFile() in set_pipe_non_blocking(true) will fail
> +	 with STATUS_PIPE_BUSY, while it succeeds in the latter case.
> +	 Therefore, we can distinguish these cases by calling set_pipe_non_
> +	 blocking(true). If it returns success, the pipe is empty, so we
> +	 return the pipe buffer size. Otherwise, we return the value of
> +	 WriteQuotaAvailable as is. */
> +      if (fh->get_device () =3D=3D FH_PIPEW
> +	  && fpli.WriteQuotaAvailable < fpli.InboundQuota)
>  	{
>  	  NTSTATUS status =3D
>  	    ((fhandler_pipe *) fh)->set_pipe_non_blocking (true);
>  	  if (status =3D=3D STATUS_PIPE_BUSY)
> -	    return 0; /* Full */
> +	    return fpli.WriteQuotaAvailable; /* Not empty */
>  	  else if (!NT_SUCCESS (status))
>  	    /* We cannot know actual write pipe space. */
> -	    return 1;
> +	    return PDA_UNKNOWN;
>  	  /* Restore pipe mode to blocking mode */
>  	  ((fhandler_pipe *) fh)->set_pipe_non_blocking (false);
>  	  /* Empty */
> @@ -681,7 +684,7 @@ pipe_data_available (int fd, fhandler_base *fh, HAND=
LE h, int mode)
>        return fpli.ReadDataAvailable;
>      }
>    if (fpli.NamedPipeState & FILE_PIPE_CLOSING_STATE)
> -    return -1;
> +    return PDA_ERROR;
>    return 0;
>  }
> =20
> @@ -731,7 +734,7 @@ peek_pipe (select_record *s, bool from_select)
>        if (n =3D=3D 0 && fh->get_echo_handle ())
>  	n =3D pipe_data_available (s->fd, fh, fh->get_echo_handle (), PDA_READ=
);
> =20
> -      if (n < 0)
> +      if (n =3D=3D PDA_ERROR)
>  	{
>  	  select_printf ("read: %s, n %d", fh->get_name (), n);
>  	  if (s->except_selected)
> @@ -772,8 +775,8 @@ out:
>  	}
>        ssize_t n =3D pipe_data_available (s->fd, fh, h, PDA_WRITE);
>        select_printf ("write: %s, n %d", fh->get_name (), n);
> -      gotone +=3D s->write_ready =3D (n > 0);
> -      if (n < 0 && s->except_selected)
> +      gotone +=3D s->write_ready =3D (n > 0 || n =3D=3D PDA_UNKNOWN);
> +      if (n =3D=3D PDA_ERROR && s->except_selected)
>  	gotone +=3D s->except_ready =3D true;
>      }
>    return gotone;
> @@ -986,7 +989,7 @@ out:
>        ssize_t n =3D pipe_data_available (s->fd, fh, fh->get_handle (), =
PDA_WRITE);
>        select_printf ("write: %s, n %d", fh->get_name (), n);
>        gotone +=3D s->write_ready =3D (n > 0);
> -      if (n < 0 && s->except_selected)
> +      if (n =3D=3D PDA_ERROR && s->except_selected)
>  	gotone +=3D s->except_ready =3D true;
>      }
>    return gotone;
> @@ -1412,7 +1415,7 @@ out:
>        ssize_t n =3D pipe_data_available (s->fd, fh, h, PDA_WRITE);
>        select_printf ("write: %s, n %d", fh->get_name (), n);
>        gotone +=3D s->write_ready =3D (n > 0);
> -      if (n < 0 && s->except_selected)
> +      if (n =3D=3D PDA_ERROR && s->except_selected)
>  	gotone +=3D s->except_ready =3D true;
>      }
>    return gotone;
> --=20
> 2.45.1
>=20
>=20
