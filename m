Return-Path: <SRS0=NTQ+=G6=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
	by sourceware.org (Postfix) with ESMTPS id 09CCA3858D28
	for <cygwin-patches@cygwin.com>; Fri, 17 Nov 2023 20:26:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 09CCA3858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 09CCA3858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1700252765; cv=none;
	b=H4NarjQ2Wjcp3mjjpfJwCVpSk4bRV5Up9r78rbkWbB0rTGcZMkga7/Ra5eLlZ6pGWjpt/tF4Fo+kOgBqtW57jEAyjH4wSXU5kSgLAoMrrwlGSgSiwO+J9VUOLnZnUPnVRbk+QmrqyOSdr/EBKo0L6Qg1pM05tcxCNLsFgd1hPS4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1700252765; c=relaxed/simple;
	bh=gT43ezJEaFa21tsc/qoJG4bD4JRYuQHRANKCS9OPrmI=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=Vq7QMIA0VZ6RckYCTDkwwP72rUcUk5uwawpbz75wDzbPgxEUkeimFgkiXadV9nCfyyhXNgI9Yp2hgaFb9eA7/0dSG6sx3ATffv37coGJb9USHLwvHjTDMnrXe/yzGa6XJzvIUij7Xap8WE/qN3osHQowv3pXFQUcJdCkO3ttYP0=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd84.aul.t-online.de (fwd84.aul.t-online.de [10.223.144.110])
	by mailout01.t-online.de (Postfix) with SMTP id 48D4930309
	for <cygwin-patches@cygwin.com>; Fri, 17 Nov 2023 21:26:01 +0100 (CET)
Received: from [192.168.2.101] ([91.57.240.134]) by fwd84.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1r45Pb-10fV3o0; Fri, 17 Nov 2023 21:25:59 +0100
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-label and /dev/disk/by-uuid
 symlinks
To: cygwin-patches@cygwin.com
References: <9c82a61c-02f8-a679-90f2-90e853d47e53@t-online.de>
 <ZVeTfEHgbgLJKFpU@calimero.vinschen.de>
 <57fb24ee-cd4c-0b54-6613-40f817e12571@t-online.de>
 <ZVeZhRmrMlbK7qkz@calimero.vinschen.de>
 <d74801f8-45fb-6a66-cc92-8f021f58c53b@t-online.de>
 <ZVfBmQiTGOjx14lW@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <b924c0f6-7ac1-9fa8-f828-0482f1ea5d36@t-online.de>
Date: Fri, 17 Nov 2023 21:25:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZVfBmQiTGOjx14lW@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------B73BE3DD1975DE9AC2D3C8DF"
X-TOI-EXPURGATEID: 150726::1700252759-2F7FD9FB-D59AF485/0/0 CLEAN NORMAL
X-TOI-MSGID: 317ba245-251a-4237-96b7-08349e273128
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------B73BE3DD1975DE9AC2D3C8DF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> On Nov 17 18:53, Christian Franke wrote:
>> Corinna Vinschen wrote:
>>> ...
>>> I see.  Admittedly, I don't know how Linux handles this either.
>> A quick test on Debian 12 with by-label suggests that the last duplicate
>> wins. Also not very sophisticated :-)
> Given this is all controlled by rather simple udev rules, see
> /usr/lib/udev/rules.d/60-persistent-storage.rules, that's not
> really surprising.
>
>> IIRC in the past I've seen in another of these directories (by-id?) that
>> '#N' was appended if duplicates occur.
> I don't see anything like that in 60-persistent-storage.rules, though.
> It has been removed at one point, it seems.

A quick followup to mark duplicates and (more important) avoid leading 
spaces in NTFS serial number.


--------------B73BE3DD1975DE9AC2D3C8DF
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-dev-disk-Mark-duplicates-fix-serial-number-fo.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-dev-disk-Mark-duplicates-fix-serial-number-fo.pa";
 filename*1="tch"

RnJvbSAxZTIxMjgxNGNmYjE3NTc5MTA1ZWFkNDgzNTQxMGJkNzRkZmIxODhhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBGcmksIDE3IE5vdiAyMDIzIDIxOjIwOjI2ICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiAvZGV2L2Rpc2s6IE1hcmsgZHVwbGljYXRlcywg
Zml4IHNlcmlhbCBudW1iZXIgZm9ybWF0CgpLZWVwIHJhbmdlcyBvZiBkdXBsaWNhdGUgbmFt
ZXMgYW5kIGFwcGVuZCAnI04nIHRvIGVhY2ggbmFtZS4KQWRkIG1pc3NpbmcgbGVhZGluZyB6
ZXJvcyB0byBvdXRwdXQgZm9ybWF0IG9mIE5URlMgc2VyaWFsIG51bWJlci4KTm8gbG9uZ2Vy
IGlnbm9yZSBudWxsIHZvbHVtZSBzZXJpYWwgbnVtYmVycy4KClNpZ25lZC1vZmYtYnk6IENo
cmlzdGlhbiBGcmFua2UgPGNocmlzdGlhbi5mcmFua2VAdC1vbmxpbmUuZGU+Ci0tLQogd2lu
c3VwL2N5Z3dpbi9maGFuZGxlci9kZXZfZGlzay5jYyB8IDM4ICsrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDIwIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIvZGV2X2Rp
c2suY2MgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyL2Rldl9kaXNrLmNjCmluZGV4IDAxNmI0
YzdiYy4uMTMxZmZkOTM1IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyL2Rl
dl9kaXNrLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIvZGV2X2Rpc2suY2MKQEAg
LTY0LDEwICs2NCwxMiBAQCBzYW5pdGl6ZV9sYWJlbF9zdHJpbmcgKFdDSEFSICpzKQogICAv
KiBMaW51eCBkb2VzIG5vdCBza2lwIGxlYWRpbmcgc3BhY2VzLiAqLwogICByZXR1cm4gc2Fu
aXRpemVfc3RyaW5nIChzLCBMJ1wwJywgTCcgJywgTCdfJywgW10gKFdDSEFSIGMpIC0+IGJv
b2wKICAgICB7Ci0gICAgICAvKiBMYWJlbHMgbWF5IGNvbnRhaW4gY2hhcmFjdGVycyBub3Qg
YWxsb3dlZCBpbiBmaWxlbmFtZXMuCi0JIExpbnV4IHJlcGxhY2VzIHNwYWNlcyB3aXRoIFx4
MjAgd2hpY2ggaXMgbm90IGFuIG9wdGlvbiBoZXJlLiAqLworICAgICAgLyogTGFiZWxzIG1h
eSBjb250YWluIGNoYXJhY3RlcnMgbm90IGFsbG93ZWQgaW4gZmlsZW5hbWVzLiAgQWxzbwor
ICAgICAgICAgcmVwbGFjZSAnIycgdG8gYXZvaWQgdGhhdCBkdXBsaWNhdGUgbWFya2VycyBp
bnRyb2R1Y2UgbmV3CisJIGR1cGxpY2F0ZXMuICBMaW51eCByZXBsYWNlcyBzcGFjZXMgd2l0
aCBceDIwIHdoaWNoIGlzIG5vdCBhbgorCSBvcHRpb24gaGVyZS4gKi8KICAgICAgIHJldHVy
biAhKCgwIDw9IGMgJiYgYyA8PSBMJyAnKSB8fCBjID09IEwnOicgfHwgYyA9PSBMJy8nIHx8
IGMgPT0gTCdcXCcKLQkgICAgICB8fCBjID09IEwnIicpOworCSAgICAgIHx8IGMgPT0gTCcj
JyB8fCBjID09IEwnIicpOwogICAgIH0KICAgKTsKIH0KQEAgLTMwNCwxMSArMzA2LDEwIEBA
IHBhcnRpdGlvbl90b19sYWJlbF9vcl91dWlkKGJvb2wgdXVpZCwgY29uc3QgVU5JQ09ERV9T
VFJJTkcgKmRyaXZlX3VuYW1lLAogICBjb25zdCBOVEZTX1ZPTFVNRV9EQVRBX0JVRkZFUiAq
bnZkYiA9CiAgICAgcmVpbnRlcnByZXRfY2FzdDxjb25zdCBOVEZTX1ZPTFVNRV9EQVRBX0JV
RkZFUiAqPihpb2N0bF9idWYpOwogICBpZiAodXVpZCAmJiBEZXZpY2VJb0NvbnRyb2wgKHZv
bGhkbCwgRlNDVExfR0VUX05URlNfVk9MVU1FX0RBVEEsIG51bGxwdHIsIDAsCi0JCQkgICAg
ICAgaW9jdGxfYnVmLCBOVF9NQVhfUEFUSCwgJmJ5dGVzX3JlYWQsIG51bGxwdHIpCi0gICAg
ICAmJiBudmRiLT5Wb2x1bWVTZXJpYWxOdW1iZXIuUXVhZFBhcnQpCisJCQkgICAgICAgaW9j
dGxfYnVmLCBOVF9NQVhfUEFUSCwgJmJ5dGVzX3JlYWQsIG51bGxwdHIpKQogICAgIHsKICAg
ICAgIC8qIFByaW50IHdpdGhvdXQgYW55IHNlcGFyYXRvciBhcyBvbiBMaW51eC4gKi8KLSAg
ICAgIF9fc21hbGxfc3ByaW50ZiAobmFtZSwgIiUxNlgiLCBudmRiLT5Wb2x1bWVTZXJpYWxO
dW1iZXIuUXVhZFBhcnQpOworICAgICAgX19zbWFsbF9zcHJpbnRmIChuYW1lLCAiJTAxNlgi
LCBudmRiLT5Wb2x1bWVTZXJpYWxOdW1iZXIuUXVhZFBhcnQpOwogICAgICAgTnRDbG9zZSh2
b2xoZGwpOwogICAgICAgcmV0dXJuIHRydWU7CiAgICAgfQpAQCAtMzI3LDEzICszMjgsOSBA
QCBwYXJ0aXRpb25fdG9fbGFiZWxfb3JfdXVpZChib29sIHV1aWQsIGNvbnN0IFVOSUNPREVf
U1RSSU5HICpkcml2ZV91bmFtZSwKICAgRklMRV9GU19WT0xVTUVfSU5GT1JNQVRJT04gKmZm
dmkgPQogICAgIHJlaW50ZXJwcmV0X2Nhc3Q8RklMRV9GU19WT0xVTUVfSU5GT1JNQVRJT04g
Kj4oaW9jdGxfYnVmKTsKICAgaWYgKHV1aWQpCi0gICAgewotICAgICAgaWYgKCFmZnZpLT5W
b2x1bWVTZXJpYWxOdW1iZXIpCi0JcmV0dXJuIGZhbHNlOwotICAgICAgLyogUHJpbnQgd2l0
aCBzZXBhcmF0b3IgYXMgb24gTGludXguICovCi0gICAgICBfX3NtYWxsX3NwcmludGYgKG5h
bWUsICIlMDR4LSUwNHgiLCBmZnZpLT5Wb2x1bWVTZXJpYWxOdW1iZXIgPj4gMTYsCi0JCSAg
ICAgICBmZnZpLT5Wb2x1bWVTZXJpYWxOdW1iZXIgJiAweGZmZmYpOwotICAgIH0KKyAgICAv
KiBQcmludCB3aXRoIHNlcGFyYXRvciBhcyBvbiBMaW51eC4gKi8KKyAgICBfX3NtYWxsX3Nw
cmludGYgKG5hbWUsICIlMDR4LSUwNHgiLCBmZnZpLT5Wb2x1bWVTZXJpYWxOdW1iZXIgPj4g
MTYsCisJCSAgICAgZmZ2aS0+Vm9sdW1lU2VyaWFsTnVtYmVyICYgMHhmZmZmKTsKICAgZWxz
ZQogICAgIHsKICAgICAgIC8qIExhYmVsIGlzIG5vdCBudWxsIHRlcm1pbmF0ZWQuICovCkBA
IC02MTAsNyArNjA3LDcgQEAgZ2V0X2J5X2lkX3RhYmxlIChieV9pZF9lbnRyeSAqICZ0YWJs
ZSwgZmhhbmRsZXJfZGV2X2Rpc2s6OmRldl9kaXNrX2xvY2F0aW9uIGxvYykKICAgaWYgKCF0
YWJsZSkKICAgICByZXR1cm4gKGVycm5vX3NldCA/IC0xIDogMCk7CiAKLSAgLyogU29ydCBi
eSBuYW1lIGFuZCByZW1vdmUgZHVwbGljYXRlcy4gKi8KKyAgLyogU29ydCBieSBuYW1lIGFu
ZCBtYXJrIGR1cGxpY2F0ZXMuICovCiAgIHFzb3J0ICh0YWJsZSwgdGFibGVfc2l6ZSwgc2l6
ZW9mICgqdGFibGUpLCBieV9pZF9jb21wYXJlX25hbWUpOwogICBmb3IgKHVuc2lnbmVkIGkg
PSAwOyBpIDwgdGFibGVfc2l6ZTsgaSsrKQogICAgIHsKQEAgLTYxOSwxMiArNjE2LDEzIEBA
IGdldF9ieV9pZF90YWJsZSAoYnlfaWRfZW50cnkgKiAmdGFibGUsIGZoYW5kbGVyX2Rldl9k
aXNrOjpkZXZfZGlza19sb2NhdGlvbiBsb2MpCiAJaisrOwogICAgICAgaWYgKGogPT0gaSAr
IDEpCiAJY29udGludWU7Ci0gICAgICAvKiBEdXBsaWNhdGUocykgZm91bmQsIHJlbW92ZSBh
bGwgZW50cmllcyB3aXRoIHRoaXMgbmFtZS4gKi8KLSAgICAgIGRlYnVnX3ByaW50ZiAoInJl
bW92aW5nIGR1cGxpY2F0ZXMgJWQtJWQ6ICclcyciLCBpLCBqIC0gMSwgdGFibGVbaV0ubmFt
ZSk7Ci0gICAgICBpZiAoaiA8IHRhYmxlX3NpemUpCi0JbWVtbW92ZSAodGFibGUgKyBpLCB0
YWJsZSArIGosICh0YWJsZV9zaXplIC0gaikgKiBzaXplb2YgKCp0YWJsZSkpOwotICAgICAg
dGFibGVfc2l6ZSAtPSBqIC0gaTsKLSAgICAgIGktLTsKKyAgICAgIC8qIER1cGxpY2F0ZShz
KSBmb3VuZCwgYXBwZW5kICIjTiIgdG8gYWxsIGVudHJpZXMuICBUaGlzIG5ldmVyCisJIGlu
dHJvZHVjZXMgbmV3IGR1cGxpY2F0ZXMgYmVjYXVzZSAnIycgbmV2ZXIgb2NjdXJzIGluIHRo
ZQorCSBvcmlnaW5hbCBuYW1lcy4gKi8KKyAgICAgIGRlYnVnX3ByaW50ZiAoIm1hcmsgZHVw
bGljYXRlcyAldS0ldSBvZiAnJXMnIiwgaSwgaiAtIDEsIHRhYmxlW2ldLm5hbWUpOworICAg
ICAgc2l6ZV90IGxlbiA9IHN0cmxlbiAodGFibGVbaV0ubmFtZSk7CisgICAgICBmb3IgKHVu
c2lnbmVkIGsgPSBpOyBrIDwgajsgaysrKQorCV9fc21hbGxfc3ByaW50ZiAodGFibGVba10u
bmFtZSArIGxlbiwgIiMldSIsIGsgLSBpKTsKICAgICB9CiAKICAgZGVidWdfcHJpbnRmICgi
dGFibGVfc2l6ZTogJWQiLCB0YWJsZV9zaXplKTsKLS0gCjIuNDIuMQoK
--------------B73BE3DD1975DE9AC2D3C8DF--
