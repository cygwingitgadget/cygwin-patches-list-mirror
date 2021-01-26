Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id CB4103857C62
 for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021 11:45:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CB4103857C62
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MAwPZ-1lFgWl3IKX-00BOZG for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021
 12:45:10 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 57F81A80D7F; Tue, 26 Jan 2021 12:45:10 +0100 (CET)
Date: Tue, 26 Jan 2021 12:45:10 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 6/8] syscalls.cc: Expose shallow-pathconv unlink_nt
Message-ID: <20210126114510.GL4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210120161056.77784-7-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120161056.77784-7-ben@wijen.net>
X-Provags-ID: V03:K1:3YJPdULvZvZftL/Cpiy1wUAoUmeMQFJ0D8+r40Iq5y53nlZEAqO
 SWOOJIJECUb5uvV/rNF/XUHQhIlG5KvAj5Bk+kdhV9Zfk4SzNFbwH1Fz2SFyZiHpiGmqJtg
 T7/+c9NxSwqE3b80kKL2LXonqg5m7ANehjsVXs2TFX+a9AfG6mk33jiWzBe86koaQQuSQ6w
 mvL2LoYZqXeHAxjIbbhFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vj/xxWHlM9U=:MkvI5CBcw5nI+yFclTHi1E
 H3IiP1cLKCUiaMkCCdcHYNUBNYsh/6e0JB5x4aXusED72I9k2gcFuwqGD4JJcc2ah70ZEMSEQ
 MTrgOn1++mx+65yKaVRfwqXFe7OZ6WTgVR0uhC+OGJQsNIEW7ZYxfx7U9S9h8FEqeRwfpCxGm
 /hdzjI8208OK1zq20UzoPyy0lYT1TyAOm9xdO0LVL8myoFGjLjCTEolANqAWWROW3OqdGjzWM
 hvuqQUUBNFUhf7HbjMm4f1mdUcINTIydl6kcGsxHeCaWqToCbd2ufa9WpS/UQyv0j+lckW+yg
 P35RiN2+HrqzQC5gzDt1jQBIeEC6pND91BGbpHeXXqv87Y3DjBB7T8akc1quq0re+hE6eT3uD
 2oqyk+JIjzdgpknK/xVStmY8VrbO2HfjS+XQzdTGlrKtRGM9h5eon6ryEKBV0Bu2b2qf7ZZBy
 Xr6JW8TDew==
X-Spam-Status: No, score=-106.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 26 Jan 2021 11:45:14 -0000

On Jan 20 17:10, Ben Wijen wrote:
> Not having to query file information improves unlink speed.
> ---
>  winsup/cygwin/syscalls.cc | 78 ++++++++++++++++++++++++++-------------
>  1 file changed, 52 insertions(+), 26 deletions(-)
> 
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index ab0c4c2d6..b5ab6ac5e 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -1272,6 +1272,28 @@ _unlink_ntpc_ (path_conv& pc, bool shareable)
>    return status;
>  }
>  
> +NTSTATUS
> +unlink_nt (const char *ourname, ULONG eflags)
> +{
> +  uint32_t opt = PC_SYM_NOFOLLOW | PC_SKIP_SYM_CHECK | PC_SKIP_FS_CHECK;
> +  if (!(eflags & FILE_NON_DIRECTORY_FILE))
> +    opt &= ~PC_SKIP_FS_CHECK;
> +
> +  path_conv pc (ourname, opt, NULL);
> +  if (pc.error || pc.isspecial ())
> +    return STATUS_CANNOT_DELETE;
> +
> +  OBJECT_ATTRIBUTES attr;
> +  PUNICODE_STRING ntpath = pc.get_nt_native_path ();
> +  InitializeObjectAttributes(&attr, ntpath, 0, NULL, NULL);
> +  NTSTATUS status = _unlink_nt (&attr, eflags);

Sorry again, but I don't see the advantage of not using the intelligence
already collected in path_conv by neglecting to call the unlink
variation not using them.  It's also unclear to me, why the new code
doesn't try_to_bin right away, rather than stomping ahead and falling
back to the current code for each such file.  In an rm -rf on a file
hirarchy used by other users, you could end up with a much slower
operation.

Wouldn't it make more sense to streamline the existing _unlink_nt?  I
don't claim it's the most streamlined way to delete files, but at least
it has documented workarounds for problems encountered on the way,
already.


Corinna
