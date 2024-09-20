Return-Path: <SRS0=s2Gy=QS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id C40113858D29
	for <cygwin-patches@cygwin.com>; Fri, 20 Sep 2024 13:24:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C40113858D29
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C40113858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1726838661; cv=none;
	b=vIptVdaihW1twy1T46JteUXMAz2v7DMu3jwbKTEQYQi1XdkKC7iKpRp5XHlwG4wSRqA1v2bf4hil7FLz8TA4cigMq/42KSJjT5/tO/W6xkhj8JPRpQa8EP+1P/AgwwF4ZnDvwF5IpPKT662tW6sYGxmXsmyx2meHtRZP8C9DUX0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1726838661; c=relaxed/simple;
	bh=vp2KgLpHzD58pLta5KX4V1UI3T+X82jE3HIn4ETHdoo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=CCgGrMVBEE/Rmhioc/DnntkGemHJVTCW1HNw2rsr00rBE2zzkr7GDVw6slYQhOXJhkSAQO3c3+PcPtCvj5x4N3rgsf9y9Z1dz2zqdWfKsh8/MDGd9l0Zf1jpOttTGTO9HdOu2FWiOsu89tzxs70suCW33T5Vub4vJQSc1QWFTyA=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w01.mail.nifty.com with ESMTP
          id <20240920132415559.NKII.69727.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 20 Sep 2024 22:24:15 +0900
Date: Fri, 20 Sep 2024 22:24:14 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4.2] Cygwin: pipe: Switch pipe mode to blocking mode by
 defaut
Message-Id: <20240920222414.fba7f30bf727f8ad4e61fed6@nifty.ne.jp>
In-Reply-To: <20240920182335.183898c8a2e34f9a74b24a46@nifty.ne.jp>
References: <20240907024725.123-1-takashi.yano@nifty.ne.jp>
	<d197495e-b91e-4cfb-bc5e-84fbea62e6cb@cornell.edu>
	<20240917224901.b2569f125ffd15efd1992126@nifty.ne.jp>
	<7fb9a624-9a01-420c-913d-f7c70a04ea9f@cornell.edu>
	<21841d53-184a-4a89-8b18-8804a540da5d@cornell.edu>
	<20240920182335.183898c8a2e34f9a74b24a46@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1726838655;
 bh=OkaAmRtB1Sk9WeqqZkHdgZN2DaORJa3Ex+MwdhRgj3g=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=kHieCmfzvc2sjl7cMuY7Cup5/5sOKwE/6D3upe7zW1HD/znUsJ9YoMfScS5tGdAmJ8V9OwL0
 aTvej9VYhrx05OkHVz3eMRimzoPlN3C31ZTUGJnJ2czD9OnaDzzeEOjmNCCRgpu5ZhNK2umMeG
 EE2sUK+Z0lWXtNLbBW3cmuGbKkTX4z2pszJ8YlKJ+TMbtTIQwpWs1ygbZaXfm7xaO9NfDgZrl/
 O/3pr3Iih86ezyzRhjXrRs+VhHVKg6cc6juGWNDmoYyaAf17GkOUUiIoYVSd/HoAr7wXt1HvIA
 HbBKasj2N7SmHk9jp7HvYa/1swilxekXrf7qp/ewbeZYbU3Q==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 20 Sep 2024 18:23:35 +0900
Takashi Yano wrote:
> Hi Ken,
> 
> On Wed, 18 Sep 2024 10:03:13 -0400
> Ken Brown wrote:
> > On 9/17/2024 2:22 PM, Ken Brown wrote:
> > > On 9/17/2024 9:49 AM, Takashi Yano wrote:
> > >>>> @@ -439,19 +396,45 @@ fhandler_pipe_fifo::raw_write (const void 
> > >>>> *ptr, size_t len)
> > >>>>      if (!len)
> > >>>>        return 0;
> > >>>> -  if (reader_closed ())
> > >>>> +  ssize_t avail = pipe_buf_size;
> > >>>> +  bool real_non_blocking_mode = false;
> > >>>> +  if (is_nonblocking ())
> > >>>>        {
> > >>>> -      set_errno (EPIPE);
> > >>>> -      raise (SIGPIPE);
> > >>>> -      return -1;
> > >>>> +      FILE_PIPE_LOCAL_INFORMATION fpli;
> > >>>> +      status = NtQueryInformationFile (get_handle (), &io, &fpli, 
> > >>>> sizeof fpli,
> > >>>> +                       FilePipeLocalInformation);
> > >>>> +      if (NT_SUCCESS (status))
> > >>>> +    {
> > >>>> +      if (fpli.WriteQuotaAvailable != 0)
> > >>>> +        avail = fpli.WriteQuotaAvailable;
> > >>>> +      else /* WriteQuotaAvailable == 0 */
> > >>>> +        { /* Refer to the comment in select.cc: 
> > >>>> pipe_data_available(). */
> > >>>> +          /* NtSetInformationFile() in set_pipe_non_blocking(true) 
> > >>>> seems
> > >>>> +         to fail with STATUS_PIPE_BUSY if the pipe is not empty.
> > >>>> +         In this case, the pipe is really full if WriteQuotaAvailable
> > >>>> +         is zero. Otherwise, the pipe is empty. */
> > >>>> +          if (!((fhandler_pipe *)this)->set_pipe_non_blocking (true))
> > >>>> +        {
> > >>>> +          /* Full */
> > >>>> +          set_errno (EAGAIN);
> > >>>> +          return -1;
> > >>>> +        }
> > >>>> +          /* Restore the pipe mode to blocking. */
> > >>>> +          ((fhandler_pipe *)this)->set_pipe_non_blocking (false);
> > >>>> +          /* Pipe should be empty because reader is waiting the 
> > >>>> data. */
> > 
> > One other thing that I missed in my first review.  Is there a possible 
> > race condition here?  What if the pipe is empty now but another writer 
> > fills the pipe before we try to write?  Can that happen?  If so, maybe 
> > it's safer to leave the pipe non-blocking instead of restoring it to 
> > blocking.
> 
> Thanks!
> Shouldn't we add mutex guard for raw_write() as well as raw_read()?
> 
> I think I have addressed all the points you have raised. Could you
> please check v5 patch?

Bug in v5 has been fixed in v6.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
