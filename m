Return-Path: <SRS0=gMO3=RN=skymard.com=flora@sourceware.org>
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
	by sourceware.org (Postfix) with ESMTPS id 0214F385840B
	for <cygwin-patches@cygwin.com>; Thu, 17 Oct 2024 14:30:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0214F385840B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=skymard.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=skymard.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0214F385840B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=43.155.67.158
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1729175470; cv=none;
	b=MCqGAzry7P+QBYF/HBMoHm/K9TdFGNj4l3N+lcWfwvebIwWIIMU2jp0Q331q3a02uJYwE23KaFOcWQMu4h1xXoQiZSgufwuLvgU3E8IZYLh6R2HnKeQ9IygXb9d+Mlylsf8FvHZ+a6u9X+bRK78Wp9f6ZnCEfhT+H565kQ2eLTU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1729175470; c=relaxed/simple;
	bh=DNRt2gPzhAS2M/T2dLZ+AcwiJpQf6R6trN9E3dqdgzk=;
	h=DKIM-Signature:Date:From:To:Subject:Mime-Version:Message-ID; b=xvbNGiaGp0N/XAS5REBWdTdSd0Vizu+PN/3PTVPMksyBUzhc3WEnEAADIMm/BtQnHqVQ20yIpbySEKjRQSlXDzr0/a4j4zPgjAr8AYMwYM5XeFN4Z3SxETpqMjYGQ0JCN9WYPfoSLvlpDmgXG1wOJjP/PbIcj4rqt6aai5u9g/o=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skymard.com;
	s=cqen2407; t=1729175455;
	bh=5va5+fBz0SohdI/4xLpqbiNYyU/50wydhb0eUk0Wv4M=;
	h=Date:From:To:Subject:Mime-Version:Message-ID;
	b=UIgeBapu23fZEkloGyk37yP5ZaMIVNaDKQZBBZGzj3nDuGZ5qe0AL3/o8Xfk7J0o3
	 CpzmDLkdJFwtTRN58qWvWmuP3s77w1jiunfGJtXVsnIssBJrRIkkrqhhmzrF/3hkJn
	 /MkC/g5Sph/e331cN+mp5sOBLsuHEBGlmBCdBfH0=
X-QQ-mid: bizesmtpsz9t1729175454tzkrfp7
X-QQ-Originating-IP: +SxX4JVn1rcPkv29WLJx81Yp/eerD/IxIhiJaBjBPy0=
Received: from LAPTOP-C8TGA5NJ ( [119.39.114.238])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <cygwin-patches@cygwin.com>; Thu, 17 Oct 2024 22:30:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6428990486523829120
Date: Thu, 17 Oct 2024 22:23:59 +0800
From: "Flora Li" <flora@skymard.com>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: China Good Construction Machinery Exporter
X-Priority: 3
X-GUID: 2191AD8B-7AB8-4C4D-8A59-7EFCD5CB05AC
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.306[cn]
Mime-Version: 1.0
Message-ID: <5FC4190AAE7C5F9F+202410172223420592259@skymard.com>
Content-Type: multipart/alternative;
	boundary="----=_001_NextPart322420814146_=----"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:skymard.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MsthqgywqSPpb17vpQYAH50a8Ld1auchhZJg/oUo34zAazpmQXldjXol
	QsHDfnF22cb0FpFH0U/CR3K2iD3D1CcCvlg4ih6AanKKgtgxNd35v+wC8JzKaa8CJtoHnHo
	nC3PiGoOo2mXM19RlB37P0Ujc14qyr3gWU1opggKvpHrjrFDz4/X8mmRk1YkGgMUJ/sL/Bz
	5KNZdMyEehP3P+bIJVuYFfV3uLk59wm20M0GNvGcf8AGURshYMRFWb0W8ohcnJACj/DOUzw
	QHj3i/SJjQYOBVRDdcBwA9KtPabMD/QH0esiH784AJS5HE8eYQJmAEyJxwMF9xrQoPppt1H
	2d104YQEu9IcU4VIqMnMRikyLSoCBXpvgSr+XZwvsXTe8cbXfOCk6+1z/N5U+SPjzf1eb0P
	nAO6L86JgEef8WBs2I5Budft07aJYlGvZMqbePODRnecBg8hT34Klglrd3K8KG8e4rvvVn7
	h97hFn0weuSJCJrVcegi00pQHb+VEZPWjgEqBk/ZscfAHXk7IeX9v05/8bM3pd3z4UZSpVA
	65EWqvU66QwJVr6wawFzFrtnDiAw4piT9Mk2ZLDLfyrwiVY4D3GnxBtqGIOqMk0VHTFGmtR
	Y2A62IyT18jQnvBMZMhw5djXQzaWmgppF3a3JCtQLWkI2hKYXSP1Gz6fEUO1kUUJDqVRmji
	b0Qg6hr/tjlOMFoHK5Gp4gR5F5Q2fhxQ32OcAWsNizWuRDL78j0bSkehEXHFX5CMZUoJBSU
	kwlTsZBJLLtd/q3OoiHsRlEup+GUXwLgeXys8XF96cdvLXrpo5JUh/5ZYjApEOUkCdpDhOI
	b2nw1GmGW8Q1fVFNMftZDkd+yEgvye3vc8lN5/r/f4pZxMabf2L5pR0apD73Zg+AYpnY8x8
	kx8bR87LcQqKxkDH8ZG03osUoHDTd7CFtC2NH1/FGbb63IwE5O5ZG+ZLswbW6D0I5ETPYlD
	4gt2tpTLjryVW13Hc7m2b/M3TY7A4CrIU9ek0loTPgSOYdGM4VGp/mWMoW+dOjNioGkcwQ1
	9PJW45fXZ6Yn3ChxJvIEqeHPoRzosMqjzrzYJS0P9Vtq9vWLQo9mPrVpKGg5+iZXDtuEK1k
	yyvrxmg33dgTwT/1PyXieyClxLfLRXvIkDOxH3Q9tGIHw2h3H0/O0kjJ91/6BW2ZE8oEZ3Z
	S6NoiOotL/K0TqPmhW2dnTWAJHvQMlON9vF/P0yG7rdnO6FeLJzmM68Z/ojgz67mpv/YXXT
	JFBSmwQk=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-SPAM: true
X-QQ-RECHKSPAM: 3
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_80,CHINA_SUBJECT,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_IMAGE_RATIO_04,HTML_MESSAGE,MIME_BASE64_TEXT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

------=_001_NextPart322420814146_=----
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: base64

SGksIG15IGZyaWVuZCwNCiANCldhcm0gR3JlZXRpbmdzIGZyb20gRmxvcmEu
DQpXZSBhcmUgYW4gZXhwb3J0ZXIgb2YgY29uc3RydWN0aW9uIG1hY2hpbmVy
eSBmb3IgMTYgeWVhcnMuDQpXZSBjYW4gcHJvdmlkZSB5b3UgdmFyaW91cyBm
YW1vdXMgYnJhbmQgbWFjaGluZXJ5LCBzdWNoIGFzIFhDTUcsIFNBTlksIENB
VCwgU1VOV0FSRCBhbmQgc28gb24uDQpJZiB5b3UgYXJlIGludGVyZXN0ZWQg
aW4gdGhlbSwgcGxzIGNvbnRhY3QgbWUuDQpMb29raW5nIGZvcndhcmQgdG8g
eW91ciByZXBseSENCkJlc3QgcmVnYXJkcw0KRmxvcmENCkZsb3JhIExpDQpT
YWxlcyBNYW5hZ2VyDQpXaGF0c2FwcC9XZWNoYXQvTW9iaWxlOiArODYtMTMz
MjcyOTI0ODANCkUtbWFpbDpmbG9yYUBza3ltYXJkLmNvbQ0KDQpTa3ltYXJk
IENvbnN0cnVjdGlvbiBNYWNoaW5lcnkgKEh1bmFuKSBDby4sIEx0ZC4NClNr
eW1hcmQgQ2hpbmEgTGltaXRlZA0KVGVsOis4Ni0xMzY2MTYyNjQwMQ0KQWRk
OlJvb20gMzUwMSwgRnV4aW5nIFRpbWVzIEZpbmFuY2lhbCBDZW50ZXIgVDYs
IERvbmdmZW5nDQpSb2FkIFN0cmVldCwgS2FpZnUgRGlzdHJpY3QsIENoYW5n
c2hhLCBIdW5hbiwgQ2hpbmENCg0KDQoNCmZsb3JhQHNreW1hcmQuY29tDQo=

------=_001_NextPart322420814146_=------

