Return-Path: <SRS0=lxoL=4U=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id 3FF6D3857026
	for <cygwin-patches@cygwin.com>; Thu, 22 Dec 2022 20:26:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3FF6D3857026
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTP
	id 8Hc0pJPk3l2xS8S8opBL4O; Thu, 22 Dec 2022 20:26:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1671740770; bh=Mc1R92iIhC7u5ILKqXMJpT8GwSZJ6OjSAT7m2THnJc0=;
	h=Date:From:Subject:To:Reply-To;
	b=gRVyXN0G9hlm+H44Ku4/ekYAUY8rvvYeLDoueoxMCJE69aZMpkUM3mrKiV7LghSLd
	 4+/f+vyMd0keh7881gBGnXcS7PtPyKOz904HSbz+DQ9UA7QtpSGaMq5oFk86ZU1ZnL
	 3pr4a3Sdywq0QP7b/ysUUNpybgob46cEykEHr3icH93uAWGuLfGr7IXomTPuQSJFmj
	 Hkad0xVSl3mATgOcCoWfoVtQFUa4J3RmHTHRG+HlRcVy419XMaWhMueFfRwBPPZYJZ
	 Iw65E/cAtg0gWOCSh0xBHBzRtuwHYu1hRK3C3GW5+182gO3/mhQNYBnce3JEmAbZaA
	 oWfbMikqWyvxw==
Received: from [10.0.0.5] ([184.64.124.72])
	by cmsmtp with ESMTP
	id 8S8npB1yOyAOe8S8npdvLu; Thu, 22 Dec 2022 20:26:10 +0000
X-Authority-Analysis: v=2.4 cv=e5oV9Il/ c=1 sm=1 tr=0 ts=63a4bd62
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=uaBMWcycIeZdFX-EFUsA:9 a=QEXdDO2ut3YA:10
 a=k4UfgQKOEQEA:10 a=RdwwBK8X-F3Ms-17ZgIA:9 a=B2y7HmGcmWMA:10
Content-Type: multipart/mixed; boundary="------------5uDAcGlsLFufycc9RMRI5Tzd"
Message-ID: <4d0d6a99-5f21-33dc-c9fa-7d73eef030bd@Shaw.ca>
Date: Thu, 22 Dec 2022 13:26:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Subject: [PATCH] fhandler/proc.cc(format_proc_cpuinfo): add Linux 6.1 cpuinfo
To: Cygwin Patches <cygwin-patches@cygwin.com>
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Language: en-CA
Organization: Inglis
X-CMAE-Envelope: MS4xfBbs5+s31VSyf0EvUjoHJ3cIoIKCS9Anizh1wI8rPkuOKeZCLnSVfLnkeKGG1za6ABp31rj6gfEzZ1tgIypRz8O3H2qR09ikbeqlnvW3xyYfaLrMD9Zl
 4k00Qn1MKsvyM2LMEKjm8TOPpXHS+pBtaIpoRqyRZkdojkQGfYADiICSMYHpVsap7QRZUbvK/N37U2BiEyM98fBDYRaQT1HQDbqccVoWQd54zgkTllCrWS2z
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------5uDAcGlsLFufycc9RMRI5Tzd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Intel 0x00000007:1 EAX:26 lam	Linear Address Masking (& recent entries)
---
  winsup/cygwin/fhandler/proc.cc | 4 ++++
  1 file changed, 4 insertions(+)


--------------5uDAcGlsLFufycc9RMRI5Tzd
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-fhandler-proc.cc-format_proc_cpuinfo-add-Linux-6.1-cpuinfo.patch"
Content-Disposition: attachment;
 filename*0="0001-fhandler-proc.cc-format_proc_cpuinfo-add-Linux-6.1-cpui";
 filename*1="nfo.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIvcHJvYy5jYyBiL3dpbnN1cC9j
eWd3aW4vZmhhbmRsZXIvcHJvYy5jYw0KaW5kZXggNjY0M2QxZjFhYTBmLi43NWE2YTg1NTE3
Y2QgMTAwNjQ0DQotLS0gYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyL3Byb2MuY2MNCisrKyBi
L3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIvcHJvYy5jYw0KQEAgLTE0ODQsNiArMTQ4NCwxMCBA
QCBmb3JtYXRfcHJvY19jcHVpbmZvICh2b2lkICosIGNoYXIgKiZkZXN0YnVmKQ0KIA0KIAkg
IGZ0Y3ByaW50IChmZWF0dXJlczEsICA0LCAiYXZ4X3ZubmkiKTsJICAgIC8qIHZleCBlbmMg
Tk4gdmVjICovDQogCSAgZnRjcHJpbnQgKGZlYXR1cmVzMSwgIDUsICJhdng1MTJfYmYxNiIp
OyAgLyogdmVjIGJmbG9hdDE2IHNob3J0ICovDQorLyoJICBmdGNwcmludCAoZmVhdHVyZXMx
LCAgNywgImNtcGNjeGFkZCIpOyAqLyAvKiBDTVBjY1hBREQgaW5zdHJ1Y3Rpb25zICovDQor
LyoJICBmdGNwcmludCAoZmVhdHVyZXMxLCAyMSwgImFteF9mcDE2Iik7CSAqLyAvKiBBTVgg
ZnAxNiBTdXBwb3J0ICovDQorLyoJICBmdGNwcmludCAoZmVhdHVyZXMxLCAyMywgImF2eF9p
Zm1hIik7CSAqLyAvKiBTdXBwb3J0IGZvciBWUE1BREQ1MltILExdVVEgKi8NCisJICBmdGNw
cmludCAoZmVhdHVyZXMxLCAyNiwgImxhbSIpOwkgICAgLyogTGluZWFyIEFkZHJlc3MgTWFz
a2luZyAqLw0KIAl9DQogDQogICAgICAgLyogQU1EIGNwdWlkIDB4ODAwMDAwMDggZWJ4ICov
DQoNCg==

--------------5uDAcGlsLFufycc9RMRI5Tzd--
