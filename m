Return-Path: <cygwin-patches-return-8483-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12491 invoked by alias); 22 Mar 2016 01:51:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12467 invoked by uid 89); 22 Mar 2016 01:51:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=H*M:cygwin, HTo:U*cygwin-patches, our, H*Ad:U*yselkowitz
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 22 Mar 2016 01:51:44 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])	by mx1.redhat.com (Postfix) with ESMTPS id 1D1B2461EA	for <cygwin-patches@cygwin.com>; Tue, 22 Mar 2016 01:51:43 +0000 (UTC)
Received: from [10.10.116.34] (ovpn-116-34.rdu2.redhat.com [10.10.116.34])	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u2M1pfJs004284	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 21:51:42 -0400
Subject: Re: [PATCH v2 1/5] Add nonnull annotation to posix_memalign.
To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-5-git-send-email-pefoley2@pefoley.com> <20160320111558.GG25241@calimero.vinschen.de> <CAOFdcFPxwdnyjbtAm5FVD6d4DhZB9Cm80kPzzNVaCPKfN9yX9Q@mail.gmail.com> <1458580546-14484-1-git-send-email-pefoley2@pefoley.com>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <56F0A52D.5070303@cygwin.com>
Date: Tue, 22 Mar 2016 01:51:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00189.txt.bz2

On 2016-03-21 12:15, Peter Foley wrote:
> GCC 6.0+ asserts that the memptr argument to the builtin function
> posix_memalign is nonnull.
> Add the necessary annotation to the prototype and
> remove the now unnecessary check to fix a warning.
>
> newlib/Changelog
> newlib/libc/include/stdlib.h: Annotate arg to posix_memalign as
> non-null.
>
> winsup/cygwin/ChangeLog
> malloc_wrapper.cc (posix_memalign): Remove always true nonnull check.
>
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> ---
>   newlib/libc/include/stdlib.h    | 2 +-
>   winsup/cygwin/malloc_wrapper.cc | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/newlib/libc/include/stdlib.h b/newlib/libc/include/stdlib.h
> index f4b2626..7d4ae76 100644
> --- a/newlib/libc/include/stdlib.h
> +++ b/newlib/libc/include/stdlib.h
> @@ -253,7 +253,7 @@ int	_EXFUN(_unsetenv_r,(struct _reent *, const char *__string));
>
>   #ifdef __rtems__
>   #if __POSIX_VISIBLE >= 200112
> -int _EXFUN(posix_memalign,(void **, size_t, size_t));
> +int _EXFUN(__nonnull (1) posix_memalign,(void **, size_t, size_t));
>   #endif
>   #endif

Note the ifdef __rtems__ there; we have our own posix_memalign 
declaration in winsup/cygwin/include/cygwin/stdlib.h.  Perhaps these 
should be merged?

-- 
Yaakov
