Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 3D859385480E
 for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021 12:15:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3D859385480E
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N4yuK-1m5J0j11vQ-010qOD for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021
 13:15:17 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B4EB5A80D7F; Tue, 26 Jan 2021 13:15:16 +0100 (CET)
Date: Tue, 26 Jan 2021 13:15:16 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 8/8] fhandler_disk_file.cc: Use path_conv's IndexNumber
Message-ID: <20210126121516.GN4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210120161056.77784-9-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120161056.77784-9-ben@wijen.net>
X-Provags-ID: V03:K1:nmOx8o8WJK64VkK2N56rvACPL8ZOHGCfR53CRfB8Qj4IpNCC+v0
 C+vswOn/mhuN5LKXfLAcrJD1K4DPDEbKi6/E54Z/bbva7B8NfweTQgYHRoGbEi0ufUTOxkn
 3O2pDoGgHy8GEsb0p5dF9EurRduz5lHI0kARpLBq0DkTURNUIqZCOlvyjLs48aYTTy2G/ba
 dLMB49+ZUHaUG8oOl4haA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c56/dszOP54=:l37a/iljoNcSHi+L/1ufxy
 kkII8yk7LXA91Xn6MB2pbaHBsRpahMqQYU5JoC8wCQUCwduiFo0rUtSDD9zLrCGhxkhtYMuKt
 Vx7ExyzlNWLWkIPfQm3N7JA7YQOlsodQ/Iiy16K9f8cUgKzdIryJnmwXhYNJ3fpHZ7RcvUR6q
 vrMX4jGOr0awugKkP3vdFCYQ0APEmGdcrr52pyJyNgSCLd91OJ53yqt1ejehevIy18+a8JVZx
 Kk59IdJpq/YD7Y+a+EVB+08gBAf95GDeoh9n8k2LfICw2Td1ZPbNnznhWWHP0SudfwoFBNV7b
 /i+SrO580aidkS0O8pnCylyT09B8imFPyzLsTux3ZaiHVdSx+9wgbZwruukqR+fNneNjFRUek
 /4ahxZUE6s+o1+JfWOWtbm/HCbcH59a7ldOFO1rsqFCbx0rp/GklWKns8YEYaTMUgX03QQJUH
 i/e4vthbgA==
X-Spam-Status: No, score=-107.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Tue, 26 Jan 2021 12:15:20 -0000

On Jan 20 17:10, Ben Wijen wrote:
> path_conv already knows the IndexNumber, so just use it.

Yeah, this looks like a vestige from before the time we switched to
FILE_ALL_INFORMATION.

> 
> This commit also fixes the potential handle leak.
> ---
>  winsup/cygwin/fhandler_disk_file.cc | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
> index fe04f832b..39f914a59 100644
> --- a/winsup/cygwin/fhandler_disk_file.cc
> +++ b/winsup/cygwin/fhandler_disk_file.cc
> @@ -2029,9 +2029,6 @@ readdir_get_ino (const char *path, bool dot_dot)
>  {
>    char *fname;
>    struct stat st;
> -  HANDLE hdl;
> -  OBJECT_ATTRIBUTES attr;
> -  IO_STATUS_BLOCK io;
>    ino_t ino = 0;
>  
>    if (dot_dot)
> @@ -2044,26 +2041,17 @@ readdir_get_ino (const char *path, bool dot_dot)
>        path = fname;
>      }
>    path_conv pc (path, PC_SYM_NOFOLLOW | PC_POSIX | PC_KEEP_HANDLE);

Given that this function doesn't need a handle anymore, PC_KEEP_HANDLE
can go away.

> -  if (pc.isspecial ())
> +  if (pc.isgood_inode (pc.fai ()->InternalInformation.IndexNumber.QuadPart))
> +    ino = pc.fai ()->InternalInformation.IndexNumber.QuadPart;

This ignores the fact that the file could be on an NFS filesystem.
Rather than using pc.fai ()->InternalInformation.IndexNumber.QuadPart,
this call should use pc.get_ino ().


Thanks,
Corinna
