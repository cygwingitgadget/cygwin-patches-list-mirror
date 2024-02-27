Return-Path: <SRS0=seNy=KE=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
	by sourceware.org (Postfix) with ESMTPS id 6AFB83858C35
	for <cygwin-patches@cygwin.com>; Tue, 27 Feb 2024 12:19:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6AFB83858C35
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6AFB83858C35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.82
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709036363; cv=none;
	b=M5EdmBVp+DS+1bt40scJ9DM7fqC/kAkDUeT97Rx4hSxqN+nY96MQ9JAfNAhngpv3Gun22b7yDBwt2xToaf7rvTwJk1N5Iy0QKpfG1kXtqMrHyh74aoDDghD5zuE4ZunzkW45WlpR2/dgtKElwYvd5V+qZFFd/8Vt75CrWVTCOpw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709036363; c=relaxed/simple;
	bh=GsDIhRWwZR82TEpq3Zt7HA9d48ayCwTMWB3oOmLvhCU=;
	h=Subject:From:To:Message-ID:Date:MIME-Version; b=othKSDFHfIpt9bEF9snByZFOzavczbt3OGGrHikOieEHkWAwGFjAmsheMhMB//aebOsalOT0SuaHYS/r7bWiHcQxEaxmocYuTSyoJvcHi9r49LWKqnGm81GIOow1Jfu1uitZtYRJDMo+rievq2tHntswn2kJmLJ0sx/wKgFwfCU=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd89.aul.t-online.de (fwd89.aul.t-online.de [10.223.144.115])
	by mailout05.t-online.de (Postfix) with SMTP id 44CB5355F
	for <cygwin-patches@cygwin.com>; Tue, 27 Feb 2024 13:18:41 +0100 (CET)
Received: from [192.168.2.102] ([87.187.47.57]) by fwd89.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1rewPv-3pJTt20; Tue, 27 Feb 2024 13:18:39 +0100
Subject: [PATCH 2/2] Cygwin: remove ENOSHARE and ECASECLASH from
 _sys_errlist[]
From: Christian Franke <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
References: <f0c37daf-4086-d5b9-9812-8b15916ad987@t-online.de>
Message-ID: <ede12d4d-3401-5d68-cfd1-f3aafa6a3394@t-online.de>
Date: Tue, 27 Feb 2024 13:18:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <f0c37daf-4086-d5b9-9812-8b15916ad987@t-online.de>
Content-Type: multipart/mixed;
 boundary="------------E802E48A3761B70983997072"
X-TOI-EXPURGATEID: 150726::1709036319-317F9820-BC31E92E/0/0 CLEAN NORMAL
X-TOI-MSGID: e30373b1-c4db-4c24-92db-ad03327dd16f
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------E802E48A3761B70983997072
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



--------------E802E48A3761B70983997072
Content-Type: text/plain; charset=UTF-8;
 name="0002-Cygwin-remove-ENOSHARE-and-ECASECLASH-from-_sys_errl.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0002-Cygwin-remove-ENOSHARE-and-ECASECLASH-from-_sys_errl.pa";
 filename*1="tch"

RnJvbSBmNDk1ZmIwZTdjMmJkM2E0MmYxNmY4MWFmMThjNjRmZmFiYTlhODYwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUdWUsIDI3IEZlYiAyMDI0IDEzOjA1OjM2ICswMTAw
ClN1YmplY3Q6IFtQQVRDSCAyLzJdIEN5Z3dpbjogcmVtb3ZlIEVOT1NIQVJFIGFuZCBFQ0FT
RUNMQVNIIGZyb20KIF9zeXNfZXJybGlzdFtdCgpUaGVzZSBlcnJubyB2YWx1ZXMgYXJlIG5v
IGxvbmdlciB1c2VkIGJ5IEN5Z3dpbi4gIEFsc28gYWRkIGEKc3RhdGljX2Fzc2VydCBjaGVj
ayBmb3IgX3N5c19lcnJsaXN0W10gc2l6ZS4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBG
cmFua2UgPGNocmlzdGlhbi5mcmFua2VAdC1vbmxpbmUuZGU+Ci0tLQogd2luc3VwL2N5Z3dp
bi9lcnJuby5jYyB8IDYgKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZXJybm8uY2Mg
Yi93aW5zdXAvY3lnd2luL2Vycm5vLmNjCmluZGV4IDdkNThlNjJlYy4uZDhjMDU3ZTUxIDEw
MDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2Vycm5vLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4v
ZXJybm8uY2MKQEAgLTE2Nyw4ICsxNjcsOCBAQCBjb25zdCBjaGFyICpfc3lzX2Vycmxpc3Rb
XSA9CiAvKiBFU1RBTEUgMTMzICovCSAgIlN0YWxlIE5GUyBmaWxlIGhhbmRsZSIsCiAvKiBF
Tk9UU1VQIDEzNCAqLwkgICJOb3Qgc3VwcG9ydGVkIiwKIC8qIEVOT01FRElVTSAxMzUgKi8J
ICAiTm8gbWVkaXVtIGZvdW5kIiwKLS8qIEVOT1NIQVJFIDEzNiAqLwkgICJObyBzdWNoIGhv
c3Qgb3IgbmV0d29yayBwYXRoIiwKLS8qIEVDQVNFQ0xBU0ggMTM3ICovCSAgIkZpbGVuYW1l
IGV4aXN0cyB3aXRoIGRpZmZlcmVudCBjYXNlIiwKKwkJCSAgTlVMTCwgLyogV2FzIEVOT1NI
QVJFIDEzNiwgbm8gbG9uZ2VyIHVzZWQuICovCisJCQkgIE5VTEwsIC8qIFdhcyBFQ0FTRUNM
QVNIIDEzNywgbm8gbG9uZ2VyIHVzZWQuICovCiAvKiBFSUxTRVEgMTM4ICovCSAgIkludmFs
aWQgb3IgaW5jb21wbGV0ZSBtdWx0aWJ5dGUgb3Igd2lkZSBjaGFyYWN0ZXIiLAogLyogRU9W
RVJGTE9XIDEzOSAqLwkgICJWYWx1ZSB0b28gbGFyZ2UgZm9yIGRlZmluZWQgZGF0YSB0eXBl
IiwKIC8qIEVDQU5DRUxFRCAxNDAgKi8JICAiT3BlcmF0aW9uIGNhbmNlbGVkIiwKQEAgLTE3
Nyw2ICsxNzcsOCBAQCBjb25zdCBjaGFyICpfc3lzX2Vycmxpc3RbXSA9CiAvKiBFU1RSUElQ
RSAxNDMgKi8JICAiU3RyZWFtcyBwaXBlIGVycm9yIgogfTsKIAorc3RhdGljX2Fzc2VydCgx
NDMgKyAxID09IHNpemVvZiAoX3N5c19lcnJsaXN0KSAvIHNpemVvZiAoX3N5c19lcnJsaXN0
WzBdKSk7CisKIGludCBOT19DT1BZX0lOSVQgX3N5c19uZXJyID0gc2l6ZW9mIChfc3lzX2Vy
cmxpc3QpIC8gc2l6ZW9mIChfc3lzX2Vycmxpc3RbMF0pOwogfTsKIAotLSAKMi40My4wCgo=
--------------E802E48A3761B70983997072--
