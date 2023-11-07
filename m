Return-Path: <SRS0=wcLp=GU=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout03.t-online.de (mailout03.t-online.de [194.25.134.81])
	by sourceware.org (Postfix) with ESMTPS id 3AB7E3858D1E
	for <cygwin-patches@cygwin.com>; Tue,  7 Nov 2023 14:30:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3AB7E3858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3AB7E3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.81
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699367456; cv=none;
	b=nDdzLw3yE5OFb6okpDEICr3AgSUWOescuHqwuelcCsnfLlqlbX51RwyHstulSpuilSnBDl5oenbMKzzeQPKedNOlWyGGMiD+CbJBZj5VaKZdk2tADq2yzM5h5ihDqxL8A+hAE1xW7d3zHlyvCXfIrryVOtnz6X/1f4SrWN7nyns=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699367456; c=relaxed/simple;
	bh=oyr8wXrhBDATIMMgQfzwXVgkhL9gX922Aix9llVZlzo=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=QUdGZw6w2N5HABmek5vAo4HiJ3xfTeNB/SLXs/yHbV98NMzSdN7Lgz8LX5oiXCjEmsjf3tQsu8hrx2wj2f7CBBTd/rE1faWeMsUsJ3hP8m3en0WF7Ruqhdu5YqNDmmMMge+9eLMRaG2wlsv35sM34bZ3Ss0PF/798SxXCqKRol4=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd80.aul.t-online.de (fwd80.aul.t-online.de [10.223.144.106])
	by mailout03.t-online.de (Postfix) with SMTP id 46C6A1857C
	for <cygwin-patches@cygwin.com>; Tue,  7 Nov 2023 15:30:53 +0100 (CET)
Received: from [192.168.2.101] ([91.57.240.134]) by fwd80.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1r0N6R-2AUI1A0; Tue, 7 Nov 2023 15:30:51 +0100
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
To: cygwin-patches@cygwin.com
References: <ZUUfit/OdR3G5G/H@calimero.vinschen.de>
 <ZUUgKHqlCQRghuzy@calimero.vinschen.de>
 <1133d1d3-e6d9-4a52-a595-89ee338f8d2f@t-online.de>
 <ZUYQPPsrxf5yp1Ir@calimero.vinschen.de>
 <ZUYVeeYDcAKC74wg@calimero.vinschen.de>
 <c82507ab-193a-4a85-7ef0-64f7a7f30705@t-online.de>
 <ZUautCVKk4bXD4q4@calimero.vinschen.de>
 <eeee1473-7902-6ef7-9fab-cfc3f4eb2785@t-online.de>
 <ZUf0DwCsxbuPR3iL@calimero.vinschen.de>
 <3074268d-edb9-6eef-f486-c9caedb6d54c@t-online.de>
 <ZUo7ydnzBK8HM8FI@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <31771842-9012-b781-6197-84fae3570a24@t-online.de>
Date: Tue, 7 Nov 2023 15:30:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZUo7ydnzBK8HM8FI@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------C14B4A5273203B5C307FDAE4"
X-TOI-EXPURGATEID: 150726::1699367451-4BFFCED2-B9D9C6DD/0/0 CLEAN NORMAL
X-TOI-MSGID: df35e76f-815a-49fa-98a8-9e35a9df1f54
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------C14B4A5273203B5C307FDAE4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> ..
> Looking forward to it. We'll just need an entry for the release text
> in winsup/cygwin/release/3.5.0 and doc/new-features.xml in the end :)

Attached for now as implementing the remaining subdirs is not yet 
scheduled. Docbook formatting not tested.

Christian


--------------C14B4A5273203B5C307FDAE4
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-Document-dev-disk-by-id-and-dev-disk-by-partu.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-Document-dev-disk-by-id-and-dev-disk-by-partu.pa";
 filename*1="tch"

RnJvbSBiMDdkZTIxNDYxMjA3YTJiNTc0NjVkM2RkOGY3ZGIyYjM2ZDg4NmMwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUdWUsIDcgTm92IDIwMjMgMTU6MjU6NTQgKzAxMDAK
U3ViamVjdDogW1BBVENIXSBDeWd3aW46IERvY3VtZW50IC9kZXYvZGlzay9ieS1pZCBhbmQg
L2Rldi9kaXNrL2J5LXBhcnR1dWlkCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gRnJhbmtl
IDxjaHJpc3RpYW4uZnJhbmtlQHQtb25saW5lLmRlPgotLS0KIHdpbnN1cC9jeWd3aW4vcmVs
ZWFzZS8zLjUuMCB8ICA2ICsrKysrKwogd2luc3VwL2RvYy9uZXctZmVhdHVyZXMueG1sIHwg
MTQgKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjUuMCBiL3dpbnN1cC9jeWd3
aW4vcmVsZWFzZS8zLjUuMAppbmRleCBkYmJmODAwOWQuLjJkNTk4MThiNSAxMDA2NDQKLS0t
IGEvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuNS4wCisrKyBiL3dpbnN1cC9jeWd3aW4vcmVs
ZWFzZS8zLjUuMApAQCAtMTcsNiArMTcsMTIgQEAgV2hhdCdzIG5ldzoKICAgY2xhc3MgZXhw
cmVzc2lvbnMsIGFuZCBjb2xsYXRpbmcgc3ltYm9scyBpbiB0aGUgc2VhcmNoIHBhdHRlcm4s
IGkuZS4sCiAgIFs6YWxudW06XSwgWz1hPV0sIFsuYWEuXS4KIAorLSBJbnRyb2R1Y2UgL2Rl
di9kaXNrIGRpcmVjdG9yeSB3aXRoIHN1YmRpcmVjdG9yaWVzIGJ5LWlkIGFuZCBieS1wYXJ0
dXVpZC4KKyAgVGhlIGJ5LWlkIGRpcmVjdG9yeSBwcm92aWRlcyBzeW1saW5rcyBmb3IgZWFj
aCBkaXNrIGFuZCBpdHMgcGFydGl0aW9uczoKKyAgQlVTVFlQRS1bVkVORE9SX11QUk9EVUNU
X1tTRVJJQUx8SEFTSF1bLXBhcnROXSAtPiAuLi8uLi9zZFhbTl0uCisgIFRoZSBieS1wYXJ0
dXVpZCBkaXJlY3RvcnkgcHJvdmlkZXMgc3ltbGlua3MgZm9yIGVhY2ggTUJSIGFuZCBHUFQg
ZGlzaworICBwYXJ0aXRpb246IE1CUl9TRVJJQUwtT0ZGU0VUIC0+IC4uLy4uL3NkWE4sIEdQ
VF9HVUlEIC0+IC4uLy4uL3NkWE4uCisKIC0gSW50cm9kdWNlIC9wcm9jL2NvZGVzZXRzIGFu
ZCAvcHJvYy9sb2NhbGVzIHdpdGggaW5mb3JtYXRpb24gb24KICAgc3VwcG9ydGVkIGNvZGVz
ZXRzIGFuZCBsb2NhbGVzIGZvciBhbGwgaW50ZXJlc3RlZCBwYXJ0aWVzLiAgTG9jYWxlKDEp
CiAgIG9wZW5zIHRoZXNlIGZpbGVzIGFuZCB1c2VzIHRoZSBpbmZvIGZvciBwcmludGluZyBs
b2NhbGUgaW5mbyBsaWtlIGFueQpkaWZmIC0tZ2l0IGEvd2luc3VwL2RvYy9uZXctZmVhdHVy
ZXMueG1sIGIvd2luc3VwL2RvYy9uZXctZmVhdHVyZXMueG1sCmluZGV4IDc4YjJkYmFmZC4u
YThlOGE3OTkxIDEwMDY0NAotLS0gYS93aW5zdXAvZG9jL25ldy1mZWF0dXJlcy54bWwKKysr
IGIvd2luc3VwL2RvYy9uZXctZmVhdHVyZXMueG1sCkBAIC0zNCw2ICszNCwyMCBAQCBjbGFz
cyBleHByZXNzaW9ucywgYW5kIGNvbGxhdGluZyBzeW1ib2xzIGluIHRoZSBzZWFyY2ggcGF0
dGVybiwgaS5lLiwKIFs6YWxudW06XSwgWz1hPV0sIFsuYWEuXS4KIDwvcGFyYT48L2xpc3Rp
dGVtPgogCis8bGlzdGl0ZW0+PHBhcmE+CitJbnRyb2R1Y2UgL2Rldi9kaXNrIGRpcmVjdG9y
eSB3aXRoIHN1YmRpcmVjdG9yaWVzIGJ5LWlkIGFuZCBieS1wYXJ0dXVpZC4KK1RoZSBieS1p
ZCBkaXJlY3RvcnkgcHJvdmlkZXMgc3ltbGlua3MgZm9yIGVhY2ggZGlzayBhbmQgaXRzIHBh
cnRpdGlvbnM6CisgIDxzY3JlZW4+CisgIEJVU1RZUEUtW1ZFTkRPUl9dUFJPRFVDVF9bU0VS
SUFMfDB4SEFTSF1bLXBhcnROXSAtPiAuLi8uLi9zZFhbTl0KKyAgPC9zY3JlZW4+CitUaGUg
YnktcGFydHV1aWQgZGlyZWN0b3J5IHByb3ZpZGVzIHN5bWxpbmtzIGZvciBlYWNoIE1CUiBh
bmQgR1BUIGRpc2sKK3BhcnRpdGlvbjoKKyAgPHNjcmVlbj4KKyAgTUJSX1NFUklBTC1PRkZT
RVQgLT4gLi4vLi4vc2RYTgorICBHUFRfR1VJRCAtPiAuLi8uLi9zZFhOCisgIDwvc2NyZWVu
PgorPC9wYXJhPjwvbGlzdGl0ZW0+CisKIDxsaXN0aXRlbT48cGFyYT4KIEludHJvZHVjZSAv
cHJvYy9jb2Rlc2V0cyBhbmQgL3Byb2MvbG9jYWxlcyB3aXRoIGluZm9ybWF0aW9uIG9uIHN1
cHBvcnRlZAogY29kZXNldHMgYW5kIGxvY2FsZXMgZm9yIGFsbCBpbnRlcmVzdGVkIHBhcnRp
ZXMuICBMb2NhbGUoMSkgb3BlbnMgdGhlc2UKLS0gCjIuNDIuMQoK
--------------C14B4A5273203B5C307FDAE4--
