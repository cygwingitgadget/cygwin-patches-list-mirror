Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id A1AD03857C5E
 for <cygwin-patches@cygwin.com>; Tue, 16 Nov 2021 14:00:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A1AD03857C5E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MvKGv-1mV2Vt0vOD-00rDok for <cygwin-patches@cygwin.com>; Tue, 16 Nov 2021
 15:00:08 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7B532A80D6A; Tue, 16 Nov 2021 15:00:06 +0100 (CET)
Date: Tue, 16 Nov 2021 15:00:06 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] console: handle Unicode surrogate pairs
Message-ID: <YZO5Zp4KlZLKSP1R@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2111161125300.21127@tvgsbejvaqbjf.bet>
 <20211116221958.aa98712827563090a83a2565@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211116221958.aa98712827563090a83a2565@nifty.ne.jp>
X-Provags-ID: V03:K1:Ordz9kfKL6228H9y3E3nBn+jJJVMEERnaUc38witozCgc5TtuU8
 Yf1p85mWv61DxA8tTe4iXRAjmSCaLCKI8jQngtFdH7vCPWCjp/unuN2efS5fQoqrNbIB86v
 2MxN0P9bMShbrxDdsrDAgrYJTFjJb4MHVQzJ8f/eZE3Lx9xgoUjtRj/1nsTulgNH8OlVRbW
 ixwDmzXkXYJ8947KSlTkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:klITOwKLoTY=:1qw0tqjFsp9hkMGIub0Dok
 zgu87GUNi6bN0bVTxzaYVft7gY3YoqsTebkXZ5/fmv6ylcUnk3J7gHbhcw1XI7JU1GoCLGc2u
 NPW/uG32OzSBz41KDoZCjvMrqbTLcwFQrxLuLpX3er6ujsmLPJ5Ln8ETrYZHAt+CddNYYZROC
 XpTuJvbJy8LAbekNJZABzILI20r8gBbAmoXgBEpiQFWoiAFx6yrzAWvlW4O5ezEAuPyE2vque
 VfvYPEwcHmS4nOzMyeyc5nQXOjmXJQAMXWi6hT8ov5JUX1CO+BcqrGV/+VgAD9Wx/EiSErNDj
 fgbDq+sXK+iSTmKlp9CnQUQ99g1Mg7t1GvIpBeZ/HsjKytgIe5LG1s2c1pe52ML8qkAow62H9
 eZbWuAuE0m6/jKxJOpja52X+xz4Sih+2pzKC5eQ+jXxGpd+Z4Y5VE0Im+NayKQGiW/yKg/sS/
 GCLhsdi5FewG7jbqbNYN2pObA/k/JrsFrhJ/zcnHkS56V8oSc9xaHYpiD1c945dBWpaZDnr6n
 GGIiThfCeYmJw4F2DTkJx1+NAFGxudfp5CNWel+bd4vqTYskTCUdBW+emy7oYL5rPcrq1kFNY
 oCLE3LTGa9GCPdJMtxwa3ghsIxgGmuYIz1BMyQbNj4qCm4dSrS5FlK6uNkH0Cnb0kRtu+0Mi2
 J9Av+HjYLqIbGbi0zsZae6ueyFuQ/9JScMDUDsQF3yBBjE8dt9gJJDcCzt8ayXa13bz3r70VS
 fT/V8RVESmxeFwyW
X-Spam-Status: No, score=-99.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 16 Nov 2021 14:00:11 -0000

On Nov 16 22:19, Takashi Yano wrote:
> On Tue, 16 Nov 2021 11:26:10 +0100 (CET)
> Johannes Schindelin wrote:
> > When running Cygwin's Bash in the Windows Terminal (see
> > https://docs.microsoft.com/en-us/windows/terminal/ for details), Cygwin
> > is receiving keyboard input in the form of UTF-16 characters.
> > [...]
> > This fixes https://github.com/git-for-windows/git/issues/3281

Please put this into the release file.

> Thanks for the patch. LGTM.
> I will push the patch to the master branch.
> 
> 
> Corinna,
> 
> Should we apply this patch also to cygwin-3_3-branch?
> Or should only the bug fix be for cygwin-3_3-branch?

The entire patch looks like a bugfix to me, but it depends on how
one looks at it.  Your decision.


Thanks,
Corinna
