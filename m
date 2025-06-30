Return-Path: <SRS0=wRab=ZN=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 81AB8385481D
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 10:09:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 81AB8385481D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 81AB8385481D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751278149; cv=none;
	b=QNavmOw85du9jvPMdn+7sMeEttzkltCVrWJACizxk3u6Oyt+kOXuQAae3M/pTEb36hRG5PR7OXOYadDP/9Dtt1QcSiOIoIfm9yRtTAEuFfTZ1Z17mztMY9sK3fCeCf1sQS9bTzlx2ehtaCy19ZOskSuao0VEr6SsFqyXHW8SVYc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751278149; c=relaxed/simple;
	bh=GH3MO7B/iYycyJV9exUTpcOYg3OLLPxFAWes4tSqczM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=UCWYgp4zo0fId1ggvqpTeWFXB2nCGIKTqtzCHJidCf1glM6vfmYDS9b8cztEvMMN64cXkrpl9DFzJtFCp0pNXYOUiE2ZWoHe6pKdwDH6uh9HbliNZkxoMrqH1KjWgefe4u1BO7U4ABgneiKiMCNfDKoq//5Z13dwGXCTL/kgdNs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 81AB8385481D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=XOFovRYR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751278142; x=1751882942;
	i=johannes.schindelin@gmx.de;
	bh=rTvCZa7f84YdSqGb1Qtxksv7MqTHaS17ddxUT7o13RA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XOFovRYRD9jL3iQvT0Kk2/PZ255Ks5zGwWIqhj9AkNtntFP0V2awFtXvEBaek0nh
	 znv5r7cSbddPEMZ8UNJBKPRCge18ZgZ1QIsPYPLONWsHX0nGlaXl2f0yXiPd96RcJ
	 5w1Yn37i4w6240i+uI+MwVEL1EYE8BaqIOIN80QtWz/UC/8Umtaik2PCCgNbvxYwv
	 WgQVlvKaHlZqngLYH/k1ASpk62vggdr3lfi6DzDFKp+tzuu8HnWYX6zuM41j2E4MA
	 x91m5+TZ97RaSDKIvFJSEeo6597JzXmIgRo/cPvB7KeMI85E8PMnZpqWKPfF3APdk
	 t8TIOPDXWZZ5Qa9fdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.53]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGeB-1u5PFW2fFj-00K5aC; Mon, 30
 Jun 2025 12:09:01 +0200
Date: Mon, 30 Jun 2025 12:08:59 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/3] Cygwin: pipe: Fix SSH hang with non-cygwin pipe
 reader
In-Reply-To: <20250627114103.30364-1-takashi.yano@nifty.ne.jp>
Message-ID: <42eaee7a-4a40-b41f-d605-cfbf23b2d329@gmx.de>
References: <20250627114103.30364-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:p3VX6ArJSJ7Hcs1yNNfdQllbUAscw94XYy1CSR9YWr1wNzp95s6
 SylQyJ8dHAE8qOu/VDDC3c+MD5xaP2tIsXZhUiG3wJhjwSAplojF1bemNWHMJTcXokNzqOY
 VdRNW4stB/ISUNtN/iXV6I6kNlqniZ6kWZ4dtyywKjyAbuM7Km+ysyOBH7zeDK2s7oEXpRM
 yCjZojfMfrGBudGGLB02A==
UI-OutboundReport: notjunk:1;M01:P0:gzePGsESx9M=;EryreUqi6n8efZ4Ya4CRJvedj6b
 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
 3zIBLsS8xgCFNsETArtvnKk=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

this patch now looks good to go to me. It has a very good commit message
that explains the context well.

Thank you for working on this,
Johannes

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
>=20
> Addresses: https://github.com/git-for-windows/git/issues/5682
> Fixes: 7ed9adb356df ("Cygwin: pipe: Switch pipe mode to blocking mode by=
 default")
> Reported-by: Vincent-Liem (@github), Johannes Schindelin <johannes.schin=
delin@gmx.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pipe.cc | 15 ++++++++++-----
>  winsup/cygwin/select.cc        |  5 +++--
>  2 files changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pip=
e.cc
> index e35d523bb..bda0a9b25 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -491,9 +491,9 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size=
_t len)
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
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index bb141b065..0b9afb359 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -649,12 +649,13 @@ pipe_data_available (int fd, fhandler_base *fh, HA=
NDLE h, int mode)
>  	Therefore, we can distinguish these cases by calling set_pipe_non_
>  	blocking(true). If it returns success, the pipe is empty, so we
>  	return the pipe buffer size. Otherwise, we return 0. */
> -      if (fh->get_device () =3D=3D FH_PIPEW && fpli.WriteQuotaAvailable=
 =3D=3D 0)
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
>  	    return 1;
> --=20
> 2.45.1
>=20
>=20
