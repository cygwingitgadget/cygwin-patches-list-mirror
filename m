Return-Path: <SRS0=iWVE=XY=vip.126.com=aafactory@sourceware.org>
Received: from mail-proxy50252.vip.163.com (mail-proxy50252.vip.163.com [45.254.50.252])
	by sourceware.org (Postfix) with ESMTP id 3D71F3858C2F
	for <cygwin-patches@cygwin.com>; Thu,  8 May 2025 07:32:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3D71F3858C2F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=vip.126.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=vip.126.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3D71F3858C2F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=45.254.50.252
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746689548; cv=none;
	b=SHcQnnsVhjE2YtcBIiARvHmr66O0w3+AXA1VfHspa2FQU4C1gCJFtZz86gPxDxZoZ0OxsYU5pHsDMPQUMZmw/Mj/yS7Dou4vZxHgnTcVc7pIM9kOTFfWCDotDbZdp1BisUdGMlFOOY2OYjSaQCz1nrCgP+nNajWvWJJcEvWdIOk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746689548; c=relaxed/simple;
	bh=PazdbOoLVXUI8eUkAXCqeyFqVvGuTfJBH9E1mjFqphU=;
	h=DKIM-Signature:Date:From:To:Subject:MIME-Version:Message-ID; b=ZSjUb14U5HNLJXsQ5PzV/jLDlxSGfhZ7drkM5BYwy2XGo+L8b/m+F/6xNM79G7VJhcdMyjEyn2jfWk31bQg2RTnOHCaSufWgkREfsiGO0BUIJdfMjbx1Em/KYbHPM0vRpQdvEYM8TZVrIucUqoeqKexKmGm8EGrwwdCIdsh0QA0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3D71F3858C2F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.126.com header.i=@vip.126.com header.a=rsa-sha256 header.s=s110527 header.b=H1z06XtU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=vip.126.com; s=s110527; h=Date:From:Subject:Content-Type:
	MIME-Version:Message-ID; bh=PazdbOoLVXUI8eUkAXCqeyFqVvGuTfJBH9E1
	mjFqphU=; b=H1z06XtUZJbFteJRvu8gqH7Vcy6w/viOMNP5cR4wgECUT013jZbp
	cNucp2oHTGiSv8OR1sRN0ksBQ9v1hsVc/NruHXy1G/Oke/6h0tN3yUNvyd3etweV
	shRi4uyplZkC/C+Upde1pT0Rq0ERUeaXivivVqIjAMqrhq3UXUs7urk=
Received: from aafactory$vip.126.com ( [219.136.78.194] ) by
 ajax-webmail-wmsvr-207-27 (Coremail) ; Thu, 8 May 2025 15:22:20 +0800 (CST)
X-Originating-IP: [219.136.78.194]
Date: Thu, 8 May 2025 15:22:20 +0800 (CST)
From: "aafactory@126.vip.com" <aafactory@vip.126.com>
To: cygwin-patches@cygwin.com
Subject: Fw: frames,hooks ,hangings , mounts ,display hanging,clamps ,wall
 hangings, picture hangings ;,Custom metal components and more!
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 126vip
X-NTES-SC: AL_Qu2fBPqTt0Ev5iCcYOkfm0sWhu06W8S3u/su2oNQOpt4jATk8Ss5TVhkBVrZzfy0DCWuvD+wcgJu4+BBZ5BTZpIQEhbE43ggYzjddBA3/TMj0A==
Content-Type: multipart/alternative; 
	boundary="----=_Part_17168_1287831079.1746688940079"
MIME-Version: 1.0
Message-ID: <4f3321f8.1221.196aec6182f.Coremail.aafactory@vip.126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:G88vCgD3__qsWxxoujQBAA--.14419W
X-CM-SenderInfo: 5dditupwru5qxylshiyswou0bp/1tbiAwdHxmgcUcUZKQADsW
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_60,DEAR_SOMETHING,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,GB_FROM_NAME_FREEMAIL,HTML_MESSAGE,MIME_HTML_MOSTLY,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

------=_Part_17168_1287831079.1746688940079
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RGVhciBTaXIgOgoKSSBob3BlIHlvdeKAmXJlIGRvaW5nIHdlbGwhCgpNeSBu
YW1lIGlzIFN1LCBhbmQgSeKAmW0gcmVhY2hpbmcgb3V0IGZyb20gTUVUQUwg
UFJPRFVDVFMsIGEgdHJ1c3RlZCBtYW51ZmFjdHVyZXIgb2YgaGlnaC1xdWFs
aXR5IG1ldGFsIGhhcmR3YXJlLiBXZSBzcGVjaWFsaXplIGluIHByb2R1Y2lu
ZyBhIHdpZGUgcmFuZ2Ugb2YgcHJvZHVjdHMsIGluY2x1ZGluZzoKCuKclCBm
cmFtZXMsaG9va3MgLGhhbmdpbmdzICwgbW91bnRzICxkaXNwbGF5IGhhbmdp
bmcsY2xhbXBzICx3YWxsIGhhbmdpbmdzLCBwaWN0dXJlIGhhbmdpbmdzIDsK
CuKclCBELXJpbmdzLCBPLXJpbmdzLEZhc3RlbmVycywgcml2ZXRzLCBzY3Jl
d3MsIGFuZCBib2x0cyxTY3Jld3MsIGJvbHRzLCAgYW5jaG9yczsKCuKclCBl
eWVsZXRzLHN0YWlubGVzcyBzdGVlbCBoYXJkd2FyZSwgYnJhc3MgaGFyZHdh
cmUsIHphbWFrIGhhcmR3YXJlOwoK4pyUIGNsYXNwcyxidWNrbGVzLGdyb21t
ZXRzLENoYWlucywgaG9va3MsIHNuYXBzLCBjYXJhYmluZXJzOwoK4pyUIEJh
Zywgc2hvZSwgYW5kIGNsb3RoaW5nICxCZWx0LGpld2VscnkgZmluZGluZ3Ms
dHJpbW1pbmdzOwoK4pyUIGhvcnNlIGhhcmR3YXJlLCBoYXJuZXNzZXMsc2Fk
ZGxlcnkgaGFkd2FyZSxsZWF0aGVyIGhhcmR3YXJlOwoK4pyUIGFuZ3JpY3Vs
dHVyZSBoYXJkd2FyZSxwbGFudHMgYnVja2xlczsKCuKclCBDdXN0b20gbWV0
YWwgY29tcG9uZW50cyBhbmQgbW9yZSEKCkFzIGEgZGlyZWN0IG1hbnVmYWN0
dXJlciwgd2UgcHJvdmlkZSB0b3AtcXVhbGl0eSBwcm9kdWN0cyBhdCBoaWdo
bHkgY29tcGV0aXRpdmUgcHJpY2VzLiBXaGV0aGVyIHlvdSdyZSBsb29raW5n
IGZvciBzdGFuZGFyZCBoYXJkd2FyZSBvciBjdXN0b20gZGVzaWducywgb3Vy
IGZhY3RvcnkgY2FuIHByb2R1Y2UgaXRlbXMgdG8gbWVldCB5b3VyIGV4YWN0
IHNwZWNpZmljYXRpb25zLgoKV2Ugd291bGQgbG92ZSB0aGUgb3Bwb3J0dW5p
dHkgdG8gd29yayB3aXRoIHlvdSBhbmQgc3VwcGx5IGhpZ2gtcXVhbGl0eSBt
ZXRhbCBwcm9kdWN0cyB0YWlsb3JlZCB0byB5b3VyIG5lZWRzLiBQbGVhc2Ug
bGV0IHVzIGtub3cgd2hhdCB5b3UncmUgbG9va2luZyBmb3IsIGFuZCB3ZeKA
mWxsIGJlIGhhcHB5IHRvIGFzc2lzdCEKCkxvb2tpbmcgZm9yd2FyZCB0byB5
b3VyIHJlcGx5LgoKQmVzdCByZWdhcmRzLAoKU3UKCg==

------=_Part_17168_1287831079.1746688940079--

