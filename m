Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 8495E3858410
 for <cygwin-patches@cygwin.com>; Tue, 26 Oct 2021 10:43:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8495E3858410
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MumVX-1mvsrw0bbv-00rmeg for <cygwin-patches@cygwin.com>; Tue, 26 Oct 2021
 12:43:15 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A27C4A80DAB; Tue, 26 Oct 2021 12:43:14 +0200 (CEST)
Date: Tue, 26 Oct 2021 12:43:14 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Make native clipboard layout same for 32- and
 64-bit
Message-ID: <YXfbwhOHlXBYgCFA@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211025092540.4819-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211025092540.4819-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:45GB4VPjcUXVTPHJVfEmafpPYD6TgCkM4xyBP7g7vMEG8+rlhg1
 up55uzMASQMf0X5ssojHonsgwQ1TFeNWTZJfGUzfQtGg+ZtlKoCq0H8+QClmCjapcbXr/ea
 9Hg+XW2yh0Hvk8KDQqMoB4b9Ge23cnOocZ0AyTS3agj8nRJX8LaD+G7ZCX0Ax8aGzaNrLAc
 ysIiRVusbgd372vIw1aBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e97hDlFklsU=:kvhL12gQWV79ntVPqHkaOx
 0xZlBNukWHJs2gmLbiqe0m7/RwgCXEfuxFvzlnKMR4h+k50OVmeCbT2LcpKY1qC7bNjYWuAjA
 NBG+XlqG2ipIwwQgyFlwWgpraV6CyoeqnaORlLONFM4r6kU06vfdFTBxOEzS51yepJhAY6zHs
 WN9GtJQKwzjMvSEUyJDdfWG8RMD9852aKGJ4M1hJsBmUFK8MJJaA21rcCbhSO4d3Bvb/xP4l9
 0Ib4KrgZQtWNc5poGsXEfVXNaWFJBJEVCtbA8FThn7+l/LUBrLHVo9lsJXjk0WiXKnviZnFS9
 P8nkxW0K/AaEe3JAoW6fvL2Glmx8UKRQOgAj1jJgBUqvxrR+N7dtQXnAempClokXjZrP31Fos
 Uo/P4PZ8VOa1B/KtU8G2k/DCUKAxONOjXxq0EeMJt+RrniRAKzer7MECZua5d4uxdRD2T3S87
 H98saW3wxsiWVAZ46OcE4YWI4kf+VYUnXQWgjGgOL0yQJkBWsj361oOfLbQ+cLj/4hiVfh5yc
 6yJo4hjL73RXT2KC4pfwgTERq+71D50CAywR31SFtYzB6/VMhz0HSvqO5un9I1tkWFz8JS+aZ
 bFx7UoFClian0Fn8tzTGZ4x5NFLIjn/FkFXc841Ta3i81dJOCI1vCB1vOHqlzbmldF8Fqb19k
 ikany1bncKVxsWSrtJjCSAGxS9/juTd/gXTDtJDBUa0W1ottXreImiKFEwzcrIFTHP5yCTG9Z
 iDsjl0FwTjTNoj6d
X-Spam-Status: No, score=-105.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 26 Oct 2021 10:43:18 -0000

On Oct 25 02:25, Mark Geisert wrote:
> This patch unifies the layout of the clipboard descriptor cygcb_t for
> 32- and 64-bit Cygwin.  It allows correct copy/paste between the two
> environments without corruption of user's copied data and without access
> violations due to interpreting that data as a size field.
> 
> The definitions of CYGWIN_NATIVE and cygcb_t are moved to a new include
> file, sys/clipboard.h.  The include file is used by fhandler_clipboard.cc
> as well as getclip.c and putclip.c in the Cygwin cygutils package.
> 
> When copy/pasting between 32- and 64-bit Cygwin environments, both must
> be running version 3.3.0 or later for successful operation.
> 
> ---
>  winsup/cygwin/fhandler_clipboard.cc   | 42 +++++++++++++----------
>  winsup/cygwin/include/sys/clipboard.h | 49 +++++++++++++++++++++++++++
>  winsup/cygwin/release/3.3.0           |  4 +++
>  3 files changed, 78 insertions(+), 17 deletions(-)
>  create mode 100644 winsup/cygwin/include/sys/clipboard.h
> 
> diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
> index ccdb295f3..7adb50991 100644
> --- a/winsup/cygwin/fhandler_clipboard.cc
> +++ b/winsup/cygwin/fhandler_clipboard.cc
> @@ -17,6 +17,7 @@ details. */
>  #include "dtable.h"
>  #include "cygheap.h"
>  #include "child_info.h"
> +#include "sys/clipboard.h"

Pushed with a minor change:

   #include <sys/clipboard.h>

given this is a system header.


Thanks,
Corinna
