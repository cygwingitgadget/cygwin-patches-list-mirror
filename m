Return-Path: <SRS0=iCjl=ZJ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 436BD385626D
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 15:27:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 436BD385626D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 436BD385626D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750951630; cv=none;
	b=R01hMk1+It33QHhuUQaSxVpuG7LCqtF1/4AA8ayvm5EN52D097+jMJtcLYJWvk98pRWGqLO+9nF5ISha942u7iYMNkzcQdF6dgtCe/gFUd7v7OL1COL1UVVe0YsWITzpyN/C1V40lp2MW71f1eIHOxR//4pzFyMDhpKRpzJXWao=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750951630; c=relaxed/simple;
	bh=4tYU0XfRf2JLZVSXR+fhIsfxIFEj7ferRd5n4450Jj4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=opRifVJqdnpX1A3FKJc602RTfj/kDggehGZX/FBsRlt8a2j+0gk9z1QJEN3BTo5WSFw+SSjQWLav8Tg4sbzZyhXLpkxxDCiIWkYGKdm8HfkNlkWDHpX630YJ7zarTBDcWra1YD8P8jqxZyei7I/2DkwsU737WDADrj94LlJDqTU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 436BD385626D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gxnNplae
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750951629; x=1751556429;
	i=johannes.schindelin@gmx.de;
	bh=LuXbVjqPeXnXYnrag6R9bAAFEoIKxoYveIGgngnKiYA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gxnNplae3awQ0UuF7CLnrlxx4YBrWD/DA1yQ91lxPEOIpfRGL2H349SHwdpc7g1K
	 qrtnlbki+PvicKkrxYvBSc5mgWYvgDJeVuqFl3nVcy2UJmhWzW8iUd1bPBj/aUJYL
	 7L1x7O4f7lVrRCOsFG/3tmA0VbmC1/FRdVtnkkoqR9MJ+lMT5y1DgzzXHzdirSC2L
	 7+41g4wiVYXtywE2UFZFw++fsgw6DM+6GJ5yAbbz1MRCXCPdSLvtbqVNuZLzvB2N6
	 Qvv506THkv06SmXMgvott55v7ITrv9eML6/iG4Sp0ThrV25A4KA/enqVHYYfjEJfi
	 9DRLxL4GZL0KW9WG4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.172]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTmO-1uGyKI41Ac-00YOtO; Thu, 26
 Jun 2025 17:27:09 +0200
Date: Thu, 26 Jun 2025 17:27:07 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pipe: Fix unexpected blocking mode change by
 pipe_data_available()
In-Reply-To: <20250626073945.1134-1-takashi.yano@nifty.ne.jp>
Message-ID: <85d26293-05ea-5192-dc3c-02a7a955c3e2@gmx.de>
References: <20250626073945.1134-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hXE+0/kT1il43lQXqW7bderMrfaQaCTL1E9bMKqrohzQIJLyArx
 8NLpfe35LETK9ZLztJ6/FIqwEQZVEK96CnKrCAwwA7yNdmNuz7z5P6EBhtN5RmLSh7R4mCS
 Dt1ClwOxD+8eTrTHSnbTupd2jpSDc4h5M5K1hHaSRPHA5GX6n26N2wznF7pSrOPBwp/BhXe
 82UCqdtsQld/s2sKIJH4g==
UI-OutboundReport: notjunk:1;M01:P0:jmK0xdiBMuw=;cfuPuNs8nhq5RuX6A9rVNUnYu76
 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
 vcf9CimVyb/ysM=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 26 Jun 2025, Takashi Yano wrote:

> pipe_data_available() is called from raw_write(). If the pipe is in
> real_non_blocking_mode at that time, calling pipe_data_available()
> can, in some cases, inadvertently revert the pipe to blocking mode.
> Here is the background: pipe_data_available() checks the amount of
> writable space in the pipe by calling NtQueryInformationFile() with
> the FilePipeLocalInformation parameter. However, if the read side of
> the pipe is simultaneously consuming data with a large buffer,
> NtQueryInformationFile() may return 0 for WriteQuotaAvailable.
> As a workaround for this behavior, pipe_data_available() temporarily
> attempts to change the pipe-mode to blocking. If the pipe contains
> data, this operation fails-indicating that the pipe is full. If it
> succeeds, the pipe is considered empty. The problem arises from the
> assumption that the pipe is always in real blocking mode before
> attempting to flip the mode. However, if raw_write() has already set
> the pipe to non-blocking mode due to its failure to determine available
> space, two issues occur:
> 1) Changing to non-blocking mode in pipe_data_available() always
>    succeeds, since the pipe is already in non-blocking mode.
> 2) After this, pipe_data_available() sets the pipe back to blocking
>    mode, unintentionally overriding the non-blocking state required
>    by raw_write().
>=20
> This patch addresses the issue by having pipe_data_available() check
> the current real blocking mode, temporarily flip the pipe-mode and
> then restore the pipe-mode to its original state.

Thank you for writing this commit message. It describes the problem and
the solution well.

> Addresses: https://github.com/git-for-windows/git/issues/5682#issuecomme=
nt-2997428207
> Fixes: 7ed9adb356df ("Cygwin: pipe: Switch pipe mode to blocking mode by=
 default")
> Reported-by: Andrew Ng (nga888 @github)

You may want to use Andrew Ng <andrew.ng@sony.com> instead.

Other than that, this patch looks good to me.

Ciao,
Johannes

> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pipe.cc          |  2 --
>  winsup/cygwin/local_includes/fhandler.h |  3 +++
>  winsup/cygwin/select.cc                 | 11 ++++++-----
>  3 files changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pip=
e.cc
> index e35d523bb..e7dc8850f 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -326,7 +326,6 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
>        ULONG_PTR nbytes_now =3D 0;
>        ULONG len1 =3D (ULONG) (len - nbytes);
>        DWORD select_sem_timeout =3D 0;
> -      bool real_non_blocking_mode =3D false;
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
> --=20
> 2.45.1
>=20
>=20
