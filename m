Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	by sourceware.org (Postfix) with ESMTPS id 9B7743858D3C
	for <cygwin-patches@cygwin.com>; Sat, 29 Oct 2022 08:33:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9B7743858D3C
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N49xZ-1pF84a1wCP-0101U7; Sat, 29 Oct 2022 10:32:53 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9A162A80A3C; Sat, 29 Oct 2022 10:32:52 +0200 (CEST)
Date: Sat, 29 Oct 2022 10:32:52 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: Add loaded module base address list to
 stackdump
Message-ID: <Y1zlNBjeblW9dvfW@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
	cygwin-patches@cygwin.com
References: <20221028150558.2300-1-jon.turney@dronecode.org.uk>
 <20221028150558.2300-4-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221028150558.2300-4-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:PxrIxgl8+bye4FHg6C6RFvb4ZRZBiZRiZm2+uIQnz7WI+zaskSn
 2TXTfZmjGDzJY1GUbsNHg2KLKv8H5EVfUKmT7KLklzHmCp0AEfyVIOUerdXXuhALiFjUJd7
 XxTHO+sIL9gnnBEfZJMMkjaFf8wsa+PEN0nL002rBB39FJ5Bwrzj25evgBqhF+07ZRKmY2m
 pRRAGqteWEegUm+SFk6pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7bagk3RoAIk=:lv6Or394lVkQ7KCwvfv7qz
 Lstm6Iha6rVguG5/AMvh7YyhbQLgQjjcvHYmU+TVHf6igYpRE+T6786vS/0ZjIUQkY7GdzgvP
 FdBBG1eL1CYT5Ra4q4q7NpQyIsANbSsf2ZcpGu7zTj9nDWOjFRthFW4J4BA7Io14SckBhRkdp
 XLjsgM0xsvBRK8MrfZpOXHxMpSpCMk9F2KNLZOba2e0pjWnO2JebNjfN548IoV9U/OH8/l177
 i6OLrBEKbHij4B3jjZ25nrbIyRxfnrcGSvAwmftzfPy3Ona0iuokPrnIL9ETSnBjTOAX/YclB
 cMs8+nFzhhZDHAa1wwchrWFmnxeJVEmkyXVEejcUkqoi+bAjCaTMEg1TCQLqAfvuWHgbAWK6w
 mC7amTIOBpE/vWx2QLcz8stPIwjBPXWEbIsdOotWSAO3EH8XTln+kvVw2a8/YHTOfPLkL20HB
 kqQFVbpnAMsCUywXdTGW+2yPVAqweIqkTNqNvji34VAcfTbxrlxmg8D8drXD7F0X7ez99+bVr
 lUNFOexaF8O+bx8LvheEuEZmz8b5harg2ezijEWHTL/SNJcstdK4kDCpeCCYPr+UfhKapj3jM
 diImkoVUSRH3nnyQzd3DLiNZbizHUfO3KrS+elElGsVuC2u90CCEzsWxaDCpnuXKEkMWCTEr1
 LjVWOT0RRcaMokVcRG5IE4R+O3v2gWbxdNbf9ATOGepssOIHLMRuWXADt2yHRLCL+pIYtkIKV
 bZpL5scZ81jgCiz7/z5Nr9AG7x44SnAtH7KiMxDGqVIgpzgDRyetbmC10d4XPQw2l6WHmqvKd
 hPNmDlZ1amHrKVCqXugadCtifZBAg==
X-Spam-Status: No, score=-101.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Oct 28 16:05, Jon Turney wrote:
> This adds an extra section to the stackdump, which lists the loaded
> modules and their base address.  This is perhaps useful as it makes it
> immediately clear if RandomCrashInjectedDll.dll is loaded...
> 
> XXX: It seems like the 'InMemoryOrder' part of 'InMemoryOrderModuleList' is a lie?

Probably just an alternative fact...

> 
> > Loaded modules
> > 000100400000 segv-test.exe
> > 7FFF2AC30000 ntdll.dll
> > 7FFF29050000 KERNEL32.DLL
> > 7FFF28800000 KERNELBASE.dll
> > 000180040000 cygwin1.dll
> > 7FFF28FA0000 advapi32.dll
> > 7FFF29F20000 msvcrt.dll
> > 7FFF299E0000 sechost.dll
> > 7FFF29B30000 RPCRT4.dll
> > 7FFF27C10000 CRYPTBASE.DLL
> > 7FFF28770000 bcryptPrimitives.dll
> ---
>  winsup/cygwin/exceptions.cc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index 1e9ea26bf..7dde44140 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -383,6 +383,16 @@ cygwin_exception::dumpstack ()
>        small_printf ("End of stack trace%s\r\n",
>  		    i == DUMPSTACK_FRAME_LIMIT ?
>  		    " (more stack frames may be present)" : "");
> +
> +      small_printf ("Loaded modules\r\n");
> +      PLIST_ENTRY head = &NtCurrentTeb()->Peb->Ldr->InMemoryOrderModuleList;
> +      for (PLIST_ENTRY x = head->Flink; x != head; x = x->Flink)
> +	{
> +	  PLDR_DATA_TABLE_ENTRY mod = CONTAINING_RECORD (x, LDR_DATA_TABLE_ENTRY,
> +							 InMemoryOrderLinks);
> +	  small_printf ("%012X %S\r\n", mod->DllBase, &mod->BaseDllName);
> +	}
> +
>        if (h)
>  	NtClose (h);
>      }
> -- 
> 2.38.1
