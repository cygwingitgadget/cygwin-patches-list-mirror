Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id EED32386F80C
 for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2020 08:12:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EED32386F80C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mdva2-1kdrVk3HQE-00b6i8 for <cygwin-patches@cygwin.com>; Tue, 04 Aug 2020
 10:12:58 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 66102A807C3; Tue,  4 Aug 2020 10:12:58 +0200 (CEST)
Date: Tue, 4 Aug 2020 10:12:58 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): use
 _small_sprintf %X for microcode
Message-ID: <20200804081258.GU460314@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200804065156.5072-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200804065156.5072-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:oQsQtkVpaLE9abtps45tFY54IlNJzXRknOR1yiLJ8A+YgTkZviR
 FIdk9HnHLsgVPqJpmEU/zKPnmL3N7weFgAzzCUTgxTmtSrYRYG5IWUxYCMvVRI7qw8stkW9
 JRa4nLv9Dg/QDNoYF5pWTY/lvftXwJY+2/So4zla1kPfDdk0Jf+Y2kWXWXX6ol889AXZWA/
 f9i7uu5TigwZzbK0OpjyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xDdLTY+6tiw=:RT9LPni8Slb0VP5NheAdMr
 102NsDWy+GfWUn9z/IfFa15g9s/RMiJBrPN/uPaxL8PjVFSl17rHcEVKI+YGCDNoTLbqkWtfe
 iSVpRKvUP3YQysCv68UjsxrcYlXhmCZzfrXimKHKo+bFsC4bCDZayb6kpPgNfSIzwqFQO1uVW
 3fI6BmOQi0StTgRrp4pA0j6Ub9SvCVtFTROSkVSkN69AI0/im8UV5jpBB6tNJN3MqEeSFg+Vt
 h3jMu5Hd7fWIhOpRJPnCMFxCwnhlKWyHC87rZEj5qfOAGi0DvtMkACskHqx0GmH+fYRV6vae7
 9p6jM11H7t7R07rMxmU5WXQUKX7rP+1ofJk3aS5BsdHU2iEJs6fuyasfefr84v48P6vW189Aw
 wpicr1Yv543Zy+4g8ohGXCcnNre5QdUhiQ71b5rALLfk7Yd/UJdPpBOn4nGWa2vniL2dk3BiC
 JEYq9PZPL780cp8rIExToH23Uk9EQBMvTLDdSV2rwHlUBAqV/jBUAzDrWUQ8fBS+9jL//ndPi
 nSmYeuSUKPuQck0FsooQtkg+G+6mFfSg3P7LePUNbhfgDrihVBnSfgMoS6pcp7+y7L6hJwAip
 qqiU55L0aWoa/7JOxdUxhxgcGHIYS9A5ay9yE+qTIGr0nrR+rG4EeHe7sqRjbEasaZGRwsWCW
 SiNSpG0aItR1eiagWF/KqqwMTgPqb50CRTBcat5jNYxoBdpX9OnaQAAt+K4fj2ZZDyHlQl2LD
 4a85GSo11pVUQO/qtYfeV9gXK+9bC4vsKFdJ/Bkp6SLUmnKs5i+EC8OrXWlJZoNpOYCp6W0zh
 6U+FuvRvd6XCVhVheRWsPhpptKu6Oe66qYma0K7YS/ei7aX3GXPbxwpFcSmijT3MXHxObKTWz
 IC33W/xzm0zD3SO4ogsA==
X-Spam-Status: No, score=-104.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 04 Aug 2020 08:13:01 -0000

On Aug  4 00:51, Brian Inglis wrote:
> microcode is unsigned long long, printed by _small_sprintf using %x;
> Cygwin32 used last 4 bytes of microcode for next field MHz, printing 0;
> use correct _small_sprintf format %X to print microcode, producing
> correct MHz value under Cygwin32
> ---
>  winsup/cygwin/fhandler_proc.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
> index 72ffa89cdc79..9a20c23d4b65 100644
> --- a/winsup/cygwin/fhandler_proc.cc
> +++ b/winsup/cygwin/fhandler_proc.cc
> @@ -833,7 +833,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
>  					 "model\t\t: %d\n"
>  					 "model name\t: %s\n"
>  					 "stepping\t: %d\n"
> -					 "microcode\t: 0x%x\n"
> +					 "microcode\t: 0x%X\n"
>  					 "cpu MHz\t\t: %d.000\n",
>  				 family,
>  				 model,
> -- 
> 2.28.0

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
