Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 20055385780E
 for <cygwin-patches@cygwin.com>; Mon,  9 Nov 2020 10:05:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 20055385780E
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MSbp1-1kiV8r1XnF-00SwiJ for <cygwin-patches@cygwin.com>; Mon, 09 Nov 2020
 11:05:28 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D3F90A80BFB; Mon,  9 Nov 2020 11:05:27 +0100 (CET)
Date: Mon, 9 Nov 2020 11:05:27 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fhandler_fifo: reduce size
Message-ID: <20201109100527.GY33165@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201108171632.39541-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201108171632.39541-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:y3Is/o5Ir5LMOPn6k6mRwRQ323WCLBtAUl58vayG6K41Qtkg7on
 djk/PMeL14UW9ydR0vASBDDCXjXYrvjk8BMO47fAwhUWzGz/Z9ZbUUceu/EyFxALxJyTNgx
 i1DvId4dxSXJIb5YafrG6qqRq4bhDZDXQWI0kRD7zSErGLqBfOiTheYIOdu1S0z5TqJd6xu
 P9SBUGEHzfYBEe5ozMujg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vinwc5uLURI=:hn7Ndii1DNMy2dOlvQ32e/
 SPr21QYZq5lVnqFXuZ/mWZ7qo4c9RKOmsYsHZpLvBzejAgYYyt8jCrpYoDxF31h3VYbLE+FDX
 NsAVVor7T5ZbnrmJDt2bqq2XXw5hUalaqF/oa6Fykbh3AO65SW+GBfHoMaOkV2prjqslXbkGU
 esrZUBXLo8oJUhMOS4JAy6iFcJ7nOrcK9zkWUbbVAcHH1ZVO8Fxk4AI8SGG7O9SeO/jFvMhFI
 T9zSFACqIgUxF/bOFGJLAXI3L3IF6x8GEW2rrHJ5YS9Ot+03TpJjZ3R9u0RU0V5j2NSJKB61E
 ixS2qu+fIIRTE9blijQ2uHCCNC0U/HjYUJlkFDe5eX15hoqR5uGZJS3+VF6N5e6KjeIJGYFA9
 KkN7MKBp1VSKl/mytoNUHeoT9Ed6SUfoPjSgw9uyg2u8P+LXxAljE7Ta5YII4R5Iv5gtiHVG+
 WnOjC3v7qA==
X-Spam-Status: No, score=-100.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Mon, 09 Nov 2020 10:05:31 -0000

On Nov  8 12:16, Ken Brown via Cygwin-patches wrote:
> Replace the 'WCHAR pipe_name_buf[48]' class member by 'PWCHAR
> pipe_name_buf', and allocate space for the latter as needed.
> 
> Change the default constructor to accommodate this change, and add a
> destructor that frees the allocated space.
> 
> Also change get_pipe_name and clone to accommodate this change.
> ---
>  winsup/cygwin/fhandler.h       | 12 +++++++-----
>  winsup/cygwin/fhandler_fifo.cc | 11 +++++++----
>  2 files changed, 14 insertions(+), 9 deletions(-)

+1


Thanks,
Corinna
