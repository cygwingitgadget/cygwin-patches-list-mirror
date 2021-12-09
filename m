Return-Path: <takashi.yano@nifty.ne.jp>
Received: from condef-06.nifty.com (condef-06.nifty.com [202.248.20.71])
 by sourceware.org (Postfix) with ESMTPS id 8FF813858C39
 for <cygwin-patches@cygwin.com>; Thu,  9 Dec 2021 11:20:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8FF813858C39
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-06.nifty.com
 with ESMTP id 1B9BFNNp019710
 for <cygwin-patches@cygwin.com>; Thu, 9 Dec 2021 20:15:23 +0900
Received: from Express5800-S70 (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 1B9BEuGH012015
 for <cygwin-patches@cygwin.com>; Thu, 9 Dec 2021 20:14:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1B9BEuGH012015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639048496;
 bh=EvVJVOn5pGFIX4wRbOEt9BqcEG5Dkq53SQoZMNqY6mc=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=qFbmFosftY6Uwx3zHzSNFttzQPDsilpSryDZ5w5nEx5LFL6HvRGYblm5FH7eLk8VM
 8/1IvKYTd+TZrGTVWqw8yDodvtsG2LV1d+CF+i4guCawtyvHzG4/b4IyHg9YhnmbND
 3FmRq+QvNNg0Uv5TF3PT8ZAc71Ns81FFBfbbE26EUvnTTiVNZza2U937miA/1C9200
 H5Xk5HxwMGlcaQlQhe2LYcrLrMXO+w0GdLekoYVOvBlTZivGk8Z59GcZYPIV2WuYlw
 dyHLH5FAMtmPP2ylOn/VUhjRTHYxkdxqruh8n+ccA7oXmvPG0fexrT2kXaekqZBzdg
 iMOP7nff3XsPw==
X-Nifty-SrcIP: [110.4.221.123]
Date: Thu, 9 Dec 2021 20:14:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: path: Fix path conversion of virtual drive.
Message-Id: <20211209201457.97d11b5796075ec8eea87bf9@nifty.ne.jp>
In-Reply-To: <YbHVrmn+hm7sH23S@calimero.vinschen.de>
References: <20211209081750.4970-1-takashi.yano@nifty.ne.jp>
 <YbHVrmn+hm7sH23S@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Thu, 09 Dec 2021 11:20:03 -0000

On Thu, 9 Dec 2021 11:08:46 +0100
Corinna Vinschen wrote:
> On Dec  9 17:17, Takashi Yano wrote:
> > +		      if (!QueryDosDeviceW (drive, remote, MAX_PATH))
> > +			goto file_not_symlink; /* fallback */
> > +
> > +		      int remlen = wcslen (remote);
> 
> QueryDosDeviceW returns the string followed by two \0 chars, and that's
> reflected by its return value.  You could skip the wcslen call:
> 
>                       int remlen;
> 		      remlen = QueryDosDeviceW (drive, remote, MAX_PATH);
> 		      if (!remlen)
> 		      	goto file_not_symlink;
> 		      remlen -= 2;
> 
> 
> > +		      if (remote[remlen - 1] == L'\\')
> > +			remlen--;
> > +		      WCHAR *p;
> > +		      if (wcsstr (remote, L"\\??\\UNC\\") == remote)
> 
> That should be wcsncmp.  The subst'ed UNC path always begins with that
> string.  Alternatively:
> 
> 		      UNICODE_STRING rpath;
> 		      RtlInitCountedUnicodeString (&rpath, remote,
> 						   remlen * sizeof (WCHAR));
> 		      if (RtlEqualUnicodePathPrefix (&rpath, &ro_u_uncp, TRUE))
> 
> 
> > +			remlen -= 6;
> > +		      else if ((p = wcschr (remote, L';') + 1)
> 
> This expression is always true, even if wcschr returns a NULL pointer.
> 
> > +			       && wcsstr (p, drive) == p
> 
>                                && wcsncmp (p, drive, 2) == 2?
> 
> Alternatively just skip the additional drive letter check and move
> the pointer immediately forward to the next backslash:

Thanks for checking and advice. I'll submit v2 patch shortly.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
