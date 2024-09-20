Return-Path: <SRS0=s2Gy=QS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 6DE4B3858420
	for <cygwin-patches@cygwin.com>; Fri, 20 Sep 2024 09:23:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6DE4B3858420
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6DE4B3858420
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1726824220; cv=none;
	b=a3FACsU6qGi5vBam1WivCZOyRAet75d224vDJDFs3euha68MfZy5IFs4mi2EDWYXUtT2jsK2Vcz1lZe7PeqzD/S85XRsoFJmpFzwe/YBwE2KoKJjBzhsUy0NvY0eoVgYzEuVVTwh61TeAdEY7Tnl+z+DXZsiXOmI1JAMNgnU0Gc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1726824220; c=relaxed/simple;
	bh=sU4xIeVZNPLCjUAWl2Nn0BLElds1P8ldEwgjx4zvPzw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=RU+yRvE7rPN23fbEdxgdSa1b7Sk8InNfgMfBqgIs4Yy7fqca4XQtzu21Kq2xnd3C6lFkUgdxqYg5jCwcm3Pqt1LUSvSuLuvt1H8ZMTexUoRMWFdaA60txysHBACUJjrJQG//LH/dFnCo6TIz6HqaAcklGfrxGX4urPPKUe9h19w=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20240920092336696.MMFW.93209.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 20 Sep 2024 18:23:36 +0900
Date: Fri, 20 Sep 2024 18:23:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4.2] Cygwin: pipe: Switch pipe mode to blocking mode by
 defaut
Message-Id: <20240920182335.183898c8a2e34f9a74b24a46@nifty.ne.jp>
In-Reply-To: <21841d53-184a-4a89-8b18-8804a540da5d@cornell.edu>
References: <20240907024725.123-1-takashi.yano@nifty.ne.jp>
	<d197495e-b91e-4cfb-bc5e-84fbea62e6cb@cornell.edu>
	<20240917224901.b2569f125ffd15efd1992126@nifty.ne.jp>
	<7fb9a624-9a01-420c-913d-f7c70a04ea9f@cornell.edu>
	<21841d53-184a-4a89-8b18-8804a540da5d@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1726824216;
 bh=7iaUrBAzxBiv+DbDsqk1lEXQcVOg7nxpARuFn4YIq/Q=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=B/LqJC5ujOqtYwHAOpBANrPlHsz6UJBvwlukY+ZczocK3khaOhWeuz4YfDVDzzriYw/2nZci
 ys9EElUucxbWueGvHvnUEG2iHF+znEuUfXHZLg7+R0CSfqYik4G+QDfSIqT2IJT7nQ0IxVP0Kk
 H75J+JrqeQt2QEX9aYodMSlP+YYqcMLnu1rMTTwcwkBIQwsV7Gk+QkiZ/+q+gUqQROq16fVaRt
 kGhFSJdePQkC22k5ZYKrpuuZWJFbd7cH3E7VTQaU4qULzO8Iql3x3CpY690Py+xljAAwEaTJ7U
 AFgcXcJP9/O5dZgky7h7lnD3SwIv2utWImdt33j4M4AWOLXg==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Ken,

On Wed, 18 Sep 2024 10:03:13 -0400
Ken Brown wrote:
> On 9/17/2024 2:22 PM, Ken Brown wrote:
> > On 9/17/2024 9:49 AM, Takashi Yano wrote:
> >>>> @@ -439,19 +396,45 @@ fhandler_pipe_fifo::raw_write (const void 
> >>>> *ptr, size_t len)
> >>>>      if (!len)
> >>>>        return 0;
> >>>> -  if (reader_closed ())
> >>>> +  ssize_t avail = pipe_buf_size;
> >>>> +  bool real_non_blocking_mode = false;
> >>>> +  if (is_nonblocking ())
> >>>>        {
> >>>> -      set_errno (EPIPE);
> >>>> -      raise (SIGPIPE);
> >>>> -      return -1;
> >>>> +      FILE_PIPE_LOCAL_INFORMATION fpli;
> >>>> +      status = NtQueryInformationFile (get_handle (), &io, &fpli, 
> >>>> sizeof fpli,
> >>>> +                       FilePipeLocalInformation);
> >>>> +      if (NT_SUCCESS (status))
> >>>> +    {
> >>>> +      if (fpli.WriteQuotaAvailable != 0)
> >>>> +        avail = fpli.WriteQuotaAvailable;
> >>>> +      else /* WriteQuotaAvailable == 0 */
> >>>> +        { /* Refer to the comment in select.cc: 
> >>>> pipe_data_available(). */
> >>>> +          /* NtSetInformationFile() in set_pipe_non_blocking(true) 
> >>>> seems
> >>>> +         to fail with STATUS_PIPE_BUSY if the pipe is not empty.
> >>>> +         In this case, the pipe is really full if WriteQuotaAvailable
> >>>> +         is zero. Otherwise, the pipe is empty. */
> >>>> +          if (!((fhandler_pipe *)this)->set_pipe_non_blocking (true))
> >>>> +        {
> >>>> +          /* Full */
> >>>> +          set_errno (EAGAIN);
> >>>> +          return -1;
> >>>> +        }
> >>>> +          /* Restore the pipe mode to blocking. */
> >>>> +          ((fhandler_pipe *)this)->set_pipe_non_blocking (false);
> >>>> +          /* Pipe should be empty because reader is waiting the 
> >>>> data. */
> 
> One other thing that I missed in my first review.  Is there a possible 
> race condition here?  What if the pipe is empty now but another writer 
> fills the pipe before we try to write?  Can that happen?  If so, maybe 
> it's safer to leave the pipe non-blocking instead of restoring it to 
> blocking.

Thanks!
Shouldn't we add mutex guard for raw_write() as well as raw_read()?

I think I have addressed all the points you have raised. Could you
please check v5 patch?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
