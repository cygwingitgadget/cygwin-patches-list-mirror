Return-Path: <SRS0=aFB7=W6=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout03.t-online.de (mailout03.t-online.de [194.25.134.81])
	by sourceware.org (Postfix) with ESMTPS id CB5BB385C424
	for <cygwin-patches@cygwin.com>; Sat, 12 Apr 2025 14:03:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CB5BB385C424
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CB5BB385C424
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.81
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744466635; cv=none;
	b=wFpwBZx3C6+Po7xtd3iGQ2qp9Fp9uz3mSj9jFDnHYx4aL+28T1wLx/QCxgCINLL1+g8oYhrDga4K1aTPLFaGhehapcwBwhDqyz3bJSzgprTEwaYUrLSB7SadMjE1GD/GOC5WWo13Pbq9vw8ZCCF3RuwShDHofymcC4f5MHfa2CI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744466635; c=relaxed/simple;
	bh=RaKwInAdSDNPW7zvkfhjo7N6j+bywNMRH2HElQ9ygbY=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=NSaRqmsjtvBM8JxNXlpApiy3SRftAjqtRyGsazYKE1fd9ybr1Gp8XwddVv+29uhYPJIlEsSZJRqHze5WjG8r1OhvWPdViKxFL9CFpBusF30orOISOTlpmBGXzFFMszdkXFRdzkdaJy5xPQyB0yb87r1qGFoYpbGYV7sbx7sUpk0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CB5BB385C424
Received: from fwd79.aul.t-online.de (fwd79.aul.t-online.de [10.223.144.105])
	by mailout03.t-online.de (Postfix) with SMTP id 6CC847ED
	for <cygwin-patches@cygwin.com>; Sat, 12 Apr 2025 16:03:53 +0200 (CEST)
Received: from [192.168.2.101] ([87.187.37.162]) by fwd79.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1u3bSa-2ccmHo0; Sat, 12 Apr 2025 16:03:52 +0200
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: kill(1): fix parsing of negative pid
Message-ID: <98fb7b3b-362e-4ccc-b25d-ab68e000627c@t-online.de>
Date: Sat, 12 Apr 2025 16:03:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C72A8A5D6FBBFEBAF485A828"
X-TOI-EXPURGATEID: 150726::1744466632-89FFA3F8-85A71D7C/0/0 CLEAN NORMAL
X-TOI-MSGID: 25c59f19-f692-4a5f-962b-f2113fbde74d
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------C72A8A5D6FBBFEBAF485A828
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Found during testing of:
https://sourceware.org/pipermail/cygwin-patches/2025q2/013651.html

Examples using nonexistent PIDs:

$ /bin/kill -9 -8 # OK, same as /bin/kill -9 -- -8
kill: -8: No such process

$ /bin/kill -SIGKILL -11 # bogus message
kill: illegal pid: -SIGKILL
kill: -11: No such process

$ /bin/kill -9 -11 # BAD, same as /bin/kill -9 -- -9 -11
kill: -9: No such process
kill: -11: No such process

The above works as expected with the bash builtin and with /usr/bin/kill 
from Debian 12.

-- 
Regards,
Christian


--------------C72A8A5D6FBBFEBAF485A828
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-kill-1-fix-parsing-of-negative-pid.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Cygwin-kill-1-fix-parsing-of-negative-pid.patch"

RnJvbSAwY2U0NjE1ZDgwY2QxYTVmNDE3NTExZDc5ODhjOTBjZDdjYzZlYmM3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBTYXQsIDEyIEFwciAyMDI1IDE1OjUxOjUzICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBraWxsKDEpOiBmaXggcGFyc2luZyBvZiBuZWdh
dGl2ZSBwaWQKClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBGcmFua2UgPGNocmlzdGlhbi5m
cmFua2VAdC1vbmxpbmUuZGU+Ci0tLQogd2luc3VwL3V0aWxzL2tpbGwuY2MgfCA0ICsrKy0K
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS93aW5zdXAvdXRpbHMva2lsbC5jYyBiL3dpbnN1cC91dGlscy9raWxsLmNjCmlu
ZGV4IGJjYWJjZDQ3Yy4uMWU2YWI1YzRiIDEwMDY0NAotLS0gYS93aW5zdXAvdXRpbHMva2ls
bC5jYworKysgYi93aW5zdXAvdXRpbHMva2lsbC5jYwpAQCAtMzcyLDcgKzM3Miw5IEBAIG1h
aW4gKGludCBhcmdjLCBjaGFyICoqYXJndikKIAljYXNlICc/JzoKIAkgIGlmIChnb3Rhc2ln
KSAvKiB0aGlzIGlzIGEgbmVnYXRpdmUgcGlkLCBnbyBhaGVhZCAqLwogCSAgICB7Ci0JICAg
ICAgLS1vcHRpbmQ7CisJICAgICAgLyogUmVzZXQgb3B0aW5kIGJlY2F1c2UgaXQgcG9pbnRz
IHRvIHRoZSBuZXh0IGFyZ3VtZW50IGlmIGFuZAorCQkgb25seSBpZiB0aGUgcGlkIGhhcyBv
bmUgZGlnaXQuICovCisJICAgICAgb3B0aW5kID0gYXYgLSBhcmd2OwogCSAgICAgIGdvdG8g
b3V0OwogCSAgICB9CiAJICBvcHRyZXNldCA9IDE7Ci0tIAoyLjQ1LjEKCg==
--------------C72A8A5D6FBBFEBAF485A828--
