Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id B79863858431
 for <cygwin-patches@cygwin.com>; Tue, 16 Nov 2021 08:11:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B79863858431
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 1AG8Avni027945
 for <cygwin-patches@cygwin.com>; Tue, 16 Nov 2021 17:10:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 1AG8Avni027945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637050257;
 bh=YeexZZKSiND2i2t7S2jNel3UV4ALifsFudl0FJF+6g4=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=rC40tBieYg+2FLHA6h8fPvTxJOE8P5Lrr5nfjObXWdSFHUN5IqueavuArplOCfGNJ
 MHonJPM5zQ65ykWQbWjqV9k9eTbRkNRjHRpYD+9YoUu9FDXNpmLUGf+6NoyBiFOOvV
 ly7uP3wsy0PjMeknaQV+fgie1aRYgIiMrlKe/brxR1puzt+mMSA+BmCKRHtv0wu4Id
 9eA1dcX8KKGxW5kW88nGrFk8d58OAKEYTz9rui4rMPc0zmRq8CXIvETGFsC5MvLdnN
 MMSr3AoMi6LVEW1MyFO15jcI9tDBYPlmYPikQ4InWa2Ee2YjE3h9iQy1+N+8iVp2LX
 hsmU44e0QARGA==
X-Nifty-SrcIP: [110.4.221.123]
Date: Tue, 16 Nov 2021 17:10:56 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Handle STATUS_PENDING even for
 nonblocking mode.
Message-Id: <20211116171056.a9f0fd202624fc25d764de25@nifty.ne.jp>
In-Reply-To: <20211116031848.247-1-takashi.yano@nifty.ne.jp>
References: <20211116031848.247-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Tue, 16 Nov 2021 08:11:22 -0000

On Tue, 16 Nov 2021 12:18:47 +0900
Takashi Yano wrote:
> - NtReadFile() and NtWriteFile() seems to return STATUS_PENDING
>   occasionally even in nonblocking mode. This patch adds handling
>   for STATUS_PENDING in nonblocking mode.
> 
> Addresses:
>   https://cygwin.com/pipermail/cygwin/2021-November/249910.html
> ---
>  winsup/cygwin/fhandler_pipe.cc | 10 ++++++----
>  winsup/cygwin/release/3.3.3    |  5 +++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
> index 1ebf4de10..f70ff56fe 100644
> --- a/winsup/cygwin/fhandler_pipe.cc
> +++ b/winsup/cygwin/fhandler_pipe.cc
> @@ -336,9 +336,10 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
>  	break;
>        status = NtReadFile (get_handle (), evt, NULL, NULL, &io, ptr,
>  			   len1, NULL, NULL);
> -      if (evt && status == STATUS_PENDING)
> +      if (status == STATUS_PENDING)
>  	{
> -	  waitret = cygwait (evt, INFINITE, cw_cancel | cw_sig);
> +	  HANDLE w = evt ?: get_handle ();
> +	  waitret = cygwait (w, INFINITE, cw_cancel | cw_sig);
>  	  /* If io.Status is STATUS_CANCELLED after CancelIo, IO has actually
>  	     been cancelled and io.Information contains the number of bytes
>  	     processed so far.
> @@ -507,10 +508,11 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
>  	    break;
>  	  len1 >>= 1;
>  	}
> -      if (evt && status == STATUS_PENDING)
> +      if (status == STATUS_PENDING)
>  	{
> +	  HANDLE w = evt ?: get_handle ();
>  	  while (WAIT_TIMEOUT ==
> -		 (waitret = cygwait (evt, (DWORD) 0, cw_cancel | cw_sig)))
> +		 (waitret = cygwait (w, (DWORD) 0, cw_cancel | cw_sig)))
>  	    {
>  	      if (reader_closed ())
>  		{
> diff --git a/winsup/cygwin/release/3.3.3 b/winsup/cygwin/release/3.3.3
> index 1eb25e2fc..49c1bcdc3 100644
> --- a/winsup/cygwin/release/3.3.3
> +++ b/winsup/cygwin/release/3.3.3
> @@ -16,3 +16,8 @@ Bug Fixes
>  - Fix long-standing problem that new files don't get created with the
>    FILE_ATTRIBUTE_ARCHIVE DOS attribute set.
>    Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249909.html
> +
> +- Fix issue that pipe read()/write() occationally returns a garnage
> +  length when NtReadFile/NtWriteFile returns STATUS_PENDING in non-
> +  blocking mode.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249910.html
> -- 
> 2.33.0

I noticed that this patch sometimes does not work as expected.
cygwaint(get_handle(), ...) may sometimes return WAIT_OBJECT_0
even when the operation is not completed.

I will submit a patch according to Corinna's way. (Use event
even in nonblocking mode.)

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
