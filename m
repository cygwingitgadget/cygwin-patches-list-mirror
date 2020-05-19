Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 7BE4E389781C
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 10:05:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7BE4E389781C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MiagR-1j6Knu1UPP-00fljP for <cygwin-patches@cygwin.com>; Tue, 19 May 2020
 12:05:37 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 09672A80706; Tue, 19 May 2020 12:05:37 +0200 (CEST)
Date: Tue, 19 May 2020 12:05:37 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: termios: Set ECHOE, ECHOK, ECHOCTL and ECHOKE by
 default.
Message-ID: <20200519100537.GT3947@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200517023444.286-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200517023444.286-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:lTDF5WF3s0gOkhxzPRVRTUGyHLkE2kIXqxLzbDEhlN90i42SLXe
 S5YY4mHiq0YRgjcjrBb6S6KLlK/9VtFQosNIEZWMmgwHzGI23ugp4rcsLBdVqv+p/eXgKPc
 aunFNow8gJrCwy7qrxdTGUBf6aXpbwg/XAjEGxH8IPSstc424plNlXaXFbKl3gQ67GnBAu4
 OTp6PEAPGLVFEutQ8lfxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hd0XXXEiEO4=:mfZ4XYAgdFC3Qt3aWZBXu7
 viH1vAaRe2OIZdEzfffQBOL1pydzXCksGpu4mGkxYtowMaaGnPqiy6cp4MeUKl9A/pGspK9eF
 P7/SvSE6vX2OloLiDAP3N/7YBXR/hZqvYqcrMLo0+4+zpiEhStpTHi4jIXq+vN+TMsMBbkdDW
 mOBOS+kWJ4ZAP1qvgUkwJrG6IQzLd/SzRqcQSeO01ykzmBbTklUCzBn326zieFxgaKAMP8tK4
 qIHGyStURr2VdhMb3SHimHRBRrufvyXKGRa9Oy3fPNelOZKfm5I1mzX0hdwvFCsRljBD9TEv9
 nm2Xb2SGMtcZIzzeVl9JjzwScMfRdpEJ/rpdEkI2du1zf09ovntEQj4LjETqvAIzOGQoO8ppl
 4ZQkXl4am9/1O4KGe9Rl7mJBOFdz3mr6R4frRRknh00MojzKj+Bv3SCehiWAo1H7kLPIC4tbc
 AB/WH7CsYTEsw9UVqIgvn8uHnRluTijq7OuJXBw0OMbkgue0VMIWgZq+A4uOvV1F/lVcwH5Bw
 r1XRVai53wgQw9dhL2vSTA+JZfzML1so6mUPTOce+KdUbBsUAJtBs+ESr4bU/+tEbL/DA1qV6
 OddGCzLtUYpYUTg2QX++s85R5PeWeJX46McR2SciA4emG8wCenFHDEfPDd/EzLyxfD5STx90k
 FNd1uRTQBq1hcEPiYAjTIylZWrWr6lnZkKfoGU0Inn2KmglFmDc4bkTRRtK+NW7tsXnYMUj6I
 CZ1bk6uUW0E1T7rHtTjYxEAWhO3fWWJo5MeX3OBttwY4fKJoE+LALa2rosK+2Ds7DekD/mnW+
 4aLgOit73+quxSM2c08+jr1nRkqc914qkWztkVmHZy11Gt4eOLCNQj+8b8nzAOr2dSdv/ux
X-Spam-Status: No, score=-103.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 19 May 2020 10:05:40 -0000

On May 17 11:34, Takashi Yano via Cygwin-patches wrote:
> - Backspace key does not work correctly in linux session opend by
>   ssh from cygwin console if the shell is bash. This is due to lack
>   of these flags.
> 
>   Addresses: https://cygwin.com/pipermail/cygwin/2020-May/244837.html.
> ---
>  winsup/cygwin/fhandler_termios.cc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
> index b6759b0a7..b03478b87 100644
> --- a/winsup/cygwin/fhandler_termios.cc
> +++ b/winsup/cygwin/fhandler_termios.cc
> @@ -33,7 +33,8 @@ fhandler_termios::tcinit (bool is_pty_master)
>        tc ()->ti.c_iflag = BRKINT | ICRNL | IXON | IUTF8;
>        tc ()->ti.c_oflag = OPOST | ONLCR;
>        tc ()->ti.c_cflag = B38400 | CS8 | CREAD;
> -      tc ()->ti.c_lflag = ISIG | ICANON | ECHO | IEXTEN;
> +      tc ()->ti.c_lflag = ISIG | ICANON | ECHO | IEXTEN
> +	| ECHOE | ECHOK | ECHOCTL | ECHOKE;
>  
>        tc ()->ti.c_cc[VDISCARD]	= CFLUSH;
>        tc ()->ti.c_cc[VEOL]	= CEOL;
> -- 
> 2.21.0

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
