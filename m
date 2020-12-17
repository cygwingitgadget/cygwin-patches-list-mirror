Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 7D19B388E808
 for <cygwin-patches@cygwin.com>; Thu, 17 Dec 2020 15:04:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7D19B388E808
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFsIZ-1ksLeu0Wul-00HM6m for <cygwin-patches@cygwin.com>; Thu, 17 Dec 2020
 16:04:19 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A9FE6A80457; Thu, 17 Dec 2020 16:04:18 +0100 (CET)
Date: Thu, 17 Dec 2020 16:04:18 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): report Intel SGX
 bits
Message-ID: <20201217150418.GH4560@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201217071127.60537-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201217071127.60537-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:EeLDR2XOi9RB6wb9Qczu615R0wuDv2z4uMeF8zLCXlymmsNwzRL
 EvvXU1OyCiSmMcjhpXgv4YGWdJuY0XMR2Sx5SwF+zklzrFVIWLh2EmI3G0gokh+KgqRlmFg
 BHyIEmDgWgZDjENAd6DaaMeAEZ1vtPK2YnFirRtyKw2HKd5+ybxbwmz6EKfkYV1w7avRnt5
 C3ARFujcCo8QhI00015mQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IFurX+UvU1M=:3QV4Y8CTKjloc10mSMy7J5
 9LSn5qv1nlobUljPOXCewXIC6FYb2ub0b9XtIMzV2G9j+dphj4m72b31pj6erv8lPTxMlXUaj
 1CWFha4ex2fiQeveN55RzikubA9Urh8LmIFBb5I2Lc387S8RCZzXfionurZgv11Ho76UF3N2v
 +xgGOoaByEXrGHnZMPWTDWEEzqOAc3HOcyiIRip8qvmj3/pD/6H6CAztmfCky25eSfXnpxziv
 GTBHA4Sd9tC24hMHhTfYfxAmvHRqRG/E7+0p26uT6Wecy+oAl4pPEe4AC8vQWZO+vD3JSNkd1
 ZKljEfVe89UaLf/6vSq5m9L/cHuFPSnk9BCtLdz2J89Qx+v56SYxCaB+u9pofzGlGfWB3KPZ5
 NHkaeVgDNoEDq8oE307nLhHQaQPPs/akwve4kwBoHY7Aty/kRbxZL/s3hEs9TWTShNJhPZiwc
 TII8ZR1K/g==
X-Spam-Status: No, score=-107.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Thu, 17 Dec 2020 15:04:22 -0000

On Dec 17 00:11, Brian Inglis wrote:
> Update to Linux next 5.10 cpuinfo flags for Intel SDM 36.7.1 Software
> Guard Extensions, and 38.1.4 SGX Launch Control Configuration.
> Launch control restricts what software can run with enclave protections,
> which helps protect the system from bad enclaves.
> ---
>  winsup/cygwin/fhandler_proc.cc | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
> index 13397150ff53..8e23c0609485 100644
> --- a/winsup/cygwin/fhandler_proc.cc
> +++ b/winsup/cygwin/fhandler_proc.cc
> @@ -1414,6 +1414,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
>  
>  	  ftcprint (features1,  0, "fsgsbase");	    /* rd/wr fs/gs base */
>  	  ftcprint (features1,  1, "tsc_adjust");   /* TSC adjustment MSR 0x3B */
> +	  ftcprint (features1,  2, "sgx");	    /* software guard extensions */
>  	  ftcprint (features1,  3, "bmi1");         /* bit manip ext group 1 */
>  	  ftcprint (features1,  4, "hle");          /* hardware lock elision */
>  	  ftcprint (features1,  5, "avx2");         /* AVX ext instructions */
> @@ -1564,6 +1565,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
>  	  ftcprint (features1, 27, "movdiri");          /* movdiri instr */
>  	  ftcprint (features1, 28, "movdir64b");        /* movdir64b instr */
>  	  ftcprint (features1, 29, "enqcmd");		/* enqcmd/s instructions*/
> +	  ftcprint (features1, 30, "sgx_lc");		/* sgx launch control */
>          }
>  
>        /* AMD MCA cpuid 0x80000007 ebx */


Pushed.

Thanks,
Corinna
