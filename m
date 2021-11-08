Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id CD5D63858401
 for <cygwin-patches@cygwin.com>; Mon,  8 Nov 2021 09:51:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CD5D63858401
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M6lxe-1mnral2Jn4-008LIc for <cygwin-patches@cygwin.com>; Mon, 08 Nov 2021
 10:51:09 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 32AF8A80D53; Mon,  8 Nov 2021 10:51:09 +0100 (CET)
Date: Mon, 8 Nov 2021 10:51:09 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Avoid false EOF while reading output of C#
 programs.
Message-ID: <YYjzDcfEVMDKA7IA@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211107034718.1048-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211107034718.1048-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:6wa5IXb2Gj2W40Iv7cMIURSgxoPMAqbGnTmb2bvaiec0eDWlhoG
 GEgvtb2Mukj3AavjGkJeYGxTefZR15rOatnCVO+4NNrkugy/yj14aGMcA4SS5XTiS6X4nZf
 IumGswxBTDaaesKTx1cg3nrD6nNAnynfKToR2pKfIncRks5c3UodRjWDEkuIXNSXWya59vT
 7nIqAfiF+qttaP1zXAfTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a47NTxZ3gzI=:5a+Z35oR95fidFqu4SnVZa
 gMRS5/mP4hCNfPUbL01G5ZmaaP07ZBMUZqBAiEQoYl17ZJPbM99ooJHAqUlagXzkb3peg29b+
 T5dlFJTOyBdcZxH9e0zq+YgOz040t2mr8iippDXB0a1a3eXCEZIJ+W1nOVXM2LBAQMSFsEuza
 +h2yos66mDKVSUGbGk2V09vN1W9p0RuPM1WpW0roWgPSK8VMuZX6GLlP659R4QbWNlSXFCRZJ
 mqLW6gMwckkHt8w6zS0lVr0PZ3qGgTgPN9REwWDxNYfNmFV8uCBel9swG1FrwUONnDed422uY
 WdxY9ZlwYs+9tP1hQWaNl5FkFfeTt0tF6rsg0aBcG64jPw9tQ7MfbZIWMGGTPxsKaU5Y/Kzbh
 J7820Ccwqx7SPd8Y1Nk4YocZNPpGYwCrubk7+LDycNju5a35vcJEBq/muGOMgLYYXM8XnQs/l
 fVL7FJtNxXV+eyXri9Gcv2YsCraeJSbdEauI5XUBvoZchxJsiIbP2kKwGAQRiGNGG4tfdTvvi
 lVdPf4B0gWbteS5XVVCeArpQdvx9V4rePiIR2F7Dsqc38mF2MgqusCuIgvNx/BU2/4yUmlY3h
 XZkx9Ft0Zqn+4mjct1Yis8c+n2wk/k13x1acvsHTMBtL/x1Ev9vF7kSlSh7mp0+SGfbJvUbrn
 +G5yNvHd+2G4LIhWI3/z5GafvmY0ZVuCDJDEWWQRuEfcgX2gBb4WKRDfV+A64DIK1o6qB6Vkw
 2tIazpnHYju1JFrK
X-Spam-Status: No, score=-105.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 08 Nov 2021 09:51:12 -0000

On Nov  7 12:47, Takashi Yano wrote:
> - If output of C# program is redirected to pipe, pipe reader falsely
>   detects EOF. This happens after overhaul of pipe implementation.
>   This patch fixes the issue.
> 
> Addresses:
>   https://cygwin.com/pipermail/cygwin/2021-November/249777.html
> ---
>  winsup/cygwin/fhandler_pipe.cc | 3 ++-
>  winsup/cygwin/release/3.3.2    | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
> index 43771e8f7..bc06d157c 100644
> --- a/winsup/cygwin/fhandler_pipe.cc
> +++ b/winsup/cygwin/fhandler_pipe.cc
> @@ -393,7 +393,8 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
>  	    }
>  	}
>  
> -      if (nbytes_now == 0 || status == STATUS_BUFFER_OVERFLOW)
> +      if ((nbytes_now == 0 && !NT_SUCCESS (status))
> +	  || status == STATUS_BUFFER_OVERFLOW)
>  	break;
>      }
>    ReleaseMutex (read_mtx);
> diff --git a/winsup/cygwin/release/3.3.2 b/winsup/cygwin/release/3.3.2
> index 263c3efe6..2e48e39be 100644
> --- a/winsup/cygwin/release/3.3.2
> +++ b/winsup/cygwin/release/3.3.2
> @@ -8,3 +8,7 @@ Bug Fixes
>    Addresses: https://sourceware.org/pipermail/newlib/2021/018626.html
>  
>  - Fix a permission problem when writing ACLs on Samba.
> +
> +- Fix the issue that pipe reader falsely detects EOF if the output of
> +  the C# program is redirected to the pipe.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249777.html
> -- 
> 2.33.0

Pushed.


Thanks,
Corinna
