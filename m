Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id A4C5138460B4
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 11:08:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A4C5138460B4
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MNtny-1lPaxs3CkS-00OCYD for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 12:08:48 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4981FA8093E; Mon, 18 Jan 2021 12:08:48 +0100 (CET)
Date: Mon, 18 Jan 2021 12:08:48 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 05/11] Cygwin: Move post-dir unlink check
Message-ID: <20210118110848.GV59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-6-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115134534.13290-6-ben@wijen.net>
X-Provags-ID: V03:K1:HIkuuhLixuG/oognxPskIYDm5NtElhiEvvxLVGU4KL9ZFxe00HN
 vrK15IiNz3rReTW0C0JvJPSQlmenNoRrnyQ0/hPUJnuB7cDJIuLkAsattVcJQZ1/HDBJM9s
 PpooAGNZe8xhZSOy3jCodYF/NeBsp5R6YBP9VYPAiE+scKQqDvrQf/pG+C5wHbx2KUMM3CG
 T8GhsY4bRgJ8g/oGSw7Ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fztJIGIcsQQ=:J/RM3cLBtKBZrbHHoOY95v
 U5zcwINoBUk+NiJw4JUffgIzVLcakTXjA6K3ijG3+gTAzOgSRE1WDGPN+dU3WYcRQQK+r85+x
 OQ5gzdfpz/HwC5gx16MO/N39RCKHRKK1eECzKGpfcaCfqVLZ0cxqqBGJfpyppGOsvP0QJdyFk
 NN1L8Sad+8+dgdos2rVozb3om3CtNqceCy9C5LdC2za5ajegTtKrl2BxmtNqE80InBu7BMgOF
 y9AnDPvdF/zk3eJJH66Gma+zB3p0wyHNJFTdENjGkKoV/xHnti9UiCSmuiQ8GsP1iOtE9Z/y1
 1uqJ8cx6sGOkbZRR2p2gkEC6T1OfvBregG1VFO5mIreK7gMXRWVw23Y0YxDOIZvXP/XBC8Ka8
 glG874QAxFxgazBEfelyDyjMapvhk7LwK/ygDdhd9xUAEGRBFpQTgFyYek/SSRnwpq4IWwRfI
 DbkoaLb7xw==
X-Spam-Status: No, score=-100.9 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 18 Jan 2021 11:08:51 -0000

On Jan 15 14:45, Ben Wijen wrote:
> Move post-dir unlink check from
> fhandler_disk_file::rmdir to _unlink_nt

Why?  It's not much of a problem, codewise, but the commit message
could be improved here.


Corinna
