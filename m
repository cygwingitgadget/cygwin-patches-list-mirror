Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 4433A398B841
 for <cygwin-patches@cygwin.com>; Tue,  9 Feb 2021 15:25:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4433A398B841
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mzy6q-1m5CN63Im6-00x4Jh for <cygwin-patches@cygwin.com>; Tue, 09 Feb 2021
 16:25:10 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 45D9CA807A5; Tue,  9 Feb 2021 16:25:10 +0100 (CET)
Date: Tue, 9 Feb 2021 16:25:10 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Have tmpfile(3) use O_TMPFILE
Message-ID: <20210209152510.GV4251@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210209105000.26544-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210209105000.26544-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:Yn0hiITrYH1+VN6ji9JQrEDgUe5ESv/MsTH7Px34J4mt88xoBuo
 d372zoZFsKlyow+mhwy8a/IHVjcS9WcrpoyJT99rhIpxfdvvOU68Id36rI1RivlbEs0Uqw9
 eYcZLTeV0mylMbWkAcbQVuk3sxOQURycA5PJAcW19bRhC/VnVAO9fzhyCmvlNy+YNe6kzS5
 dK2MqrfEg980xJThLn+vA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IhOmMgTt+eM=:522ULxJ4jMojP8GBWV58K3
 BEMbJY8NL0oRS9rg3dfqZfXnN5V2P2KHoFMxNLBVPzap/AHM1rdgGZs0wolbCXD5g4nzXHvfk
 DaOaYBNw1XXe2+Ou3f1vEFs2FZ1kfCGxuAuu3if53UoTkqf31Psl89ISBjg/h+WNlyqx5FUTk
 5hs+YJKPosBdu4f5uF5VIXa1Aq2ddoz2xr5CG6YTDUl5YnOf8G4aiF2MYmVupyj6rn0NwuOcL
 xQsrgqGcqS3Zm4Xugp3vVpXwHPrtL8mCN4mhVUkbetQIUEkNDjnJj7sZaS+S+TdEw9LWW0qkd
 mMUeafW3g+D6+Vg26E+AuGpS2ep3l4iw+GkIBIjj4ZRLO0TxbuZqDGgy6mWMNSL4AdZ2+E+m8
 9Nli61wWWRa5J3sgScnTqexTVU+9+0MPbKBhM4VlJ7goH7hc5Yrq2JiQR8AKYU7JkE1U/uggc
 0Rb1m5WfKg==
X-Spam-Status: No, score=-107.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 KAM_SHORT, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 09 Feb 2021 15:25:14 -0000

Hi Mark,

On Feb  9 02:50, Mark Geisert wrote:
> Per discussion on cygwin-developers, a Cygwin tmpfile(3) implementation
> has been added to syscalls.cc.  This overrides the one supplied by
> newlib.  Then the open(2) flag O_TMPFILE was added to the open call that
> tmpfile internally makes.
> ---
>  winsup/cygwin/release/3.2.0 |  4 ++++
>  winsup/cygwin/syscalls.cc   | 20 ++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
> index f748a9bc8..d02d16863 100644
> --- a/winsup/cygwin/release/3.2.0
> +++ b/winsup/cygwin/release/3.2.0
> @@ -19,6 +19,10 @@ What changed:
>  
>  - A few FAQ updates.
>  
> +- Have tmpfile(3) make use of Win32 FILE_ATTRIBUTE_TEMPORARY via open(2)
> +  flag O_TMPFILE.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2021-January/247304.html
> +
>  
>  Bug Fixes
>  ---------
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 52a020f07..b79c1c7cd 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -5225,3 +5225,23 @@ pipe2 (int filedes[2], int mode)
>    syscall_printf ("%R = pipe2([%d, %d], %y)", res, read, write, mode);
>    return res;
>  }
> +
> +extern "C" FILE *
> +tmpfile (void)
> +{
> +  char *dir = getenv ("TMPDIR");

This isn't what Linux tmpfile does.  Per the man page, it tries to
create the file in P_tmpdir first, and if that fails, it tries
"/tmp".

> +  if (!dir)
> +    dir = P_tmpdir;
> +  int fd = open (dir, O_RDWR | O_CREAT | O_BINARY | O_TMPFILE,

You have to specify O_EXCL here.  The idea is that this file cannot be
made permanent, and missing the O_EXCL flag allows exactly that.  See
https://man7.org/linux/man-pages/man2/open.2.html, the lengthy
description in terms of O_TMPFILE.


Thanks,
Corinna
