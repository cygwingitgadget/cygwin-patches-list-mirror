Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 05F233861845
 for <cygwin-patches@cygwin.com>; Tue, 18 Aug 2020 07:45:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 05F233861845
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQ6C0-1kLE0h1v1s-00M46F for <cygwin-patches@cygwin.com>; Tue, 18 Aug 2020
 09:45:47 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 6B31BA806BD; Tue, 18 Aug 2020 09:45:45 +0200 (CEST)
Date: Tue, 18 Aug 2020 09:45:45 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: main exception handler (64-bit): continue GCC
 exceptions
Message-ID: <20200818074545.GJ3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200817204436.53379-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817204436.53379-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:dYdjv++BHydRUhriidttwcBl+dkI03nJyoAmUFr9LKkezwe1eQj
 El6TC7aAGUX0P4ne6ku+1eQO0DXmkr02hqFkv/jNXYQjwBu4lYjZQKiFgd8Qela5p2W3cwx
 yQpYVYflIFE7TDPb4c9GNGMuEIJq0y5Yg/heUrJfI1No93g7/tgKq1JdW4oU8/rERzszMjB
 zolfpEcX+vHC3kPgyVDdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uDQnKC/oJ9E=:qQ/SdgHzzJV7hJXbjhnSQT
 +CnYsPBSBELAyxD5NhycMwmcx7fOjuqyxqYXcvqoknBYui0thnKNr5sQ51M9RkT3f9LSGFbx8
 EsMlVhhBLP4gcQC0lkq3Xhb6HSNGvgJzzA3THxKyWwMn3WxQDvXIQHBRAbAmxkhVHbHAot0t6
 9VnedOalf1vySawP4UdpvxmhSi8FqhvGgNut3paI1QnMcA7lvT+Bwa9yzS2SP3WzUNBHW1dCt
 714DJjev5iYzEDR0GbIRLkMM9YEMzMH2Q49qx5PJu/iZrNBDfW9N2HmKHm6OcCS9g5XSipao/
 FjyxS8IlokGDQIH0NzUpPa/84Ge8GdYH2110HtkUY+Cm/A9Rjbth6lZVEs4ScKgFLVc95mRyl
 u7ZLEZcbg5bHhUoO6BDC5M51/zPXSRriKCdxv3VeAjZqknkhftiLjTjK2LhQ0UN5FVRpCLsNS
 QYu+EecsZmdrdfqOEYUoZCPZe+JJwyjWyRNJvSLaDRd+wnsk2rQdtJeaRpci2DJ6XBwExkAan
 XbHMfydQiFyUXUKmRCToUtU0Ym9YNrUWECIOYYA9PITnPzsYiJV1rYKkfYItQnK8dAE5mG1C2
 eYhgxo+rq96xm2dv4iTJHqzPCTFi02+LIPqoGt8sWinLMuifzACy8myv3aex6U3x+wKlj7ecK
 IFWkoNLXbl3JRFJFVsP2NbQHPpmqWdkJXa8hsI9lIWQ35sUwssqG8BRJElJNiojHEGDMrpA5E
 lh/3A6BcbfNFytVm4TRMm1aq0/BU0o9bgtxUB8dJp2sOLHgxPSecZrI3ceUXm9l/kkPpv/105
 9zzW+nxwuUTFsMraJ7pGUv3FQ5eejxf8k5aQ5pNPc+f/3fh2dFJRNvEg4EsJ6SoeM1QqWaM3n
 eNDCykL+iFSrbLlas5pA==
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Tue, 18 Aug 2020 07:45:50 -0000

On Aug 17 16:44, Ken Brown via Cygwin-patches wrote:
> This is necessary in order to be consistent with the following comment
> in the definition of _Unwind_RaiseException() in the GCC source file
> libgcc/unwind-seh.c:
> 
>      The exception handler installed in crt0 will continue any GCC
>      exception that reaches there (and isn't marked non-continuable).
> 
> Previously we failed to do this and, as a consequence, the C++ runtime
> didn't call std::terminate after an unhandled exception.
> 
> This fixes the problem reported here:
> 
>   https://sourceware.org/pipermail/cygwin/2020-August/245897.html
> ---
>  winsup/cygwin/exceptions.cc | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Thanks a lot!  Please push.


Corinna
