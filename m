Return-Path: <SRS0=4E8T=W5=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
	by sourceware.org (Postfix) with ESMTPS id C43F1385E45D
	for <cygwin-patches@cygwin.com>; Fri, 11 Apr 2025 14:46:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C43F1385E45D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C43F1385E45D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.83
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744382771; cv=none;
	b=uB1ViE+q9mXWCgd6PdBSxftu4OjNGH9TNFrh3iE5Lz9am4KQFBc+kBLKDiZeb5fMqFfwND9RFSaUX+NgYu7DdBvqq+TJvwbtPKDRoCyDxz5SdOVH2Sm8bjaP7eTZvH3bosKuPfh/0tOJsoC7EZoFAGxbk9jRdiWXpSsSQlXgZSY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744382771; c=relaxed/simple;
	bh=lcPkGksd3nNom+v8cfBW3pphG4qdEFu9Ai0IHzbFlC4=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=RmyeDnKS2oXGzV3S3/AgNSYaO0A81Fou5uXSiiskqzcfF/H1Vaua/AFIkpogpSkXZCJvWd0+Vft6IY2VLf3hvdhEkt1ZqUcyBgURZWpHywGeiYHIlhyiP8eYwvgnchOEEGhxSOZDY+IfRUBvfn03trv2tjJUaNph5LCrFebTCdU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C43F1385E45D
Received: from fwd86.aul.t-online.de (fwd86.aul.t-online.de [10.223.144.112])
	by mailout07.t-online.de (Postfix) with SMTP id 189B5755
	for <cygwin-patches@cygwin.com>; Fri, 11 Apr 2025 16:46:09 +0200 (CEST)
Received: from [192.168.2.101] ([87.187.37.162]) by fwd86.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1u3Fdu-07rGfA0; Fri, 11 Apr 2025 16:46:06 +0200
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: kill(1): skip kill(2) call if '-f -s -' is used
Message-ID: <16c95bad-2310-e66c-d538-403321033d2c@t-online.de>
Date: Fri, 11 Apr 2025 16:46:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------5C1C07D7FD736FB255D8B23F"
X-TOI-EXPURGATEID: 150726::1744382766-C2FF39F3-A96EDB47/0/0 CLEAN NORMAL
X-TOI-MSGID: fa7f73a8-6b35-45a7-ae0f-335c1ff8c2b5
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------5C1C07D7FD736FB255D8B23F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

In rare cases, '/bin/kill -f PID' hangs because kill(2) is always tried 
first. With this patch, this could be prevented with '/bin/kill -f -s - 
PID'.

-- 
Regards,
Christian


--------------5C1C07D7FD736FB255D8B23F
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-kill-1-skip-kill-2-call-if-f-s-is-used.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Cygwin-kill-1-skip-kill-2-call-if-f-s-is-used.patch"

RnJvbSBjYjA3Y2EwMmE4NTZiZTM3OGEyNDM1ZjIwOTU4MzVjMjY0YjYyYmQ5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBGcmksIDExIEFwciAyMDI1IDE2OjM0OjQ4ICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBraWxsKDEpOiBza2lwIGtpbGwoMikgY2FsbCBp
ZiAnLWYgLXMgLScgaXMgdXNlZAoKSWYgYSBwcm9jZXNzIGRvZXMgbm90IHByb2Nlc3Mgc2ln
bmFscyBpbmNsdWRpbmcgU0lHS0lMTCwgYSBraWxsKDIpCmNhbGwgbWF5IGFsc28gaGFuZy4g
IElmICctJyBpcyBzcGVjaWZpZWQgaW5zdGVhZCBvZiBhIHNpZ25hbCwgdGhlCndpbjMyIGlu
dGVyZmFjZSBpcyB1c2VkIHdpdGhvdXQgdHJ5aW5nIGtpbGwoMikgZmlyc3QuCgpTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJhbmtlQHQtb25saW5lLmRl
PgotLS0KIHdpbnN1cC91dGlscy9raWxsLmNjIHwgMTYgKysrKysrKysrKysrKy0tLQogMSBm
aWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvd2luc3VwL3V0aWxzL2tpbGwuY2MgYi93aW5zdXAvdXRpbHMva2lsbC5jYwppbmRl
eCBiY2FiY2Q0N2MuLmIyZDNjNjcwOSAxMDA2NDQKLS0tIGEvd2luc3VwL3V0aWxzL2tpbGwu
Y2MKKysrIGIvd2luc3VwL3V0aWxzL2tpbGwuY2MKQEAgLTQ0LDYgKzQ0LDcgQEAgdXNhZ2Ug
KEZJTEUgKndoZXJlID0gc3RkZXJyKQogCSJTZW5kIHNpZ25hbHMgdG8gcHJvY2Vzc2VzXG4i
CiAJIlxuIgogCSIgLWYsIC0tZm9yY2UgICAgIGZvcmNlLCB1c2luZyB3aW4zMiBpbnRlcmZh
Y2UgaWYgbmVjZXNzYXJ5XG4iCisJIiAgICAgICAgICAgICAgICAgKGFkZCAnLXMgLScgdG8g
YWx3YXlzIHVzZSB3aW4zMiBpbnRlcmZhY2UpXG4iCiAJIiAtbCwgLS1saXN0ICAgICAgcHJp
bnQgYSBsaXN0IG9mIHNpZ25hbCBuYW1lc1xuIgogCSIgLUwsIC0tdGFibGUgICAgIHByaW50
IGEgZm9ybWF0dGVkIHRhYmxlIG9mIHNpZ25hbCBuYW1lc1xuIgogCSIgLXMsIC0tc2lnbmFs
ICAgIHNlbmQgc2lnbmFsICh1c2UgJTEkcyAtLWxpc3QgZm9yIGEgbGlzdClcbiIKQEAgLTMx
Miw2ICszMTMsNyBAQCBtYWluIChpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiB7CiAgIGludCBz
aWcgPSBTSUdURVJNOwogICBpbnQgZm9yY2UgPSAwOworICBpbnQgZm9yY2Vfbm9fc2lnID0g
MDsKICAgaW50IHdpbnBpZHMgPSAwOwogICBpbnQgcmV0ID0gMDsKICAgY2hhciAqZ290YXNp
ZyA9IE5VTEw7CkBAIC0zMzUsNyArMzM3LDkgQEAgbWFpbiAoaW50IGFyZ2MsIGNoYXIgKiph
cmd2KQogCXsKIAljYXNlICdzJzoKIAkgIGdvdGFzaWcgPSBvcHRhcmc7Ci0JICBzaWcgPSBn
ZXRzaWcgKGdvdGFzaWcpOworCSAgZm9yY2Vfbm9fc2lnID0gIXN0cmNtcCAoZ290YXNpZywg
Ii0iKTsKKwkgIHNpZyA9ICghZm9yY2Vfbm9fc2lnID8gZ2V0c2lnIChnb3Rhc2lnKSA6CisJ
CVNJR0tJTEwgLyogZm9yIGV4aXQgc3RhdHVzICovKTsKIAkgIGJyZWFrOwogCWNhc2UgJ2wn
OgogCSAgaWYgKCFvcHRhcmcpCkBAIC0zODcsNiArMzkxLDExIEBAIG1haW4gKGludCBhcmdj
LCBjaGFyICoqYXJndikKICAgICB9CiAKIG91dDoKKyAgaWYgKGZvcmNlX25vX3NpZyAmJiAh
Zm9yY2UpCisgICAgeworICAgICAgZnByaW50ZiAoc3RkZXJyLCAiJXM6IHNpZ25hbCAnLScg
cmVxdWlyZXMgJy1mJ1xuIiwgcHJvZ19uYW1lKTsKKyAgICAgIHJldHVybiAxOworICAgIH0K
ICAgdGVzdF9mb3JfdW5rbm93bl9zaWcgKHNpZywgZ290YXNpZyk7CiAKICAgYXJndiArPSBv
cHRpbmQ7CkBAIC00MTAsOSArNDE5LDEwIEBAIG91dDoKICAgICAgIGlmICh3aW5waWRzKQog
CXsKIAkgIGR3cGlkID0gcGlkOwotCSAgcGlkID0gKHBpZF90KSBjeWd3aW5faW50ZXJuYWwg
KENXX1dJTlBJRF9UT19DWUdXSU5fUElELCBkd3BpZCk7CisJICBpZiAoIWZvcmNlX25vX3Np
ZykKKwkgICAgcGlkID0gKHBpZF90KSBjeWd3aW5faW50ZXJuYWwgKENXX1dJTlBJRF9UT19D
WUdXSU5fUElELCBkd3BpZCk7CiAJfQotICAgICAgaWYgKGtpbGwgKChwaWRfdCkgcGlkLCBz
aWcpID09IDApCisgICAgICBpZiAoIWZvcmNlX25vX3NpZyAmJiBraWxsICgocGlkX3QpIHBp
ZCwgc2lnKSA9PSAwKQogCXsKIAkgIGlmIChmb3JjZSkKIAkgICAgZm9yY2VraWxsICgocGlk
X3QpIHBpZCwgZHdwaWQsIHNpZywgMSk7Ci0tIAoyLjQ1LjEKCg==
--------------5C1C07D7FD736FB255D8B23F--
