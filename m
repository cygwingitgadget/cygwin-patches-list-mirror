From: egor duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin build SEGV
Date: Wed, 05 Sep 2001 13:25:00 -0000
Message-id: <8425103266.20010906002344@logos-m.ru>
References: <3B950586.3050106@ece.gatech.edu> <20010904130237.B7509@redhat.com> <3B950F1E.80008@ece.gatech.edu> <114122083636.20010904223654@logos-m.ru> <3B958C2F.6040003@ece.gatech.edu> <20010904225434.A12398@redhat.com> <3B9598F0.8050008@ece.gatech.edu> <20010904234003.A13012@redhat.com> <20010905000529.A13237@redhat.com> <3B95AA46.5090000@ece.gatech.edu> <20010905011923.A17984@redhat.com>
X-SW-Source: 2001-q3/msg00104.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-96"

This is a multi-part message in MIME format...

------------=_1583532848-65438-96
Content-length: 602

Hi!

Wednesday, 05 September, 2001 Christopher Faylor cgf@redhat.com wrote:

ok, i've reproduced something similar and i believe i know the reason.
in my case set_nt_attribute is called with alloca()ed buffer of size
256, but actual security descriptor is 268 bytes long. Bang. Stack
corrupted. This is a workaround, though i think alloc_sd should check
buffer size, but i cannot produce a patch for this right now.
hopefully, 4k is enough for any sd. And yes, i think it's a
show-stopper.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
alloca-fix.diff
alloca-fix.ChangeLog


------------=_1583532848-65438-96
Content-Type: text/plain; charset=us-ascii; name="alloca-fix.ChangeLog"
Content-Disposition: inline; filename="alloca-fix.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 281

MjAwMS0wOS0wNiAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBk
aXIuY2MgKG1rZGlyKTogRXhwYW5kIGJ1ZmZlciBmb3Igc2VjdXJpdHkgZGVz
Y3JpcHRvciB0byA0SyB0bwoJYXZvaWQgc3RhY2sgY29ycnVwdGlvbi4KCSog
ZmhhbmRsZXIuY2MgKGZoYW5kbGVyX2Jhc2U6Om9wZW4pOiBEaXR0by4KCSog
cGF0aC5jYyAoc3ltbGluayk6IERpdHRvLgo=

------------=_1583532848-65438-96
Content-Type: text/x-diff; charset=us-ascii; name="alloca-fix.diff"
Content-Disposition: inline; filename="alloca-fix.diff"
Content-Transfer-Encoding: base64
Content-Length: 2351

SW5kZXg6IGRpci5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxl
OiAvY3ZzL3ViZXJiYXVtL3dpbnN1cC9jeWd3aW4vZGlyLmNjLHYKcmV0cmll
dmluZyByZXZpc2lvbiAxLjQxCmRpZmYgLXUgLXAgLTIgLXIxLjQxIGRpci5j
YwotLS0gZGlyLmNjCTIwMDEvMDkvMDMgMTk6MDY6NTgJMS40MQorKysgZGly
LmNjCTIwMDEvMDkvMDUgMjA6MjI6NDIKQEAgLTM0MCw1ICszNDAsNSBAQCBt
a2RpciAoY29uc3QgY2hhciAqZGlyLCBtb2RlX3QgbW9kZSkKICAgaWYgKGFs
bG93X250c2VjICYmIHJlYWxfZGlyLmhhc19hY2xzICgpKQogICAgIHNldF9z
ZWN1cml0eV9hdHRyaWJ1dGUgKFNfSUZESVIgfCAoKG1vZGUgJiAwNzc3Nykg
JiB+Y3lnaGVhcC0+dW1hc2spLAotCQkJICAgICZzYSwgYWxsb2NhICgyNTYp
LCAyNTYpOworCQkJICAgICZzYSwgYWxsb2NhICg0MDk2KSwgNDA5Nik7CiAK
ICAgaWYgKENyZWF0ZURpcmVjdG9yeUEgKHJlYWxfZGlyLmdldF93aW4zMiAo
KSwgJnNhKSkKSW5kZXg6IGZoYW5kbGVyLmNjCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KUkNTIGZpbGU6IC9jdnMvdWJlcmJhdW0vd2luc3VwL2N5Z3dpbi9m
aGFuZGxlci5jYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS43NwpkaWZmIC11
IC1wIC0yIC1yMS43NyBmaGFuZGxlci5jYwotLS0gZmhhbmRsZXIuY2MJMjAw
MS8wOS8wMSAwNToxNzozNAkxLjc3CisrKyBmaGFuZGxlci5jYwkyMDAxLzA5
LzA1IDIwOjIyOjQyCkBAIC0zODgsNSArMzg4LDUgQEAgZmhhbmRsZXJfYmFz
ZTo6b3BlbiAoaW50IGZsYWdzLCBtb2RlX3QgbQogICAgICBzZXQgZmlsZXMg
YXR0cmlidXRlcy4gKi8KICAgaWYgKGZsYWdzICYgT19DUkVBVCAmJiBnZXRf
ZGV2aWNlICgpID09IEZIX0RJU0sgJiYgYWxsb3dfbnRzZWMgJiYgaGFzX2Fj
bHMgKCkpCi0gICAgc2V0X3NlY3VyaXR5X2F0dHJpYnV0ZSAobW9kZSwgJnNh
LCBhbGxvY2EgKDI1NiksIDI1Nik7CisgICAgc2V0X3NlY3VyaXR5X2F0dHJp
YnV0ZSAobW9kZSwgJnNhLCBhbGxvY2EgKDQwOTYpLCA0MDk2KTsKIAogICB4
ID0gQ3JlYXRlRmlsZUEgKGdldF93aW4zMl9uYW1lICgpLCBhY2Nlc3MsIHNo
YXJlZCwKSW5kZXg6IHBhdGguY2MKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpS
Q1MgZmlsZTogL2N2cy91YmVyYmF1bS93aW5zdXAvY3lnd2luL3BhdGguY2Ms
dgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTU5CmRpZmYgLXUgLXAgLTIgLXIx
LjE1OSBwYXRoLmNjCi0tLSBwYXRoLmNjCTIwMDEvMDgvMjkgMDQ6NDM6MTkJ
MS4xNTkKKysrIHBhdGguY2MJMjAwMS8wOS8wNSAyMDoyMjo0MwpAQCAtMjQ2
Miw1ICsyNDYyLDUgQEAgc3ltbGluayAoY29uc3QgY2hhciAqdG9wYXRoLCBj
b25zdCBjaGFyIAogICBpZiAoYWxsb3dfbnRzZWMgJiYgd2luMzJfcGF0aC5o
YXNfYWNscyAoKSkKICAgICBzZXRfc2VjdXJpdHlfYXR0cmlidXRlIChTX0lG
TE5LIHwgU19JUldYVSB8IFNfSVJXWEcgfCBTX0lSV1hPLAotCQkJICAgICZz
YSwgYWxsb2NhICgyNTYpLCAyNTYpOworCQkJICAgICZzYSwgYWxsb2NhICg0
MDk2KSwgNDA5Nik7CiAKICAgaCA9IENyZWF0ZUZpbGVBKHdpbjMyX3BhdGgs
IEdFTkVSSUNfV1JJVEUsIDAsICZzYSwK

------------=_1583532848-65438-96--
