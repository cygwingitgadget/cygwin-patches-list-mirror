Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	by sourceware.org (Postfix) with ESMTPS id 7A4203858D28
	for <cygwin-patches@cygwin.com>; Tue, 31 Jan 2023 09:23:33 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M593i-1pNsn91tXo-0018di for <cygwin-patches@cygwin.com>; Tue, 31 Jan 2023
 10:23:31 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5BAB9A81B7B; Tue, 31 Jan 2023 10:23:30 +0100 (CET)
Date: Tue, 31 Jan 2023 10:23:30 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: winsup/cygwin/sys/termios.h bit rates extension
Message-ID: <Y9jeErJ8hncUdoQb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3a9a7529-a8ee-6681-8838-37025e3fd809@Shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a9a7529-a8ee-6681-8838-37025e3fd809@Shaw.ca>
X-Provags-ID: V03:K1:PRKxHq1H7jeEHQYS0ds4Zke0KK6WwO5xC5+e0+hbirydfQVg0kw
 RT/LpRtwOXDQGfjQY9bk349f2TJi67by3Y1FBXDTS/uQabEjUR7zKEC6bseHDZ3Jf9JVm5V
 fQk3aHOoJKpj81aL9pg/EWZsxpWH7/TwaNWOCxK1HZ3P2vfT7rkY+8hq7FeUq3q72/qiKAr
 ouZoXsJafUPmw5CmRQo+g==
UI-OutboundReport: notjunk:1;M01:P0:DUmDPVW73yc=;SeKvFIuPjcUvilYv2U2+KV99Jms
 0LMGKOCX2GlC6D0fqqgE7hFGSMcg93kCBImnCSVIOaLi5dGw6/tPKh1f5RkQK3r/LMEeaxGR3
 uC786xFPIs+d0oDOTbpPwnWnwCvwU+OR4IZUPpdMenzpi1HDeeDSBXlbDNHbTieV7yKigCK3F
 yAplOEm2LKcl7zF/qGUkWPmQ0f8AHMMxpqm5i8VoEoH6sMhAnT9pFLOy295/Oq9H6bg+UVPaW
 +ROhSXSFicgqStOjYsSD1aBSkH2IdTShZmN1H86rf1IxH2khpoV6fA0YbLQzAde3wgDMfWvZB
 FclgNHtGGS6H0/tKHNqC6Hyzp6bP5nAo/ePgUmPTItZyrlXKt8+jNSKhpeZoHaVl2IWw386aR
 xrurI4ljmOSkyNXIqU8vJLdwOVEip3m2MutQuGz7ieFlifKoWDVeDYvyOS4ENHB2evdPrDd4w
 hl879yfxyDKvaB5oVoUFd9Z1BY+/fM/FHEEqYaEyZDvBQV+djmjuPeP1iFmBnIRm1Pa5RjLu1
 s9Y8hfivXN2wEXnd+bHetPAMFHh/uTjrDEu6etT4jN13Tz/zZBmr9mJWvPqWXtRCV9gXE/HTZ
 yxqjeZT2RjADYfxc0RwltEAME3YgRFjTMdc87yUFDNW1PTyMAf/4HU6yR53DOjWVt8+Z+sTue
 EpmLg/nbyH8AZempqwNszutOOufmZQnomQxaxbL+9Q==
X-Spam-Status: No, score=-97.1 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Jan 29 22:57, Brian Inglis wrote:
> FreeBSD, NetBSD, and Linux all bumped their serial bit rates to support
> 500k(+500k)4000k, extending the rates to 3500k and 4000k, dropping 128k and
> 256k, renumbering the extended baud rate indices under Linux, effectively
> changing the ABI for any previously compiled serial application.
> 
> See:
> https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/include/sys/termios.h;hb=HEAD#l189
> 
> Patch would be like:
> diff a/winsup/cygwin/include/sys/termios.h b/winsup/cygwin/include/sys/termios.h
> --- a/winsup/cygwin/include/sys/termios.h
> +++ b/winsup/cygwin/include/sys/termios.h
> @@ -190,19 +190,19
>  #define CBAUDEX  0x0100f
>  #define B57600	  0x01001
>  #define B115200  0x01002
> -#define B128000  0x01003
> -#define B230400  0x01004
> +#define B230400  0x01003
> -#define B256000  0x01005
> -#define B460800  0x01006
> +#define B460800  0x01004
> -#define B500000  0x01007
> +#define B500000  0x01005
> -#define B576000  0x01008
> +#define B576000  0x01006
> -#define B921600  0x01009
> +#define B921600  0x01007
> -#define B1000000 0x0100a
> +#define B1000000 0x01008
> -#define B1152000 0x0100b
> +#define B1152000 0x01009
> -#define B1500000 0x0100c
> +#define B1500000 0x0100a
> -#define B2000000 0x0100d
> +#define B2000000 0x0100b
> -#define B2500000 0x0100e
> +#define B2500000 0x0100c
> -#define B3000000 0x0100f
> +#define B3000000 0x0100d
> +#define B3500000 0x0100e
> +#define B4000000 0x0100f
> 
>  #define CRTSXOFF 0x04000
>  #define CRTSCTS  0x08000
> 
> Is this acceptable, not really any issue for Cygwin, or an issue, and some
> compatibility code would be required to do an internal upgrade, and return
> an error for unsupported speeds, or should we add another bit to extend
> CBAUD/CBAUDEX to 0x0101f, and use higher indices 0x01010/0x01011?

We'd need a compat layer, depending on the version of Cygwin
the executable has been created under (see include/sys/cygwin.h).

Just extending CBAUD/CBAUDEX. isn't an option because all bits
in cflags are taken, afaics.

However, afaics our CBAUDEX is defined incorrectly.  The BSDs define it
as LINUX_CBAUDEX, because it's apparently not a BSD idea.  And per
Linux, it should only contain the mask bit which defines extended
speeds, so

  #define CBAUD    0x0100f
  #define CBAUDEX  0x01000

would be the right (i. e., Linux-compatible).


Corinna
