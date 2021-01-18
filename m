Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id A5FA83865C2D
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 11:02:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A5FA83865C2D
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqbI0-1lnyK718Iy-00mdHN for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 12:01:59 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 9A242A8093E; Mon, 18 Jan 2021 12:01:58 +0100 (CET)
Date: Mon, 18 Jan 2021 12:01:58 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 03/11] syscalls.cc: Fix num_links
Message-ID: <20210118110158.GT59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-4-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115134534.13290-4-ben@wijen.net>
X-Provags-ID: V03:K1:o6H69ANStrj1QJ7hNs5ORo/mKTji2LUz0DecTxCTiIYLgjsUeA1
 vCYsmfyJnm0pGMmH+DdnolMPKJy6wrv38hQ/ehotsOJ/Qvyixi1+tXHYBrz+6acOT6fDUq2
 b4bLgAnOuZuysv3eGSS5kA3Tt/n69X1M3g0IIa+FSqkfbbLmekgosPixJ/ZpEIj6GMYa8L4
 xqEXJU1IZO+qKWqDjr3AQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rDAj9pgh7qE=:ER4VotL68CJYSUlRp02bNZ
 nrjfuL0Bu19RJaSIGNxavWaKtDb1I+PR5Km7ai3piq7jd5acZQA4b+XBIqe6ycuIaYlRHL/x8
 hm/Phrt0MGwP1R8uM5BhwKAe88i7CS5Arm+zs9u6oIaMRUDwfVeRVa17eEx0f52yuMeoxxjJN
 BVzYVQr74lqIZILa1ID4189RQSC96y8vh8EvVrLeQBqOvxEge8B2DN+p5gjvzNsvppwOom2/U
 YDYCod7A3cdz0pe9d+dKi6EscfJ+H78i+i2vRTZwqjdmuAqx67H0N06BiDEOWeAjt8simd1k0
 H8fyJERqG+Jf8GNkoyW7Uq2LZJiu0Q3R6lILD1mNEJxtEiwICUG0BRb76D4RCgetEW+lV+0OK
 EGOK2kKC0j3V6vOo3JvzEhf2130h5KKtaGftAu867jmaKXJu1i8PYu2QI+AlhV9i8yGLevjMw
 iJHM7JGweQ==
X-Spam-Status: No, score=-106.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 18 Jan 2021 11:02:11 -0000

On Jan 15 14:45, Ben Wijen wrote:
> NtQueryInformationFile on fh_ro needs FILE_READ_ATTRIBUTES
> to succeed.
> ---
>  winsup/cygwin/syscalls.cc | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 0e89b4f44..227d1a911 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -767,8 +767,9 @@ _unlink_nt (path_conv &pc, bool shareable)
>        if ((pc.fs_flags () & FILE_SUPPORTS_TRANSACTIONS))
>  	start_transaction (old_trans, trans);
>  retry_open:
> -      status = NtOpenFile (&fh_ro, FILE_WRITE_ATTRIBUTES, &attr, &io,
> -			   FILE_SHARE_VALID_FLAGS, flags);
> +      status = NtOpenFile (&fh_ro,
> +                           FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES,
> +                           &attr, &io, FILE_SHARE_VALID_FLAGS, flags);
>        if (NT_SUCCESS (status))
>  	{
>  	  debug_printf ("Opening %S for removing R/O succeeded",
> -- 
> 2.29.2

Oh, right!  Pushed.


Thanks,
Corinna
