From: "Michael A. Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH]Add help option to mount and umount
Date: Tue, 10 Apr 2001 09:22:00 -0000
Message-id: <000c01c0c1da$475de120$6d31273f@ca.boeing.com>
X-SW-Source: 2001-q2/msg00024.html
Content-type: multipart/mixed; boundary="----------=_1583532847-65438-38"

This is a multi-part message in MIME format...

------------=_1583532847-65438-38
Content-length: 358

It's going to take a while to figure out who at Oracle should sign the
disclaimer for me, so here's the help option part of the previous patch.

You can discard the ChangeLog if you like, this really just completes the
changes made on 2 April.
--
Mac :})
Give a hobbit a fish and he'll eat fish for a day.
Give a hobbit a ring and he'll eat fish for an age.

------------=_1583532847-65438-38
Content-Type: text/plain; charset=us-ascii;
 name="ChangeLog-winsup-utils-mac-2"
Content-Disposition: inline; filename="ChangeLog-winsup-utils-mac-2"
Content-Transfer-Encoding: base64
Content-Length: 383

MjAwMS0wNC0xMCAgTWljaGFlbCBBIENoYXNlIDxtY2hhc2VAaXgubmV0Y29t
LmNvbT4KCiAgICAqIG1vdW50LmNjIChsb25nb3B0cyk6IEFkZCBoZWxwIHRv
IG9wdGlvbnMgbGlzdC4KICAgICAgICAgICAgICAgKG9wdHMpOiBBZGQgJ2gn
IHRvIG9wdGlvbnMgc3RyaW5nLgogICAgKiB1bW91bnQuY2MgKGxvbmdvcHRz
KTogQWRkIGhlbHAgdG8gb3B0aW9ucyBsaXN0LgogICAgICAgICAgICAgICAg
KG9wdHMpOiBBZGQgJ2gnIHRvIG9wdGlvbnMgc3RyaW5nIGFuZCBjaGFuZ2Ug
J1InIHRvICdBJy4K

------------=_1583532847-65438-38
Content-Type: text/x-diff; charset=us-ascii; name="mount.cc-patch"
Content-Disposition: inline; filename="mount.cc-patch"
Content-Transfer-Encoding: base64
Content-Length: 663

LS0tIG1vdW50LmNjLTAJVHVlIEFwciAxMCAwODozODo0NCAyMDAxCisrKyBt
b3VudC5jYwlUdWUgQXByIDEwIDA4OjQ4OjI3IDIwMDEKQEAgLTg3LDYgKzg3
LDcgQEAgZG9fbW91bnQgKGNvbnN0IGNoYXIgKmRldiwgY29uc3QgY2hhciAq
dwogCiBzdHJ1Y3Qgb3B0aW9uIGxvbmdvcHRzW10gPQogeworICB7ImhlbHAi
LCBub19hcmd1bWVudCwgTlVMTCwgJ2gnIH0sCiAgIHsiYmluYXJ5Iiwgbm9f
YXJndW1lbnQsIE5VTEwsICdiJ30sCiAgIHsiZm9yY2UiLCBub19hcmd1bWVu
dCwgTlVMTCwgJ2YnfSwKICAgeyJzeXN0ZW0iLCBub19hcmd1bWVudCwgTlVM
TCwgJ3MnfSwKQEAgLTEwMCw3ICsxMDEsNyBAQCBzdHJ1Y3Qgb3B0aW9uIGxv
bmdvcHRzW10gPQogICB7TlVMTCwgMCwgTlVMTCwgMH0KIH07CiAKLWNoYXIg
b3B0c1tdID0gImJmc3R1eFhwaWMiOworY2hhciBvcHRzW10gPSAiaGJmc3R1
eFhwaWMiOwogCiBzdGF0aWMgdm9pZAogdXNhZ2UgKHZvaWQpCg==

------------=_1583532847-65438-38
Content-Type: text/x-diff; charset=us-ascii; name="umount.cc-patch"
Content-Disposition: inline; filename="umount.cc-patch"
Content-Transfer-Encoding: base64
Content-Length: 692

LS0tIHVtb3VudC5jYy0wCVR1ZSBBcHIgMTAgMDg6Mzg6NDQgMjAwMQorKysg
dW1vdW50LmNjCVR1ZSBBcHIgMTAgMDg6NDk6NDAgMjAwMQpAQCAtMjUsNiAr
MjUsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqcHJvZ25hbWU7CiAKIHN0cnVj
dCBvcHRpb24gbG9uZ29wdHNbXSA9CiB7CisgIHsiaGVscCIsIG5vX2FyZ3Vt
ZW50LCBOVUxMLCAnaCcgfSwKICAgeyJyZW1vdmUtYWxsLW1vdW50cyIsIG5v
X2FyZ3VtZW50LCBOVUxMLCAnQSd9LAogICB7InJlbW92ZS1jeWdkcml2ZS1w
cmVmaXgiLCBub19hcmd1bWVudCwgTlVMTCwgJ2MnfSwKICAgeyJyZW1vdmUt
c3lzdGVtLW1vdW50cyIsIG5vX2FyZ3VtZW50LCBOVUxMLCAnUyd9LApAQCAt
MzQsNyArMzUsNyBAQCBzdHJ1Y3Qgb3B0aW9uIGxvbmdvcHRzW10gPQogICB7
TlVMTCwgMCwgTlVMTCwgMH0KIH07CiAKLWNoYXIgb3B0c1tdID0gIlJTVXN1
YyI7CitjaGFyIG9wdHNbXSA9ICJoQVNVc3VjIjsKIAogc3RhdGljIHZvaWQK
IHVzYWdlICh2b2lkKQo=

------------=_1583532847-65438-38--
