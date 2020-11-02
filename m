Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 6A5DB3858005
 for <cygwin-patches@cygwin.com>; Mon,  2 Nov 2020 11:21:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6A5DB3858005
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MDQRy-1kgfAH3qh4-00AWAk for <cygwin-patches@cygwin.com>; Mon, 02 Nov 2020
 12:21:27 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7FACAA80DDC; Mon,  2 Nov 2020 12:21:26 +0100 (CET)
Date: Mon, 2 Nov 2020 12:21:26 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/7] Yet more Makefile/configure cleanups
Message-ID: <20201102112126.GB33165@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201031150821.18041-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201031150821.18041-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:9zoDlHv87irH1zlijnGvzDy9PTUrOR2HM6GROFqhs3/YNXEn//l
 wGU8FUfcrykxOn0bbRO/7TpN3fFc/whv1GOo+soEtmUALlvJ4wObUGgLiFqqXqJd57zC7zS
 3jU/WBeTg7Kvgf8qKEm58WEt/k+WVImoZ6IolZ/HEg2RsBcJSccn+LFzbdQez67lLkM7Fqp
 ciw3lWsNatbjLO2AnY77A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eWj2mvzonD4=:2Lqehb+oIts/A2e3hm3i3B
 rnVhKgDem4pkrd1XwhViDauB3GFRdV6iOjGH3/smwdiopE30bNVlsKPDurdDF5kBGGyi38PSL
 OYToEwfog/fbr24kb6CIfw2/LL6XMjQktb8rKKs4GilJLkb48u/mB7OiLH+EMaVG1Hveli3o8
 3N+zMlgIBg8Uwmt0IkZlQRYl1zFuRhD88p/faH1ZX22tCg/rFcBw+FgMIDyB6eKwaVmph9AgZ
 35kUJShrQOKkmlVbGnx8bAXS7jnx8vSLVmuP9TjYLK7DXwGnilNaXuoYAEcc5znz/b8rnJNoO
 yjZR/S6z2mrc64Lw3cNy6m1HTEthgNPdxPElEege+gBoHtI5Ya3494pXTzLk335TodnqaNlHG
 uUmi0w1zH2gSl/HLle/AVMTXbUUONekIg1+veKsheES90sP9YqmRtMbiPnoq0AXrVlbvmS8Gz
 0VjC4NsRzw==
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
X-List-Received-Date: Mon, 02 Nov 2020 11:21:33 -0000

On Oct 31 15:08, Jon Turney wrote:
> For ease of reviewing, this patch series doesn't contain changes to
> generated files which would be made by an autoreconf.
> 
> Jon Turney (7):
>   Remove intro2man.stamp on clean
>   Drop AC_SUBST(build_exeext)
>   Remove autoconf variable DLL_NAME
>   Drop autoconf variable all_host
>   Remove Makefile contents conditional on PREPROCESS, which is never
>     defined
>   Remove rules for building libcygwin_s.a
>   Drop passing '-c' compiler flag into gentls_offsets
> 
>  winsup/cygserver/configure.ac | 11 ------
>  winsup/cygwin/Makefile.in     | 36 +++-----------------
>  winsup/cygwin/configure.ac    | 14 --------
>  winsup/cygwin/mkstatic        | 63 -----------------------------------
>  winsup/doc/Makefile.in        |  5 +--
>  winsup/doc/configure.ac       |  2 --
>  6 files changed, 8 insertions(+), 123 deletions(-)
>  delete mode 100755 winsup/cygwin/mkstatic
> 
> -- 
> 2.29.0

Looks good, I checked full build from scratch and partial
build from inside the cygwin dir.  Please push.


Thanks,
Corinna
