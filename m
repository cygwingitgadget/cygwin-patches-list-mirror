Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	by sourceware.org (Postfix) with ESMTPS id E722A3858418
	for <cygwin-patches@cygwin.com>; Fri,  4 Nov 2022 11:10:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E722A3858418
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=tempfail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MCsDe-1oi4tF0hIO-008s1s for <cygwin-patches@cygwin.com>; Fri, 04 Nov 2022
 12:10:41 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E5404A80B6D; Fri,  4 Nov 2022 11:34:14 +0100 (CET)
Date: Fri, 4 Nov 2022 11:34:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: Add loaded module base address list to
 stackdump
Message-ID: <Y2Tqpl1TuQc588N2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221028150558.2300-1-jon.turney@dronecode.org.uk>
 <20221028150558.2300-4-jon.turney@dronecode.org.uk>
 <Y1zlNBjeblW9dvfW@calimero.vinschen.de>
 <d82f87ff-6708-b3bb-60f4-7f77ea47fd66@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d82f87ff-6708-b3bb-60f4-7f77ea47fd66@dronecode.org.uk>
X-Provags-ID: V03:K1:FF5O/C0X0STzELk16URcYR3fo+082JsU/NKnZlHSCXgey2uWOHn
 qD49Pg2xpl5o4jChM6rhz2nexYfPq3jOIKIKKxgGXzjknmp71oUffBr7xFSDjjbhDDhP6mx
 6dR2nxqCjpWjBS4Bq2MbtPL1+zqSJiccvCVP71rkmqBalnAHiKoINY5sQCqfdAr82YdOsUD
 DYytXiw93Z3AML4lr2lyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IbccnpsmSOg=:KH99fvhle2vEgUhHKRLKm4
 8H6r2qYaZ2eRkFi452my46vNCrPsBI5GUAOZOa04Q8oaTfNKRXojegcepiZOYycUGqCqKV8uz
 ol+DwWzl8bnqcxJVC+IR4tcRxdaWib6Iy5te7tXxNiLXmfAUnhYPAN5PQWJ6x+s2yG3UrZTqH
 Paa6D3gI59+MB6ddrhGsWLrhW4GRFoB1jDo/RFI4YpZ0WYXXPyfqUR905jc+5KOSTybqmxyQp
 aufucvt/tDVI0UrUBmJzO5z56Nn2QwvFkut0AoQgqcfs2rCTrR8fqiBY0eC5+5YjQi/cC9M84
 3pgNqTZNhSjFNY3xObIBZ1odHhQrck2ZQIFJO1DHapHrIpqjziYwooE7UsP90hCmr2jb2SVkP
 xRxnrttsyXAkxNfj9x6oSaSeNtdzxaODNKtT66kUFDedeIqGL7R7Rs1yAIW6kMQ11guoU1aVz
 D3kVmyWpD15cB0VbDc5GZRVQm/qrGYIt91X2u865uM9xCW/hFSyYFt9mxDM320yjH78FpAxla
 FKT6n1brMhvPy2k85cx3JC8updF88UYnCDqXlnHDLtcCA5h48VbaLkXhNyvAxZMSbbgmiV5Fo
 QnOZuCqoB5ja87pP7KDKpDc3ZtRx7vYyaajm49waKPk+Soc8swztgTiS1KApmQzm12oabac9y
 r/+9of0X9JmdHx7m9Qifa5Z76Aqy2B6cAifnDky1lMQQa1tSffRCkEKwd/FearXItWRmWqjOw
 dvPTkHComfBK2sg1uJ1bVHEKi9iysrJcwi+2Ep6fTdQzeuTSRTJkMyDTxKWRFJFtftOJfZUtK
 QRP6NWrtsori31VHVy11fIqV9JazA==
X-Spam-Status: No, score=-101.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,TXREP,T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Nov  3 17:02, Jon Turney wrote:
> On 29/10/2022 09:32, Corinna Vinschen wrote:
> > On Oct 28 16:05, Jon Turney wrote:
> > > This adds an extra section to the stackdump, which lists the loaded
> > > modules and their base address.  This is perhaps useful as it makes it
> > > immediately clear if RandomCrashInjectedDll.dll is loaded...
> > > 
> > > XXX: It seems like the 'InMemoryOrder' part of 'InMemoryOrderModuleList' is a lie?
> > 
> > Probably just an alternative fact...
> 
> Yeah.  I did stared a bit at the code wondering if the structure layouts
> were incorrect so we were somehow traversing one of the other module lists
> with a different ordering, but everything looks correct.
> 
> The attached might be a good idea, then, to ensure that module+offset is
> calculated correctly.

Good idea, please push.


Corinna

> From ea47826047e8bb175b1b0e0286d7d7b8cf15c7fe Mon Sep 17 00:00:00 2001
> From: Jon Turney <jon.turney@dronecode.org.uk>
> Date: Tue, 1 Nov 2022 14:01:08 +0000
> Subject: [PATCH] Cygwin: Handle out of order modules for module offsets in
>  stackdump
> 
> Improve address to module+offset conversion, to work correctly in the
> presence of out-of-order elements in InMemoryOrderModuleList.
> 
> Fixes: d59651d4
> ---
>  winsup/cygwin/exceptions.cc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index 8cc454c90..c3433ab94 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -342,11 +342,13 @@ prettyprint_va (PVOID func_va)
>      {
>        PLDR_DATA_TABLE_ENTRY mod = CONTAINING_RECORD (x, LDR_DATA_TABLE_ENTRY,
>  						     InMemoryOrderLinks);
> -      if (mod->DllBase > func_va)
> +      if ((func_va < mod->DllBase) ||
> +	  (func_va > (PVOID)((DWORD_PTR)mod->DllBase + mod->SizeOfImage)))
>  	continue;
>  
>        __small_sprintf (buf, "%S+0x%x", &mod->BaseDllName,
>  		       (DWORD_PTR)func_va - (DWORD_PTR)mod->DllBase);
> +      break;
>      }
>  
>    return buf;
> -- 
> 2.38.1
> 

