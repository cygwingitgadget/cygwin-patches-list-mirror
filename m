Return-Path: <SRS0=s2Gy=QS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id 5764C3858D29
	for <cygwin-patches@cygwin.com>; Fri, 20 Sep 2024 14:09:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5764C3858D29
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5764C3858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1726841362; cv=none;
	b=lpiSLavS5TLFdUcuL6AnMtXJMxeez+gcDIdA7IN8QxuBLZzeHiIpwR3FQIIJLKYdTL6rq7brsNJjE28e8WVOtX1G6ipAU1PmMjNRsAPHCaEXYTfDBHDmzGNaGcDiL5gg8y4TtWP8LF0peI4BtgWJ4pFqk0wCHOC/lvdrVfnOJL4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1726841362; c=relaxed/simple;
	bh=XIcYDaTEqgVgK3iUIGHEznOnB2w4h0xZaeOL0zBvmDc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=u/b60fZ8gFqq3xdEmbSxkJxCJd6tUveQ96c91Qktg+Pns26sncFZcWw7jcgFWEJQ/d3vsZySr8lWefWHQEjbG8vHh6r3kp57ZJql8sckTuLXcvu7Uc4Fau9FDiiEJlt3miyexeDJsu7w2OtDVZT3BP+2jzVAShomtTIZR88Jusg=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w02.mail.nifty.com with ESMTP
          id <20240920140918445.NVRL.12429.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 20 Sep 2024 23:09:18 +0900
Date: Fri, 20 Sep 2024 23:09:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4.2] Cygwin: pipe: Switch pipe mode to blocking mode by
 defaut
Message-Id: <20240920230917.3c81c71330834583ec1e3ff8@nifty.ne.jp>
In-Reply-To: <20240920222414.fba7f30bf727f8ad4e61fed6@nifty.ne.jp>
References: <20240907024725.123-1-takashi.yano@nifty.ne.jp>
	<d197495e-b91e-4cfb-bc5e-84fbea62e6cb@cornell.edu>
	<20240917224901.b2569f125ffd15efd1992126@nifty.ne.jp>
	<7fb9a624-9a01-420c-913d-f7c70a04ea9f@cornell.edu>
	<21841d53-184a-4a89-8b18-8804a540da5d@cornell.edu>
	<20240920182335.183898c8a2e34f9a74b24a46@nifty.ne.jp>
	<20240920222414.fba7f30bf727f8ad4e61fed6@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1726841358;
 bh=2c8NYoyQJUKBdabqp24/qCUCRIs6DW1lQh3tJebMiFA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=BrI8a522A5xFh8BRiwUbF74hVjkmckOWfqdx3UlT1T9i/P4cygTgjQxLgAwuTePUxBGAZm5A
 rpdYxI6zNDtgSyx6sWQIXdzksr6mmSh/f9/CtYKz1N8yomOJk40jrHtw7cQJBIhpWNP5NPOEgo
 VQrsT2jvCHVn+0jZTFGiu1J5ctEUisGvINZYWKAsuKSQCQQd7f8TF3BXFOBwHIYM9bBbU8Bvgh
 3lTWONXTTTdIQy1NxinizCHUisS9BIkApn59Ake0F/1v0kv/A7y/vgg3poRqAdIvyf1M/XHsvC
 JLw43ZAt5p7JPgs1X9rjvsj3G5KBspu4IlkGxcOFcY0vmywQ==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 20 Sep 2024 22:24:14 +0900
Takashi Yano wrote:
> On Fri, 20 Sep 2024 18:23:35 +0900
> Takashi Yano wrote:
> > Hi Ken,
> > 
> > On Wed, 18 Sep 2024 10:03:13 -0400
> > Ken Brown wrote:
> > > On 9/17/2024 2:22 PM, Ken Brown wrote:
> > > > On 9/17/2024 9:49 AM, Takashi Yano wrote:
> > > >>>> @@ -439,19 +396,45 @@ fhandler_pipe_fifo::raw_write (const void 
> > > >>>> *ptr, size_t len)
> > > >>>>      if (!len)
> > > >>>>        return 0;
> > > >>>> -  if (reader_closed ())
> > > >>>> +  ssize_t avail = pipe_buf_size;
> > > >>>> +  bool real_non_blocking_mode = false;
> > > >>>> +  if (is_nonblocking ())
> > > >>>>        {
> > > >>>> -      set_errno (EPIPE);
> > > >>>> -      raise (SIGPIPE);
> > > >>>> -      return -1;
> > > >>>> +      FILE_PIPE_LOCAL_INFORMATION fpli;
> > > >>>> +      status = NtQueryInformationFile (get_handle (), &io, &fpli, 
> > > >>>> sizeof fpli,
> > > >>>> +                       FilePipeLocalInformation);
> > > >>>> +      if (NT_SUCCESS (status))
> > > >>>> +    {
> > > >>>> +      if (fpli.WriteQuotaAvailable != 0)
> > > >>>> +        avail = fpli.WriteQuotaAvailable;
> > > >>>> +      else /* WriteQuotaAvailable == 0 */
> > > >>>> +        { /* Refer to the comment in select.cc: 
> > > >>>> pipe_data_available(). */
> > > >>>> +          /* NtSetInformationFile() in set_pipe_non_blocking(true) 
> > > >>>> seems
> > > >>>> +         to fail with STATUS_PIPE_BUSY if the pipe is not empty.
> > > >>>> +         In this case, the pipe is really full if WriteQuotaAvailable
> > > >>>> +         is zero. Otherwise, the pipe is empty. */
> > > >>>> +          if (!((fhandler_pipe *)this)->set_pipe_non_blocking (true))
> > > >>>> +        {
> > > >>>> +          /* Full */
> > > >>>> +          set_errno (EAGAIN);
> > > >>>> +          return -1;
> > > >>>> +        }
> > > >>>> +          /* Restore the pipe mode to blocking. */
> > > >>>> +          ((fhandler_pipe *)this)->set_pipe_non_blocking (false);
> > > >>>> +          /* Pipe should be empty because reader is waiting the 
> > > >>>> data. */
> > > 
> > > One other thing that I missed in my first review.  Is there a possible 
> > > race condition here?  What if the pipe is empty now but another writer 
> > > fills the pipe before we try to write?  Can that happen?  If so, maybe 
> > > it's safer to leave the pipe non-blocking instead of restoring it to 
> > > blocking.
> > 
> > Thanks!
> > Shouldn't we add mutex guard for raw_write() as well as raw_read()?
> > 
> > I think I have addressed all the points you have raised. Could you
> > please check v5 patch?
> 
> Bug in v5 has been fixed in v6.

v7: Improve error handling in raw_write()

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
