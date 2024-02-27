Return-Path: <SRS0=seNy=KE=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout11.t-online.de (mailout11.t-online.de [194.25.134.85])
	by sourceware.org (Postfix) with ESMTPS id A55AA3858C35
	for <cygwin-patches@cygwin.com>; Tue, 27 Feb 2024 12:17:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A55AA3858C35
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A55AA3858C35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.85
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709036260; cv=none;
	b=fn8U/XtvkVfp7+nyHC0FXs9FHlL7KaYh/YMo+wFhFdmHa5zs9chkGq4v8mk547+8RypHoV7gLUlgjeH68FxmUuITQ/L1xp+Jwy9Z4Dofsw561oVSDxtIsLikXWVlo+5DQyfDYdnl1a34S6RPzFE4O9AA3V3tQAlnzrnQq1Grixk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709036260; c=relaxed/simple;
	bh=8CE2RgpHYQhgoZIqBgqqh8d15o5+VMFAa/dwS/WyRHs=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=AMOmMb6/WwptYYVdMCrga+ADb9/nJL1ZTGeNqLXbiS330RJXifCD8jHIZyQVDOUJhkGVho4aZJpG0cuxByjUtVA1rd2Y+xoq7trT96ahAjeLT5dPBZYmURGStC342hyxIY7AYXLPiApwhVCWwg3Cc3b1LR1zUQVViLhVBfknK6M=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd78.aul.t-online.de (fwd78.aul.t-online.de [10.223.144.104])
	by mailout11.t-online.de (Postfix) with SMTP id D3686193C7
	for <cygwin-patches@cygwin.com>; Tue, 27 Feb 2024 13:16:43 +0100 (CET)
Received: from [192.168.2.102] ([87.187.47.57]) by fwd78.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1rewO0-1hGyrg0; Tue, 27 Feb 2024 13:16:40 +0100
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH 1/2] Cygwin: add compile warning if ENOSHARE or ECASECLASH is
 used
Message-ID: <f0c37daf-4086-d5b9-9812-8b15916ad987@t-online.de>
Date: Tue, 27 Feb 2024 13:16:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------4EC26B8FD317BBFA8C1811A4"
X-TOI-EXPURGATEID: 150726::1709036200-5DF5F979-280C7AB9/0/0 CLEAN NORMAL
X-TOI-MSGID: bde64592-1d82-46e8-a870-aadd29c24b89
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------4EC26B8FD317BBFA8C1811A4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A suggestion for a first (possibly polite) step to get rid of ENOSHARE 
or ECASECLASH. Would also work with clang.

The internally used ENMFILE is not included yet. In theory, it may be 
returned to outside world as it still appears in errmap[].

-- 
Regards,
Christian


--------------4EC26B8FD317BBFA8C1811A4
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-add-compile-warning-if-ENOSHARE-or-ECASECLASH.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-add-compile-warning-if-ENOSHARE-or-ECASECLASH.pa";
 filename*1="tch"

RnJvbSBmM2FkMTkxMmE5YzdmYTRjZDI4YWRlNWRjN2M5NTEzNGJlNzU5NjE1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUdWUsIDI3IEZlYiAyMDI0IDEzOjAzOjA4ICswMTAw
ClN1YmplY3Q6IFtQQVRDSCAxLzJdIEN5Z3dpbjogYWRkIGNvbXBpbGUgd2FybmluZyBpZiBF
Tk9TSEFSRSBvciBFQ0FTRUNMQVNIIGlzCiB1c2VkCgpUaGVzZSBlcnJubyB2YWx1ZXMgYXJl
IG5vIGxvbmdlciB1c2VkIGJ5IEN5Z3dpbi4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBG
cmFua2UgPGNocmlzdGlhbi5mcmFua2VAdC1vbmxpbmUuZGU+Ci0tLQogbmV3bGliL2xpYmMv
aW5jbHVkZS9zeXMvZXJybm8uaCB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ld2xpYi9saWJjL2lu
Y2x1ZGUvc3lzL2Vycm5vLmggYi9uZXdsaWIvbGliYy9pbmNsdWRlL3N5cy9lcnJuby5oCmlu
ZGV4IGYxNTA5NzEyZS4uNzE5OWRiMGQyIDEwMDY0NAotLS0gYS9uZXdsaWIvbGliYy9pbmNs
dWRlL3N5cy9lcnJuby5oCisrKyBiL25ld2xpYi9saWJjL2luY2x1ZGUvc3lzL2Vycm5vLmgK
QEAgLTE3Niw5ICsxNzYsOSBAQCBleHRlcm4gX19JTVBPUlQgY2hhciAqcHJvZ3JhbV9pbnZv
Y2F0aW9uX3Nob3J0X25hbWU7CiAjaWZkZWYgX19MSU5VWF9FUlJOT19FWFRFTlNJT05TX18K
ICNkZWZpbmUgRU5PTUVESVVNIDEzNSAgIC8qIE5vIG1lZGl1bSAoaW4gdGFwZSBkcml2ZSkg
Ki8KICNlbmRpZgotI2lmZGVmIF9fQ1lHV0lOX18KLSNkZWZpbmUgRU5PU0hBUkUgMTM2ICAg
IC8qIE5vIHN1Y2ggaG9zdCBvciBuZXR3b3JrIHBhdGggKi8KLSNkZWZpbmUgRUNBU0VDTEFT
SCAxMzcgIC8qIEZpbGVuYW1lIGV4aXN0cyB3aXRoIGRpZmZlcmVudCBjYXNlICovCisjaWYg
ZGVmaW5lZChfX0NZR1dJTl9fKSAmJiAhZGVmaW5lZChfX0lOU0lERV9DWUdXSU5fXykKKyNk
ZWZpbmUgRU5PU0hBUkUgKF9QcmFnbWEoIkdDQyB3YXJuaW5nIFwiJ0VOT1NIQVJFJyBpcyBu
byBsb25nZXIgdXNlZCBieSBDeWd3aW5cIiIpIDEzNikKKyNkZWZpbmUgRUNBU0VDTEFTSCAo
X1ByYWdtYSgiR0NDIHdhcm5pbmcgXCInRUNBU0VDTEFTSCcgaXMgbm8gbG9uZ2VyIHVzZWQg
YnkgQ3lnd2luXCIiKSAxMzcpCiAjZW5kaWYKICNkZWZpbmUgRUlMU0VRIDEzOAkJLyogSWxs
ZWdhbCBieXRlIHNlcXVlbmNlICovCiAjZGVmaW5lIEVPVkVSRkxPVyAxMzkJLyogVmFsdWUg
dG9vIGxhcmdlIGZvciBkZWZpbmVkIGRhdGEgdHlwZSAqLwotLSAKMi40My4wCgo=
--------------4EC26B8FD317BBFA8C1811A4--
