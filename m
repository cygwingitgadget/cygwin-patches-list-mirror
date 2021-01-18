Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 4D7F93865C2D
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 10:56:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4D7F93865C2D
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mbzhv-1lcA4B3ivf-00dTrt for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 11:56:04 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 6DE49A8093E; Mon, 18 Jan 2021 11:56:03 +0100 (CET)
Date: Mon, 18 Jan 2021 11:56:03 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 02/11] syscalls.cc: Deduplicate _remove_r
Message-ID: <20210118105603.GS59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-3-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115134534.13290-3-ben@wijen.net>
X-Provags-ID: V03:K1:ejTreKyBEypQQR49L00DU/jZWYpuciGjOBBN2qB/KaapNEKQRrt
 JaVWlIlQMg/6wKVX90Zuovrjspg2m5zwzOqDeQgJn8B62dmLYpcqOMgjDyaOUJ8hOb0rXKn
 E0H7WjQx0rE7on6ZkrXX6mC5AZ2mEUUml0Ll+bejXf2cEqaU4vEj8f/k2nq7pwFKqf/mS8I
 kFM9E4bXVkCIHWsV2hlFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YRA8cAYopik=:9dazWe+hIP3LsPgH3slCXT
 vJw9FsypfYnwplJG6iz2onnhsZX0LdTEgG6zBHzEJFEO8JpcMdU1CCYRnA7QIq18D5Eo817Oy
 z589W2b7ixyaYX/bSy+yLXdts1oMFc3I6eWfn9rDHMlyATysyv65s9/msS54K/vRDBCRa2y9U
 0TeSJfhm4hQYUG/IuC/Ihrmlij7RXlfFv9WXn3t3EXUGesqbgLDZVJT/UomrJ1ff4+7PnfDWo
 nA2PqlYCi9LUJHxBMfITNoPGeKknrKWgNY4ATUQ7b+jSkD+Fz2Y27NTvWjkMjACBR2XHdfYqL
 I7spVG+ShkVkWgUBUfAMBe88zLzu7+jsYc0ZxNWSLZNBn0wvt4ii4AXrAkKIpLV6LpULGY/h4
 6YX3n7s7M9AEHxLqjeDf6/dYkJp59924V6DbV28lT1PMM878j2Xp4FpkpYMsfKr0hStryXh/S
 meHHKa/hKA==
X-Spam-Status: No, score=-106.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 18 Jan 2021 10:56:07 -0000

On Jan 15 14:45, Ben Wijen wrote:
> The _remove_r code is already in the remove function.
> Therefore, just call the remove function and make
> sure errno is set correctly in the reent struct.
> ---
>  winsup/cygwin/syscalls.cc | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index ce4e9c65c..0e89b4f44 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -1133,18 +1133,15 @@ unlink (const char *ourname)
>  }
>  
>  extern "C" int
> -_remove_r (struct _reent *, const char *ourname)
> +_remove_r (struct _reent *ptr, const char *ourname)
>  {
> -  path_conv win32_name (ourname, PC_SYM_NOFOLLOW);
> +  int ret;
>  
> -  if (win32_name.error)
> -    {
> -      set_errno (win32_name.error);
> -      syscall_printf ("%R = remove(%s)",-1, ourname);
> -      return -1;
> -    }
> +  errno = 0;
> +  if ((ret = remove (ourname)) == -1 && errno != 0)
> +    ptr->_errno = errno;
>  
> -  return win32_name.isdir () ? rmdir (ourname) : unlink (ourname);
> +  return ret;
>  }

Hmm, you're adding another function call to the call stack.  Doesn't
that slow down _remove_r rather than speeding it up?  Ok, this function
is called from _tmpfile_r/_tmpfile64_r only, so dedup may trump speed
here...

What's your stance?


Thanks,
Corinna
