Return-Path: <Christian.Franke@t-online.de>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
 by sourceware.org (Postfix) with ESMTPS id 0F7743848407
 for <cygwin-patches@cygwin.com>; Thu, 20 May 2021 10:02:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0F7743848407
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=Christian.Franke@t-online.de
Received: from fwd36.aul.t-online.de (fwd36.aul.t-online.de [172.20.26.137])
 by mailout07.t-online.de (Postfix) with SMTP id 9A69D53B78
 for <cygwin-patches@cygwin.com>; Thu, 20 May 2021 12:01:34 +0200 (CEST)
Received: from [192.168.2.105]
 (V+eLLBZU8hvQRDrIvZLN+uYhRX50eFfnvSAYjpb81MQsY+MgP0U31YKkmS3E+ZdZvp@[79.230.169.184])
 by fwd36.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1ljfUe-0LjPe40; Thu, 20 May 2021 12:01:28 +0200
From: Christian Franke <Christian.Franke@t-online.de>
Subject: Re: [PATCH] Cygwin: utils: chattr: Improve option parsing.
To: cygwin-patches@cygwin.com
References: <d515bfba-ce77-40c0-0c3e-67895675f753@t-online.de>
 <YKVPOaBrb0a9lV54@calimero.vinschen.de>
Message-ID: <e78257d8-bd2a-3ea0-0cea-48114ec017a0@t-online.de>
Date: Thu, 20 May 2021 12:01:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 SeaMonkey/2.53.6
MIME-Version: 1.0
In-Reply-To: <YKVPOaBrb0a9lV54@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------44D411B130C01B4B380B8673"
X-ID: V+eLLBZU8hvQRDrIvZLN+uYhRX50eFfnvSAYjpb81MQsY+MgP0U31YKkmS3E+ZdZvp
X-TOI-EXPURGATEID: 150726::1621504888-000121E1-078DF690/0/0 CLEAN NORMAL
X-TOI-MSGID: 3cb71040-61d9-4196-af07-c9a9948d6fe3
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00, BODY_8BITS,
 FREEMAIL_FROM, GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Thu, 20 May 2021 10:02:41 -0000

This is a multi-part message in MIME format.
--------------44D411B130C01B4B380B8673
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Corinna Vinschen wrote:
> Hi Christian,
>
> On May 19 17:46, Christian Franke wrote:
>> ...
>> $ egrep 'ACL|--r' chattr.c
>>            "Get POSIX ACL information\n"
>>        "  -R, --recursive     recursively list attributes of directories and
>> their \n"
> Oops.  Please patch while you're at it...
> ...
>>  From 865a5a50501f3fd0cf5ed28500d3e6e45a6456de Mon Sep 17 00:00:00 2001
>> From: Christian Franke<...>
>> Date: Wed, 19 May 2021 16:24:47 +0200
>> Subject: [PATCH] Cygwin: utils: chattr: Improve option parsing.
>>
>> Interpret '-h' as '--help' only if last argument.
> Who was the idiot using -h for help *and* the hidden flag? *blush*
>
> I'd vote for --help to be changed to -H for the single character
> option.  The help output is very unlikely to be used in scripts,
> so that shouldn't be a backward compat problem.

New patch attached.

Note that there is now the possibly unexpected (& hidden) behavior that 
'chattr -h' without file argument clears the hidden attribute of cwd.

Regards,
Christian


--------------44D411B130C01B4B380B8673
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-utils-chattr-Improve-option-parsing-fix-some-.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-utils-chattr-Improve-option-parsing-fix-some-.pa";
 filename*1="tch"

RnJvbSBiODM4MTI1Zjc5N2MxMjNkNGE2ZDJmMGVmMzBjY2NlZThmYWNlNTBjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUaHUsIDIwIE1heSAyMDIxIDExOjA1OjI5ICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiB1dGlsczogY2hhdHRyOiBJbXByb3ZlIG9wdGlv
biBwYXJzaW5nLCBmaXggc29tZQogbWVzc2FnZXMuCgpBbGxvdyBtdWx0aXBsZSBjaGFyYWN0
ZXJzIGFsc28gaW4gZmlyc3QgJy1tb2RlJyBhcmd1bWVudC4KVXNlICctSCcgaW5zdGVhZCBv
ZiAnLWgnIGZvciAnLS1oZWxwJyB0byBmaXggYW1iaWd1aXR5IHdpdGgKaGlkZGVuIGF0dHJp
YnV0ZS4gIEZpeCBoZWxwIGFuZCB1c2FnZSB0ZXh0cyBhbmQgZG9jdW1lbnRhdGlvbi4KClNp
Z25lZC1vZmYtYnk6IENocmlzdGlhbiBGcmFua2UgPGNocmlzdGlhbi5mcmFua2VAdC1vbmxp
bmUuZGU+Ci0tLQogd2luc3VwL2RvYy91dGlscy54bWwgIHwgMTAgKysrKystLS0tLQogd2lu
c3VwL3V0aWxzL2NoYXR0ci5jIHwgMzIgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0KIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvd2luc3VwL2RvYy91dGlscy54bWwgYi93aW5zdXAvZG9jL3V0aWxz
LnhtbAppbmRleCAyMmJkODY5MDQuLjY5NjExYjk1NCAxMDA2NDQKLS0tIGEvd2luc3VwL2Rv
Yy91dGlscy54bWwKKysrIGIvd2luc3VwL2RvYy91dGlscy54bWwKQEAgLTI3LDE4ICsyNywx
OCBAQAogCiAgICAgPHJlZnN5bm9wc2lzZGl2PgogICAgICAgPHNjcmVlbj4KLWNoYXR0ciBb
LVJWZmh2XSBbKy09bW9kZV0uLi4gW2ZpbGVdLi4uCitjaGF0dHIgWy1SVmZIdl0gWystPW1v
ZGVdLi4uIFtmaWxlXS4uLgogICAgICAgPC9zY3JlZW4+CiAgICAgPC9yZWZzeW5vcHNpc2Rp
dj4KIAogICAgIDxyZWZzZWN0MSBpZD0iY2hhdHRyLW9wdGlvbnMiPgogICAgICAgPHRpdGxl
Pk9wdGlvbnM8L3RpdGxlPgogICAgICAgPHNjcmVlbj4KLSAgLVIsIC0tcmVjdXJzaXZlICAg
ICByZWN1cnNpdmVseSBsaXN0IGF0dHJpYnV0ZXMgb2YgZGlyZWN0b3JpZXMgYW5kIHRoZWly
Ci0gICAgICAgICAgICAgICAgICAgICAgY29udGVudHMKKyAgLVIsIC0tcmVjdXJzaXZlICAg
ICByZWN1cnNpdmVseSBhcHBseSB0aGUgY2hhbmdlcyB0byBkaXJlY3RvcmllcyBhbmQKKyAg
ICAgICAgICAgICAgICAgICAgICB0aGVpciBjb250ZW50cwogICAtViwgLS12ZXJib3NlICAg
ICAgIEJlIHZlcmJvc2UgZHVyaW5nIG9wZXJhdGlvbgogICAtZiwgLS1mb3JjZSAgICAgICAg
IHN1cHByZXNzIGVycm9yIG1lc3NhZ2VzCi0gIC1oLCAtLWhlbHAgICAgICAgICAgdGhpcyBo
ZWxwIHRleHQKKyAgLUgsIC0taGVscCAgICAgICAgICB0aGlzIGhlbHAgdGV4dAogICAtdiwg
LS12ZXJzaW9uICAgICAgIGRpc3BsYXkgdGhlIHByb2dyYW0gdmVyc2lvbgogPC9zY3JlZW4+
CiAgICAgPC9yZWZzZWN0MT4KQEAgLTYwLDcgKzYwLDcgQEAgY2hhdHRyIFstUlZmaHZdIFsr
LT1tb2RlXS4uLiBbZmlsZV0uLi4KICAgICA8cGFyYT5TdXBwb3J0ZWQgYXR0cmlidXRlczo8
L3BhcmE+CiAKICAgICA8c2NyZWVuPgotICAncicsICdSZWFkb25seSc6ICAgICBmaWxlIGlz
IHJlYWQtb25seQorICAncicsICdSZWFkb25seSc6ICAgICAgZmlsZSBpcyByZWFkLW9ubHkK
ICAgJ2gnLCAnSGlkZGVuJzogICAgICAgIGZpbGUgb3IgZGlyZWN0b3J5IGlzIGhpZGRlbgog
ICAncycsICdTeXN0ZW0nOiAgICAgICAgZmlsZSBvciBkaXJlY3RvcnkgdGhhdCB0aGUgb3Bl
cmF0aW5nIHN5c3RlbSB1c2VzCiAgICdhJywgJ0FyY2hpdmUnOiAgICAgICBmaWxlIG9yIGRp
cmVjdG9yeSBoYXMgdGhlIGFyY2hpdmUgbWFya2VyIHNldApkaWZmIC0tZ2l0IGEvd2luc3Vw
L3V0aWxzL2NoYXR0ci5jIGIvd2luc3VwL3V0aWxzL2NoYXR0ci5jCmluZGV4IDk4ZjY5M2Fh
Yi4uYzdkYzY0OWMyIDEwMDY0NAotLS0gYS93aW5zdXAvdXRpbHMvY2hhdHRyLmMKKysrIGIv
d2luc3VwL3V0aWxzL2NoYXR0ci5jCkBAIC0yOCwxMiArMjgsMTIgQEAgc3RydWN0IG9wdGlv
biBsb25nb3B0c1tdID0gewogICB7ICJyZWN1cnNpdmUiLCBub19hcmd1bWVudCwgTlVMTCwg
J1InIH0sCiAgIHsgInZlcmJvc2UiLCBub19hcmd1bWVudCwgTlVMTCwgJ1YnIH0sCiAgIHsg
ImZvcmNlIiwgbm9fYXJndW1lbnQsIE5VTEwsICdmJyB9LAotICB7ICJoZWxwIiwgbm9fYXJn
dW1lbnQsIE5VTEwsICdoJyB9LAorICB7ICJoZWxwIiwgbm9fYXJndW1lbnQsIE5VTEwsICdI
JyB9LAogICB7ICJ2ZXJzaW9uIiwgbm9fYXJndW1lbnQsIE5VTEwsICd2JyB9LAogICB7IE5V
TEwsIG5vX2FyZ3VtZW50LCBOVUxMLCAwfQogfTsKIAotY29uc3QgY2hhciAqb3B0cyA9ICIr
UlZmaHYiOworY29uc3QgY2hhciAqb3B0cyA9ICIrUlZmSHYiOwogCiBzdHJ1Y3QKIHsKQEAg
LTIxMSw3ICsyMTEsNyBAQCBzdGF0aWMgdm9pZAogcHJpbnRfdmVyc2lvbiAoKQogewogICBw
cmludGYgKCIlcyAoY3lnd2luKSAlZC4lZC4lZFxuIgotCSAgIkdldCBQT1NJWCBBQ0wgaW5m
b3JtYXRpb25cbiIKKwkgICJDaGFuZ2UgZmlsZSBhdHRyaWJ1dGVzXG4iCiAJICAiQ29weXJp
Z2h0IChDKSAyMDE4IC0gJXMgQ3lnd2luIEF1dGhvcnNcbiIKIAkgICJUaGlzIGlzIGZyZWUg
c29mdHdhcmU7IHNlZSB0aGUgc291cmNlIGZvciBjb3B5aW5nIGNvbmRpdGlvbnMuICAiCiAJ
ICAiVGhlcmUgaXMgTk9cbiIKQEAgLTIyNyw3ICsyMjcsNyBAQCBwcmludF92ZXJzaW9uICgp
CiBzdGF0aWMgdm9pZCBfX2F0dHJpYnV0ZV9fICgoX19ub3JldHVybl9fKSkKIHVzYWdlIChG
SUxFICpzdHJlYW0pCiB7Ci0gIGZwcmludGYgKHN0cmVhbSwgIlVzYWdlOiAlcyBbLVJWZmh2
XSBbKy09bW9kZV0uLi4gW2ZpbGVdLi4uXG4iLAorICBmcHJpbnRmIChzdHJlYW0sICJVc2Fn
ZTogJXMgWy1SVmZIdl0gWystPW1vZGVdLi4uIFtmaWxlXS4uLlxuIiwKIAkgICBwcm9ncmFt
X2ludm9jYXRpb25fc2hvcnRfbmFtZSk7CiAgIGlmIChzdHJlYW0gPT0gc3RkZXJyKQogICAg
IGZwcmludGYgKHN0cmVhbSwgIlRyeSAnJXMgLS1oZWxwJyBmb3IgbW9yZSBpbmZvcm1hdGlv
blxuIiwKQEAgLTIzNiwxMSArMjM2LDExIEBAIHVzYWdlIChGSUxFICpzdHJlYW0pCiAgICAg
ZnByaW50ZiAoc3RyZWFtLCAiXG4iCiAgICAgICAiQ2hhbmdlIGZpbGUgYXR0cmlidXRlc1xu
IgogICAgICAgIlxuIgotICAgICAgIiAgLVIsIC0tcmVjdXJzaXZlICAgICByZWN1cnNpdmVs
eSBsaXN0IGF0dHJpYnV0ZXMgb2YgZGlyZWN0b3JpZXMgYW5kIHRoZWlyIFxuIgorICAgICAg
IiAgLVIsIC0tcmVjdXJzaXZlICAgICByZWN1cnNpdmVseSBhcHBseSB0aGUgY2hhbmdlcyB0
byBkaXJlY3RvcmllcyBhbmQgdGhlaXJcbiIKICAgICAgICIgICAgICAgICAgICAgICAgICAg
ICAgY29udGVudHNcbiIKICAgICAgICIgIC1WLCAtLXZlcmJvc2UgICAgICAgQmUgdmVyYm9z
ZSBkdXJpbmcgb3BlcmF0aW9uXG4iCiAgICAgICAiICAtZiwgLS1mb3JjZSAgICAgICAgIHN1
cHByZXNzIGVycm9yIG1lc3NhZ2VzXG4iCi0gICAgICAiICAtaCwgLS1oZWxwICAgICAgICAg
IHRoaXMgaGVscCB0ZXh0XG4iCisgICAgICAiICAtSCwgLS1oZWxwICAgICAgICAgIHRoaXMg
aGVscCB0ZXh0XG4iCiAgICAgICAiICAtdiwgLS12ZXJzaW9uICAgICAgIGRpc3BsYXkgdGhl
IHByb2dyYW0gdmVyc2lvblxuIgogICAgICAgIlxuIgogICAgICAgIlRoZSBmb3JtYXQgb2Yg
J21vZGUnIGlzIHsrLT19W2FjQ2VobnJzU3RdXG4iCkBAIC0yNTEsNyArMjUxLDcgQEAgdXNh
Z2UgKEZJTEUgKnN0cmVhbSkKICAgICAgICJcbiIKICAgICAgICJTdXBwb3J0ZWQgYXR0cmli
dXRlczpcbiIKICAgICAgICJcbiIKLSAgICAgICIgICdyJywgJ1JlYWRvbmx5JzogICAgIGZp
bGUgaXMgcmVhZC1vbmx5XG4iCisgICAgICAiICAncicsICdSZWFkb25seSc6ICAgICAgZmls
ZSBpcyByZWFkLW9ubHlcbiIKICAgICAgICIgICdoJywgJ0hpZGRlbic6ICAgICAgICBmaWxl
IG9yIGRpcmVjdG9yeSBpcyBoaWRkZW5cbiIKICAgICAgICIgICdzJywgJ1N5c3RlbSc6ICAg
ICAgICBmaWxlIG9yIGRpcmVjdG9yeSB0aGF0IHRoZSBvcGVyYXRpbmcgc3lzdGVtIHVzZXNc
biIKICAgICAgICIgICdhJywgJ0FyY2hpdmUnOiAgICAgICBmaWxlIG9yIGRpcmVjdG9yeSBo
YXMgdGhlIGFyY2hpdmUgbWFya2VyIHNldFxuIgpAQCAtMjcxLDcgKzI3MSw3IEBAIGludAog
bWFpbiAoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogewogICBpbnQgYywgcmV0ID0gMDsKLSAg
aW50IGxhc3RvcHRpbmQgPSAwOworICBpbnQgbGFzdG9wdGluZCA9IDE7CiAgIGNoYXIgKm9w
dDsKIAogICBvcHRlcnIgPSAwOwpAQCAtMjgxLDE1ICsyODEsMTUgQEAgbWFpbiAoaW50IGFy
Z2MsIGNoYXIgKiphcmd2KQogCXsKIAljYXNlICdSJzoKIAkgIFJvcHQgPSAxOwotCSAgbGFz
dG9wdGluZCA9IG9wdGluZDsKIAkgIGJyZWFrOwogCWNhc2UgJ1YnOgogCSAgVm9wdCA9IDE7
Ci0JICBsYXN0b3B0aW5kID0gb3B0aW5kOwogCSAgYnJlYWs7CiAJY2FzZSAnZic6CiAJICBm
b3B0ID0gMTsKLQkgIGxhc3RvcHRpbmQgPSBvcHRpbmQ7CisJICBicmVhazsKKwljYXNlICdI
JzoKKwkgIHVzYWdlIChzdGRvdXQpOwogCSAgYnJlYWs7CiAJY2FzZSAndic6CiAJICBwcmlu
dF92ZXJzaW9uICgpOwpAQCAtMjk3LDE0ICsyOTcsMTAgQEAgbWFpbiAoaW50IGFyZ2MsIGNo
YXIgKiphcmd2KQogCSAgYnJlYWs7CiAJZGVmYXVsdDoKIAkgIGlmIChvcHRpbmQgPiBsYXN0
b3B0aW5kKQotCSAgICB7Ci0JICAgICAgLS1vcHRpbmQ7Ci0JICAgICAgZ290byBuZXh0Owot
CSAgICB9Ci0JICAvKkZBTExUSFJVKi8KLQljYXNlICdoJzoKLQkgIHVzYWdlIChjID09ICdo
JyA/IHN0ZG91dCA6IHN0ZGVycik7CisJICAgIC0tb3B0aW5kOworCSAgZ290byBuZXh0Owog
CX0KKyAgICAgIGxhc3RvcHRpbmQgPSBvcHRpbmQ7CiAgICAgfQogbmV4dDoKICAgd2hpbGUg
KG9wdGluZCA8IGFyZ2MpCi0tIAoyLjMxLjEKCg==
--------------44D411B130C01B4B380B8673--
