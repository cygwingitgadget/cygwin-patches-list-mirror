Return-Path: <SRS0=zLbh=H4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.185])
	by sourceware.org (Postfix) with ESMTPS id 340054BA5436
	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2026 12:37:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 340054BA5436
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 340054BA5436
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.185
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791290271; cv=none;
	b=gEiYPBzbXA1idnu2pqTtIzlDwp/l/D3TEeFD+bajVPOv8w1QSEPQHgZ/zxJm3vnlgrTQbJzGUqx7iNlJLgFyWvlKqtUdKWaYSrgU3kPkQ1oRo5B3lsDiDiYQAydB0LkDITgBTS2WYJOZoD9JOObaavgKTqxMoOO4F5eKIncNy7c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791290271; c=relaxed/simple;
	bh=t9kr6QjbNAk84rkmcRpFKve58ybjWM1cSj5uCXaEt4w=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=cJrZpi/L+58LASpUpOxTj6iB050AlCdItjrviH82VMuyT2iOlVWcTgyinIX7BE8XerCYD/0heTNZCz6XHlhvHnjoE+mLm0ENcH4E00SqeUUzKtLhx/8jRMpQ1sjKTdztfy8Vxkw4KlwGH6FOf7XZyGBlV0yQGA2RArGuyWBQSrk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nIfy3XTc
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 340054BA5436
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nIfy3XTc
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20261006123747044.VFXZ.60338.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 6 Oct 2026 21:37:47 +0900
Date: Tue, 6 Oct 2026 21:37:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: playmidi (Re: [PATCH] Cygwin: sequencer: Implement /dev/sequencer)
Message-Id: <20261006213749.c4566d29130124cbad6bab8f@nifty.ne.jp>
In-Reply-To: <20261006123131.99528-1-takashi.yano@nifty.ne.jp>
References: <20261006123131.99528-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__6_Oct_2026_21_37_49_+0900_+Tqtf5ILM5FQEaNx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1791290267;
 bh=zUGztCXm8lUfZxZ/J+R/1acUWcI8YOrPDYnhpkPV+Kk=;
 h=Date:From:To:Subject:In-Reply-To;
 b=nIfy3XTcyQeUBrNCQ28YoaEjyP8O2U4roWJFBtAw9q8Fp16cnsW9dE2N04iRcuX22DoZ70xu
 tlBncEEk0/LuGfH5dDevX88+mcxsiCBm0wnYJMDA4PbTOsgeTgDi36CNVoi09R+du/Fd8w5wjg
 Qfd40To7Hw2bfLZp/hLHb1V3joymnrAA5dkN6Z6ip9rjddAgjs3Gwwu5Z7pPvMjZMpkPZ9xbd+
 sadKYvbecYgNPxurN3Cu57Kf3xfUssIN/Aqx8B2Hn/TBrOifFo+wPrCVRNN5S57/lol19NUTFH
 xpLV2wQg9fzHlKcHmjNSvBcdi7ennL6323hK7nJtiR5b11cw==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Tue__6_Oct_2026_21_37_49_+0900_+Tqtf5ILM5FQEaNx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

For testing /dev/sequencer, a simple MIDI file player attached
can be used. If no external MIDI port is found, it falls-back to
"Microsoft GS Wavetable Synth".

Any suggestions would be appreciated.

On Tue,  6 Oct 2026 21:31:17 +0900
Takashi Yano wrote:
> This is an experimental implementation of /dev/sequencer for the
> external MIDI devices. Currently, only output is supported.
> 
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/Makefile.am               |   1 +
>  winsup/cygwin/autoload.cc               |   7 +
>  winsup/cygwin/devices.cc                | 847 ++++++++++++------------
>  winsup/cygwin/devices.in                |   1 +
>  winsup/cygwin/dtable.cc                 |   3 +
>  winsup/cygwin/fhandler/sequencer.cc     | 452 +++++++++++++
>  winsup/cygwin/local_includes/devices.h  |   1 +
>  winsup/cygwin/local_includes/fhandler.h |  52 ++
>  8 files changed, 953 insertions(+), 411 deletions(-)
>  create mode 100644 winsup/cygwin/fhandler/sequencer.cc
> 
> diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
> index 22b7b14bd..e86cbf5b6 100644
> --- a/winsup/cygwin/Makefile.am
> +++ b/winsup/cygwin/Makefile.am
> @@ -114,6 +114,7 @@ FHANDLER_FILES= \
>  	fhandler/raw.cc \
>  	fhandler/registry.cc \
>  	fhandler/serial.cc \
> +	fhandler/sequencer.cc \
>  	fhandler/signalfd.cc \
>  	fhandler/socket.cc \
>  	fhandler/socket_inet.cc \
> diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
> index 7054511b6..769005a3f 100644
> --- a/winsup/cygwin/autoload.cc
> +++ b/winsup/cygwin/autoload.cc
> @@ -730,6 +730,13 @@ LoadDLLfuncEx3 (waveOutUnprepareHeader, winmm, 1, 0, 1)
>  LoadDLLfuncEx3 (waveOutWrite, winmm, 1, 0, 1)
>  LoadDLLfuncEx3 (waveOutMessage, winmm, 1, 0, 1)
>  LoadDLLfuncEx3 (waveOutGetDevCapsA, winmm, 1, 0, 1)
> +LoadDLLfuncEx3 (midiOutGetNumDevs, winmm, 1, 0, 1)
> +LoadDLLfuncEx3 (midiOutOpen, winmm, 1, 0, 1)
> +LoadDLLfuncEx3 (midiOutClose, winmm, 1, 0, 1)
> +LoadDLLfuncEx3 (midiOutShortMsg, winmm, 1, 0, 1)
> +LoadDLLfuncEx3 (midiOutLongMsg, winmm, 1, 0, 1)
> +LoadDLLfuncEx3 (midiOutPrepareHeader, winmm, 1, 0, 1)
> +LoadDLLfuncEx3 (midiOutUnprepareHeader, winmm, 1, 0, 1)
>  
>  LoadDLLfunc (accept, ws2_32)
>  LoadDLLfunc (bind, ws2_32)
> diff --git a/winsup/cygwin/devices.cc b/winsup/cygwin/devices.cc
> index 6eb6a41d1..539193316 100644
> --- a/winsup/cygwin/devices.cc
> +++ b/winsup/cygwin/devices.cc
> @@ -605,6 +605,7 @@ const _RDATA _device dev_storage[] =
>    {"/dev/scd13", BRACK(FHDEV(DEV_CDROM_MAJOR, 13)), "\\Device\\CdRom13", exists_ntdev, S_IFBLK, true},
>    {"/dev/scd14", BRACK(FHDEV(DEV_CDROM_MAJOR, 14)), "\\Device\\CdRom14", exists_ntdev, S_IFBLK, true},
>    {"/dev/scd15", BRACK(FHDEV(DEV_CDROM_MAJOR, 15)), "\\Device\\CdRom15", exists_ntdev, S_IFBLK, true},
> +  {"/dev/sequencer", BRACK(FH_OSS_SEQUENCER), "\\Device\\Null", exists_ntdev, S_IFCHR, true},
>    {"/dev/sr0", BRACK(FHDEV(DEV_CDROM_MAJOR, 0)), "\\Device\\CdRom0", exists_ntdev, S_IFBLK, true},
>    {"/dev/sr1", BRACK(FHDEV(DEV_CDROM_MAJOR, 1)), "\\Device\\CdRom1", exists_ntdev, S_IFBLK, true},
>    {"/dev/sr2", BRACK(FHDEV(DEV_CDROM_MAJOR, 2)), "\\Device\\CdRom2", exists_ntdev, S_IFBLK, true},
> @@ -1018,9 +1019,9 @@ const _RDATA _device dev_storage[] =
>  
>  const _device *cons_dev = dev_storage + 20;
>  const _device *console_dev = dev_storage + 148;
> -const _device *ptym_dev = dev_storage + 726;
> +const _device *ptym_dev = dev_storage + 727;
>  const _device *ptys_dev = dev_storage + 300;
> -const _device *urandom_dev = dev_storage + 721;
> +const _device *urandom_dev = dev_storage + 722;
>  
>  
>  static KR_device_t KR_find_keyword (const char *KR_keyword, int KR_length)
> @@ -1050,7 +1051,7 @@ return	NULL;
>            if (strncmp (KR_keyword, ":pipe", 5) == 0)
>              {
>  {
> -return dev_storage + 725;
> +return dev_storage + 726;
>  
>  }
>              }
> @@ -1065,7 +1066,7 @@ return	NULL;
>            if (strncmp (KR_keyword, ":fifo", 5) == 0)
>              {
>  {
> -return dev_storage + 724;
> +return dev_storage + 725;
>  
>  }
>              }
> @@ -1089,7 +1090,7 @@ return	NULL;
>            if (strncmp (KR_keyword, ":ptym9", 6) == 0)
>              {
>  {
> -return dev_storage + 735;
> +return dev_storage + 736;
>  
>  }
>              }
> @@ -1104,7 +1105,7 @@ return	NULL;
>            if (strncmp (KR_keyword, ":ptym8", 6) == 0)
>              {
>  {
> -return dev_storage + 734;
> +return dev_storage + 735;
>  
>  }
>              }
> @@ -1119,7 +1120,7 @@ return	NULL;
>            if (strncmp (KR_keyword, ":ptym7", 6) == 0)
>              {
>  {
> -return dev_storage + 733;
> +return dev_storage + 734;
>  
>  }
>              }
> @@ -1134,7 +1135,7 @@ return	NULL;
>            if (strncmp (KR_keyword, ":ptym6", 6) == 0)
>              {
>  {
> -return dev_storage + 732;
> +return dev_storage + 733;
>  
>  }
>              }
> @@ -1149,7 +1150,7 @@ return	NULL;
>            if (strncmp (KR_keyword, ":ptym5", 6) == 0)
>              {
>  {
> -return dev_storage + 731;
> +return dev_storage + 732;
>  
>  }
>              }
> @@ -1164,7 +1165,7 @@ return	NULL;
>            if (strncmp (KR_keyword, ":ptym4", 6) == 0)
>              {
>  {
> -return dev_storage + 730;
> +return dev_storage + 731;
>  
>  }
>              }
> @@ -1179,7 +1180,7 @@ return	NULL;
>            if (strncmp (KR_keyword, ":ptym3", 6) == 0)
>              {
>  {
> -return dev_storage + 729;
> +return dev_storage + 730;
>  
>  }
>              }
> @@ -1194,7 +1195,7 @@ return	NULL;
>            if (strncmp (KR_keyword, ":ptym2", 6) == 0)
>              {
>  {
> -return dev_storage + 728;
> +return dev_storage + 729;
>  
>  }
>              }
> @@ -1209,7 +1210,7 @@ return	NULL;
>            if (strncmp (KR_keyword, ":ptym1", 6) == 0)
>              {
>  {
> -return dev_storage + 727;
> +return dev_storage + 728;
>  
>  }
>              }
> @@ -1224,7 +1225,7 @@ return	NULL;
>            if (strncmp (KR_keyword, ":ptym0", 6) == 0)
>              {
>  {
> -return dev_storage + 726;
> +return dev_storage + 727;
>  
>  }
>              }
> @@ -1266,7 +1267,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym99", 7) == 0)
>                  {
>  {
> -return dev_storage + 825;
> +return dev_storage + 826;
>  
>  }
>                  }
> @@ -1281,7 +1282,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym98", 7) == 0)
>                  {
>  {
> -return dev_storage + 824;
> +return dev_storage + 825;
>  
>  }
>                  }
> @@ -1296,7 +1297,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym97", 7) == 0)
>                  {
>  {
> -return dev_storage + 823;
> +return dev_storage + 824;
>  
>  }
>                  }
> @@ -1311,7 +1312,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym96", 7) == 0)
>                  {
>  {
> -return dev_storage + 822;
> +return dev_storage + 823;
>  
>  }
>                  }
> @@ -1326,7 +1327,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym95", 7) == 0)
>                  {
>  {
> -return dev_storage + 821;
> +return dev_storage + 822;
>  
>  }
>                  }
> @@ -1341,7 +1342,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym94", 7) == 0)
>                  {
>  {
> -return dev_storage + 820;
> +return dev_storage + 821;
>  
>  }
>                  }
> @@ -1356,7 +1357,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym93", 7) == 0)
>                  {
>  {
> -return dev_storage + 819;
> +return dev_storage + 820;
>  
>  }
>                  }
> @@ -1371,7 +1372,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym92", 7) == 0)
>                  {
>  {
> -return dev_storage + 818;
> +return dev_storage + 819;
>  
>  }
>                  }
> @@ -1386,7 +1387,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym91", 7) == 0)
>                  {
>  {
> -return dev_storage + 817;
> +return dev_storage + 818;
>  
>  }
>                  }
> @@ -1401,7 +1402,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym90", 7) == 0)
>                  {
>  {
> -return dev_storage + 816;
> +return dev_storage + 817;
>  
>  }
>                  }
> @@ -1425,7 +1426,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym89", 7) == 0)
>                  {
>  {
> -return dev_storage + 815;
> +return dev_storage + 816;
>  
>  }
>                  }
> @@ -1440,7 +1441,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym88", 7) == 0)
>                  {
>  {
> -return dev_storage + 814;
> +return dev_storage + 815;
>  
>  }
>                  }
> @@ -1455,7 +1456,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym87", 7) == 0)
>                  {
>  {
> -return dev_storage + 813;
> +return dev_storage + 814;
>  
>  }
>                  }
> @@ -1470,7 +1471,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym86", 7) == 0)
>                  {
>  {
> -return dev_storage + 812;
> +return dev_storage + 813;
>  
>  }
>                  }
> @@ -1485,7 +1486,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym85", 7) == 0)
>                  {
>  {
> -return dev_storage + 811;
> +return dev_storage + 812;
>  
>  }
>                  }
> @@ -1500,7 +1501,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym84", 7) == 0)
>                  {
>  {
> -return dev_storage + 810;
> +return dev_storage + 811;
>  
>  }
>                  }
> @@ -1515,7 +1516,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym83", 7) == 0)
>                  {
>  {
> -return dev_storage + 809;
> +return dev_storage + 810;
>  
>  }
>                  }
> @@ -1530,7 +1531,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym82", 7) == 0)
>                  {
>  {
> -return dev_storage + 808;
> +return dev_storage + 809;
>  
>  }
>                  }
> @@ -1545,7 +1546,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym81", 7) == 0)
>                  {
>  {
> -return dev_storage + 807;
> +return dev_storage + 808;
>  
>  }
>                  }
> @@ -1560,7 +1561,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym80", 7) == 0)
>                  {
>  {
> -return dev_storage + 806;
> +return dev_storage + 807;
>  
>  }
>                  }
> @@ -1584,7 +1585,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym79", 7) == 0)
>                  {
>  {
> -return dev_storage + 805;
> +return dev_storage + 806;
>  
>  }
>                  }
> @@ -1599,7 +1600,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym78", 7) == 0)
>                  {
>  {
> -return dev_storage + 804;
> +return dev_storage + 805;
>  
>  }
>                  }
> @@ -1614,7 +1615,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym77", 7) == 0)
>                  {
>  {
> -return dev_storage + 803;
> +return dev_storage + 804;
>  
>  }
>                  }
> @@ -1629,7 +1630,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym76", 7) == 0)
>                  {
>  {
> -return dev_storage + 802;
> +return dev_storage + 803;
>  
>  }
>                  }
> @@ -1644,7 +1645,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym75", 7) == 0)
>                  {
>  {
> -return dev_storage + 801;
> +return dev_storage + 802;
>  
>  }
>                  }
> @@ -1659,7 +1660,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym74", 7) == 0)
>                  {
>  {
> -return dev_storage + 800;
> +return dev_storage + 801;
>  
>  }
>                  }
> @@ -1674,7 +1675,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym73", 7) == 0)
>                  {
>  {
> -return dev_storage + 799;
> +return dev_storage + 800;
>  
>  }
>                  }
> @@ -1689,7 +1690,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym72", 7) == 0)
>                  {
>  {
> -return dev_storage + 798;
> +return dev_storage + 799;
>  
>  }
>                  }
> @@ -1704,7 +1705,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym71", 7) == 0)
>                  {
>  {
> -return dev_storage + 797;
> +return dev_storage + 798;
>  
>  }
>                  }
> @@ -1719,7 +1720,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym70", 7) == 0)
>                  {
>  {
> -return dev_storage + 796;
> +return dev_storage + 797;
>  
>  }
>                  }
> @@ -1743,7 +1744,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym69", 7) == 0)
>                  {
>  {
> -return dev_storage + 795;
> +return dev_storage + 796;
>  
>  }
>                  }
> @@ -1758,7 +1759,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym68", 7) == 0)
>                  {
>  {
> -return dev_storage + 794;
> +return dev_storage + 795;
>  
>  }
>                  }
> @@ -1773,7 +1774,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym67", 7) == 0)
>                  {
>  {
> -return dev_storage + 793;
> +return dev_storage + 794;
>  
>  }
>                  }
> @@ -1788,7 +1789,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym66", 7) == 0)
>                  {
>  {
> -return dev_storage + 792;
> +return dev_storage + 793;
>  
>  }
>                  }
> @@ -1803,7 +1804,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym65", 7) == 0)
>                  {
>  {
> -return dev_storage + 791;
> +return dev_storage + 792;
>  
>  }
>                  }
> @@ -1818,7 +1819,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym64", 7) == 0)
>                  {
>  {
> -return dev_storage + 790;
> +return dev_storage + 791;
>  
>  }
>                  }
> @@ -1833,7 +1834,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym63", 7) == 0)
>                  {
>  {
> -return dev_storage + 789;
> +return dev_storage + 790;
>  
>  }
>                  }
> @@ -1848,7 +1849,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym62", 7) == 0)
>                  {
>  {
> -return dev_storage + 788;
> +return dev_storage + 789;
>  
>  }
>                  }
> @@ -1863,7 +1864,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym61", 7) == 0)
>                  {
>  {
> -return dev_storage + 787;
> +return dev_storage + 788;
>  
>  }
>                  }
> @@ -1878,7 +1879,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym60", 7) == 0)
>                  {
>  {
> -return dev_storage + 786;
> +return dev_storage + 787;
>  
>  }
>                  }
> @@ -1902,7 +1903,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym59", 7) == 0)
>                  {
>  {
> -return dev_storage + 785;
> +return dev_storage + 786;
>  
>  }
>                  }
> @@ -1917,7 +1918,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym58", 7) == 0)
>                  {
>  {
> -return dev_storage + 784;
> +return dev_storage + 785;
>  
>  }
>                  }
> @@ -1932,7 +1933,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym57", 7) == 0)
>                  {
>  {
> -return dev_storage + 783;
> +return dev_storage + 784;
>  
>  }
>                  }
> @@ -1947,7 +1948,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym56", 7) == 0)
>                  {
>  {
> -return dev_storage + 782;
> +return dev_storage + 783;
>  
>  }
>                  }
> @@ -1962,7 +1963,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym55", 7) == 0)
>                  {
>  {
> -return dev_storage + 781;
> +return dev_storage + 782;
>  
>  }
>                  }
> @@ -1977,7 +1978,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym54", 7) == 0)
>                  {
>  {
> -return dev_storage + 780;
> +return dev_storage + 781;
>  
>  }
>                  }
> @@ -1992,7 +1993,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym53", 7) == 0)
>                  {
>  {
> -return dev_storage + 779;
> +return dev_storage + 780;
>  
>  }
>                  }
> @@ -2007,7 +2008,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym52", 7) == 0)
>                  {
>  {
> -return dev_storage + 778;
> +return dev_storage + 779;
>  
>  }
>                  }
> @@ -2022,7 +2023,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym51", 7) == 0)
>                  {
>  {
> -return dev_storage + 777;
> +return dev_storage + 778;
>  
>  }
>                  }
> @@ -2037,7 +2038,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym50", 7) == 0)
>                  {
>  {
> -return dev_storage + 776;
> +return dev_storage + 777;
>  
>  }
>                  }
> @@ -2061,7 +2062,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym49", 7) == 0)
>                  {
>  {
> -return dev_storage + 775;
> +return dev_storage + 776;
>  
>  }
>                  }
> @@ -2076,7 +2077,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym48", 7) == 0)
>                  {
>  {
> -return dev_storage + 774;
> +return dev_storage + 775;
>  
>  }
>                  }
> @@ -2091,7 +2092,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym47", 7) == 0)
>                  {
>  {
> -return dev_storage + 773;
> +return dev_storage + 774;
>  
>  }
>                  }
> @@ -2106,7 +2107,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym46", 7) == 0)
>                  {
>  {
> -return dev_storage + 772;
> +return dev_storage + 773;
>  
>  }
>                  }
> @@ -2121,7 +2122,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym45", 7) == 0)
>                  {
>  {
> -return dev_storage + 771;
> +return dev_storage + 772;
>  
>  }
>                  }
> @@ -2136,7 +2137,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym44", 7) == 0)
>                  {
>  {
> -return dev_storage + 770;
> +return dev_storage + 771;
>  
>  }
>                  }
> @@ -2151,7 +2152,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym43", 7) == 0)
>                  {
>  {
> -return dev_storage + 769;
> +return dev_storage + 770;
>  
>  }
>                  }
> @@ -2166,7 +2167,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym42", 7) == 0)
>                  {
>  {
> -return dev_storage + 768;
> +return dev_storage + 769;
>  
>  }
>                  }
> @@ -2181,7 +2182,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym41", 7) == 0)
>                  {
>  {
> -return dev_storage + 767;
> +return dev_storage + 768;
>  
>  }
>                  }
> @@ -2196,7 +2197,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym40", 7) == 0)
>                  {
>  {
> -return dev_storage + 766;
> +return dev_storage + 767;
>  
>  }
>                  }
> @@ -2220,7 +2221,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym39", 7) == 0)
>                  {
>  {
> -return dev_storage + 765;
> +return dev_storage + 766;
>  
>  }
>                  }
> @@ -2235,7 +2236,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym38", 7) == 0)
>                  {
>  {
> -return dev_storage + 764;
> +return dev_storage + 765;
>  
>  }
>                  }
> @@ -2250,7 +2251,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym37", 7) == 0)
>                  {
>  {
> -return dev_storage + 763;
> +return dev_storage + 764;
>  
>  }
>                  }
> @@ -2265,7 +2266,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym36", 7) == 0)
>                  {
>  {
> -return dev_storage + 762;
> +return dev_storage + 763;
>  
>  }
>                  }
> @@ -2280,7 +2281,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym35", 7) == 0)
>                  {
>  {
> -return dev_storage + 761;
> +return dev_storage + 762;
>  
>  }
>                  }
> @@ -2295,7 +2296,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym34", 7) == 0)
>                  {
>  {
> -return dev_storage + 760;
> +return dev_storage + 761;
>  
>  }
>                  }
> @@ -2310,7 +2311,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym33", 7) == 0)
>                  {
>  {
> -return dev_storage + 759;
> +return dev_storage + 760;
>  
>  }
>                  }
> @@ -2325,7 +2326,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym32", 7) == 0)
>                  {
>  {
> -return dev_storage + 758;
> +return dev_storage + 759;
>  
>  }
>                  }
> @@ -2340,7 +2341,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym31", 7) == 0)
>                  {
>  {
> -return dev_storage + 757;
> +return dev_storage + 758;
>  
>  }
>                  }
> @@ -2355,7 +2356,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym30", 7) == 0)
>                  {
>  {
> -return dev_storage + 756;
> +return dev_storage + 757;
>  
>  }
>                  }
> @@ -2379,7 +2380,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym29", 7) == 0)
>                  {
>  {
> -return dev_storage + 755;
> +return dev_storage + 756;
>  
>  }
>                  }
> @@ -2394,7 +2395,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym28", 7) == 0)
>                  {
>  {
> -return dev_storage + 754;
> +return dev_storage + 755;
>  
>  }
>                  }
> @@ -2409,7 +2410,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym27", 7) == 0)
>                  {
>  {
> -return dev_storage + 753;
> +return dev_storage + 754;
>  
>  }
>                  }
> @@ -2424,7 +2425,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym26", 7) == 0)
>                  {
>  {
> -return dev_storage + 752;
> +return dev_storage + 753;
>  
>  }
>                  }
> @@ -2439,7 +2440,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym25", 7) == 0)
>                  {
>  {
> -return dev_storage + 751;
> +return dev_storage + 752;
>  
>  }
>                  }
> @@ -2454,7 +2455,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym24", 7) == 0)
>                  {
>  {
> -return dev_storage + 750;
> +return dev_storage + 751;
>  
>  }
>                  }
> @@ -2469,7 +2470,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym23", 7) == 0)
>                  {
>  {
> -return dev_storage + 749;
> +return dev_storage + 750;
>  
>  }
>                  }
> @@ -2484,7 +2485,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym22", 7) == 0)
>                  {
>  {
> -return dev_storage + 748;
> +return dev_storage + 749;
>  
>  }
>                  }
> @@ -2499,7 +2500,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym21", 7) == 0)
>                  {
>  {
> -return dev_storage + 747;
> +return dev_storage + 748;
>  
>  }
>                  }
> @@ -2514,7 +2515,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym20", 7) == 0)
>                  {
>  {
> -return dev_storage + 746;
> +return dev_storage + 747;
>  
>  }
>                  }
> @@ -2538,7 +2539,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym19", 7) == 0)
>                  {
>  {
> -return dev_storage + 745;
> +return dev_storage + 746;
>  
>  }
>                  }
> @@ -2553,7 +2554,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym18", 7) == 0)
>                  {
>  {
> -return dev_storage + 744;
> +return dev_storage + 745;
>  
>  }
>                  }
> @@ -2568,7 +2569,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym17", 7) == 0)
>                  {
>  {
> -return dev_storage + 743;
> +return dev_storage + 744;
>  
>  }
>                  }
> @@ -2583,7 +2584,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym16", 7) == 0)
>                  {
>  {
> -return dev_storage + 742;
> +return dev_storage + 743;
>  
>  }
>                  }
> @@ -2598,7 +2599,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym15", 7) == 0)
>                  {
>  {
> -return dev_storage + 741;
> +return dev_storage + 742;
>  
>  }
>                  }
> @@ -2613,7 +2614,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym14", 7) == 0)
>                  {
>  {
> -return dev_storage + 740;
> +return dev_storage + 741;
>  
>  }
>                  }
> @@ -2628,7 +2629,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym13", 7) == 0)
>                  {
>  {
> -return dev_storage + 739;
> +return dev_storage + 740;
>  
>  }
>                  }
> @@ -2643,7 +2644,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym12", 7) == 0)
>                  {
>  {
> -return dev_storage + 738;
> +return dev_storage + 739;
>  
>  }
>                  }
> @@ -2658,7 +2659,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym11", 7) == 0)
>                  {
>  {
> -return dev_storage + 737;
> +return dev_storage + 738;
>  
>  }
>                  }
> @@ -2673,7 +2674,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym10", 7) == 0)
>                  {
>  {
> -return dev_storage + 736;
> +return dev_storage + 737;
>  
>  }
>                  }
> @@ -2703,7 +2704,7 @@ return	NULL;
>            if (strncmp (KR_keyword, "/dev/tty", 8) == 0)
>              {
>  {
> -return dev_storage + 592;
> +return dev_storage + 593;
>  
>  }
>              }
> @@ -2736,7 +2737,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st9", 8) == 0)
>                  {
>  {
> -return dev_storage + 470;
> +return dev_storage + 471;
>  
>  }
>                  }
> @@ -2751,7 +2752,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/sr9", 8) == 0)
>                  {
>  {
> -return dev_storage + 454;
> +return dev_storage + 455;
>  
>  }
>                  }
> @@ -2781,7 +2782,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym119", 8) == 0)
>                  {
>  {
> -return dev_storage + 845;
> +return dev_storage + 846;
>  
>  }
>                  }
> @@ -2796,7 +2797,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym109", 8) == 0)
>                  {
>  {
> -return dev_storage + 835;
> +return dev_storage + 836;
>  
>  }
>                  }
> @@ -2820,7 +2821,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st8", 8) == 0)
>                  {
>  {
> -return dev_storage + 469;
> +return dev_storage + 470;
>  
>  }
>                  }
> @@ -2835,7 +2836,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/sr8", 8) == 0)
>                  {
>  {
> -return dev_storage + 453;
> +return dev_storage + 454;
>  
>  }
>                  }
> @@ -2865,7 +2866,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym118", 8) == 0)
>                  {
>  {
> -return dev_storage + 844;
> +return dev_storage + 845;
>  
>  }
>                  }
> @@ -2880,7 +2881,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym108", 8) == 0)
>                  {
>  {
> -return dev_storage + 834;
> +return dev_storage + 835;
>  
>  }
>                  }
> @@ -2904,7 +2905,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st7", 8) == 0)
>                  {
>  {
> -return dev_storage + 468;
> +return dev_storage + 469;
>  
>  }
>                  }
> @@ -2919,7 +2920,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/sr7", 8) == 0)
>                  {
>  {
> -return dev_storage + 452;
> +return dev_storage + 453;
>  
>  }
>                  }
> @@ -2949,7 +2950,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym127", 8) == 0)
>                  {
>  {
> -return dev_storage + 853;
> +return dev_storage + 854;
>  
>  }
>                  }
> @@ -2964,7 +2965,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym117", 8) == 0)
>                  {
>  {
> -return dev_storage + 843;
> +return dev_storage + 844;
>  
>  }
>                  }
> @@ -2979,7 +2980,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym107", 8) == 0)
>                  {
>  {
> -return dev_storage + 833;
> +return dev_storage + 834;
>  
>  }
>                  }
> @@ -3003,7 +3004,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st6", 8) == 0)
>                  {
>  {
> -return dev_storage + 467;
> +return dev_storage + 468;
>  
>  }
>                  }
> @@ -3018,7 +3019,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/sr6", 8) == 0)
>                  {
>  {
> -return dev_storage + 451;
> +return dev_storage + 452;
>  
>  }
>                  }
> @@ -3048,7 +3049,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym126", 8) == 0)
>                  {
>  {
> -return dev_storage + 852;
> +return dev_storage + 853;
>  
>  }
>                  }
> @@ -3063,7 +3064,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym116", 8) == 0)
>                  {
>  {
> -return dev_storage + 842;
> +return dev_storage + 843;
>  
>  }
>                  }
> @@ -3078,7 +3079,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym106", 8) == 0)
>                  {
>  {
> -return dev_storage + 832;
> +return dev_storage + 833;
>  
>  }
>                  }
> @@ -3102,7 +3103,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st5", 8) == 0)
>                  {
>  {
> -return dev_storage + 466;
> +return dev_storage + 467;
>  
>  }
>                  }
> @@ -3117,7 +3118,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/sr5", 8) == 0)
>                  {
>  {
> -return dev_storage + 450;
> +return dev_storage + 451;
>  
>  }
>                  }
> @@ -3147,7 +3148,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym125", 8) == 0)
>                  {
>  {
> -return dev_storage + 851;
> +return dev_storage + 852;
>  
>  }
>                  }
> @@ -3162,7 +3163,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym115", 8) == 0)
>                  {
>  {
> -return dev_storage + 841;
> +return dev_storage + 842;
>  
>  }
>                  }
> @@ -3177,7 +3178,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym105", 8) == 0)
>                  {
>  {
> -return dev_storage + 831;
> +return dev_storage + 832;
>  
>  }
>                  }
> @@ -3201,7 +3202,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st4", 8) == 0)
>                  {
>  {
> -return dev_storage + 465;
> +return dev_storage + 466;
>  
>  }
>                  }
> @@ -3216,7 +3217,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/sr4", 8) == 0)
>                  {
>  {
> -return dev_storage + 449;
> +return dev_storage + 450;
>  
>  }
>                  }
> @@ -3246,7 +3247,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym124", 8) == 0)
>                  {
>  {
> -return dev_storage + 850;
> +return dev_storage + 851;
>  
>  }
>                  }
> @@ -3261,7 +3262,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym114", 8) == 0)
>                  {
>  {
> -return dev_storage + 840;
> +return dev_storage + 841;
>  
>  }
>                  }
> @@ -3276,7 +3277,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym104", 8) == 0)
>                  {
>  {
> -return dev_storage + 830;
> +return dev_storage + 831;
>  
>  }
>                  }
> @@ -3300,7 +3301,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st3", 8) == 0)
>                  {
>  {
> -return dev_storage + 464;
> +return dev_storage + 465;
>  
>  }
>                  }
> @@ -3315,7 +3316,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/sr3", 8) == 0)
>                  {
>  {
> -return dev_storage + 448;
> +return dev_storage + 449;
>  
>  }
>                  }
> @@ -3345,7 +3346,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym123", 8) == 0)
>                  {
>  {
> -return dev_storage + 849;
> +return dev_storage + 850;
>  
>  }
>                  }
> @@ -3360,7 +3361,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym113", 8) == 0)
>                  {
>  {
> -return dev_storage + 839;
> +return dev_storage + 840;
>  
>  }
>                  }
> @@ -3375,7 +3376,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym103", 8) == 0)
>                  {
>  {
> -return dev_storage + 829;
> +return dev_storage + 830;
>  
>  }
>                  }
> @@ -3399,7 +3400,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st2", 8) == 0)
>                  {
>  {
> -return dev_storage + 463;
> +return dev_storage + 464;
>  
>  }
>                  }
> @@ -3414,7 +3415,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/sr2", 8) == 0)
>                  {
>  {
> -return dev_storage + 447;
> +return dev_storage + 448;
>  
>  }
>                  }
> @@ -3444,7 +3445,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym122", 8) == 0)
>                  {
>  {
> -return dev_storage + 848;
> +return dev_storage + 849;
>  
>  }
>                  }
> @@ -3459,7 +3460,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym112", 8) == 0)
>                  {
>  {
> -return dev_storage + 838;
> +return dev_storage + 839;
>  
>  }
>                  }
> @@ -3474,7 +3475,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym102", 8) == 0)
>                  {
>  {
> -return dev_storage + 828;
> +return dev_storage + 829;
>  
>  }
>                  }
> @@ -3498,7 +3499,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st1", 8) == 0)
>                  {
>  {
> -return dev_storage + 462;
> +return dev_storage + 463;
>  
>  }
>                  }
> @@ -3513,7 +3514,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/sr1", 8) == 0)
>                  {
>  {
> -return dev_storage + 446;
> +return dev_storage + 447;
>  
>  }
>                  }
> @@ -3543,7 +3544,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym121", 8) == 0)
>                  {
>  {
> -return dev_storage + 847;
> +return dev_storage + 848;
>  
>  }
>                  }
> @@ -3558,7 +3559,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym111", 8) == 0)
>                  {
>  {
> -return dev_storage + 837;
> +return dev_storage + 838;
>  
>  }
>                  }
> @@ -3573,7 +3574,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym101", 8) == 0)
>                  {
>  {
> -return dev_storage + 827;
> +return dev_storage + 828;
>  
>  }
>                  }
> @@ -3597,7 +3598,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st0", 8) == 0)
>                  {
>  {
> -return dev_storage + 461;
> +return dev_storage + 462;
>  
>  }
>                  }
> @@ -3612,7 +3613,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/sr0", 8) == 0)
>                  {
>  {
> -return dev_storage + 445;
> +return dev_storage + 446;
>  
>  }
>                  }
> @@ -3642,7 +3643,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym120", 8) == 0)
>                  {
>  {
> -return dev_storage + 846;
> +return dev_storage + 847;
>  
>  }
>                  }
> @@ -3657,7 +3658,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym110", 8) == 0)
>                  {
>  {
> -return dev_storage + 836;
> +return dev_storage + 837;
>  
>  }
>                  }
> @@ -3672,7 +3673,7 @@ return	NULL;
>                if (strncmp (KR_keyword, ":ptym100", 8) == 0)
>                  {
>  {
> -return dev_storage + 826;
> +return dev_storage + 827;
>  
>  }
>                  }
> @@ -3717,7 +3718,7 @@ return	NULL;
>            if (strncmp (KR_keyword, "/dev/zero", 9) == 0)
>              {
>  {
> -return dev_storage + 723;
> +return dev_storage + 724;
>  
>  }
>              }
> @@ -3849,7 +3850,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st99", 9) == 0)
>                  {
>  {
> -return dev_storage + 560;
> +return dev_storage + 561;
>  
>  }
>                  }
> @@ -3864,7 +3865,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st89", 9) == 0)
>                  {
>  {
> -return dev_storage + 550;
> +return dev_storage + 551;
>  
>  }
>                  }
> @@ -3879,7 +3880,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st79", 9) == 0)
>                  {
>  {
> -return dev_storage + 540;
> +return dev_storage + 541;
>  
>  }
>                  }
> @@ -3894,7 +3895,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st69", 9) == 0)
>                  {
>  {
> -return dev_storage + 530;
> +return dev_storage + 531;
>  
>  }
>                  }
> @@ -3909,7 +3910,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st59", 9) == 0)
>                  {
>  {
> -return dev_storage + 520;
> +return dev_storage + 521;
>  
>  }
>                  }
> @@ -3924,7 +3925,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st49", 9) == 0)
>                  {
>  {
> -return dev_storage + 510;
> +return dev_storage + 511;
>  
>  }
>                  }
> @@ -3939,7 +3940,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st39", 9) == 0)
>                  {
>  {
> -return dev_storage + 500;
> +return dev_storage + 501;
>  
>  }
>                  }
> @@ -3954,7 +3955,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st29", 9) == 0)
>                  {
>  {
> -return dev_storage + 490;
> +return dev_storage + 491;
>  
>  }
>                  }
> @@ -3969,7 +3970,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st19", 9) == 0)
>                  {
>  {
> -return dev_storage + 480;
> +return dev_storage + 481;
>  
>  }
>                  }
> @@ -4053,7 +4054,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st98", 9) == 0)
>                  {
>  {
> -return dev_storage + 559;
> +return dev_storage + 560;
>  
>  }
>                  }
> @@ -4068,7 +4069,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st88", 9) == 0)
>                  {
>  {
> -return dev_storage + 549;
> +return dev_storage + 550;
>  
>  }
>                  }
> @@ -4083,7 +4084,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st78", 9) == 0)
>                  {
>  {
> -return dev_storage + 539;
> +return dev_storage + 540;
>  
>  }
>                  }
> @@ -4098,7 +4099,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st68", 9) == 0)
>                  {
>  {
> -return dev_storage + 529;
> +return dev_storage + 530;
>  
>  }
>                  }
> @@ -4113,7 +4114,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st58", 9) == 0)
>                  {
>  {
> -return dev_storage + 519;
> +return dev_storage + 520;
>  
>  }
>                  }
> @@ -4128,7 +4129,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st48", 9) == 0)
>                  {
>  {
> -return dev_storage + 509;
> +return dev_storage + 510;
>  
>  }
>                  }
> @@ -4143,7 +4144,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st38", 9) == 0)
>                  {
>  {
> -return dev_storage + 499;
> +return dev_storage + 500;
>  
>  }
>                  }
> @@ -4158,7 +4159,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st28", 9) == 0)
>                  {
>  {
> -return dev_storage + 489;
> +return dev_storage + 490;
>  
>  }
>                  }
> @@ -4173,7 +4174,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st18", 9) == 0)
>                  {
>  {
> -return dev_storage + 479;
> +return dev_storage + 480;
>  
>  }
>                  }
> @@ -4257,7 +4258,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st97", 9) == 0)
>                  {
>  {
> -return dev_storage + 558;
> +return dev_storage + 559;
>  
>  }
>                  }
> @@ -4272,7 +4273,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st87", 9) == 0)
>                  {
>  {
> -return dev_storage + 548;
> +return dev_storage + 549;
>  
>  }
>                  }
> @@ -4287,7 +4288,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st77", 9) == 0)
>                  {
>  {
> -return dev_storage + 538;
> +return dev_storage + 539;
>  
>  }
>                  }
> @@ -4302,7 +4303,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st67", 9) == 0)
>                  {
>  {
> -return dev_storage + 528;
> +return dev_storage + 529;
>  
>  }
>                  }
> @@ -4317,7 +4318,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st57", 9) == 0)
>                  {
>  {
> -return dev_storage + 518;
> +return dev_storage + 519;
>  
>  }
>                  }
> @@ -4332,7 +4333,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st47", 9) == 0)
>                  {
>  {
> -return dev_storage + 508;
> +return dev_storage + 509;
>  
>  }
>                  }
> @@ -4347,7 +4348,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st37", 9) == 0)
>                  {
>  {
> -return dev_storage + 498;
> +return dev_storage + 499;
>  
>  }
>                  }
> @@ -4362,7 +4363,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st27", 9) == 0)
>                  {
>  {
> -return dev_storage + 488;
> +return dev_storage + 489;
>  
>  }
>                  }
> @@ -4377,7 +4378,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st17", 9) == 0)
>                  {
>  {
> -return dev_storage + 478;
> +return dev_storage + 479;
>  
>  }
>                  }
> @@ -4461,7 +4462,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st96", 9) == 0)
>                  {
>  {
> -return dev_storage + 557;
> +return dev_storage + 558;
>  
>  }
>                  }
> @@ -4476,7 +4477,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st86", 9) == 0)
>                  {
>  {
> -return dev_storage + 547;
> +return dev_storage + 548;
>  
>  }
>                  }
> @@ -4491,7 +4492,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st76", 9) == 0)
>                  {
>  {
> -return dev_storage + 537;
> +return dev_storage + 538;
>  
>  }
>                  }
> @@ -4506,7 +4507,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st66", 9) == 0)
>                  {
>  {
> -return dev_storage + 527;
> +return dev_storage + 528;
>  
>  }
>                  }
> @@ -4521,7 +4522,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st56", 9) == 0)
>                  {
>  {
> -return dev_storage + 517;
> +return dev_storage + 518;
>  
>  }
>                  }
> @@ -4536,7 +4537,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st46", 9) == 0)
>                  {
>  {
> -return dev_storage + 507;
> +return dev_storage + 508;
>  
>  }
>                  }
> @@ -4551,7 +4552,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st36", 9) == 0)
>                  {
>  {
> -return dev_storage + 497;
> +return dev_storage + 498;
>  
>  }
>                  }
> @@ -4566,7 +4567,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st26", 9) == 0)
>                  {
>  {
> -return dev_storage + 487;
> +return dev_storage + 488;
>  
>  }
>                  }
> @@ -4581,7 +4582,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st16", 9) == 0)
>                  {
>  {
> -return dev_storage + 477;
> +return dev_storage + 478;
>  
>  }
>                  }
> @@ -4665,7 +4666,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st95", 9) == 0)
>                  {
>  {
> -return dev_storage + 556;
> +return dev_storage + 557;
>  
>  }
>                  }
> @@ -4680,7 +4681,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st85", 9) == 0)
>                  {
>  {
> -return dev_storage + 546;
> +return dev_storage + 547;
>  
>  }
>                  }
> @@ -4695,7 +4696,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st75", 9) == 0)
>                  {
>  {
> -return dev_storage + 536;
> +return dev_storage + 537;
>  
>  }
>                  }
> @@ -4710,7 +4711,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st65", 9) == 0)
>                  {
>  {
> -return dev_storage + 526;
> +return dev_storage + 527;
>  
>  }
>                  }
> @@ -4725,7 +4726,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st55", 9) == 0)
>                  {
>  {
> -return dev_storage + 516;
> +return dev_storage + 517;
>  
>  }
>                  }
> @@ -4740,7 +4741,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st45", 9) == 0)
>                  {
>  {
> -return dev_storage + 506;
> +return dev_storage + 507;
>  
>  }
>                  }
> @@ -4755,7 +4756,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st35", 9) == 0)
>                  {
>  {
> -return dev_storage + 496;
> +return dev_storage + 497;
>  
>  }
>                  }
> @@ -4770,7 +4771,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st25", 9) == 0)
>                  {
>  {
> -return dev_storage + 486;
> +return dev_storage + 487;
>  
>  }
>                  }
> @@ -4788,7 +4789,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st15", 9) == 0)
>                      {
>  {
> -return dev_storage + 476;
> +return dev_storage + 477;
>  
>  }
>                      }
> @@ -4803,7 +4804,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/sr15", 9) == 0)
>                      {
>  {
> -return dev_storage + 460;
> +return dev_storage + 461;
>  
>  }
>                      }
> @@ -4908,7 +4909,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st94", 9) == 0)
>                  {
>  {
> -return dev_storage + 555;
> +return dev_storage + 556;
>  
>  }
>                  }
> @@ -4923,7 +4924,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st84", 9) == 0)
>                  {
>  {
> -return dev_storage + 545;
> +return dev_storage + 546;
>  
>  }
>                  }
> @@ -4938,7 +4939,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st74", 9) == 0)
>                  {
>  {
> -return dev_storage + 535;
> +return dev_storage + 536;
>  
>  }
>                  }
> @@ -4953,7 +4954,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st64", 9) == 0)
>                  {
>  {
> -return dev_storage + 525;
> +return dev_storage + 526;
>  
>  }
>                  }
> @@ -4968,7 +4969,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st54", 9) == 0)
>                  {
>  {
> -return dev_storage + 515;
> +return dev_storage + 516;
>  
>  }
>                  }
> @@ -4983,7 +4984,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st44", 9) == 0)
>                  {
>  {
> -return dev_storage + 505;
> +return dev_storage + 506;
>  
>  }
>                  }
> @@ -4998,7 +4999,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st34", 9) == 0)
>                  {
>  {
> -return dev_storage + 495;
> +return dev_storage + 496;
>  
>  }
>                  }
> @@ -5013,7 +5014,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st24", 9) == 0)
>                  {
>  {
> -return dev_storage + 485;
> +return dev_storage + 486;
>  
>  }
>                  }
> @@ -5031,7 +5032,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st14", 9) == 0)
>                      {
>  {
> -return dev_storage + 475;
> +return dev_storage + 476;
>  
>  }
>                      }
> @@ -5046,7 +5047,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/sr14", 9) == 0)
>                      {
>  {
> -return dev_storage + 459;
> +return dev_storage + 460;
>  
>  }
>                      }
> @@ -5151,7 +5152,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st93", 9) == 0)
>                  {
>  {
> -return dev_storage + 554;
> +return dev_storage + 555;
>  
>  }
>                  }
> @@ -5166,7 +5167,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st83", 9) == 0)
>                  {
>  {
> -return dev_storage + 544;
> +return dev_storage + 545;
>  
>  }
>                  }
> @@ -5181,7 +5182,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st73", 9) == 0)
>                  {
>  {
> -return dev_storage + 534;
> +return dev_storage + 535;
>  
>  }
>                  }
> @@ -5196,7 +5197,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st63", 9) == 0)
>                  {
>  {
> -return dev_storage + 524;
> +return dev_storage + 525;
>  
>  }
>                  }
> @@ -5211,7 +5212,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st53", 9) == 0)
>                  {
>  {
> -return dev_storage + 514;
> +return dev_storage + 515;
>  
>  }
>                  }
> @@ -5226,7 +5227,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st43", 9) == 0)
>                  {
>  {
> -return dev_storage + 504;
> +return dev_storage + 505;
>  
>  }
>                  }
> @@ -5241,7 +5242,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st33", 9) == 0)
>                  {
>  {
> -return dev_storage + 494;
> +return dev_storage + 495;
>  
>  }
>                  }
> @@ -5256,7 +5257,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st23", 9) == 0)
>                  {
>  {
> -return dev_storage + 484;
> +return dev_storage + 485;
>  
>  }
>                  }
> @@ -5274,7 +5275,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st13", 9) == 0)
>                      {
>  {
> -return dev_storage + 474;
> +return dev_storage + 475;
>  
>  }
>                      }
> @@ -5289,7 +5290,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/sr13", 9) == 0)
>                      {
>  {
> -return dev_storage + 458;
> +return dev_storage + 459;
>  
>  }
>                      }
> @@ -5394,7 +5395,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st92", 9) == 0)
>                  {
>  {
> -return dev_storage + 553;
> +return dev_storage + 554;
>  
>  }
>                  }
> @@ -5409,7 +5410,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st82", 9) == 0)
>                  {
>  {
> -return dev_storage + 543;
> +return dev_storage + 544;
>  
>  }
>                  }
> @@ -5424,7 +5425,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st72", 9) == 0)
>                  {
>  {
> -return dev_storage + 533;
> +return dev_storage + 534;
>  
>  }
>                  }
> @@ -5439,7 +5440,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st62", 9) == 0)
>                  {
>  {
> -return dev_storage + 523;
> +return dev_storage + 524;
>  
>  }
>                  }
> @@ -5454,7 +5455,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st52", 9) == 0)
>                  {
>  {
> -return dev_storage + 513;
> +return dev_storage + 514;
>  
>  }
>                  }
> @@ -5469,7 +5470,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st42", 9) == 0)
>                  {
>  {
> -return dev_storage + 503;
> +return dev_storage + 504;
>  
>  }
>                  }
> @@ -5484,7 +5485,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st32", 9) == 0)
>                  {
>  {
> -return dev_storage + 493;
> +return dev_storage + 494;
>  
>  }
>                  }
> @@ -5499,7 +5500,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st22", 9) == 0)
>                  {
>  {
> -return dev_storage + 483;
> +return dev_storage + 484;
>  
>  }
>                  }
> @@ -5517,7 +5518,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st12", 9) == 0)
>                      {
>  {
> -return dev_storage + 473;
> +return dev_storage + 474;
>  
>  }
>                      }
> @@ -5532,7 +5533,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/sr12", 9) == 0)
>                      {
>  {
> -return dev_storage + 457;
> +return dev_storage + 458;
>  
>  }
>                      }
> @@ -5637,7 +5638,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st91", 9) == 0)
>                  {
>  {
> -return dev_storage + 552;
> +return dev_storage + 553;
>  
>  }
>                  }
> @@ -5652,7 +5653,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st81", 9) == 0)
>                  {
>  {
> -return dev_storage + 542;
> +return dev_storage + 543;
>  
>  }
>                  }
> @@ -5667,7 +5668,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st71", 9) == 0)
>                  {
>  {
> -return dev_storage + 532;
> +return dev_storage + 533;
>  
>  }
>                  }
> @@ -5682,7 +5683,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st61", 9) == 0)
>                  {
>  {
> -return dev_storage + 522;
> +return dev_storage + 523;
>  
>  }
>                  }
> @@ -5697,7 +5698,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st51", 9) == 0)
>                  {
>  {
> -return dev_storage + 512;
> +return dev_storage + 513;
>  
>  }
>                  }
> @@ -5712,7 +5713,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st41", 9) == 0)
>                  {
>  {
> -return dev_storage + 502;
> +return dev_storage + 503;
>  
>  }
>                  }
> @@ -5727,7 +5728,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st31", 9) == 0)
>                  {
>  {
> -return dev_storage + 492;
> +return dev_storage + 493;
>  
>  }
>                  }
> @@ -5742,7 +5743,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st21", 9) == 0)
>                  {
>  {
> -return dev_storage + 482;
> +return dev_storage + 483;
>  
>  }
>                  }
> @@ -5760,7 +5761,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st11", 9) == 0)
>                      {
>  {
> -return dev_storage + 472;
> +return dev_storage + 473;
>  
>  }
>                      }
> @@ -5775,7 +5776,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/sr11", 9) == 0)
>                      {
>  {
> -return dev_storage + 456;
> +return dev_storage + 457;
>  
>  }
>                      }
> @@ -5865,7 +5866,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st90", 9) == 0)
>                  {
>  {
> -return dev_storage + 551;
> +return dev_storage + 552;
>  
>  }
>                  }
> @@ -5880,7 +5881,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st80", 9) == 0)
>                  {
>  {
> -return dev_storage + 541;
> +return dev_storage + 542;
>  
>  }
>                  }
> @@ -5895,7 +5896,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st70", 9) == 0)
>                  {
>  {
> -return dev_storage + 531;
> +return dev_storage + 532;
>  
>  }
>                  }
> @@ -5910,7 +5911,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st60", 9) == 0)
>                  {
>  {
> -return dev_storage + 521;
> +return dev_storage + 522;
>  
>  }
>                  }
> @@ -5925,7 +5926,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st50", 9) == 0)
>                  {
>  {
> -return dev_storage + 511;
> +return dev_storage + 512;
>  
>  }
>                  }
> @@ -5940,7 +5941,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st40", 9) == 0)
>                  {
>  {
> -return dev_storage + 501;
> +return dev_storage + 502;
>  
>  }
>                  }
> @@ -5955,7 +5956,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st30", 9) == 0)
>                  {
>  {
> -return dev_storage + 491;
> +return dev_storage + 492;
>  
>  }
>                  }
> @@ -5970,7 +5971,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st20", 9) == 0)
>                  {
>  {
> -return dev_storage + 481;
> +return dev_storage + 482;
>  
>  }
>                  }
> @@ -5988,7 +5989,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st10", 9) == 0)
>                      {
>  {
> -return dev_storage + 471;
> +return dev_storage + 472;
>  
>  }
>                      }
> @@ -6003,7 +6004,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/sr10", 9) == 0)
>                      {
>  {
> -return dev_storage + 455;
> +return dev_storage + 456;
>  
>  }
>                      }
> @@ -6216,7 +6217,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/stdin", 10) == 0)
>                  {
>  {
> -return dev_storage + 590;
> +return dev_storage + 591;
>  
>  }
>                  }
> @@ -6270,7 +6271,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/ttyS9", 10) == 0)
>                  {
>  {
> -return dev_storage + 602;
> +return dev_storage + 603;
>  
>  }
>                  }
> @@ -6285,7 +6286,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/ttyS8", 10) == 0)
>                  {
>  {
> -return dev_storage + 601;
> +return dev_storage + 602;
>  
>  }
>                  }
> @@ -6300,7 +6301,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/ttyS7", 10) == 0)
>                  {
>  {
> -return dev_storage + 600;
> +return dev_storage + 601;
>  
>  }
>                  }
> @@ -6315,7 +6316,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/ttyS6", 10) == 0)
>                  {
>  {
> -return dev_storage + 599;
> +return dev_storage + 600;
>  
>  }
>                  }
> @@ -6330,7 +6331,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/ttyS5", 10) == 0)
>                  {
>  {
> -return dev_storage + 598;
> +return dev_storage + 599;
>  
>  }
>                  }
> @@ -6345,7 +6346,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/ttyS4", 10) == 0)
>                  {
>  {
> -return dev_storage + 597;
> +return dev_storage + 598;
>  
>  }
>                  }
> @@ -6360,7 +6361,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/ttyS3", 10) == 0)
>                  {
>  {
> -return dev_storage + 596;
> +return dev_storage + 597;
>  
>  }
>                  }
> @@ -6375,7 +6376,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/ttyS2", 10) == 0)
>                  {
>  {
> -return dev_storage + 595;
> +return dev_storage + 596;
>  
>  }
>                  }
> @@ -6390,7 +6391,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/ttyS1", 10) == 0)
>                  {
>  {
> -return dev_storage + 594;
> +return dev_storage + 595;
>  
>  }
>                  }
> @@ -6405,7 +6406,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/ttyS0", 10) == 0)
>                  {
>  {
> -return dev_storage + 593;
> +return dev_storage + 594;
>  
>  }
>                  }
> @@ -8721,7 +8722,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st127", 10) == 0)
>                      {
>  {
> -return dev_storage + 588;
> +return dev_storage + 589;
>  
>  }
>                      }
> @@ -8736,7 +8737,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st126", 10) == 0)
>                      {
>  {
> -return dev_storage + 587;
> +return dev_storage + 588;
>  
>  }
>                      }
> @@ -8751,7 +8752,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st125", 10) == 0)
>                      {
>  {
> -return dev_storage + 586;
> +return dev_storage + 587;
>  
>  }
>                      }
> @@ -8766,7 +8767,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st124", 10) == 0)
>                      {
>  {
> -return dev_storage + 585;
> +return dev_storage + 586;
>  
>  }
>                      }
> @@ -8781,7 +8782,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st123", 10) == 0)
>                      {
>  {
> -return dev_storage + 584;
> +return dev_storage + 585;
>  
>  }
>                      }
> @@ -8796,7 +8797,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st122", 10) == 0)
>                      {
>  {
> -return dev_storage + 583;
> +return dev_storage + 584;
>  
>  }
>                      }
> @@ -8811,7 +8812,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st121", 10) == 0)
>                      {
>  {
> -return dev_storage + 582;
> +return dev_storage + 583;
>  
>  }
>                      }
> @@ -8826,7 +8827,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st120", 10) == 0)
>                      {
>  {
> -return dev_storage + 581;
> +return dev_storage + 582;
>  
>  }
>                      }
> @@ -9708,7 +9709,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st119", 10) == 0)
>                      {
>  {
> -return dev_storage + 580;
> +return dev_storage + 581;
>  
>  }
>                      }
> @@ -9723,7 +9724,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st118", 10) == 0)
>                      {
>  {
> -return dev_storage + 579;
> +return dev_storage + 580;
>  
>  }
>                      }
> @@ -9738,7 +9739,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st117", 10) == 0)
>                      {
>  {
> -return dev_storage + 578;
> +return dev_storage + 579;
>  
>  }
>                      }
> @@ -9753,7 +9754,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st116", 10) == 0)
>                      {
>  {
> -return dev_storage + 577;
> +return dev_storage + 578;
>  
>  }
>                      }
> @@ -9768,7 +9769,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st115", 10) == 0)
>                      {
>  {
> -return dev_storage + 576;
> +return dev_storage + 577;
>  
>  }
>                      }
> @@ -9783,7 +9784,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st114", 10) == 0)
>                      {
>  {
> -return dev_storage + 575;
> +return dev_storage + 576;
>  
>  }
>                      }
> @@ -9798,7 +9799,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st113", 10) == 0)
>                      {
>  {
> -return dev_storage + 574;
> +return dev_storage + 575;
>  
>  }
>                      }
> @@ -9813,7 +9814,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st112", 10) == 0)
>                      {
>  {
> -return dev_storage + 573;
> +return dev_storage + 574;
>  
>  }
>                      }
> @@ -9828,7 +9829,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st111", 10) == 0)
>                      {
>  {
> -return dev_storage + 572;
> +return dev_storage + 573;
>  
>  }
>                      }
> @@ -9843,7 +9844,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/st110", 10) == 0)
>                      {
>  {
> -return dev_storage + 571;
> +return dev_storage + 572;
>  
>  }
>                      }
> @@ -9873,7 +9874,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st109", 10) == 0)
>                  {
>  {
> -return dev_storage + 570;
> +return dev_storage + 571;
>  
>  }
>                  }
> @@ -9888,7 +9889,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st108", 10) == 0)
>                  {
>  {
> -return dev_storage + 569;
> +return dev_storage + 570;
>  
>  }
>                  }
> @@ -9903,7 +9904,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st107", 10) == 0)
>                  {
>  {
> -return dev_storage + 568;
> +return dev_storage + 569;
>  
>  }
>                  }
> @@ -9918,7 +9919,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st106", 10) == 0)
>                  {
>  {
> -return dev_storage + 567;
> +return dev_storage + 568;
>  
>  }
>                  }
> @@ -9933,7 +9934,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st105", 10) == 0)
>                  {
>  {
> -return dev_storage + 566;
> +return dev_storage + 567;
>  
>  }
>                  }
> @@ -9948,7 +9949,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st104", 10) == 0)
>                  {
>  {
> -return dev_storage + 565;
> +return dev_storage + 566;
>  
>  }
>                  }
> @@ -9963,7 +9964,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st103", 10) == 0)
>                  {
>  {
> -return dev_storage + 564;
> +return dev_storage + 565;
>  
>  }
>                  }
> @@ -9978,7 +9979,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st102", 10) == 0)
>                  {
>  {
> -return dev_storage + 563;
> +return dev_storage + 564;
>  
>  }
>                  }
> @@ -9993,7 +9994,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st101", 10) == 0)
>                  {
>  {
> -return dev_storage + 562;
> +return dev_storage + 563;
>  
>  }
>                  }
> @@ -10008,7 +10009,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/st100", 10) == 0)
>                  {
>  {
> -return dev_storage + 561;
> +return dev_storage + 562;
>  
>  }
>                  }
> @@ -10041,7 +10042,7 @@ return	NULL;
>                if (strncmp (KR_keyword, "/dev/stdout", 11) == 0)
>                  {
>  {
> -return dev_storage + 591;
> +return dev_storage + 592;
>  
>  }
>                  }
> @@ -10077,7 +10078,7 @@ return	NULL;
>            if (strncmp (KR_keyword, "/dev/stderr", 11) == 0)
>              {
>  {
> -return dev_storage + 589;
> +return dev_storage + 590;
>  
>  }
>              }
> @@ -10113,7 +10114,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS99", 11) == 0)
>                      {
>  {
> -return dev_storage + 692;
> +return dev_storage + 693;
>  
>  }
>                      }
> @@ -10128,7 +10129,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS98", 11) == 0)
>                      {
>  {
> -return dev_storage + 691;
> +return dev_storage + 692;
>  
>  }
>                      }
> @@ -10143,7 +10144,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS97", 11) == 0)
>                      {
>  {
> -return dev_storage + 690;
> +return dev_storage + 691;
>  
>  }
>                      }
> @@ -10158,7 +10159,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS96", 11) == 0)
>                      {
>  {
> -return dev_storage + 689;
> +return dev_storage + 690;
>  
>  }
>                      }
> @@ -10173,7 +10174,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS95", 11) == 0)
>                      {
>  {
> -return dev_storage + 688;
> +return dev_storage + 689;
>  
>  }
>                      }
> @@ -10188,7 +10189,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS94", 11) == 0)
>                      {
>  {
> -return dev_storage + 687;
> +return dev_storage + 688;
>  
>  }
>                      }
> @@ -10203,7 +10204,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS93", 11) == 0)
>                      {
>  {
> -return dev_storage + 686;
> +return dev_storage + 687;
>  
>  }
>                      }
> @@ -10218,7 +10219,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS92", 11) == 0)
>                      {
>  {
> -return dev_storage + 685;
> +return dev_storage + 686;
>  
>  }
>                      }
> @@ -10233,7 +10234,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS91", 11) == 0)
>                      {
>  {
> -return dev_storage + 684;
> +return dev_storage + 685;
>  
>  }
>                      }
> @@ -10248,7 +10249,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS90", 11) == 0)
>                      {
>  {
> -return dev_storage + 683;
> +return dev_storage + 684;
>  
>  }
>                      }
> @@ -10440,7 +10441,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS89", 11) == 0)
>                      {
>  {
> -return dev_storage + 682;
> +return dev_storage + 683;
>  
>  }
>                      }
> @@ -10455,7 +10456,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS88", 11) == 0)
>                      {
>  {
> -return dev_storage + 681;
> +return dev_storage + 682;
>  
>  }
>                      }
> @@ -10470,7 +10471,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS87", 11) == 0)
>                      {
>  {
> -return dev_storage + 680;
> +return dev_storage + 681;
>  
>  }
>                      }
> @@ -10485,7 +10486,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS86", 11) == 0)
>                      {
>  {
> -return dev_storage + 679;
> +return dev_storage + 680;
>  
>  }
>                      }
> @@ -10500,7 +10501,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS85", 11) == 0)
>                      {
>  {
> -return dev_storage + 678;
> +return dev_storage + 679;
>  
>  }
>                      }
> @@ -10515,7 +10516,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS84", 11) == 0)
>                      {
>  {
> -return dev_storage + 677;
> +return dev_storage + 678;
>  
>  }
>                      }
> @@ -10530,7 +10531,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS83", 11) == 0)
>                      {
>  {
> -return dev_storage + 676;
> +return dev_storage + 677;
>  
>  }
>                      }
> @@ -10545,7 +10546,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS82", 11) == 0)
>                      {
>  {
> -return dev_storage + 675;
> +return dev_storage + 676;
>  
>  }
>                      }
> @@ -10560,7 +10561,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS81", 11) == 0)
>                      {
>  {
> -return dev_storage + 674;
> +return dev_storage + 675;
>  
>  }
>                      }
> @@ -10575,7 +10576,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS80", 11) == 0)
>                      {
>  {
> -return dev_storage + 673;
> +return dev_storage + 674;
>  
>  }
>                      }
> @@ -10767,7 +10768,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS79", 11) == 0)
>                      {
>  {
> -return dev_storage + 672;
> +return dev_storage + 673;
>  
>  }
>                      }
> @@ -10782,7 +10783,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS78", 11) == 0)
>                      {
>  {
> -return dev_storage + 671;
> +return dev_storage + 672;
>  
>  }
>                      }
> @@ -10797,7 +10798,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS77", 11) == 0)
>                      {
>  {
> -return dev_storage + 670;
> +return dev_storage + 671;
>  
>  }
>                      }
> @@ -10812,7 +10813,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS76", 11) == 0)
>                      {
>  {
> -return dev_storage + 669;
> +return dev_storage + 670;
>  
>  }
>                      }
> @@ -10827,7 +10828,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS75", 11) == 0)
>                      {
>  {
> -return dev_storage + 668;
> +return dev_storage + 669;
>  
>  }
>                      }
> @@ -10842,7 +10843,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS74", 11) == 0)
>                      {
>  {
> -return dev_storage + 667;
> +return dev_storage + 668;
>  
>  }
>                      }
> @@ -10857,7 +10858,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS73", 11) == 0)
>                      {
>  {
> -return dev_storage + 666;
> +return dev_storage + 667;
>  
>  }
>                      }
> @@ -10872,7 +10873,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS72", 11) == 0)
>                      {
>  {
> -return dev_storage + 665;
> +return dev_storage + 666;
>  
>  }
>                      }
> @@ -10887,7 +10888,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS71", 11) == 0)
>                      {
>  {
> -return dev_storage + 664;
> +return dev_storage + 665;
>  
>  }
>                      }
> @@ -10902,7 +10903,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS70", 11) == 0)
>                      {
>  {
> -return dev_storage + 663;
> +return dev_storage + 664;
>  
>  }
>                      }
> @@ -11094,7 +11095,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS69", 11) == 0)
>                      {
>  {
> -return dev_storage + 662;
> +return dev_storage + 663;
>  
>  }
>                      }
> @@ -11109,7 +11110,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS68", 11) == 0)
>                      {
>  {
> -return dev_storage + 661;
> +return dev_storage + 662;
>  
>  }
>                      }
> @@ -11124,7 +11125,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS67", 11) == 0)
>                      {
>  {
> -return dev_storage + 660;
> +return dev_storage + 661;
>  
>  }
>                      }
> @@ -11139,7 +11140,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS66", 11) == 0)
>                      {
>  {
> -return dev_storage + 659;
> +return dev_storage + 660;
>  
>  }
>                      }
> @@ -11154,7 +11155,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS65", 11) == 0)
>                      {
>  {
> -return dev_storage + 658;
> +return dev_storage + 659;
>  
>  }
>                      }
> @@ -11169,7 +11170,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS64", 11) == 0)
>                      {
>  {
> -return dev_storage + 657;
> +return dev_storage + 658;
>  
>  }
>                      }
> @@ -11184,7 +11185,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS63", 11) == 0)
>                      {
>  {
> -return dev_storage + 656;
> +return dev_storage + 657;
>  
>  }
>                      }
> @@ -11199,7 +11200,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS62", 11) == 0)
>                      {
>  {
> -return dev_storage + 655;
> +return dev_storage + 656;
>  
>  }
>                      }
> @@ -11214,7 +11215,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS61", 11) == 0)
>                      {
>  {
> -return dev_storage + 654;
> +return dev_storage + 655;
>  
>  }
>                      }
> @@ -11229,7 +11230,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS60", 11) == 0)
>                      {
>  {
> -return dev_storage + 653;
> +return dev_storage + 654;
>  
>  }
>                      }
> @@ -11421,7 +11422,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS59", 11) == 0)
>                      {
>  {
> -return dev_storage + 652;
> +return dev_storage + 653;
>  
>  }
>                      }
> @@ -11436,7 +11437,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS58", 11) == 0)
>                      {
>  {
> -return dev_storage + 651;
> +return dev_storage + 652;
>  
>  }
>                      }
> @@ -11451,7 +11452,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS57", 11) == 0)
>                      {
>  {
> -return dev_storage + 650;
> +return dev_storage + 651;
>  
>  }
>                      }
> @@ -11466,7 +11467,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS56", 11) == 0)
>                      {
>  {
> -return dev_storage + 649;
> +return dev_storage + 650;
>  
>  }
>                      }
> @@ -11481,7 +11482,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS55", 11) == 0)
>                      {
>  {
> -return dev_storage + 648;
> +return dev_storage + 649;
>  
>  }
>                      }
> @@ -11496,7 +11497,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS54", 11) == 0)
>                      {
>  {
> -return dev_storage + 647;
> +return dev_storage + 648;
>  
>  }
>                      }
> @@ -11511,7 +11512,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS53", 11) == 0)
>                      {
>  {
> -return dev_storage + 646;
> +return dev_storage + 647;
>  
>  }
>                      }
> @@ -11526,7 +11527,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS52", 11) == 0)
>                      {
>  {
> -return dev_storage + 645;
> +return dev_storage + 646;
>  
>  }
>                      }
> @@ -11541,7 +11542,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS51", 11) == 0)
>                      {
>  {
> -return dev_storage + 644;
> +return dev_storage + 645;
>  
>  }
>                      }
> @@ -11556,7 +11557,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS50", 11) == 0)
>                      {
>  {
> -return dev_storage + 643;
> +return dev_storage + 644;
>  
>  }
>                      }
> @@ -11748,7 +11749,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS49", 11) == 0)
>                      {
>  {
> -return dev_storage + 642;
> +return dev_storage + 643;
>  
>  }
>                      }
> @@ -11763,7 +11764,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS48", 11) == 0)
>                      {
>  {
> -return dev_storage + 641;
> +return dev_storage + 642;
>  
>  }
>                      }
> @@ -11778,7 +11779,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS47", 11) == 0)
>                      {
>  {
> -return dev_storage + 640;
> +return dev_storage + 641;
>  
>  }
>                      }
> @@ -11793,7 +11794,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS46", 11) == 0)
>                      {
>  {
> -return dev_storage + 639;
> +return dev_storage + 640;
>  
>  }
>                      }
> @@ -11808,7 +11809,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS45", 11) == 0)
>                      {
>  {
> -return dev_storage + 638;
> +return dev_storage + 639;
>  
>  }
>                      }
> @@ -11823,7 +11824,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS44", 11) == 0)
>                      {
>  {
> -return dev_storage + 637;
> +return dev_storage + 638;
>  
>  }
>                      }
> @@ -11838,7 +11839,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS43", 11) == 0)
>                      {
>  {
> -return dev_storage + 636;
> +return dev_storage + 637;
>  
>  }
>                      }
> @@ -11853,7 +11854,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS42", 11) == 0)
>                      {
>  {
> -return dev_storage + 635;
> +return dev_storage + 636;
>  
>  }
>                      }
> @@ -11868,7 +11869,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS41", 11) == 0)
>                      {
>  {
> -return dev_storage + 634;
> +return dev_storage + 635;
>  
>  }
>                      }
> @@ -11883,7 +11884,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS40", 11) == 0)
>                      {
>  {
> -return dev_storage + 633;
> +return dev_storage + 634;
>  
>  }
>                      }
> @@ -12075,7 +12076,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS39", 11) == 0)
>                      {
>  {
> -return dev_storage + 632;
> +return dev_storage + 633;
>  
>  }
>                      }
> @@ -12090,7 +12091,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS38", 11) == 0)
>                      {
>  {
> -return dev_storage + 631;
> +return dev_storage + 632;
>  
>  }
>                      }
> @@ -12105,7 +12106,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS37", 11) == 0)
>                      {
>  {
> -return dev_storage + 630;
> +return dev_storage + 631;
>  
>  }
>                      }
> @@ -12120,7 +12121,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS36", 11) == 0)
>                      {
>  {
> -return dev_storage + 629;
> +return dev_storage + 630;
>  
>  }
>                      }
> @@ -12135,7 +12136,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS35", 11) == 0)
>                      {
>  {
> -return dev_storage + 628;
> +return dev_storage + 629;
>  
>  }
>                      }
> @@ -12150,7 +12151,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS34", 11) == 0)
>                      {
>  {
> -return dev_storage + 627;
> +return dev_storage + 628;
>  
>  }
>                      }
> @@ -12165,7 +12166,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS33", 11) == 0)
>                      {
>  {
> -return dev_storage + 626;
> +return dev_storage + 627;
>  
>  }
>                      }
> @@ -12180,7 +12181,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS32", 11) == 0)
>                      {
>  {
> -return dev_storage + 625;
> +return dev_storage + 626;
>  
>  }
>                      }
> @@ -12195,7 +12196,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS31", 11) == 0)
>                      {
>  {
> -return dev_storage + 624;
> +return dev_storage + 625;
>  
>  }
>                      }
> @@ -12210,7 +12211,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS30", 11) == 0)
>                      {
>  {
> -return dev_storage + 623;
> +return dev_storage + 624;
>  
>  }
>                      }
> @@ -12402,7 +12403,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS29", 11) == 0)
>                      {
>  {
> -return dev_storage + 622;
> +return dev_storage + 623;
>  
>  }
>                      }
> @@ -12417,7 +12418,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS28", 11) == 0)
>                      {
>  {
> -return dev_storage + 621;
> +return dev_storage + 622;
>  
>  }
>                      }
> @@ -12432,7 +12433,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS27", 11) == 0)
>                      {
>  {
> -return dev_storage + 620;
> +return dev_storage + 621;
>  
>  }
>                      }
> @@ -12447,7 +12448,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS26", 11) == 0)
>                      {
>  {
> -return dev_storage + 619;
> +return dev_storage + 620;
>  
>  }
>                      }
> @@ -12462,7 +12463,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS25", 11) == 0)
>                      {
>  {
> -return dev_storage + 618;
> +return dev_storage + 619;
>  
>  }
>                      }
> @@ -12477,7 +12478,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS24", 11) == 0)
>                      {
>  {
> -return dev_storage + 617;
> +return dev_storage + 618;
>  
>  }
>                      }
> @@ -12492,7 +12493,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS23", 11) == 0)
>                      {
>  {
> -return dev_storage + 616;
> +return dev_storage + 617;
>  
>  }
>                      }
> @@ -12507,7 +12508,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS22", 11) == 0)
>                      {
>  {
> -return dev_storage + 615;
> +return dev_storage + 616;
>  
>  }
>                      }
> @@ -12522,7 +12523,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS21", 11) == 0)
>                      {
>  {
> -return dev_storage + 614;
> +return dev_storage + 615;
>  
>  }
>                      }
> @@ -12537,7 +12538,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS20", 11) == 0)
>                      {
>  {
> -return dev_storage + 613;
> +return dev_storage + 614;
>  
>  }
>                      }
> @@ -12987,7 +12988,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS19", 11) == 0)
>                      {
>  {
> -return dev_storage + 612;
> +return dev_storage + 613;
>  
>  }
>                      }
> @@ -13002,7 +13003,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS18", 11) == 0)
>                      {
>  {
> -return dev_storage + 611;
> +return dev_storage + 612;
>  
>  }
>                      }
> @@ -13017,7 +13018,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS17", 11) == 0)
>                      {
>  {
> -return dev_storage + 610;
> +return dev_storage + 611;
>  
>  }
>                      }
> @@ -13032,7 +13033,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS16", 11) == 0)
>                      {
>  {
> -return dev_storage + 609;
> +return dev_storage + 610;
>  
>  }
>                      }
> @@ -13047,7 +13048,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS15", 11) == 0)
>                      {
>  {
> -return dev_storage + 608;
> +return dev_storage + 609;
>  
>  }
>                      }
> @@ -13062,7 +13063,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS14", 11) == 0)
>                      {
>  {
> -return dev_storage + 607;
> +return dev_storage + 608;
>  
>  }
>                      }
> @@ -13077,7 +13078,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS13", 11) == 0)
>                      {
>  {
> -return dev_storage + 606;
> +return dev_storage + 607;
>  
>  }
>                      }
> @@ -13092,7 +13093,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS12", 11) == 0)
>                      {
>  {
> -return dev_storage + 605;
> +return dev_storage + 606;
>  
>  }
>                      }
> @@ -13107,7 +13108,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS11", 11) == 0)
>                      {
>  {
> -return dev_storage + 604;
> +return dev_storage + 605;
>  
>  }
>                      }
> @@ -13122,7 +13123,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS10", 11) == 0)
>                      {
>  {
> -return dev_storage + 603;
> +return dev_storage + 604;
>  
>  }
>                      }
> @@ -13962,7 +13963,7 @@ return	NULL;
>            if (strncmp (KR_keyword, "/dev/windows", 12) == 0)
>              {
>  {
> -return dev_storage + 722;
> +return dev_storage + 723;
>  
>  }
>              }
> @@ -13977,7 +13978,7 @@ return	NULL;
>            if (strncmp (KR_keyword, "/dev/urandom", 12) == 0)
>              {
>  {
> -return dev_storage + 721;
> +return dev_storage + 722;
>  
>  }
>              }
> @@ -14013,7 +14014,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS127", 12) == 0)
>                      {
>  {
> -return dev_storage + 720;
> +return dev_storage + 721;
>  
>  }
>                      }
> @@ -14028,7 +14029,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS126", 12) == 0)
>                      {
>  {
> -return dev_storage + 719;
> +return dev_storage + 720;
>  
>  }
>                      }
> @@ -14043,7 +14044,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS125", 12) == 0)
>                      {
>  {
> -return dev_storage + 718;
> +return dev_storage + 719;
>  
>  }
>                      }
> @@ -14058,7 +14059,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS124", 12) == 0)
>                      {
>  {
> -return dev_storage + 717;
> +return dev_storage + 718;
>  
>  }
>                      }
> @@ -14073,7 +14074,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS123", 12) == 0)
>                      {
>  {
> -return dev_storage + 716;
> +return dev_storage + 717;
>  
>  }
>                      }
> @@ -14088,7 +14089,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS122", 12) == 0)
>                      {
>  {
> -return dev_storage + 715;
> +return dev_storage + 716;
>  
>  }
>                      }
> @@ -14103,7 +14104,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS121", 12) == 0)
>                      {
>  {
> -return dev_storage + 714;
> +return dev_storage + 715;
>  
>  }
>                      }
> @@ -14118,7 +14119,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS120", 12) == 0)
>                      {
>  {
> -return dev_storage + 713;
> +return dev_storage + 714;
>  
>  }
>                      }
> @@ -14280,7 +14281,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS119", 12) == 0)
>                      {
>  {
> -return dev_storage + 712;
> +return dev_storage + 713;
>  
>  }
>                      }
> @@ -14295,7 +14296,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS118", 12) == 0)
>                      {
>  {
> -return dev_storage + 711;
> +return dev_storage + 712;
>  
>  }
>                      }
> @@ -14310,7 +14311,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS117", 12) == 0)
>                      {
>  {
> -return dev_storage + 710;
> +return dev_storage + 711;
>  
>  }
>                      }
> @@ -14325,7 +14326,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS116", 12) == 0)
>                      {
>  {
> -return dev_storage + 709;
> +return dev_storage + 710;
>  
>  }
>                      }
> @@ -14340,7 +14341,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS115", 12) == 0)
>                      {
>  {
> -return dev_storage + 708;
> +return dev_storage + 709;
>  
>  }
>                      }
> @@ -14355,7 +14356,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS114", 12) == 0)
>                      {
>  {
> -return dev_storage + 707;
> +return dev_storage + 708;
>  
>  }
>                      }
> @@ -14370,7 +14371,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS113", 12) == 0)
>                      {
>  {
> -return dev_storage + 706;
> +return dev_storage + 707;
>  
>  }
>                      }
> @@ -14385,7 +14386,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS112", 12) == 0)
>                      {
>  {
> -return dev_storage + 705;
> +return dev_storage + 706;
>  
>  }
>                      }
> @@ -14400,7 +14401,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS111", 12) == 0)
>                      {
>  {
> -return dev_storage + 704;
> +return dev_storage + 705;
>  
>  }
>                      }
> @@ -14415,7 +14416,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS110", 12) == 0)
>                      {
>  {
> -return dev_storage + 703;
> +return dev_storage + 704;
>  
>  }
>                      }
> @@ -14607,7 +14608,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS109", 12) == 0)
>                      {
>  {
> -return dev_storage + 702;
> +return dev_storage + 703;
>  
>  }
>                      }
> @@ -14622,7 +14623,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS108", 12) == 0)
>                      {
>  {
> -return dev_storage + 701;
> +return dev_storage + 702;
>  
>  }
>                      }
> @@ -14637,7 +14638,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS107", 12) == 0)
>                      {
>  {
> -return dev_storage + 700;
> +return dev_storage + 701;
>  
>  }
>                      }
> @@ -14652,7 +14653,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS106", 12) == 0)
>                      {
>  {
> -return dev_storage + 699;
> +return dev_storage + 700;
>  
>  }
>                      }
> @@ -14667,7 +14668,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS105", 12) == 0)
>                      {
>  {
> -return dev_storage + 698;
> +return dev_storage + 699;
>  
>  }
>                      }
> @@ -14682,7 +14683,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS104", 12) == 0)
>                      {
>  {
> -return dev_storage + 697;
> +return dev_storage + 698;
>  
>  }
>                      }
> @@ -14697,7 +14698,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS103", 12) == 0)
>                      {
>  {
> -return dev_storage + 696;
> +return dev_storage + 697;
>  
>  }
>                      }
> @@ -14712,7 +14713,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS102", 12) == 0)
>                      {
>  {
> -return dev_storage + 695;
> +return dev_storage + 696;
>  
>  }
>                      }
> @@ -14727,7 +14728,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS101", 12) == 0)
>                      {
>  {
> -return dev_storage + 694;
> +return dev_storage + 695;
>  
>  }
>                      }
> @@ -14742,7 +14743,7 @@ return	NULL;
>                    if (strncmp (KR_keyword, "/dev/ttyS100", 12) == 0)
>                      {
>  {
> -return dev_storage + 693;
> +return dev_storage + 694;
>  
>  }
>                      }
> @@ -14931,6 +14932,24 @@ return	NULL;
>  }
>          }
>      case 14:
> +      switch (KR_keyword [5])
> +        {
> +        case 's':
> +          if (strncmp (KR_keyword, "/dev/sequencer", 14) == 0)
> +            {
> +{
> +return dev_storage + 445;
> +
> +}
> +            }
> +          else
> +            {
> +{
> +return	NULL;
> +
> +}
> +            }
> +        case 'c':
>            if (strncmp (KR_keyword, "/dev/clipboard", 14) == 0)
>              {
>  {
> @@ -14945,6 +14964,12 @@ return	NULL;
>  
>  }
>              }
> +        default:
> +{
> +return	NULL;
> +
> +}
> +        }
>      default:
>  {
>  return	NULL;
> diff --git a/winsup/cygwin/devices.in b/winsup/cygwin/devices.in
> index ea9a70e1b..bdf2852fb 100644
> --- a/winsup/cygwin/devices.in
> +++ b/winsup/cygwin/devices.in
> @@ -169,6 +169,7 @@ const _device dev_error_storage =
>  "/dev/ptmx", BRACK(FH_PTMX), "/dev/ptmx", exists, S_IFCHR
>  "/dev/windows", BRACK(FH_WINDOWS), "\\Device\\Null", exists_ntdev, S_IFCHR
>  "/dev/mixer", BRACK(FH_OSS_MIXER), "\\Device\\Null", exists_ntdev, S_IFCHR
> +"/dev/sequencer", BRACK(FH_OSS_SEQUENCER), "\\Device\\Null", exists_ntdev, S_IFCHR
>  "/dev/dsp", BRACK(FH_OSS_DSP), "\\Device\\Null", exists_ntdev, S_IFCHR
>  "/dev/conin", BRACK(FH_CONIN), "/dev/conin", exists_console, S_IFCHR
>  "/dev/conout", BRACK(FH_CONOUT), "/dev/conout", exists_console, S_IFCHR
> diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> index 530c67910..1c8feb16b 100644
> --- a/winsup/cygwin/dtable.cc
> +++ b/winsup/cygwin/dtable.cc
> @@ -566,6 +566,9 @@ fh_alloc (path_conv& pc)
>  	case FH_OSS_MIXER:
>  	  fh = cnew (fhandler_dev_mixer);
>  	  break;
> +	case FH_OSS_SEQUENCER:
> +	  fh = cnew (fhandler_dev_sequencer);
> +	  break;
>  	case FH_OSS_DSP:
>  	  fh = cnew (fhandler_dev_dsp);
>  	  break;
> diff --git a/winsup/cygwin/fhandler/sequencer.cc b/winsup/cygwin/fhandler/sequencer.cc
> new file mode 100644
> index 000000000..1f8ae09a1
> --- /dev/null
> +++ b/winsup/cygwin/fhandler/sequencer.cc
> @@ -0,0 +1,452 @@
> +/* fhandler_dev_sequencer: code to emulate OSS sound model /dev/sequencer
> +
> +   Written by Takashi Yano <takashi.yano@nifty.ne.jp>
> +
> +This file is part of Cygwin.
> +
> +This software is a copyrighted work licensed under the terms of the
> +Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
> +details. */
> +
> +#include "winsup.h"
> +#include <sys/soundcard.h>
> +#include "cygerrno.h"
> +#include "path.h"
> +#include "fhandler.h"
> +#include "dtable.h"
> +#include "cygheap.h"
> +#include <mmddk.h>
> +
> +void
> +fhandler_dev_sequencer::midi_out::reset ()
> +{
> +  buf_len = 0;
> +  msg_len = -1;
> +}
> +
> +void
> +fhandler_dev_sequencer::midi_out::open (int id)
> +{
> +  reset ();
> +  if (MMSYSERR_NOERROR != midiOutOpen (&h_out, id, 0, 0, CALLBACK_NULL))
> +    h_out = NULL;
> +}
> +
> +void
> +fhandler_dev_sequencer::midi_out::close ()
> +{
> +  if (h_out)
> +    midiOutClose (h_out);
> +}
> +
> +void
> +fhandler_dev_sequencer::midi_out::putc (unsigned char c)
> +{
> +  if (buf_len >= sizeof (buf))
> +    return;
> +  if (c & 0x80)
> +    {
> +      switch (c & 0xf0)
> +	{
> +	case 0x80: /* Note off */
> +	case 0x90: /* Note on */
> +	case 0xa0: /* Polyphonic key pressure */
> +	case 0xb0: /* Control change */
> +	case 0xe0: /* Pitch wheel change */
> +	  buf_len = 0;
> +	  msg_len = 3;
> +	  buf[buf_len++] = c;
> +	  break;
> +	case 0xc0: /* Program change */
> +	case 0xd0: /* Channel pressure */
> +	  buf_len = 0;
> +	  msg_len = 2;
> +	  buf[buf_len++] = c;
> +	  break;
> +	case 0xf0:
> +	  switch (c & 0x0f)
> +	    {
> +	    case 0x0: /* System exclusive message */
> +	      buf_len = 0;
> +	      msg_len = -1;
> +	      buf[buf_len++] = c;
> +	      break;
> +	    case 0x1: /* MIDI time code */
> +	    case 0x3: /* Song Select */
> +	      buf_len = 0;
> +	      msg_len = 2;
> +	      buf[buf_len++] = c;
> +	      break;
> +	    case 0x2: /* Song position */
> +	      buf_len = 0;
> +	      msg_len = 3;
> +	      buf[buf_len++] = c;
> +	      break;
> +	    case 0x6: /* Tune request */
> +	    case 0x8: /* MIDI clock */
> +	    case 0xa: /* Sequence start */
> +	    case 0xb: /* Sequence continue */
> +	    case 0xc: /* Sequence stop */
> +	    case 0xe: /* Active Sensing */
> +	    case 0xf: /* Reset */
> +	      buf_len = 0;
> +	      msg_len = 1;
> +	      buf[buf_len++] = c;
> +	      break;
> +	    case 0x7: /* End of system exclusive message */
> +	      buf[buf_len++] = c;
> +		{
> +		  MIDIHDR hdr = {0, };
> +		  hdr.lpData = (char *) buf;
> +		  hdr.dwBufferLength = buf_len;
> +		  hdr.dwBytesRecorded = buf_len;
> +		  midiOutPrepareHeader (h_out, &hdr, sizeof (hdr));
> +		  midiOutLongMsg (h_out, &hdr, sizeof (hdr));
> +		  midiOutUnprepareHeader (h_out, &hdr, sizeof (hdr));
> +		}
> +	      break;
> +	    default: /* 0x4, 0x5, 0x9, 0xd */
> +	      /* Undefined. Ignore. */;
> +	    }
> +	}
> +    }
> +  else
> +    buf[buf_len++] = c;
> +  if (buf_len == msg_len && h_out)
> +    midiOutShortMsg (h_out, *(LPDWORD) buf);
> +}
> +
> +void
> +fhandler_dev_sequencer::midi_putc (int dev, unsigned char c)
> +{
> +  if (dev < 0 || dev >= num_devices)
> +    return;
> +  dev_out[dev].putc (c);
> +}
> +
> +ssize_t
> +fhandler_dev_sequencer::write (const void *ptr, size_t len)
> +{
> +  unsigned char *p = (unsigned char *) ptr;
> +  ssize_t len1 = (ssize_t) len;
> +  unsigned int *timer_param;
> +  DWORD t0 = GetTickCount ();
> +  DWORD t1;
> +  while (len1 > 0)
> +    {
> +      /* Currently, only the atomic-write is supported */
> +      switch (p[0])
> +	{
> +	  case SEQ_MIDIPUTC:
> +	    if (len1 < 4)
> +	      /* Unexpected data. Aborted. */
> +	      goto err;
> +	    midi_putc (p[2], p[1]);
> +	    len1 -= 4;
> +	    p += 4;
> +	    break;
> +	  case EV_TIMING:
> +	    if (len1 < 8)
> +	      /* Unexpected data. Aborted. */
> +	      goto err;
> +	    switch (p[1])
> +	      {
> +	      case TMR_START:
> +		start_time = t0;
> +		last_ticks = 0;
> +		timer_is_running = true;
> +		break;
> +	      case TMR_STOP:
> +		last_ticks =
> +		  (int) ((t0 - start_time) * (tempo * timebase / 60000.0));
> +		start_time -= t0;
> +		timer_is_running = false;
> +		break;
> +	      case TMR_CONTINUE:
> +		if (!timer_is_running)
> +		  start_time += t0;
> +		timer_is_running = true;
> +		break;
> +	      case TMR_WAIT_ABS:
> +		timer_param = (unsigned int *) (p + 4);
> +		t1 = (DWORD)(*timer_param * (60000.0 / (tempo * timebase)));
> +		while (GetTickCount () - start_time < t1)
> +		  Sleep (1);
> +		last_ticks = *timer_param;
> +		break;
> +	      case TMR_WAIT_REL:
> +		timer_param = (unsigned int *) (p + 4);
> +		t1 = (DWORD)((last_ticks + *timer_param)
> +			     * (60000.0 / (tempo * timebase)));
> +		while (GetTickCount () - start_time < t1)
> +		  Sleep (1);
> +		last_ticks += *timer_param;
> +		break;
> +	      case TMR_TEMPO:
> +		timer_param = (unsigned int *) (p + 4);
> +		tempo = *timer_param;
> +		break;
> +	      default:
> +		/* Unexpected data. Ignored. */
> +		system_printf ("Unimplemented timer sub-command: 0x%x\r", p[1]);
> +		break;
> +	      }
> +	    len1 -= 8;
> +	    p += 8;
> +	    break;
> +	  case EV_CHN_COMMON:
> +	    if (len1 < 8)
> +	      /* Unexpected data. Aborted. */
> +	      goto err;
> +	    switch (p[2])
> +	      {
> +	      case MIDI_PGM_CHANGE:
> +		midi_putc (p[1], 0xc0 | (p[3] & 0x0f));
> +		midi_putc (p[1], p[4]);
> +		break;
> +	      case MIDI_CTL_CHANGE:
> +		midi_putc (p[1], 0xb0 | (p[3] & 0x0f));
> +		midi_putc (p[1], p[4]);
> +		midi_putc (p[1], p[6]);
> +		break;
> +	      case MIDI_PITCH_BEND:
> +		midi_putc (p[1], 0xe0 | (p[3] & 0x0f));
> +		midi_putc (p[1], p[6]);
> +		midi_putc (p[1], p[7]);
> +		break;
> +	      case MIDI_CHN_PRESSURE:
> +		midi_putc (p[1], 0xd0 | (p[3] & 0x0f));
> +		midi_putc (p[1], p[4]);
> +		break;
> +	      default:
> +		/* Unexpected data. Ignored. */
> +		system_printf ("Unimplemented chn-common sub-command: "
> +			       "0x%x\r", p[2]);
> +		break;
> +	      }
> +	    len1 -= 8;
> +	    p += 8;
> +	    break;
> +	  case EV_CHN_VOICE:
> +	    if (len1 < 8)
> +	      /* Unexpected data. Aborted. */
> +	      goto err;
> +	    switch (p[2])
> +	      {
> +	      case MIDI_NOTEON:
> +		midi_putc (p[1], 0x90 | (p[3] & 0x0f));
> +		midi_putc (p[1], p[4]);
> +		midi_putc (p[1], p[5]);
> +		break;
> +	      case MIDI_NOTEOFF:
> +		midi_putc (p[1], 0x80 | (p[3] & 0x0f));
> +		midi_putc (p[1], p[4]);
> +		midi_putc (p[1], p[5]);
> +		break;
> +	      case MIDI_KEY_PRESSURE:
> +		midi_putc (p[1], 0xa0 | (p[3] & 0x0f));
> +		midi_putc (p[1], p[4]);
> +		midi_putc (p[1], p[5]);
> +		break;
> +	      default:
> +		/* Unexpected data. Ignored. */
> +		system_printf ("Unimplemented chn-voice sub-command: "
> +			       "0x%x\r", p[2]);
> +		break;
> +	      }
> +	    len1 -= 8;
> +	    p += 8;
> +	    break;
> +	  case EV_SYSEX:
> +	    if (len1 < 8)
> +	      /* Unexpected data. Aborted. */
> +	      goto err;
> +	    midi_putc (p[1], 0xf0);
> +	    for (int i = 2; i < 8; i++)
> +	      if (p[i] != 0xff)
> +		midi_putc (p[1], p[i]);
> +	    midi_putc (p[1], 0xf7);
> +	    len1 -= 8;
> +	    p += 8;
> +	    break;
> +	  case SEQ_PRIVATE:
> +	    system_printf ("SEQ_PRIVATE unimplemented\r");
> +	    len1 -= 8;
> +	    p += 8;
> +	    break;
> +	  case SEQ_EXTENDED:
> +	    system_printf ("SEQ_EXTENDED unimplemented\r");
> +	    len1 -= 8;
> +	    p += 8;
> +	    break;
> +	  default:
> +	    /* Unexpected data. Aborted. */
> +	    system_printf ("Unimplemented command: 0x%x\r", p[0]);
> +	    goto err;
> +	}
> +    }
> +  return len;
> +
> +err:
> +  system_printf ("Unexpected data. Aborted. (length=%d/%d)\r", len1, len);
> +  return len;
> +}
> +
> +void
> +fhandler_dev_sequencer::read (void *ptr, size_t& len)
> +{
> +  len = -1;
> +  set_errno (EINVAL);
> +}
> +
> +int
> +fhandler_dev_sequencer::open (int flags, mode_t)
> +{
> +  int ret = -1;
> +  switch (flags & O_ACCMODE)
> +    {
> +    case O_RDWR:
> +    case O_WRONLY:
> +      num_devices = midiOutGetNumDevs ();
> +      if (num_devices > 256)
> +	num_devices = 256;
> +      if (num_devices == 0)
> +	{
> +	  set_errno (ENXIO);
> +	  goto out;
> +	}
> +
> +      dev_out = (midi_out *) malloc (num_devices * sizeof (midi_out));
> +      for (int i = 0; i < num_devices; i++)
> +	dev_out[i].open (i);
> +      ret = open_null (flags);
> +      tempo = 60;
> +      timebase = 100;
> +      timer_is_running = false;
> +      break;
> +    default:
> +      set_errno (ENXIO);
> +    }
> +
> +out:
> +  return ret;
> +}
> +
> +int
> +fhandler_dev_sequencer::close (int flag)
> +{
> +  for (int i = 0; i < num_devices; i++)
> +    dev_out[i].close ();
> +  free (dev_out);
> +  return 0;
> +}
> +
> +int
> +fhandler_dev_sequencer::ioctl (unsigned int cmd, void *arg)
> +{
> +  int ret = 0;
> +  int *d = (int *) arg;
> +  DWORD t0 = GetTickCount ();
> +  switch (cmd)
> +    {
> +    case SNDCTL_SEQ_RESET:
> +      tempo = 60;
> +      timebase = 100;
> +      timer_is_running = false;
> +      start_time = 0;
> +      last_ticks = 0;
> +      for (int i = 0; i < num_devices; i++)
> +	dev_out[i].reset ();
> +      break;
> +    case SNDCTL_SEQ_NRSYNTHS:
> +      if (d)
> +	*d = 0;
> +      break;
> +    case SNDCTL_SEQ_NRMIDIS:
> +      if (d)
> +	*d = num_devices;
> +      break;
> +    case SNDCTL_TMR_TIMEBASE:
> +      if (d)
> +	{
> +	  if (*d)
> +	    timebase = *d;
> +	  else
> +	    *d = timebase;
> +	}
> +      break;
> +    case SNDCTL_TMR_TEMPO:
> +      if (d)
> +	{
> +	  if (*d)
> +	    tempo = *d;
> +	  else
> +	    *d = tempo;
> +	}
> +      break;
> +    case SNDCTL_TMR_START:
> +      start_time = t0;
> +      last_ticks = 0;
> +      timer_is_running = true;
> +      break;
> +    case SNDCTL_TMR_STOP:
> +      last_ticks = (int) ((t0 - start_time) * (tempo * timebase / 60000.0));
> +      start_time -= t0;
> +      timer_is_running = false;
> +      break;
> +    case SNDCTL_TMR_CONTINUE:
> +      if (!timer_is_running)
> +	start_time += t0;
> +      timer_is_running = true;
> +      break;
> +    case SNDCTL_SEQ_CTRLRATE:
> +      if (d)
> +	*d = tempo * timebase / 60;
> +      break;
> +    case SNDCTL_SEQ_GETTIME:
> +      if (d)
> +	{
> +	  if (timer_is_running)
> +	    *d = (int) ((t0 - start_time) * (tempo * timebase / 60000.0));
> +	  else
> +	    *d = (int) (last_ticks * (tempo * timebase / 60000.0));
> +	}
> +      break;
> +    case SNDCTL_TMR_SOURCE:
> +      if (d)
> +	{
> +	  if (*d && *d != TMR_INTERNAL)
> +	    {
> +	      set_errno (EINVAL);
> +	      ret = -1;
> +	    }
> +	  else if (*d == 0)
> +	    *d = TMR_INTERNAL;
> +	}
> +      break;
> +    case SNDCTL_TMR_SELECT:
> +      if (d && *d != 0) /* Only 0 is available */
> +	{
> +	  set_errno (EINVAL);
> +	  ret = -1;
> +	}
> +      break;
> +    case SNDCTL_SEQ_GETOUTCOUNT:
> +      if (d)
> +	*d = 0;
> +      break;
> +    case SNDCTL_SEQ_GETINCOUNT:
> +      if (d)
> +	*d = 0;
> +      break;
> +    case SNDCTL_SEQ_SYNC:
> +      /* Dummy implementation */
> +      break;
> +    default:
> +      system_printf("Unimplemented ioctl(): 0x%x\r", cmd);
> +      set_errno (EINVAL);
> +      ret = -1;
> +      break;
> +    }
> +  return ret;
> +}
> diff --git a/winsup/cygwin/local_includes/devices.h b/winsup/cygwin/local_includes/devices.h
> index dc4a29b12..10a46150e 100644
> --- a/winsup/cygwin/local_includes/devices.h
> +++ b/winsup/cygwin/local_includes/devices.h
> @@ -243,6 +243,7 @@ enum fh_devices
>  
>    DEV_SOUND_MAJOR = 14,
>    FH_OSS_MIXER = FHDEV (DEV_SOUND_MAJOR, 0),
> +  FH_OSS_SEQUENCER = FHDEV (DEV_SOUND_MAJOR, 1),
>    FH_OSS_DSP = FHDEV (DEV_SOUND_MAJOR, 3),
>  
>    DEV_SOCK_MAJOR = 30,
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
> index 766bb0c91..3889039ba 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2857,6 +2857,58 @@ class fhandler_dev_mixer: public fhandler_base
>    }
>  };
>  
> +class fhandler_dev_sequencer: public fhandler_base
> +{
> +private:
> +  int num_devices;
> +  class midi_out {
> +  private:
> +    struct HMIDIOUT__ *h_out;
> +    unsigned char buf[4096];
> +    size_t msg_len;
> +    size_t buf_len;
> +  public:
> +    void reset ();
> +    void open (int);
> +    void close ();
> +    void putc (unsigned char);
> +  };
> +  midi_out *dev_out;
> +  void midi_putc (int, unsigned char);
> +
> +  /* Timer stuff */
> +  int timebase;
> +  int tempo;
> +  int last_ticks;
> +  DWORD start_time;
> +  bool timer_is_running;
> +public:
> +  fhandler_dev_sequencer () {}
> +  int open (int, mode_t mode = 0);
> +  int close (int flag = -1);
> +  ssize_t write (const void *, size_t);
> +  void read (void *, size_t&);
> +  int ioctl (unsigned int, void *);
> +
> +  fhandler_dev_sequencer (void *) {}
> +
> +  void copy_from (fhandler_base *x)
> +    {
> +      pc.free_strings ();
> +      *this = *reinterpret_cast<fhandler_dev_sequencer *> (x);
> +      _copy_from_reset_helper ();
> +    }
> +
> +  fhandler_dev_sequencer *clone (cygheap_types malloc_type = HEAP_FHANDLER)
> +    {
> +      void *ptr =
> +	(void *) ccalloc (malloc_type, 1, sizeof (fhandler_dev_sequencer));
> +      fhandler_dev_sequencer *fh = new (ptr) fhandler_dev_sequencer (ptr);
> +      fh->copy_from (this);
> +      return fh;
> +    }
> +};
> +
>  class fhandler_dev_dsp: public fhandler_base
>  {
>   public:
> -- 
> 2.51.0
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Tue__6_Oct_2026_21_37_49_+0900_+Tqtf5ILM5FQEaNx
Content-Type: text/plain;
 name="playmidi.cygport"
Content-Disposition: attachment;
 filename="playmidi.cygport"
Content-Transfer-Encoding: base64

TkFNRT1wbGF5bWlkaQ0KVkVSU0lPTj0yLjUNClJFTEVBU0U9MQ0KTElDRU5TRT1HUEwtMi4wLW9u
bHkNCkhPTUVQQUdFPSJodHRwczovL3NvdXJjZWZvcmdlLm5ldC9wcm9qZWN0cy9wbGF5bWlkaS8i
DQpDQVRFR09SWT0iQXVkaW8iDQpTVU1NQVJZPSJhIHNpbXBsZSBNSURJIGZpbGUgcGxheWVyIg0K
U1JDX1VSST0iaHR0cHM6Ly9zb3VyY2Vmb3JnZS5uZXQvcHJvamVjdHMvcGxheW1pZGkvZmlsZXMv
cGxheW1pZGkvJHtWRVJTSU9OfS9wbGF5bWlkaS0ke1ZFUlNJT059LnRhci5neiINClNSQ19ESVI9
InBsYXltaWRpLTIuNCINCnNyY19jb21waWxlKCkgeyANCgljZCAke0J9DQoJbG5kaXJzDQoJcm0g
aW9fc3ZnYWxpYi5jDQoJY3lnbWFrZSBDRkxBR1M9ImBwa2ctY29uZmlnIC0tY2ZsYWdzIGd0aytg
Ig0KfQ0Kc3JjX2luc3RhbGwoKSB7DQoJY2QgJHtCfQ0KCWRvZG9jICR7U30vQ09QWUlORyAke1N9
L1JFQURNRS4xU1QgJHtTfS9RdWlja1N0YXJ0DQoNCglkb2RpciAvZXRjDQoJaW5zaW50byAvZXRj
DQoJZG9pbnMgJHtTfS9kcnVtcy5vMyAke1N9L2RydW1zLnNiICR7U30vc3RkLm8zICR7U30vc3Rk
LnNiDQoNCglkb2RpciAvdXNyL2Jpbg0KCWluc2ludG8gL3Vzci9iaW4NCglkb2lucyAke0J9L3Bs
YXltaWRpICR7Qn0veHBsYXltaWRpDQoNCglkb2RpciAvdXNyL1gxMS9hcHAtZGVmYXVsdHMNCglp
bnNpbnRvIC91c3IvWDExL2FwcC1kZWZhdWx0cw0KCWNwICR7U30vWFBsYXltaWRpLmFkICR7Qn0v
WFBsYXltaWRpDQoJZG9pbnMgJHtCfS9YUGxheW1pZGkNCgkNCn0NCkJVSUxEX1JFUVVJUkVTPSJs
aWJndGsxLjItZGV2ZWwiDQo=

--Multipart=_Tue__6_Oct_2026_21_37_49_+0900_+Tqtf5ILM5FQEaNx
Content-Type: text/plain;
 name="playmidi-2.5-1.src.patch"
Content-Disposition: attachment;
 filename="playmidi-2.5-1.src.patch"
Content-Transfer-Encoding: 7bit

--- origsrc/playmidi-2.4/Makefile	1998-10-01 11:39:18.000000000 +0900
+++ src/playmidi-2.4/Makefile	2026-10-06 18:03:58.413898700 +0900
@@ -43,7 +43,7 @@ INSTALLDIR = /usr/bin
 INSTALL = install -s
 
 # if you are using the GUS Ultra driver module, add -DULTRA_DRIVER
-CFLAGS	= -Wall -pipe -fomit-frame-pointer -O2 -m486 $(INCAWE)
+CFLAGS	= -Wall -pipe -fomit-frame-pointer -O2 $(INCAWE)
 LDFLAGS =
 
 OBJECTS = playmidi.o readmidi.o playevents.o \
@@ -60,9 +60,9 @@ GOBJECTS= playmidi.o readmidi.o playeven
 
 all: playmidi xplaymidi 
 
-config:
-playmidi.h: playmidi.h-dist
-	./Configure
+#config:
+#playmidi.h: playmidi.h-dist
+#	./Configure
 
 io_ncurses.o: io_ncurses.c
 	$(CC) $(CFLAGS) $(INCNC) -c io_ncurses.c -o io_ncurses.o
--- origsrc/playmidi-2.4/config.sed	1970-01-01 09:00:00.000000000 +0900
+++ src/playmidi-2.4/config.sed	2026-10-06 18:03:58.416898300 +0900
@@ -0,0 +1,5 @@
+	s/DEFAULT_PLAYBACK_MODE/PLAY_MIDI/
+	s/DEFAULT_FM_MODE/0/
+	s/MIDI_DEFAULT_DEV/0/
+	s/PRIMARY_GUS_PATCH_LOCATION/\/dos\/ultrasnd\/midi/
+	s/SECONDARY_GUS_PATCH_LOCATION/\/usr\/local\/lib\/Plib/
--- origsrc/playmidi-2.4/emumidi.h	1997-05-12 06:26:36.000000000 +0900
+++ src/playmidi-2.4/emumidi.h	2026-10-06 18:03:58.419909700 +0900
@@ -14,11 +14,13 @@
    Kelly Drive, Lackland AFB, TX 78236-5128, USA.
  *************************************************************************/
 #include "playmidi.h"
+#ifndef __CYGWIN__
 #ifdef linux
 #include <linux/ultrasound.h>
 #else
 #include <machine/ultrasound.h>
 #endif
+#endif
 
 /*
  * TABLE OF NEARLY EXACT FREQUENCIES FOR ALL MIDI NOTES (A=440Hz)
--- origsrc/playmidi-2.4/io_ncurses.c	1997-05-12 06:37:03.000000000 +0900
+++ src/playmidi-2.4/io_ncurses.c	2026-10-06 18:03:58.422899700 +0900
@@ -254,7 +254,7 @@ int length;
 	    break;
 	case MIDI_PITCH_BEND:
 	    {
-		register val = (VEL << 7) | NOTE;
+		int val = (VEL << 7) | NOTE;
 
 		if (graphics) {
 		    attrset(A_BOLD);
--- origsrc/playmidi-2.4/patchload.c	1998-02-08 01:22:51.000000000 +0900
+++ src/playmidi-2.4/patchload.c	2026-10-06 18:03:58.425898800 +0900
@@ -16,11 +16,23 @@
  *************************************************************************/
 
 #include "playmidi.h"
+#ifdef __CYGWIN__
+#define _GUS_NUMVOICES 0x00
+#define _GUS_CMD(chn, voice, cmd, p1, p2) \
+    {_SEQ_NEEDBUF(8); _seqbuf[_seqbufptr] = SEQ_PRIVATE;\
+    _seqbuf[_seqbufptr+1] = (chn); _seqbuf[_seqbufptr+2] = cmd;\
+    _seqbuf[_seqbufptr+3] = voice;\
+    *(unsigned short*)&_seqbuf[_seqbufptr+4] = p1;\
+    *(unsigned short*)&_seqbuf[_seqbufptr+6] = p2;\
+    _SEQ_ADVBUF(8);}
+#define GUS_NUMVOICES(chn, p1) _GUS_CMD(chn, 0, _GUS_NUMVOICES, (p1), 0)
+#else
 #ifdef linux
 #include <linux/ultrasound.h>
 #else
 #include <machine/ultrasound.h>
 #endif
+#endif
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
--- origsrc/playmidi-2.4/playmidi.c	1997-05-18 23:48:24.000000000 +0900
+++ src/playmidi-2.4/playmidi.c	2026-10-06 20:17:10.377131200 +0900
@@ -114,10 +114,10 @@ void synth_setup()
 	exit(-1);
     }
     if (nrmidis > 0) {
-	if (FORCE_EXT_DEV >= 0)
+	if (FORCE_EXT_DEV >= 0 && FORCE_EXT_DEV < nrmidis)
 	    ext_dev = FORCE_EXT_DEV;
 	else
-	    ext_dev = nrmidis - 1;
+	    ext_dev = 0;
     }
     if (!play_gus)
 	gus_dev = -1;
--- origsrc/playmidi-2.4/playmidi.h	1970-01-01 09:00:00.000000000 +0900
+++ src/playmidi-2.4/playmidi.h	2026-10-06 18:03:58.428910200 +0900
@@ -0,0 +1,107 @@
+#define RELEASE "Playmidi 2.4"
+/************************************************************************
+   playmidi.h  --  defines and structures for use by playmidi package
+
+   Copyright (C) 1994-1996 Nathan I. Laredo
+
+   This program is modifiable/redistributable under the terms
+   of the GNU General Public Licence.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+   Send your comments and all your spare pocket change to
+   laredo@gnu.ai.mit.edu (Nathan Laredo) or to PSC 1, BOX 709, 2401
+   Kelly Drive, Lackland AFB, TX 78236-5128, USA.
+ *************************************************************************
+ * the following definition is set by Configure */
+#define DEFAULT_MIDI_DEV	1
+/* Default mask for percussion instruments.  Channels 16 and 10 = 0x8200 */
+#define PERCUSSION	0x0200
+/* the following definition is set by Configure */
+#define PLAY_MIDI
+/* change the following if you have lots of synth devices */
+#define MAX_CARDS	5
+/* the following definition is set by Configure */
+#define FM_DEFAULT_MODE	0
+/* the following definition is set by Configure */
+#define PATCH_PATH1	"/dos/ultrasnd/midi"
+/* the following definition is set by Configure */
+#define PATCH_PATH2	"/usr/local/lib/Plib"
+/* change this if you notice performance problems,  128 bytes by default */
+#define SEQUENCERBLOCKSIZE 128
+/* change this if you have really outrageous midi files > 128 tracks */
+/* 128 tracks is approximately a 4K structure */
+#define MAXTRKS		128
+/* where to find fm patch libraries */
+#define SEQUENCER_DEV	"/dev/sequencer"
+#define O3MELODIC	"/etc/std.o3"
+#define O3DRUMS		"/etc/drums.o3"
+#define SBMELODIC	"/etc/std.sb"
+#define SBDRUMS		"/etc/drums.sb"
+#define ISPERC(x)	(perc & (1 << x))
+#define ISGUS(x)	(play_gus & (1 << x))
+#define ISFM(x)		(play_fm & (1 << x))
+#define ISMIDI(x)	(play_ext & (1 << x))
+#define ISAWE(x)	(play_awe & (1 << x))
+#define ISPLAYING(x)	(chanmask & (1 << x))
+#define NO_EXIT		100
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <sys/soundcard.h>
+#include <sys/ioctl.h>
+#ifdef linux
+#include <linux/awe_voice.h>
+#else
+#include "awe_voice.h"
+#endif
+
+struct chanstate {
+    int program;
+    int bender;
+    int oldbend;	/* used for graphics */
+    int bender_range;
+    int oldrange;	/* used for graphics */
+    int controller[255];
+    int pressure;
+};
+
+struct voicestate {
+    int note;
+    int channel;
+    int timestamp;
+    int dead;
+};
+/* Non-standard MIDI file formats */
+#define RIFF			0x52494646
+#define CTMF			0x43544d46
+/* Standard MIDI file format definitions */
+#define MThd			0x4d546864
+#define MTrk			0x4d54726b
+#define	meta_event		0xff
+#define	sequence_number 	0x00
+#define	text_event		0x01
+#define copyright_notice 	0x02
+#define sequence_name    	0x03
+#define instrument_name 	0x04
+#define lyric	        	0x05
+#define marker			0x06
+#define	cue_point		0x07
+#define channel_prefix		0x20
+#define	end_of_track		0x2f
+#define	set_tempo		0x51
+#define	smpte_offset		0x54
+#define	time_signature		0x58
+#define	key_signature		0x59
+#define	sequencer_specific	0x74
+
+struct miditrack {
+   unsigned char *data;		/* data of midi track */
+   unsigned long int length;	/* length of track data */
+   unsigned long int index;	/* current byte in track */
+   unsigned long int ticks;	/* current midi tick count */
+   unsigned char running_st;	/* running status byte */
+};
+

--Multipart=_Tue__6_Oct_2026_21_37_49_+0900_+Tqtf5ILM5FQEaNx--
