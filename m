Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 43DB8384BC21
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 10:25:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 43DB8384BC21
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MYvHa-1lW9tb3t2m-00UulN for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 11:25:31 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8B8CEA8093E; Mon, 18 Jan 2021 11:25:31 +0100 (CET)
Date: Mon, 18 Jan 2021 11:25:31 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 01/11] syscalls.cc: unlink_nt: Try
 FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE first
Message-ID: <20210118102531.GQ59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-2-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115134534.13290-2-ben@wijen.net>
X-Provags-ID: V03:K1:n8ZFTnlBmMNaiO/t9eNTDDMQqN9gnwnkBaQ8YIzoOOGGFnwfLWt
 QT8SrZ+zzJRkV7PovvChRaiKsdSTrF+j6Ne3qZFWL1CQFzTiV2M4L7FliN3rR2YL78hL+vp
 ivPHr+hqDs1LsODJ/G4a36tPgFZAZGQWd0Le5wsdZwrmZqlFtXG/184mu82rNmt6aMd+xyB
 GpdYq+wgrvh6W9FhaCXjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nK7imLVw6ns=:aH9N1JVuASHQ6ccRFJ5+T3
 fusCvR7koWgKdi734TuwkLtmVRD7cRZVOY/Yk0njOhGZDP59IgJJgXZrliCtNWUgsmUFLSNfK
 /5E2wUvmNgPFu9IG3tjPrlY3k62LC3o9jg5AKD22LEd52Fie71GcvckPoL6YPSs1/Xt6spyk7
 9esAk5BupoX+mqNK7f8e2l4vGcHe6iOZ5HYjIpz8KwDJAKIDk9kL8quRPq34BLBIoaORPj4SW
 Uq+S0ZPgxubXPUuu/IofN+1aPIZ7AhjlxVt8n1l9utZyWYSfewQLP0+tcF+BPaPyKb7BUa5/F
 cG5wSL3AQnYL/MPMUuRPy8iAQ6ZK3usStsdcPEnK9f5zHcmF0XKB43VKLFurkhUS5uJiubWz8
 nyv1dkBoY/8wSyLEGI7P9VfnZzt2HvOsoeP8AIJVFOY3VR0e5ZKpnHG5EvBOLRV56n2NIhzSs
 hNaS200o0w==
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
X-List-Received-Date: Mon, 18 Jan 2021 10:25:34 -0000

Hi Ben,

On Jan 15 14:45, Ben Wijen wrote:
> ---
>  winsup/cygwin/ntdll.h     |  3 ++-
>  winsup/cygwin/syscalls.cc | 20 ++++++++++++++++----
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/winsup/cygwin/ntdll.h b/winsup/cygwin/ntdll.h
> index d4f6aaf45..7eee383dd 100644
> --- a/winsup/cygwin/ntdll.h
> +++ b/winsup/cygwin/ntdll.h
> @@ -497,7 +497,8 @@ enum {
>    FILE_DISPOSITION_DELETE				= 0x01,
>    FILE_DISPOSITION_POSIX_SEMANTICS			= 0x02,
>    FILE_DISPOSITION_FORCE_IMAGE_SECTION_CHECK		= 0x04,
> -  FILE_DISPOSITION_ON_CLOSE				= 0x08
> +  FILE_DISPOSITION_ON_CLOSE				= 0x08,
> +  FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE		= 0x10,

How on earth did I miss this flag?


Thanks,
Corinna
