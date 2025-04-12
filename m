Return-Path: <SRS0=aFB7=W6=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
	by sourceware.org (Postfix) with ESMTPS id 76D093858CD1
	for <cygwin-patches@cygwin.com>; Sat, 12 Apr 2025 10:17:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 76D093858CD1
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 76D093858CD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744453057; cv=none;
	b=Y+u32cMT3X1jps3+QpU+7SPoZudz6hAhOkI1GGzHSN4gzweUIbiZo3KpI2o5k6gnRkij3g/zrBSYh7Rb+9q5zp3phB7xZvMMPogUaV1DXmLhdB9DRiBsJSGQ38XbgKYdHPRmzhsJgzVBfa6UVpDqGY9d2tKBGVU2pZ0gfxMAuXA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744453057; c=relaxed/simple;
	bh=UwW0mMciyYdPPyZlSQ94C1uPzmEyRtf5FQEc6cTGU9c=;
	h=Subject:From:To:Message-ID:Date:MIME-Version; b=LdmQ+2A6XpA1LfAhc7TojjM9JEqmNRmMKnzvpiuwSeqyDBtiMR1vONGbFxh6AZI6Cu9QZyY0fHoVu2pJVo5umOscxHvrQocZY5B1bwonA2U23sUymaK+0i/gTP2U+m+60tIDl0aZ2D+s6spuHHuLVR4EUwGO5X5Lhd3cUyKHBGY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 76D093858CD1
Received: from fwd78.aul.t-online.de (fwd78.aul.t-online.de [10.223.144.104])
	by mailout02.t-online.de (Postfix) with SMTP id 25045FBD
	for <cygwin-patches@cygwin.com>; Sat, 12 Apr 2025 12:17:35 +0200 (CEST)
Received: from [192.168.2.101] ([87.187.37.162]) by fwd78.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1u3XvY-2FuJma0; Sat, 12 Apr 2025 12:17:32 +0200
Subject: Re: [PATCH 2/4] Cygwin: CI: Run stress-ng
From: Christian Franke <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
References: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
 <20250411130846.3355-3-jon.turney@dronecode.org.uk>
 <56c28c6c-d670-1eee-9da4-655e48cb3935@t-online.de>
Message-ID: <68794a6d-14ab-0d06-0cd0-449fafedd6d3@t-online.de>
Date: Sat, 12 Apr 2025 12:17:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <56c28c6c-d670-1eee-9da4-655e48cb3935@t-online.de>
Content-Type: multipart/mixed;
 boundary="------------A5F7DBFD07E697829C4B5B0B"
X-TOI-EXPURGATEID: 150726::1744453052-F7FEC509-5F287113/0/0 CLEAN NORMAL
X-TOI-MSGID: 13c56fe2-109a-4fd6-bc52-55aac0ab096b
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,BODY_8BITS,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------A5F7DBFD07E697829C4B5B0B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Christian Franke wrote:
> Jon Turney wrote:
>> ---
>>   .github/workflows/cygwin.yml      |  22 +-
>>   winsup/testsuite/stress/cygstress | 603 ++++++++++++++++++++++++++++++
>>
>
> Attached is a minor update of my local version for current Cygwin and 
> stress-ng HEADs. Mostly changed comments, but also adds "pty" to CI. 
> This works (on main only) thanks to the "termios: Implement tcflow(), 
> tcdrain(), TCXONC, TIOCINQ" patch.
>

Another update on top of the above. It uses Windows own taskkill tool 
instead of Sysinternals pskill as suggested by Jeremy Drake on cygwin-apps.

Testcase:

./cygstress mprotect

This nasty test runs mprotect(ptr, size, flags) in seven child processes 
on same mmap()ed region with random address ranges and PROT_* flags.

-- 
Regards,
Christian





--------------A5F7DBFD07E697829C4B5B0B
Content-Type: text/plain; charset=UTF-8;
 name="cygstress-2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cygstress-2.patch"

ZGlmZiAtLWdpdCBhL2N5Z3N0cmVzcyBiL2N5Z3N0cmVzcwppbmRleCA5ZTMxMzI1Li4yMWU0
Y2IxIDEwMDY0NAotLS0gYS9jeWdzdHJlc3MKKysrIGIvY3lnc3RyZXNzCkBAIC0xNyw3ICsx
Nyw2IEBAIFVzYWdlOiAkezAjIyovfSBbT1BUSU9OLi4uXSB7Q0l8V09SS3xGQUlMfHRlc3Qu
Li59CiAgIC1uICAgICAgICBwcmludCBjb21tYW5kcyBvbmx5IChkcnktcnVuKQogICAtZiAg
ICAgICAgZm9yY2UgZXhlY3V0aW9uIG9mIHRlc3RzIHRhZ2dlZCAnaGVhdnknIG9yICdhZG1p
bicKICAgLWMgTElTVCAgIHNldCBDUFUgYWZmaW5pdHkgdG8gTElTVAotICAtayBQQVRIICAg
dG9vbCB0byBzdG9wIGhhbmdpbmcgdGVzdHMgW2RlZmF1bHQ6IHBza2lsbF0KICAgLXMgUEFU
SCAgIHN0cmVzcy1uZyBleGVjdXRhYmxlIFtkZWZhdWx0OiBzdHJlc3MtbmddCiAgIC10IE4g
ICAgICBydW4gZWFjaCB0ZXN0IGZvciBhdCBsZWFzdCBOIHNlY29uZHMgW2RlZmF1bHQ6IDVd
CiAgIC13IE4gICAgICBzdGFydCBOIHdvcmtlcnMgZm9yIGVhY2ggdGVzdCBbZGVmYXVsdDog
Ml0KQEAgLTIzNyw3ICsyMzYsNyBAQCBzdHJlc3NfdGVzdHM9JwogICBtb2R1bGUgICAgICAg
ICMgLS0tLS0KICAgbW9udGUtY2FybG8gICAjIFdPUktTCiAgIG1wZnIgICAgICAgICAgIyBX
T1JLUyAgICAgIyB1c2VzIGxpYm1wZnIKLSAgbXByb3RlY3QgICAgICAjIEZBSUxTICAgICAj
IFRPRE8gQ3lnd2luOiBjcmFzaGVzIG9yIGhhbmdzCisgIG1wcm90ZWN0ICAgICAgIyBGQUlM
UyAgICAgIyBUT0RPIEN5Z3dpbjogY3Jhc2hlcyBvciBoYW5ncyBhbmQgdGhlbiBpZ25vcmVz
IFNJR0tJTEwKICAgbXEgICAgICAgICAgICAjIEZBSUxTICAgICAjIFRPRE8gdW5kZWNpZGVk
OiAiZmFpbDogLi4uIG1xX1t0aW1lZF1yZWNlaXZlIGZhaWxlZCwgZXJybm89MSIKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAjIChmaXhlZCBpbiBDeWd3aW4gMy41LjY6IGNyYXNo
IG9uIGludmFsaWQgbXEgZmQpCiAgIG1yZW1hcCAgICAgICAgIyAtLS0tLQpAQCAtNDQ0LDEw
ICs0NDMsNiBAQCBzdHJlc3NfdGVzdHM9JwogICB6b21iaWUgICAgICAgICMgV09SS1MsQ0kK
ICcKIAotIyBTSUdLSUxMIG1heSBub3Qgd29yayBpZiBzdHJlc3MtbmcgaGFuZ3MuCi0jIFVz
ZSBTeXNpbnRlcm5hbHMgJ3Bza2lsbCcgYXMgbm8gJ2tpbGxhbGwgLS1mb3JjZScgaXMgYXZh
aWxhYmxlLAota2lsbGFsbF9mb3JjZT0icHNraWxsIgotCiBzdHJlc3Nfbmc9InN0cmVzcy1u
ZyIKIHRpbWVvdXQ9NTsgd29ya2Vycz0yCiBkcnlydW49ZmFsc2U7IGZvcmNlPWZhbHNlCkBA
IC00NTYsNyArNDUxLDYgQEAgdGFza3NldD0KIHdoaWxlIDo7IGRvIGNhc2UgJDEgaW4KICAg
LWMpIHNoaWZ0OyB0YXNrc2V0PSQxIDs7CiAgIC1mKSBmb3JjZT10cnVlIDs7Ci0gIC1rKSBz
aGlmdDsga2lsbGFsbF9mb3JjZT0kMSA7OwogICAtbikgZHJ5cnVuPXRydWUgOzsKICAgLXMp
IHNoaWZ0OyBzdHJlc3Nfbmc9JDEgOzsKICAgLXQpIHNoaWZ0OyB0aW1lb3V0PSQxIDs7CkBA
IC00NzYsNyArNDcwLDEwIEBAIGVzYWM7IHNoaWZ0OyBkb25lCiAkcnVuX2NpIHx8ICRydW5f
d29yayB8fCAkcnVuX2ZhaWwgfHwgWyAke3J1bl90ZXN0czordH0gXSB8fCB1c2FnZQogCiBj
b21tYW5kIC1WICIkc3RyZXNzX25nIiA+L2Rldi9udWxsIHx8IGV4aXQgMQotY29tbWFuZCAt
ViAiJGtpbGxhbGxfZm9yY2UiID4vZGV2L251bGwgfHwgZXhpdCAxCisKKyMgU0lHS0lMTCBt
YXkgbm90IHdvcmsgaWYgc3RyZXNzLW5nIGhhbmdzLgorIyBVc2UgV2luZG93cyAndGFza2tp
bGwnIGFzIG5vICdraWxsYWxsIC0tZm9yY2UnIGlzIGF2YWlsYWJsZS4KK2NvbW1hbmQgLVYg
dGFza2tpbGwgPi9kZXYvbnVsbCB8fCBleGl0IDEKIAogc3RyZXNzX25nX25hbWU9JHtzdHJl
c3NfbmcjIyovfQogdGVtcGRpcj0ke1RNUDotL3RtcH0KQEAgLTQ5MCw4ICs0ODcsOCBAQCBm
aW5kX3N0cmVzcygpCiAKIHN0b3Bfc3RyZXNzKCkKIHsKLSAgZWNobyAnJCcgIiRraWxsYWxs
X2ZvcmNlIiAiJHN0cmVzc19uZ19uYW1lIgotICAiJGtpbGxhbGxfZm9yY2UiICIkc3RyZXNz
X25nX25hbWUiIHx8OgorICBlY2hvICckJyB0YXNra2lsbCAvRiAvVCAvSU0gIiR7c3RyZXNz
X25nX25hbWV9LmV4ZSIKKyAgdGFza2tpbGwgL0YgL1QgL0lNICIke3N0cmVzc19uZ19uYW1l
fS5leGUiIHx8OgogfQogCiB0b3RhbD0wCkBAIC01MjksMTIgKzUyNiwxMiBAQCBzdHJlc3Mo
KQogCiAgIGxvY2FsIG9rPXRydWUKICAgaWYgd2FpdCAkd2F0Y2hkb2c7IHRoZW4KLSAgICBl
Y2hvICI+Pj4gRkFJTFVSRTogJG5hbWUiICIkQCIgIihjb21tYW5kIGhhbmdzKSIKICAgICBz
bGVlcCAyCisgICAgZWNobyAiPj4+IEZBSUxVUkU6ICRuYW1lIiAiJEAiICIoY29tbWFuZCBo
YW5ncykiCiAgICAgb2s9ZmFsc2UKICAgZmkKIAotICBsb2NhbCBuPTAgcAorICBsb2NhbCBw
CiAgIGlmIHA9JChmaW5kX3N0cmVzcyk7IHRoZW4KICAgICBlY2hvICI+Pj4gRkFJTFVSRTog
JG5hbWUiICIkQCIgIihwcm9jZXNzZXMgbGVmdCwgZXhpdCBzdGF0dXMgJHJjKToiCiAgICAg
ZWNobyAiJHAiCg==
--------------A5F7DBFD07E697829C4B5B0B--
