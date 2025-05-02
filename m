Return-Path: <SRS0=mLRr=XS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 1CFC53858CDA
	for <cygwin-patches@cygwin.com>; Fri,  2 May 2025 11:17:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1CFC53858CDA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1CFC53858CDA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746184632; cv=none;
	b=T34jUFLksX62n3iDcg37Ogs/+gZSjdKJWz6+d0xXG+HdOS2LnkZWAsEsUUY6WXSH9ZZfH99ops5BjgfDsV5Cc2VaT9SdPs9KL4r2Ms5zSn3oQFSeMvqt4Gs+eZMSQbDkyDNP4g/JRdbaiL4eUWbcbOnndtdp+8xeLBuQHSFM8Q0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746184632; c=relaxed/simple;
	bh=G2QGDl97zThsFNBBfUCNRhRXr/xdn0Ml4lFTB3/PpAo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=hbT2eYuxD2HH/yb6Dg/dsEzest9M+qBLD6QB2abWpd1+TfCLHhEed2tBY/DaPHk03WcfxESyTeonybrmgfb0skw4QuQXX4rOwkBpzEZzwtJpJmedVbPSkrfPEHjE2KpeN1dJVCJohyu9hSGPH0OGkYnTivioGNdNPcjXbDLATmY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1CFC53858CDA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VWswcfW/
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20250502111709780.QFEY.50988.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 2 May 2025 20:17:09 +0900
Date: Fri, 2 May 2025 20:17:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Update search.h functions for POSIX.1-2024
Message-Id: <20250502201709.2282c6e101e47b44e7098b65@nifty.ne.jp>
In-Reply-To: <20250502045656.833-1-mark@maxrnd.com>
References: <20250502045656.833-1-mark@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1746184629;
 bh=9Ul6yO2BGxIFmBHjNBOzHofdiif4lTvI9KqonQrxUqQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=VWswcfW/A2udO7gSeK2wMaWlMnta/e/hX+dejt+UgUpOd5oZmia3fNdHCKhELw38s7bTAvkA
 mUSqUnxGn0SD3iLu3+MP3VDSWzpjQFhnZDgYHoMwUrM2FNjQThJTL/8dGDMFLn9+Gt6PptGulr
 MnCsVNUe1ljy4GIvYoo5OPUpq9X4kQK/R2pYqXLBUIr4NfJ5LM2gzc5yjCxG9BtFY622RXAEPf
 bMt7EOG0gStg0TPBKxcw9I6Jsm2d38rKE910At6O/6AS8nfPzOo7jQPtSfO58m6QF4BnvXUxXp
 ErXvcTLlDoCOhrxlGo+8laOSbmCK1B8eoBvS0Lc79G9xFJoQ==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu,  1 May 2025 21:56:48 -0700
Mark Geisert wrote:
> Add type posix_tnode.  Change certain uses of "void" to "posix_tnode" in
> both the prototypes and definitions of functions associated with <search.h>.
> 
> (Necessary changes to Newlib's /libc/include/search.h have already been
> submitted in a patch sent to newlib@sourceware.org.)
> 
> Reported-by: Collin Funk <collin.funk1@gmail.com>
> Addresses: https://cygwin.com/pipermail/cygwin/2025-April/258032.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: ec98d19a08c2 "* wininfo.h (wininfo::timer_active): Delete."
> 
> ---
>  winsup/cygwin/include/search.h | 10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/include/search.h b/winsup/cygwin/include/search.h
> index f532eae55..7c6d7b4cf 100644
> --- a/winsup/cygwin/include/search.h
> +++ b/winsup/cygwin/include/search.h
> @@ -39,6 +39,8 @@ typedef	struct node
>  } node_t;
>  #endif
>  
> +typedef void posix_tnode;
> +
>  struct hsearch_data
>  {
>    struct internal_head *htable;
> @@ -58,13 +60,13 @@ ENTRY *hsearch (ENTRY, ACTION);
>  int hcreate_r (size_t, struct hsearch_data *);
>  void hdestroy_r (struct hsearch_data *);
>  int hsearch_r (ENTRY, ACTION, ENTRY **, struct hsearch_data *);
> -void *tdelete (const void * __restrict, void ** __restrict,
> +void *tdelete (const void * __restrict, posix_tnode ** __restrict,
>  	       int (*) (const void *, const void *));
>  void tdestroy (void *, void (*)(void *));
> -void *tfind (const void *, void **,
> +posix_tnode *tfind (const void *, posix_tnode *const *,
>  	     int (*) (const void *, const void *));
> -void *tsearch (const void *, void **, int (*) (const void *, const void *));
> -void  twalk (const void *, void (*) (const void *, VISIT, int));
> +posix_tnode *tsearch (const void *, posix_tnode **, int (*) (const void *, const void *));
> +void  twalk (const posix_tnode *, void (*) (const posix_tnode *, VISIT, int));
>  void *lfind (const void *, const void *, size_t *, size_t,
>  	     int (*) (const void *, const void *));
>  void *lsearch (const void *, void *, size_t *, size_t,
> -- 
> 2.45.1

LGTM. I'll push.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
