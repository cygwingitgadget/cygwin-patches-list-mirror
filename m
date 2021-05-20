Return-Path: <Christian.Franke@t-online.de>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
 by sourceware.org (Postfix) with ESMTPS id 5E758385803D
 for <cygwin-patches@cygwin.com>; Thu, 20 May 2021 21:05:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5E758385803D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=Christian.Franke@t-online.de
Received: from fwd20.aul.t-online.de (fwd20.aul.t-online.de [172.20.26.140])
 by mailout05.t-online.de (Postfix) with SMTP id 838D134718
 for <cygwin-patches@cygwin.com>; Thu, 20 May 2021 23:05:06 +0200 (CEST)
Received: from [192.168.2.105]
 (GiOWjmZp8hm4lLUdL6ejo+ZvBKqSs3sRb8YjdWXR61gGw6AMuTP26-cNv9oqioBZ8V@[79.230.169.184])
 by fwd20.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1ljpqm-3hLt680; Thu, 20 May 2021 23:05:00 +0200
To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: PATCH] Cygwin: utils: chattr: Allow to clear all attributes with '='.
Message-ID: <a8272535-f9a4-cbc0-d0ef-4d9040cc007f@t-online.de>
Date: Thu, 20 May 2021 23:04:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 SeaMonkey/2.53.6
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------256603AEEB73741EA87930CE"
X-ID: GiOWjmZp8hm4lLUdL6ejo+ZvBKqSs3sRb8YjdWXR61gGw6AMuTP26-cNv9oqioBZ8V
X-TOI-EXPURGATEID: 150726::1621544700-00000BA7-82765DC3/0/0 CLEAN NORMAL
X-TOI-MSGID: c5317db5-4f3d-411f-a808-e7bbc7a4d250
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 20 May 2021 21:05:10 -0000

This is a multi-part message in MIME format.
--------------256603AEEB73741EA87930CE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

'chattr = FILE' is shorter that 'chattr -rhsat... FILE' :-)

Regards,
Christian


--------------256603AEEB73741EA87930CE
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-utils-chattr-Allow-to-clear-all-attributes-wi.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-utils-chattr-Allow-to-clear-all-attributes-wi.pa";
 filename*1="tch"

RnJvbSA0MWMxYTk2NDhkNDY4MzUzNTQxNjdhN2UwMjRlNzE5MTAxNGUxMzcwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUaHUsIDIwIE1heSAyMDIxIDIyOjUyOjI4ICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiB1dGlsczogY2hhdHRyOiBBbGxvdyB0byBjbGVh
ciBhbGwgYXR0cmlidXRlcyB3aXRoCiAnPScuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4g
RnJhbmtlIDxjaHJpc3RpYW4uZnJhbmtlQHQtb25saW5lLmRlPgotLS0KIHdpbnN1cC91dGls
cy9jaGF0dHIuYyB8IDEwICsrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL3V0aWxzL2NoYXR0
ci5jIGIvd2luc3VwL3V0aWxzL2NoYXR0ci5jCmluZGV4IDY5NDJlMTFiMC4uYjdiZWZmMjc2
IDEwMDY0NAotLS0gYS93aW5zdXAvdXRpbHMvY2hhdHRyLmMKKysrIGIvd2luc3VwL3V0aWxz
L2NoYXR0ci5jCkBAIC0yMyw2ICsyMyw3IEBAIGRldGFpbHMuICovCiAKIGludCBSb3B0LCBW
b3B0LCBmb3B0OwogdWludDY0X3QgYWRkLCBkZWwsIHNldDsKK2ludCBzZXRfdXNlZDsKIAog
c3RydWN0IG9wdGlvbiBsb25nb3B0c1tdID0gewogICB7ICJyZWN1cnNpdmUiLCBub19hcmd1
bWVudCwgTlVMTCwgJ1InIH0sCkBAIC04Myw2ICs4NCw3IEBAIGdldF9mbGFncyAoY29uc3Qg
Y2hhciAqb3B0KQogICAgICAgYnJlYWs7CiAgICAgY2FzZSAnPSc6CiAgICAgICBtb2RlID0g
JnNldDsKKyAgICAgIHNldF91c2VkID0gMTsKICAgICAgIGJyZWFrOwogICAgIGRlZmF1bHQ6
CiAgICAgICByZXR1cm4gMTsKQEAgLTEwNCwxMCArMTA2LDEwIEBAIGludAogc2FuaXR5X2No
ZWNrICgpCiB7CiAgIGludCByZXQgPSAtMTsKLSAgaWYgKCFzZXQgJiYgIWFkZCAmJiAhZGVs
KQorICBpZiAoIXNldF91c2VkICYmICFhZGQgJiYgIWRlbCkKICAgICBmcHJpbnRmIChzdGRl
cnIsICIlczogTXVzdCB1c2UgYXQgbGVhc3Qgb25lIG9mID0sICsgb3IgLVxuIiwKIAkgICAg
IHByb2dyYW1faW52b2NhdGlvbl9zaG9ydF9uYW1lKTsKLSAgZWxzZSBpZiAoc2V0ICYmIChh
ZGQgfCBkZWwpKQorICBlbHNlIGlmIChzZXRfdXNlZCAmJiAoYWRkIHwgZGVsKSkKICAgICBm
cHJpbnRmIChzdGRlcnIsICIlczogPSBpcyBpbmNvbXBhdGlibGUgd2l0aCArIGFuZCAtXG4i
LAogCSAgICAgcHJvZ3JhbV9pbnZvY2F0aW9uX3Nob3J0X25hbWUpOwogICBlbHNlIGlmICgo
YWRkICYgZGVsKSAhPSAwKQpAQCAtMTM4LDcgKzE0MCw3IEBAIGNoYXR0ciAoY29uc3QgY2hh
ciAqcGF0aCkKIAkgICAgICAgcHJvZ3JhbV9pbnZvY2F0aW9uX3Nob3J0X25hbWUsIHN0cmVy
cm9yIChlcnJubyksIHBhdGgpOwogICAgICAgcmV0dXJuIDE7CiAgICAgfQotICBpZiAoc2V0
KQorICBpZiAoc2V0X3VzZWQpCiAgICAgbmV3ZmxhZ3MgPSBzZXQ7CiAgIGVsc2UKICAgICB7
CkBAIC0zMTMsNyArMzE1LDcgQEAgbmV4dDoKICAgICAgIG9wdCA9IHN0cmNociAoIistPSIs
IGFyZ3Zbb3B0aW5kXVswXSk7CiAgICAgICBpZiAoIW9wdCkKIAlicmVhazsKLSAgICAgIGlm
IChhcmd2W29wdGluZF1bMV0gPT0gJ1wwJyB8fCBnZXRfZmxhZ3MgKGFyZ3Zbb3B0aW5kXSkp
CisgICAgICBpZiAoKCpvcHQgIT0gJz0nICYmIGFyZ3Zbb3B0aW5kXVsxXSA9PSAnXDAnKSB8
fCBnZXRfZmxhZ3MgKGFyZ3Zbb3B0aW5kXSkpCiAJdXNhZ2UgKHN0ZGVycik7CiAgICAgICAr
K29wdGluZDsKICAgICB9Ci0tIAoyLjMxLjEKCg==
--------------256603AEEB73741EA87930CE--
