Return-Path: <SRS0=r+DF=BT=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id 9D7473858C5E
	for <cygwin-patches@cygwin.com>; Tue, 30 May 2023 20:04:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9D7473858C5E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTP
	id 3xsmqYXPp6Nwh45aJq8ZIn; Tue, 30 May 2023 20:04:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1685477087; bh=JGqBLRiTWCAPZBEwMgpZUeN9TsWKjc3L2T+QFCmPcss=;
	h=Date:Subject:Reply-To:References:To:Cc:From:In-Reply-To;
	b=TN8zkVSi5Byo1oWFhY6ak4TsrvbOE3DXUBXhgzF9Sn0biVUq8aDgcFTVGge71n5eN
	 8pBQoPC7OiHMLe/MkcBRJS/rASKk2eXzNPWdc3R/oh7bg0nYY7hKIIXn5466h2h5lu
	 RCbeoo1Sg0Xq/lB8/1QJtm/Tuop5Hew/kncHlPXWWrmxVgqsQJYpUF9Layil2bc7ak
	 AIY2bMo59StVQzsu2YDIvqYeEoj6I9SJqmawn/ynbIJE0L/pXUK37zhEGix9OjnXV+
	 m7tjZEVcmjTio95RrT771++7USPPrpvJ0FWy31YGYjxGSBDDuXNxzXHgJQtPzokVb3
	 3u+qCMy7p3Uqw==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id 45aIqPrQryAOe45aIqJZEy; Tue, 30 May 2023 20:04:47 +0000
X-Authority-Analysis: v=2.4 cv=e5oV9Il/ c=1 sm=1 tr=0 ts=647656df
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=NEAV23lmAAAA:8 a=w_pzkKWiAAAA:8
 a=7V-0JTp32qI25L6YbXcA:9 a=QEXdDO2ut3YA:10 a=pGLkceISAAAA:8
 a=TqqW1sFldYH_MiWqHD0A:9 a=B2y7HmGcmWMA:10 a=sRI3_1zDfAgwuvI8zelB:22
Content-Type: multipart/mixed; boundary="------------JgJgJ7eefapa1A6iRfOKe2dQ"
Message-ID: <f4106af5-ed7a-0df5-a870-b87bb729f862@Shaw.ca>
Date: Tue, 30 May 2023 14:04:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: [PATCH] include/cygwin/limits.h: add XATTR_{NAME,SIZE,LIST}_MAX
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <CAN+za=MhQdD2mzYxqVAm9ZwBUBKsyPiH+9T5xfGXtgxq1X1LAA@mail.gmail.com>
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: newlib@sourceware.org, Philippe Cerfon <philcerf@gmail.com>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <CAN+za=MhQdD2mzYxqVAm9ZwBUBKsyPiH+9T5xfGXtgxq1X1LAA@mail.gmail.com>
X-Forwarded-Message-Id: <CAN+za=MhQdD2mzYxqVAm9ZwBUBKsyPiH+9T5xfGXtgxq1X1LAA@mail.gmail.com>
X-CMAE-Envelope: MS4xfMkEn5dneIAuOKFn+sG2glIf+EKRJba3oQCn9SDVG42ET6tBvcKr4JyFlKgrU8p3rsHl/VL3PBnDsfccm8fZuZTQ3KbgReaxDg4TVMpRFsRk6u5RLr49
 ruAk+cLPczLNO9KjY7f435MngYJbSvy3bjTsHtbrwnxyCn+ZvJHxqh1GhO8yThYdYzj8SWj/h7ZHn2llibVm/odq7rMT8hjyyd1zIizBPLbP8EbPiZxzoAHF
 uhILf43xA0q3+yT0yLS9jw==
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------JgJgJ7eefapa1A6iRfOKe2dQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On Tue, 30 May 2023 13:25:38 +0200, Philippe Cerfon wrote:
> Hey there.
> 
> Linux exports XATTR_{NAME,SIZE,LIST}_MAX in it's linux/limits.h and
> e.g. the CPython interpreter uses them for it's XATTRs functions.
> 
> I made a corresponding PR at CPython
> https://github.com/python/cpython/pull/105075 to get the code built
> for Cygwin, but right now this would fail due to the missing
> XATTR_*_MAX symbols.
> 
> The attached patch below would add them to cygwin/limits.h.

Patches for Cygwin under winsup are submitted to cygwin-patches@cygwin.com 
(forwarded there).

> But beware, I'm absolutely no Windows/Cygwin expert ^^ - so whether
> the values I've chosen are actually correct, is more guesswork rather
> than definite knowledge.
> 
> As written in the commit message, I think:
> - XATTR_NAME_MAX corresponds to MAX_EA_NAME_LEN
> and
> - XATTR_SIZE_MAX to MAX_EA_VALUE_LEN
> 
> though I have no idea, whether these are just lower boundaries used by
> Cygwin, while e.g. Windows itself might set longer names or value
> lenghts, and thus - when Cygwin would try to read such - it might get
> into troubles (or rather e.g. CPython, as it's buffers wouldn't
> suffice to read the EA respectively XATTR.
> 
> Neither to i have an idea about XATTR_LIST_MAX. I'm not even 100% sure
> what it means (I guess the max number of XATTRs per file). Not to
> speak about whether there's such maximum for Windows EAs,
> And again - as above - what would happen if Windows itself would set
> more than that limit and within Cygwin one would try to read/list all.
> 
> Thanks,
> Philippe

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada
--------------JgJgJ7eefapa1A6iRfOKe2dQ
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-export-XATTR_-NAME-SIZE-LIST-_MAX.patch"
Content-Disposition: attachment;
 filename="0001-export-XATTR_-NAME-SIZE-LIST-_MAX.patch"
Content-Transfer-Encoding: base64

RnJvbSA4MjRiY2RmMDUzYmZiODY1NzBjN2VkZGEzYzAxODYyNmRjODU3YThiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXBwZSBDZXJmb24gPHBoaWxjZXJmQGdtYWls
LmNvbT4KRGF0ZTogVHVlLCAzMCBNYXkgMjAyMyAxMzoxNjoxOCArMDIwMApTdWJqZWN0OiBb
UEFUQ0hdIGV4cG9ydCBYQVRUUl97TkFNRSxTSVpFLExJU1R9X01BWAoKVGhlc2UgYXJlIHVz
ZWQgZm9yIGV4YW1wbGUgYnkgQ1B5dGhvbi4gWEFUVFJfTkFNRV9NQVggc2hvdWxkIGNvcnJl
c3BvbmQgdG8KTUFYX0VBX05BTUVfTEVOIGFuZCBYQVRUUl9TSVpFX01BWCB0byBNQVhfRUFf
VkFMVUVfTEVOLgoKSXQncyB1bmNsZWFyIHdoZXRoZXIgV2luZG93cyBpbXBvc2VzIGEgbWF4
aW11bSBudW1iZXIgb2YgRUEncyBwZXIgZmlsZSBhbmQgd2hpY2gKdmFsdWUgc2hvdWxkIGJl
IHVzZWQgZm9yIFhBVFRSX0xJU1RfTUFYLCBzbyBmb3Igbm93IExpbnV4JyB2YWx1ZS4KClNp
Z25lZC1vZmYtYnk6IFBoaWxpcHBlIENlcmZvbiA8cGhpbGNlcmZAZ21haWwuY29tPgotLS0K
IHdpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vbGltaXRzLmggfCA3ICsrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS93aW5zdXAvY3ln
d2luL2luY2x1ZGUvY3lnd2luL2xpbWl0cy5oIGIvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5
Z3dpbi9saW1pdHMuaAppbmRleCBhZWZjN2M3YmQuLjkzOWFiNGYzOCAxMDA2NDQKLS0tIGEv
d2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dpbi9saW1pdHMuaAorKysgYi93aW5zdXAvY3ln
d2luL2luY2x1ZGUvY3lnd2luL2xpbWl0cy5oCkBAIC01Niw0ICs1NiwxMSBAQCBkZXRhaWxz
LiAqLwogI2RlZmluZSBfX1BBVEhfTUFYIDQwOTYKICNkZWZpbmUgX19QSVBFX0JVRiA0MDk2
CiAKKy8qIEtlZXAgaW4gc3luYyB3aXRoIE1BWF9FQV9OQU1FX0xFTiByZXNwZWN0aXZlbHkg
TUFYX0VBX1ZBTFVFX0xFTiBpbgorICogd2luc3VwL2N5Z3dpbi9udGVhLmNjIGJ1dCBkb24g
bm90IHVzZSB2YWx1ZXMgdGhhdCBleGNlZWQgdGhlaXIgTGludXgKKyAqIGNvdW50ZXJwYXJ0
cyBhcyBkZWZpbmVkIGluIGxpbnV4L2xpbWl0cy5oLiAqLworI2RlZmluZSBYQVRUUl9OQU1F
X01BWCAyNTUKKyNkZWZpbmUgWEFUVFJfU0laRV9NQVggNjU1MzYKKyNkZWZpbmUgWEFUVFJf
TElTVF9NQVggNjU1MzYKKwogI2VuZGlmIC8qIF9DWUdXSU5fTElNSVRTX0hfXyAqLwotLSAK
Mi40MC4xCgo=

--------------JgJgJ7eefapa1A6iRfOKe2dQ--
