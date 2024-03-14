Return-Path: <SRS0=fxz/=KU=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id E96F3385E021
	for <cygwin-patches@cygwin.com>; Thu, 14 Mar 2024 16:10:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E96F3385E021
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E96F3385E021
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1710432658; cv=none;
	b=QB9V3j/gbWiFd/UOKeua6xOj3WjEoAhn5JEwqqhnUj8NALuVLrpMxaLwrfYxHFJ+hV+DOuDodaq2zC9eH/aWGGAZdK73njC8JoSlg+vvuPoiYu5Hydx7AHcCLOSkC0vNkhr/Cn1XK8zqqPBSPBPf5XvcAWb8Lem8VSsFkL2eM7w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1710432658; c=relaxed/simple;
	bh=GyUI3LNqwOEYsSKyiBty+b1A16MF1Eoz0hNx/C28/mQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject; b=OjaaPWQnnWZU2SmjhG48+7V2OIJiuyk5WxwW7zzscUSCfokOan4h3Fu0vPE6Gabrb/kKsfP+6tbm/gQrxD/VTPe0JTvgHRMhmH53dXFZVtZ2dMgXMF+mHcGErnGC6b4uunlF8EMsorMYsXxoh9izIvCd08m1/D+POLKW31/ZjOM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 1C67BA065B
	for <cygwin-patches@cygwin.com>; Thu, 14 Mar 2024 16:10:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf03.hostedemail.com (Postfix) with ESMTPA id 99FB76000B
	for <cygwin-patches@cygwin.com>; Thu, 14 Mar 2024 16:10:52 +0000 (UTC)
Message-ID: <9599b8e1-6d67-4b00-b7af-c412298d78af@SystematicSW.ab.ca>
Date: Thu, 14 Mar 2024 10:10:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: newlib-cygwin build fails on dumper
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 99FB76000B
X-Stat-Signature: enb6w5j6xpbs4napkxa7manjrqx53y6f
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KAM_ASCII_DIVIDERS,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+tITEUM4FuucVAG7jYR81bEVxvOLCmxgs=
X-HE-Tag: 1710432652-951742
X-HE-Meta: U2FsdGVkX1/iXfeqAvL3cNl17nu+TTsljGEzlYlnJh4uT6ZPxgehG/7ATBTjwaVEhlR8W3JhQNprkHLzZjLs9shPe4CeQBfagQRy3422fMm7bgEg40Uq/Um1VoEKRL8lxNuIfrUtumAjLvLQxN8CisVC7SJIeAvVPSZTHUWc7B9AXGpntMR4h9mefQ0Ox1o+aQQ/MAsI10hOrfIBAVx1fcEcSBQwT9zHrRs5MdflWb6d/67M86APJ6LnJtitq9Rk76vaQ9qTsUUXop4VXTmmDc0SwB0QjqpV8Bnw6Ws2g9rKjFmCB0PcgbnUo3K1hPQ8Kq9Kb26TwTND6qLfcZS7NwdAYJN84heX
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi folks,

During newlib-cygwin build to test patches, with latest current stable packages 
as of last weekend, and yesterday's repo main/master, get a warning, then errors 
building dumper:

...

   CC       libc/reent/libc_a-getentropyr.o
/usr/src/newlib-cygwin/newlib/libc/reent/getentropyr.c: In function ‘_getentropy_r’:
/usr/src/newlib-cygwin/newlib/libc/reent/getentropyr.c:48:14: warning: implicit 
declaration of function ‘_getentropy’; did you mean ‘getentropy’? 
[-Wimplicit-function-declaration]
    48 |   if ((ret = _getentropy (buf, buflen)) == -1 && errno != 0)
       |              ^~~~~~~~~~~
       |              getentropy

...

   CXX      dumper-dumper.o
In file included from /usr/src/newlib-cygwin/winsup/utils/dumper.cc:23:
/usr/include/bfd.h:2748:1: error: expected initializer before 
‘ATTRIBUTE_WARN_UNUSED_RESULT’
  2748 | ATTRIBUTE_WARN_UNUSED_RESULT;
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/bfd.h:2751:1: error: expected initializer before 
‘ATTRIBUTE_WARN_UNUSED_RESULT’
  2751 | ATTRIBUTE_WARN_UNUSED_RESULT;
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/bfd.h:2753:27: error: expected initializer before 
‘ATTRIBUTE_WARN_UNUSED_RESULT’
  2753 | file_ptr bfd_tell (bfd *) ATTRIBUTE_WARN_UNUSED_RESULT;
       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/bfd.h:2757:37: error: expected initializer before 
‘ATTRIBUTE_WARN_UNUSED_RESULT’
  2757 | int bfd_stat (bfd *, struct stat *) ATTRIBUTE_WARN_UNUSED_RESULT;
       |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/bfd.h:2759:37: error: expected initializer before 
‘ATTRIBUTE_WARN_UNUSED_RESULT’
  2759 | int bfd_seek (bfd *, file_ptr, int) ATTRIBUTE_WARN_UNUSED_RESULT;
       |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/bfd.h:2770:1: error: expected initializer before 
‘ATTRIBUTE_WARN_UNUSED_RESULT’
  2770 | ATTRIBUTE_WARN_UNUSED_RESULT;
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[5]: *** [Makefile:782: dumper-dumper.o] Error 1
make[5]: Leaving directory '/usr/src/build64/x86_64-pc-cygwin/winsup/utils'

...

$ uname -srvmo
CYGWIN_NT-10.0-19045 3.5.1-1.x86_64 2024-02-27 11:54 UTC x86_64 Cygwin
$ cygcheck -c `sed 's!,!!g' <<< 'binutils, cygwin, libgcc1, libintl8, libzstd1, 
zlib0, autoconf, automake, cocom, cygport, dblatex, dejagnu, docbook-xml45, 
docbook-xsl, docbook2X, gcc-g++, gettext-devel, libiconv, libiconv-devel, 
libzstd-devel, make, mingw64-x86_64-gcc-g++, mingw64-x86_64-zlib, patch, perl, 
python39-lxml, python39-ply, texlive-collection-fontsrecommended, 
texlive-collection-latexrecommended, texlive-collection-pictures, xmlto, 
zlib-devel'`
Cygwin Package Information
Package                             Version     Status
autoconf                            15-2           OK
automake                            11-1           OK
binutils                            2.42-1         OK
cocom                               0.996-2        OK
cygport                             0.36.8-1       OK
cygwin                              3.5.1-1        OK
dblatex                             0.3.12-2       OK
dejagnu                             1.6.3-1        OK
docbook-xml45                       4.5-1          OK
docbook-xsl                         1.77.1-1       OK
docbook2X                           0.8.8-1        OK
gcc-g++                             11.4.0-1       OK
gettext-devel                       0.22.4-1       OK
libgcc1                             11.4.0-1       OK
libiconv                            1.17-1         OK
libiconv-devel                      1.17-1         OK
libintl8                            0.22.4-1       OK
libzstd-devel                       1.5.5-1        OK
libzstd1                            1.5.5-1        OK
make                                4.4.1-2        OK
mingw64-x86_64-gcc-g++              11.4.0-1       OK
mingw64-x86_64-zlib                 1.3.1-1        OK
patch                               2.7.6-17       OK
perl                                5.36.3-1       OK
python39-lxml                       4.7.1-1        OK
python39-ply                        3.11-3         OK
texlive-collection-fontsrecommended 20230313-1     OK
texlive-collection-latexrecommended 20230313-1     OK
texlive-collection-pictures         20230313-1     OK
xmlto                               0.0.28-1       OK
zlib-devel                          1.3.1-1        OK
zlib0                               1.3.1-1        OK

Any ideas what might be going wrong here or what I may be missing?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
