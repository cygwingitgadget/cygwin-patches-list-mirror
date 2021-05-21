Return-Path: <Christian.Franke@t-online.de>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
 by sourceware.org (Postfix) with ESMTPS id ED2023847810
 for <cygwin-patches@cygwin.com>; Fri, 21 May 2021 10:07:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org ED2023847810
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=Christian.Franke@t-online.de
Received: from fwd31.aul.t-online.de (fwd31.aul.t-online.de [172.20.26.136])
 by mailout07.t-online.de (Postfix) with SMTP id 028EC20952
 for <cygwin-patches@cygwin.com>; Fri, 21 May 2021 12:07:52 +0200 (CEST)
Received: from [192.168.2.105]
 (XjziqaZrZhkuluzI6YLYwNIjB+5KWoiCi+QPzeGi97O3CSa8F2mgTCwUvzXgybpgld@[79.230.169.184])
 by fwd31.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1lk24L-3M07eq0; Fri, 21 May 2021 12:07:49 +0200
Subject: Re: PATCH] Cygwin: utils: chattr: Allow to clear all attributes with
 '='.
To: cygwin-patches@cygwin.com
References: <a8272535-f9a4-cbc0-d0ef-4d9040cc007f@t-online.de>
 <YKdoQb1YVefI2As2@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <0adadd04-acd2-8c0e-c744-690681a39a7f@t-online.de>
Date: Fri, 21 May 2021 12:07:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 SeaMonkey/2.53.6
MIME-Version: 1.0
In-Reply-To: <YKdoQb1YVefI2As2@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------AE295A2F8D17AB6C0FED6F2D"
X-ID: XjziqaZrZhkuluzI6YLYwNIjB+5KWoiCi+QPzeGi97O3CSa8F2mgTCwUvzXgybpgld
X-TOI-EXPURGATEID: 150726::1621591669-000102A7-9144111A/0/0 CLEAN NORMAL
X-TOI-MSGID: eae36a12-f908-4364-bc22-97ac20662e15
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Fri, 21 May 2021 10:07:55 -0000

This is a multi-part message in MIME format.
--------------AE295A2F8D17AB6C0FED6F2D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> On May 20 23:04, Christian Franke wrote:
>> 'chattr = FILE' is shorter that 'chattr -rhsat... FILE' :-)
> That's ok, but it might be worth to add this to the docs, too :)

Next try attached...



--------------AE295A2F8D17AB6C0FED6F2D
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-utils-chattr-Allow-to-clear-all-attributes-wi.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-utils-chattr-Allow-to-clear-all-attributes-wi.pa";
 filename*1="tch"

RnJvbSA2YmEwYWI0ODNmOTQxNzYzMWExNTkyMjEwMTQxYWVmYWZmNTBlYmMxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBGcmksIDIxIE1heSAyMDIxIDExOjQ0OjMyICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiB1dGlsczogY2hhdHRyOiBBbGxvdyB0byBjbGVh
ciBhbGwgYXR0cmlidXRlcyB3aXRoCiAnPScuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4g
RnJhbmtlIDxjaHJpc3RpYW4uZnJhbmtlQHQtb25saW5lLmRlPgotLS0KIHdpbnN1cC9kb2Mv
dXRpbHMueG1sICB8ICA1ICsrKy0tCiB3aW5zdXAvdXRpbHMvY2hhdHRyLmMgfCAxMyArKysr
KysrKy0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2RvYy91dGlscy54bWwgYi93aW5zdXAvZG9j
L3V0aWxzLnhtbAppbmRleCA2OTYxMWI5NTQuLjA2NzFhN2I0ZCAxMDA2NDQKLS0tIGEvd2lu
c3VwL2RvYy91dGlscy54bWwKKysrIGIvd2luc3VwL2RvYy91dGlscy54bWwKQEAgLTUzLDkg
KzUzLDEwIEBAIGNoYXR0ciBbLVJWZkh2XSBbKy09bW9kZV0uLi4gW2ZpbGVdLi4uCiAKICAg
ICA8cGFyYT5UaGUgZm9ybWF0IG9mICdtb2RlJyBpcyB7Ky09fVthY0NlaG5yc1N0XTwvcGFy
YT4KIAotICAgIDxwYXJhPlRoZSAgb3BlcmF0b3IgJysnIGNhdXNlcyB0aGUgc2VsZWN0ZWQg
YXR0cmlidXRlcyB0byBiZSBhZGRlZCB0byB0aGUKKyAgICA8cGFyYT5UaGUgb3BlcmF0b3Ig
JysnIGNhdXNlcyB0aGUgc2VsZWN0ZWQgYXR0cmlidXRlcyB0byBiZSBhZGRlZCB0byB0aGUK
ICAgICAgIGV4aXN0aW5nIGF0dHJpYnV0ZXMgb2YgdGhlIGZpbGVzOyAnLScgY2F1c2VzIHRo
ZW0gdG8gYmUgcmVtb3ZlZDsgYW5kCi0gICAgICAnPScgY2F1c2VzIHRoZW0gdG8gYmUgdGhl
IG9ubHkgYXR0cmlidXRlcyB0aGF0IHRoZSBmaWxlcyBoYXZlLjwvcGFyYT4KKyAgICAgICc9
JyBjYXVzZXMgdGhlbSB0byBiZSB0aGUgb25seSBhdHRyaWJ1dGVzIHRoYXQgdGhlIGZpbGVz
IGhhdmUuCisgICAgICBBIHNpbmdsZSAnPScgY2F1c2VzIGFsbCBhdHRyaWJ1dGVzIHRvIGJl
IHJlbW92ZWQuPC9wYXJhPgogCiAgICAgPHBhcmE+U3VwcG9ydGVkIGF0dHJpYnV0ZXM6PC9w
YXJhPgogCmRpZmYgLS1naXQgYS93aW5zdXAvdXRpbHMvY2hhdHRyLmMgYi93aW5zdXAvdXRp
bHMvY2hhdHRyLmMKaW5kZXggNjk0MmUxMWIwLi5lM2FiMWZiYTggMTAwNjQ0Ci0tLSBhL3dp
bnN1cC91dGlscy9jaGF0dHIuYworKysgYi93aW5zdXAvdXRpbHMvY2hhdHRyLmMKQEAgLTIz
LDYgKzIzLDcgQEAgZGV0YWlscy4gKi8KIAogaW50IFJvcHQsIFZvcHQsIGZvcHQ7CiB1aW50
NjRfdCBhZGQsIGRlbCwgc2V0OworaW50IHNldF91c2VkOwogCiBzdHJ1Y3Qgb3B0aW9uIGxv
bmdvcHRzW10gPSB7CiAgIHsgInJlY3Vyc2l2ZSIsIG5vX2FyZ3VtZW50LCBOVUxMLCAnUicg
fSwKQEAgLTgzLDYgKzg0LDcgQEAgZ2V0X2ZsYWdzIChjb25zdCBjaGFyICpvcHQpCiAgICAg
ICBicmVhazsKICAgICBjYXNlICc9JzoKICAgICAgIG1vZGUgPSAmc2V0OworICAgICAgc2V0
X3VzZWQgPSAxOwogICAgICAgYnJlYWs7CiAgICAgZGVmYXVsdDoKICAgICAgIHJldHVybiAx
OwpAQCAtMTA0LDEwICsxMDYsMTAgQEAgaW50CiBzYW5pdHlfY2hlY2sgKCkKIHsKICAgaW50
IHJldCA9IC0xOwotICBpZiAoIXNldCAmJiAhYWRkICYmICFkZWwpCisgIGlmICghc2V0X3Vz
ZWQgJiYgIWFkZCAmJiAhZGVsKQogICAgIGZwcmludGYgKHN0ZGVyciwgIiVzOiBNdXN0IHVz
ZSBhdCBsZWFzdCBvbmUgb2YgPSwgKyBvciAtXG4iLAogCSAgICAgcHJvZ3JhbV9pbnZvY2F0
aW9uX3Nob3J0X25hbWUpOwotICBlbHNlIGlmIChzZXQgJiYgKGFkZCB8IGRlbCkpCisgIGVs
c2UgaWYgKHNldF91c2VkICYmIChhZGQgfCBkZWwpKQogICAgIGZwcmludGYgKHN0ZGVyciwg
IiVzOiA9IGlzIGluY29tcGF0aWJsZSB3aXRoICsgYW5kIC1cbiIsCiAJICAgICBwcm9ncmFt
X2ludm9jYXRpb25fc2hvcnRfbmFtZSk7CiAgIGVsc2UgaWYgKChhZGQgJiBkZWwpICE9IDAp
CkBAIC0xMzgsNyArMTQwLDcgQEAgY2hhdHRyIChjb25zdCBjaGFyICpwYXRoKQogCSAgICAg
ICBwcm9ncmFtX2ludm9jYXRpb25fc2hvcnRfbmFtZSwgc3RyZXJyb3IgKGVycm5vKSwgcGF0
aCk7CiAgICAgICByZXR1cm4gMTsKICAgICB9Ci0gIGlmIChzZXQpCisgIGlmIChzZXRfdXNl
ZCkKICAgICBuZXdmbGFncyA9IHNldDsKICAgZWxzZQogICAgIHsKQEAgLTI0NSw5ICsyNDcs
MTAgQEAgdXNhZ2UgKEZJTEUgKnN0cmVhbSkKICAgICAgICJcbiIKICAgICAgICJUaGUgZm9y
bWF0IG9mICdtb2RlJyBpcyB7Ky09fVthY0NlaG5yc1N0XVxuIgogICAgICAgIlxuIgotICAg
ICAgIlRoZSAgb3BlcmF0b3IgJysnIGNhdXNlcyB0aGUgc2VsZWN0ZWQgYXR0cmlidXRlcyB0
byBiZSBhZGRlZCB0byB0aGVcbiIKKyAgICAgICJUaGUgb3BlcmF0b3IgJysnIGNhdXNlcyB0
aGUgc2VsZWN0ZWQgYXR0cmlidXRlcyB0byBiZSBhZGRlZCB0byB0aGVcbiIKICAgICAgICJl
eGlzdGluZyBhdHRyaWJ1dGVzIG9mIHRoZSBmaWxlczsgJy0nIGNhdXNlcyB0aGVtIHRvIGJl
IHJlbW92ZWQ7IGFuZFxuIgogICAgICAgIic9JyBjYXVzZXMgdGhlbSB0byBiZSB0aGUgb25s
eSBhdHRyaWJ1dGVzIHRoYXQgdGhlIGZpbGVzIGhhdmUuXG4iCisgICAgICAiQSBzaW5nbGUg
Jz0nIGNhdXNlcyBhbGwgYXR0cmlidXRlcyB0byBiZSByZW1vdmVkLlxuIgogICAgICAgIlxu
IgogICAgICAgIlN1cHBvcnRlZCBhdHRyaWJ1dGVzOlxuIgogICAgICAgIlxuIgpAQCAtMzEz
LDcgKzMxNiw3IEBAIG5leHQ6CiAgICAgICBvcHQgPSBzdHJjaHIgKCIrLT0iLCBhcmd2W29w
dGluZF1bMF0pOwogICAgICAgaWYgKCFvcHQpCiAJYnJlYWs7Ci0gICAgICBpZiAoYXJndltv
cHRpbmRdWzFdID09ICdcMCcgfHwgZ2V0X2ZsYWdzIChhcmd2W29wdGluZF0pKQorICAgICAg
aWYgKCgqb3B0ICE9ICc9JyAmJiBhcmd2W29wdGluZF1bMV0gPT0gJ1wwJykgfHwgZ2V0X2Zs
YWdzIChhcmd2W29wdGluZF0pKQogCXVzYWdlIChzdGRlcnIpOwogICAgICAgKytvcHRpbmQ7
CiAgICAgfQotLSAKMi4zMS4xCgo=
--------------AE295A2F8D17AB6C0FED6F2D--
