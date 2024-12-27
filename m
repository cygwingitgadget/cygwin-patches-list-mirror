Return-Path: <SRS0=dFpS=TU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.177])
	by sourceware.org (Postfix) with ESMTPS id 2C0AB3858D20
	for <cygwin-patches@cygwin.com>; Fri, 27 Dec 2024 12:06:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2C0AB3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2C0AB3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.177
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1735301216; cv=none;
	b=VmugJo/0Ipm8+daz8EpCh2YgNbg6Riv6g3OAQ/3fos+gpRtZQgRJN97dp2Rt3ws+FdzPix4Uj50OFjaG6/BIIAZEWNxj4ccTYqruXDBmJA0npEJ2pmdSwOAePt04tVy2VFfBYbTFkUIbJOVLuWKgD/n++2idk8Q9oIM7Kj4s7g8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1735301216; c=relaxed/simple;
	bh=nLrsgGRZroNRLa29998ns04PcWAPlm9UI3fz2Af/1N0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=p8+kfe/N/R2PnOxbNpqtRh5m1Ja1naLV1d8cq4m0PrgoxdIC5IyKsqH4JfE9wNgrYnwZsaK4hrkQvAG5Oln/iGsAL0iUfk5sDEq2A3ScOCnEu/+x+0MlC1XduYEF0AuFP4+a4a6Kev9ynItpUKFHON7JrsVkAvQtVgtQWU6BvXg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2C0AB3858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZHnr1ZvN
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20241227120652542.DQLZ.9629.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 27 Dec 2024 21:06:52 +0900
Date: Fri, 27 Dec 2024 21:06:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Fix mmap_is_attached_or_noreserve
Message-Id: <20241227210651.95954d8ac327145614f83f36@nifty.ne.jp>
In-Reply-To: <72f53e43-5475-446d-abee-9ab3de71c25c@cornell.edu>
References: <72f53e43-5475-446d-abee-9ab3de71c25c@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1735301212;
 bh=lBtOIPuVVvwrM6vv+WD5MJTNE8DWnu647e6p49xW9nM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ZHnr1ZvN+Ji4x05Rzr4fGBIdov1Y++qt6W8wLXmNxZM435MQSJ2y63aef/Pmwbg53tG6J7VT
 OYEno5Wm3If5SZDSYZ4mLZeHkmq27+e11s5DhXScx9gMdw0Mhsvj71ldHaaIolgltCHfBGFlxC
 nojfatah6sWpkw48JIZXabJGKT7NHJzmqDVE51rDJLLq+YUduaWO1b2Ia2b9YmZ5pkRC0cQ60o
 ulbkkrSCS/sDZie87vEAzNhwFp/yILxdB/c+UELciMTNT8CzFFPd3pGp3sIVOdvbdPEWejYyBf
 0E4oQuzcUWCc5QPKjMqNPjVgCjpbETQpCW5Bnyp/sRMXsGEQ==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Ken,

On Thu, 26 Dec 2024 11:56:00 -0500
Ken Brown wrote:
> diff --git a/winsup/cygwin/mm/mmap.cc b/winsup/cygwin/mm/mmap.cc
> index 13418d782baf..10e3f5bdc2b3 100644
> --- a/winsup/cygwin/mm/mmap.cc
> +++ b/winsup/cygwin/mm/mmap.cc
> @@ -580,18 +580,61 @@ mmap_record::free_fh (fhandler_base *fh)
>      delete fh;
>  }
>  
> +/* Keep the list of anonymous mappings sorted as follows: All attached
> +   records come first, then those that are noreserve but not attached,
> +   then those that are not noreserve.  Those that are noreserve but
> +   not attached are sorted by address.  This order of the mappings is
> +   used in mmap_is_attached_or_noreserve.  Note: The code that follows
> +   makes implicit use of the fact that attached maps are also
> +   noreserve. */
>  mmap_record *
>  mmap_list::add_record (mmap_record &r)
>  {
> -  mmap_record *rec = (mmap_record *) ccalloc (HEAP_MMAP,
> -		      sizeof (mmap_record)
> -		      + MAPSIZE (PAGE_CNT (r.get_len ())) * sizeof (DWORD), 1);
> -  if (!rec)
> +  mmap_record *new_rec = (mmap_record *) ccalloc (HEAP_MMAP,
> +			 sizeof (mmap_record)
> +			 + MAPSIZE (PAGE_CNT (r.get_len ()))
> +			 * sizeof (DWORD), 1);
> +  if (!new_rec)
>      return NULL;
> -  rec->init_page_map (r);
> +  new_rec->init_page_map (r);
> +
> +  bool new_attached = new_rec->attached ();
> +  bool new_noreserve = new_rec->noreserve ();
> +  caddr_t new_addr = new_rec->get_address ();
> +
> +  LIST_WRITE_LOCK ();

This patch atempt to acquire lock despite the lock has been
already acquired. I think this is the cause of deadlock.

> +  if (fd != -1 || LIST_EMPTY (&recs))
> +    {
> +      LIST_INSERT_HEAD (&recs, new_rec, mr_next);
> +      goto out;
> +    }
>  
> -  LIST_INSERT_HEAD (&recs, rec, mr_next);
> -  return rec;
> +  /* Now we're working on the anonymous list, which is non-empty. */
> +  mmap_record *rec, *prev;
> +  LIST_FOREACH (rec, &recs, mr_next)
> +    {
> +      prev = rec;
> +      if (new_attached)
> +	{
> +	  LIST_INSERT_HEAD (&recs, new_rec, mr_next);
> +	  goto out;
> +	}
> +      if (new_noreserve && (rec->attached ()
> +			    || (rec->noreserve ()
> +				&& new_addr > rec->get_address ())))
> +	continue;
> +      if (!new_noreserve && rec->noreserve ())
> +	continue;
> +      LIST_INSERT_BEFORE (rec, new_rec, mr_next);
> +      goto out;
> +    }
> +
> +  /* If we get here, new_rec should be inserted at the end of the
> +     list, and prev points to the last record. */
> +  LIST_INSERT_AFTER (prev, new_rec, mr_next);
> +out:
> +  LIST_WRITE_UNLOCK ();
> +  return new_rec;
>  }
>  
>  void

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
