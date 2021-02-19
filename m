Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 9D06F3870914
 for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021 17:07:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9D06F3870914
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MeTwY-1ll75d1OTc-00aRkR for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021
 18:07:33 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E4B4AA80CEC; Fri, 19 Feb 2021 18:07:32 +0100 (CET)
Date: Fri, 19 Feb 2021 18:07:32 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Fix fstat on FIFOs, part 2
Message-ID: <YC/wVCqFCu9OmH9S@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210218171348.3847-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210218171348.3847-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:GaXfa8yXiMVRzmoSiKX21NiwJ9G4gz7i/5ob2qdLr1LyqxLO4CD
 lI4vy7Tb2UVlVH2t2VVUTeBpHO1WYXWGpjTiBhciGoiyxkNkaZj+b2Cu3g+pLglPEnkaytS
 B1/IS+cKN8cenSonEflmkdZ9YD6B2z47A3XhJp/f4PGWGSOLm5otz+WZEYIa/p2j2cLGI26
 aU4SnenRtyoo+0kCdUX/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tjxZmlGGPco=:m0Ux3o/En5W1UpwLBWa/f/
 vKzTbyHbP2fbYyXfmePcpbb/uwpqkrLonxiWXQWYDMFQ/Py/2IsLyOcOunl5vpUiGWJUclqyk
 JuY/dTiJNrfFrsjV3MLgYZfPVkP2yZGenE+5t/CSfnJeBLUWEy5wIx5dsCoFL2qHtHCWMsSkS
 sdeHrIdHwRispI8/eLcpbFckDHkYKEBPkXHmTyfilb53YwjN82qg7Bwte9XLyZikKZYj5tDDk
 R54zyNNNRSl1LCSNxNj2VcAqORJmpk7BbmUlhBz2tVHuAYrqV384+IgKWmiQmJt4CbTm3VhOP
 ft/uz34Lit18TLBxE0JAkh1TlCnill0z7EIC5Tgk4oaURauckZhm7Bv+v8tB2ZeY+B6vET/sO
 rb4UvIw4K59sQbOj6XW119jfxixduxV5REqQGLRxHophRjxJ4ZdF1BXNO8qHUtOYzNktexJ/v
 cbV5uuv+0g==
X-Spam-Status: No, score=-101.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, KAM_NUMSUBJECT,
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
X-List-Received-Date: Fri, 19 Feb 2021 17:07:37 -0000

On Feb 18 12:13, Ken Brown via Cygwin-patches wrote:
> The first patch fixes a bug, in which fstat on FIFOs sometimes used
> pipe handles instead of file handles.
> 
> The second and third patches should improve the efficiency of fstat
> and open on FIFOs.
> 
> Ken Brown (3):
>   Cygwin: define fhandler_fifo::fstat
>   Cygwin: fstat_helper: always use handle in call to get_file_attribute
>   Cygwin: FIFO: temporarily keep a conv_handle in syscalls.cc:open
> 
>  winsup/cygwin/fhandler.h            |  1 +
>  winsup/cygwin/fhandler_disk_file.cc |  3 +--
>  winsup/cygwin/fhandler_fifo.cc      | 23 +++++++++++++++++++++++
>  winsup/cygwin/syscalls.cc           | 22 +++++++++++++++++++---
>  4 files changed, 44 insertions(+), 5 deletions(-)
> 
> -- 
> 2.30.0

LGTM, please push.


Thanks,
Corinna
