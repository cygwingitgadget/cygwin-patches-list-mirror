Return-Path: <Christian.Franke@t-online.de>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
 by sourceware.org (Postfix) with ESMTPS id CA54B3898525
 for <cygwin-patches@cygwin.com>; Wed, 19 May 2021 15:48:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CA54B3898525
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=Christian.Franke@t-online.de
Received: from fwd18.aul.t-online.de (fwd18.aul.t-online.de [172.20.26.244])
 by mailout10.t-online.de (Postfix) with SMTP id E7606C971
 for <cygwin-patches@cygwin.com>; Wed, 19 May 2021 17:46:32 +0200 (CEST)
Received: from [192.168.2.105]
 (Vyi2RaZOghPlCXM63voLnn4H9nCcvlMFUpEHjzYTIO0WDphywZ4g8tp9h0DI1+kgbu@[79.230.169.184])
 by fwd18.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1ljOP1-41R0YC0; Wed, 19 May 2021 17:46:31 +0200
To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: utils: chattr: Improve option parsing.
Message-ID: <d515bfba-ce77-40c0-0c3e-67895675f753@t-online.de>
Date: Wed, 19 May 2021 17:46:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 SeaMonkey/2.53.6
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------18D09C3B6215B2652EC2AA82"
X-ID: Vyi2RaZOghPlCXM63voLnn4H9nCcvlMFUpEHjzYTIO0WDphywZ4g8tp9h0DI1+kgbu
X-TOI-EXPURGATEID: 150726::1621439191-00004685-A07ADA49/0/0 CLEAN NORMAL
X-TOI-MSGID: 4c54cfc7-f428-47a6-83b5-83e92cb352f9
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00, BODY_8BITS,
 FREEMAIL_FROM, GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 19 May 2021 15:48:28 -0000

This is a multi-part message in MIME format.
--------------18D09C3B6215B2652EC2AA82
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This possibly improves the usability of chattr for some typical use cases:

Command         : Old  : New behavior
================================================
chattr -h       : help : help
chattr -h FILE  : help : chattr -- -h -- FILE
chattr -hs FILE : help : chattr -- -h -s -- FILE
chattr -sh FILE : fail : chattr -- -s -h -- FILE
chattr -ar FILE : fail : chattr -- -a -r -- FILE

Unrelated: there a two trivial block-copied-but-not-changed issues:

$ egrep 'ACL|--r' chattr.c
           "Get POSIX ACL information\n"
       "  -R, --recursive     recursively list attributes of directories 
and their \n"

Regards,
Christian


--------------18D09C3B6215B2652EC2AA82
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-utils-chattr-Improve-option-parsing.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Cygwin-utils-chattr-Improve-option-parsing.patch"

RnJvbSA4NjVhNWE1MDUwMWYzZmQwY2Y1ZWQyODUwMGQzZTZlNDVhNjQ1NmRlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBXZWQsIDE5IE1heSAyMDIxIDE2OjI0OjQ3ICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiB1dGlsczogY2hhdHRyOiBJbXByb3ZlIG9wdGlv
biBwYXJzaW5nLgoKSW50ZXJwcmV0ICctaCcgYXMgJy0taGVscCcgb25seSBpZiBsYXN0IGFy
Z3VtZW50LgpBbGxvdyBtdWx0aXBsZSBjaGFyYWN0ZXJzIGluIGZpcnN0ICctbW9kZScgYXJn
dW1lbnQuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgotLS0KIHdpbnN1cC91dGlscy9jaGF0dHIuYyB8IDE3ICsrKysr
KysrKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC91dGlscy9jaGF0dHIuYyBiL3dpbnN1cC91
dGlscy9jaGF0dHIuYwppbmRleCA5OGY2OTNhYWIuLmY2Y2UzNDBiNCAxMDA2NDQKLS0tIGEv
d2luc3VwL3V0aWxzL2NoYXR0ci5jCisrKyBiL3dpbnN1cC91dGlscy9jaGF0dHIuYwpAQCAt
MjcxLDcgKzI3MSw3IEBAIGludAogbWFpbiAoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogewog
ICBpbnQgYywgcmV0ID0gMDsKLSAgaW50IGxhc3RvcHRpbmQgPSAwOworICBpbnQgbGFzdG9w
dGluZCA9IDE7CiAgIGNoYXIgKm9wdDsKIAogICBvcHRlcnIgPSAwOwpAQCAtMjk1LDE1ICsy
OTUsMTYgQEAgbWFpbiAoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCSAgcHJpbnRfdmVyc2lv
biAoKTsKIAkgIHJldHVybiAwOwogCSAgYnJlYWs7CisJY2FzZSAnaCc6CisJICAvKiBQcmlu
dCBoZWxwIGlmIC1oIGlzIGxhc3QgYXJndW1lbnQgb3IgLS1oZWxwIGlzIHVzZWQsCisJICAg
ICBvdGhlcndpc2UgaW50ZXJwcmV0IC1oIGFzICdyZW1vdmUgaGlkZGVuIGF0dHJpYnV0ZScu
ICAqLworCSAgaWYgKG9wdGluZCA+PSBhcmdjIHx8IChvcHRpbmQgPiBsYXN0b3B0aW5kICYm
IGFyZ3Zbb3B0aW5kLTFdWzFdID09ICctJykpCisJICAgIHVzYWdlIChzdGRvdXQpOworCSAg
LypGQUxMVEhSVSovCiAJZGVmYXVsdDoKIAkgIGlmIChvcHRpbmQgPiBsYXN0b3B0aW5kKQot
CSAgICB7Ci0JICAgICAgLS1vcHRpbmQ7Ci0JICAgICAgZ290byBuZXh0OwotCSAgICB9Ci0J
ICAvKkZBTExUSFJVKi8KLQljYXNlICdoJzoKLQkgIHVzYWdlIChjID09ICdoJyA/IHN0ZG91
dCA6IHN0ZGVycik7CisJICAgIC0tb3B0aW5kOworCSAgZ290byBuZXh0OwogCX0KICAgICB9
CiBuZXh0OgotLSAKMi4zMS4xCgo=
--------------18D09C3B6215B2652EC2AA82--
