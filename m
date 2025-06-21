Return-Path: <SRS0=+eGr=ZE=mkt.vic-inforeport.com=nelson@sourceware.org>
Received: from out0-64.static.mail.aliyun.com (out0-64.static.mail.aliyun.com [59.82.0.64])
	by sourceware.org (Postfix) with ESMTPS id 870B2384E68C
	for <cygwin-patches@cygwin.com>; Sat, 21 Jun 2025 03:36:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 870B2384E68C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=mkt.vic-inforeport.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=mkt.vic-inforeport.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 870B2384E68C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=59.82.0.64
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750477018; cv=none;
	b=TLmFez/3ZrbFqcqp18YcQ8G4+xKMmtXyYH7Ry97ei9Vn6+7Gq4uWB9y3aHY49Ogeal/IwFa4U/hejGtGEpObSm5A2ahFF7Q/RmcxFsocjvw8nLB3Mlr+UKmxUqc2UFHQCxaXJ007zk3Qu9tx4OibSG5E9KFjUq2Tutr+jkDprQM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750477018; c=relaxed/simple;
	bh=cCC/z250Swg4LHpPCBwP9zRGZlYpR89CcI4BWKrIIq0=;
	h=Date:From:Message-ID:Subject:MIME-Version; b=qqjPydOvECtLrGqyLS+9BWZIjmXqxIahsxLj5AQqyfkqAa6MG1d5Ik5tvg4P77lNH1FM6oU2i42uXML67FT6f3G3vhaFYdiNkGxfbn0ma6DS7yLjpvBg72FYh2e9/z7l95J83qdD/+EmZTT4fDWcOJ91jd0X1743oGvEICQuu28=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 870B2384E68C
X-Alimail-AntiSpam:AC=CONTINUE;BC=-1|-1;BR=01201311R151S93rulernew9999_292140_250212;CH=yellow;DM=||false|;DS=||;FP=12243583164280373392|5|1|600|0|-1|-1|-1;HT=maildocker-contentspam033068162005;MF=nelson@mkt.vic-inforeport.com;NM=1;PH=DW;RN=251;RT=1;SR=0;TI=W4_0.2.3_v5ForWebDing_21250EEA_1750477012581_o7001c27o;
Received: from WS-web (nelson@mkt.vic-inforeport.com[W4_0.2.3_v5ForWebDing_21250EEA_1750477012581_o7001c27o] cluster:ay29) at Sat, 21 Jun 2025 11:36:52 +0800
Date: Sat, 21 Jun 2025 11:36:52 +0800
From: "Nelson" <nelson@mkt.vic-inforeport.com>
Cc: "13542868304" <13542868304@163.com>
Reply-To: "Nelson" <nelson@mkt.vic-inforeport.com>
Message-ID: <b9e7da36-c383-40ae-b523-a7b04b3867cb.nelson@mkt.vic-inforeport.com>
Subject: =?UTF-8?B?SW5kdXN0cmlhbCAzRCBTZW5zb3I=?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Chrome]
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_M3LTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjAuMCBTYWZhcmkvNTM3LjM2vN
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_524_7f4261726700_685628d4_bd08f"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_60,BODY_8BITS,HTML_MESSAGE,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

------=ALIBOUNDARY_524_7f4261726700_685628d4_bd08f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

RGVhci4KV2UgaGF2ZSByZWxlYXNlZCBhIHJlcG9ydCBvbiB0aGUgbGF0ZXN0
IEluZHVzdHJpYWwgM0QgU2Vuc29yIG1hcmtldCByZXNlYXJjaC4KUGxzIGZl
ZWwgZnJlZSB0byBjb250YWN0IHNldmVuQHZpY21hcmtldHJlc2VhcmNoLmNv
bSBpZiB5b3UgYXJlIGludGVyZXN0ZWQgaW4gaXQuIEEgc2FtcGxlIHJlcG9y
dCB3aWxsIGJlIHNlbnQgdG8geW91LiAKVGhlIGZvbGxvd2luZyBtYW51ZmFj
dHVyZXJzIGFyZSBjb3ZlcmVkIGluIHRoaXMgcmVwb3J0OgpTaWNrCkNvZ25l
eApLZXllbmNlCk9tcm9uCkJhbm5lcgpQZXBwZXJsK0Z1Y2hzCk9yYmJlYwpI
aWtyb2JvdApTaW5jZVZpc2lvbgpUZWxlZHluZSBUZWNobm9sb2dpZXMKQmFz
bGVyIEFHCklzcmEgVmlzaW9uCkFsbGllZCBWaXNpb24gVGVjaG5vbG9naWVz
CkJBTExVRkYKQXV0b21hdGlvbiBUZWNobm9sb2d5CuKApuKApgpCZXN0IHJl
Z2FyZHMgLyBNaXQgZnJldW5kbGljaGVuIEdyw7zDn2VuIC8g5q2k6Ie05pWs
5oSPLApzZXZlbgo=

------=ALIBOUNDARY_524_7f4261726700_685628d4_bd08f--

