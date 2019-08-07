Return-Path: <cygwin-patches-return-9552-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8025 invoked by alias); 7 Aug 2019 16:24:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7826 invoked by uid 89); 7 Aug 2019 16:24:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1787
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 07 Aug 2019 16:24:05 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id vOjHh45CpIhW9vOjIhW2D5; Wed, 07 Aug 2019 10:24:01 -0600
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Subject: Re: [PATCH] Cygwin: build_env: fix off-by-one bug when re-adding PATH
Reply-To: Brian.Inglis@SystematicSw.ab.ca
To: cygwin-patches@cygwin.com
References: <20190807085116.7985-1-michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <95af5e7d-21a3-6188-0b85-f7df355a0b6f@SystematicSw.ab.ca>
Date: Wed, 07 Aug 2019 16:24:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807085116.7985-1-michael.haubenwallner@ssi-schaefer.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00072.txt.bz2

On 2019-08-07 02:51, Michael Haubenwallner wrote:
> Adding default winvar 'PATH=C:\cygwin64\binZ' to an environment that is
> already allocated for 'SYSTEMROOT=ZWINDIR=Z', we need to count that
> trailing (Z)ero as well.  Otherwise we trigger this assertion failure:
> 
> $ /bin/env -i SYSTEMROOT= WINDIR= /bin/env
> assertion "(s - envblock) <= tl" failed: file "/home/corinna/src/cygwin/cygwin-3.0.7/cygwin-3.0.7-1.x86_64/src/newlib-cygwin/winsup/cygwin/environ.cc", line 1302, function: char** build_env(const char* const*, WCHAR*&, int&, bool, HANDLE)
> Aborted (core dumped)
> ---
>  winsup/cygwin/environ.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
> index 124842734..8fa01b2d5 100644
> --- a/winsup/cygwin/environ.cc
> +++ b/winsup/cygwin/environ.cc
> @@ -1295,7 +1295,7 @@ build_env (const char * const *envp, PWCHAR &envblock, int &envc,
>  	 during execve. */
>        if (!saw_PATH)
>  	{
> -	  new_tl += cygheap->installation_dir.Length / sizeof (WCHAR) + 5;
> +	  new_tl += cygheap->installation_dir.Length / sizeof (WCHAR) + 5 + 1;
>  	  if (new_tl > tl)
>  	    tl = raise_envblock (new_tl, envblock, s);
>  	  s = wcpcpy (wcpcpy (s, L"PATH="),
> 

Don't forget also to allow for the single null char '\0' final entry to
terminate the env var block, and ensure that is cleared following any addition:

	SYSTEMDRIVE=C:\0
	SYSTEMROOT=C:\WINDOWS\0
	WINDIR=C:\WINDOWS\0
	PATH=C:\cygwin64\bin\0
	\0

Nothing like running off the end thru memory looking for another ...=...\0! ;^>

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
