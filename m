Return-Path: <cygwin-patches-return-3271-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 528 invoked by alias); 3 Dec 2002 09:47:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 519 invoked from network); 3 Dec 2002 09:47:44 -0000
Date: Tue, 03 Dec 2002 01:47:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <19973816953.20021203124546@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
In-Reply-To: <20021202175006.GC21442@redhat.com>
References: <20021119072016.23A231BF36@redhat.com>
 <3577371564.20021119120659@logos-m.ru>
 <1451205547776.20021202133024@logos-m.ru> <20021202175006.GC21442@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------A1A5D623365A1B"
X-SW-Source: 2002-q4/txt/msg00222.txt.bz2

------------A1A5D623365A1B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1052

Hi!

Monday, 02 December, 2002 Christopher Faylor cgf@redhat.com wrote:

CF> On Mon, Dec 02, 2002 at 01:30:24PM +0300, egor duda wrote:
>>2002-12-02  Egor Duda <deo@logos-m.ru>
>>
>>        * cygwin/lib/pseudo-reloc.c: New file.
>>        * cygwin/cygwin.sc: Add symbols to handle runtime pseudo-relocs.
>>        * cygwin/lib/_cygwin_crt0_common.cc: Perform pseudo-relocs during
>>        initialization of cygwin binary (.exe or .dll).

CF> I'm rapidly approaching the I-don't-care-anymore state for this but I am
CF> not clear on why we need to add the changes to cygwin.sc.  This is for people
CF> who want to link the cygwin DLL without using the appropriate header files
CF> which label things as __declspec(dllexport) or using the appropriate libcygwin.a,
CF> right?  Why should that matter?

Yes, you're right. This part is not needed. It's probably been left
out from the "experimental" phase when i tried different ways to
handle pseudo-relocs. Here's the updated one.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
------------A1A5D623365A1B
Content-Type: application/octet-stream; name="pseudo-reloc.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pseudo-reloc.c"
Content-length: 1546

LyogcHNldWRvLXJlbG9jLmMKCiAgIFdyaXR0ZW4gYnkgRWdvciBEdWRhIDxk
ZW9AbG9nb3MtbS5ydT4KICAgVEhJUyBTT0ZUV0FSRSBJUyBOT1QgQ09QWVJJ
R0hURUQKCiAgIFRoaXMgc291cmNlIGNvZGUgaXMgb2ZmZXJlZCBmb3IgdXNl
IGluIHRoZSBwdWJsaWMgZG9tYWluLiBZb3UgbWF5CiAgIHVzZSwgbW9kaWZ5
IG9yIGRpc3RyaWJ1dGUgaXQgZnJlZWx5LgoKICAgVGhpcyBjb2RlIGlzIGRp
c3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwg
YnV0CiAgIFdJVEhPVVQgQU5ZIFdBUlJBTlRZLiBBTEwgV0FSUkVOVElFUywg
RVhQUkVTUyBPUiBJTVBMSUVEIEFSRSBIRVJFQlkKICAgRElTQ0xBTUVELiBU
aGlzIGluY2x1ZGVzIGJ1dCBpcyBub3QgbGltaXRlZCB0byB3YXJyZW50aWVz
IG9mCiAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJ
Q1VMQVIgUFVSUE9TRS4KKi8KCiNpbmNsdWRlIDx3aW5kb3dzLmg+CgpleHRl
cm4gY2hhciBfX1JVTlRJTUVfUFNFVURPX1JFTE9DX0xJU1RfXzsKZXh0ZXJu
IGNoYXIgX19SVU5USU1FX1BTRVVET19SRUxPQ19MSVNUX0VORF9fOwpleHRl
cm4gY2hhciBfaW1hZ2VfYmFzZV9fOwoKdHlwZWRlZiBzdHJ1Y3QKICB7CiAg
ICBEV09SRCBhZGRlbmQ7CiAgICBEV09SRCB0YXJnZXQ7CiAgfQpydW50aW1l
X3BzZXVkb19yZWxvYzsKCnZvaWQKZG9fcHNldWRvX3JlbG9jICh2b2lkKiBz
dGFydCwgdm9pZCogZW5kLCB2b2lkKiBiYXNlKQp7CiAgRFdPUkQgcmVsb2Nf
dGFyZ2V0OwogIHJ1bnRpbWVfcHNldWRvX3JlbG9jKiByOwogIGZvciAociA9
IChydW50aW1lX3BzZXVkb19yZWxvYyopIHN0YXJ0OyByIDwgKHJ1bnRpbWVf
cHNldWRvX3JlbG9jKikgZW5kOyByKyspCiAgICB7CiAgICAgIHJlbG9jX3Rh
cmdldCA9IChEV09SRCkgYmFzZSArIHItPnRhcmdldDsKICAgICAgKigoRFdP
UkQqKSByZWxvY190YXJnZXQpICs9IHItPmFkZGVuZDsKICAgIH0KfQoKdm9p
ZApfcGVpMzg2X3J1bnRpbWVfcmVsb2NhdG9yICgpCnsKICBkb19wc2V1ZG9f
cmVsb2MgKCZfX1JVTlRJTUVfUFNFVURPX1JFTE9DX0xJU1RfXywKCQkgICAm
X19SVU5USU1FX1BTRVVET19SRUxPQ19MSVNUX0VORF9fLAoJCSAgICZfaW1h
Z2VfYmFzZV9fKTsKfQo=

------------A1A5D623365A1B
Content-Type: application/octet-stream; name="cygwin-runtime-pseudo-reloc-support-4.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cygwin-runtime-pseudo-reloc-support-4.diff"
Content-length: 1021

SW5kZXg6IGN5Z3dpbi9saWIvX2N5Z3dpbl9jcnQwX2NvbW1vbi5jYwo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3ZzL3ViZXJiYXVtL3dp
bnN1cC9jeWd3aW4vbGliL19jeWd3aW5fY3J0MF9jb21tb24uY2MsdgpyZXRy
aWV2aW5nIHJldmlzaW9uIDEuMTAKZGlmZiAtdSAtcCAtMiAtcjEuMTAgX2N5
Z3dpbl9jcnQwX2NvbW1vbi5jYwotLS0gY3lnd2luL2xpYi9fY3lnd2luX2Ny
dDBfY29tbW9uLmNjCTExIFNlcCAyMDAxIDIwOjAxOjAyIC0wMDAwCTEuMTAK
KysrIGN5Z3dpbi9saWIvX2N5Z3dpbl9jcnQwX2NvbW1vbi5jYwkyIERlYyAy
MDAyIDEwOjA1OjMwIC0wMDAwCkBAIC0yNyw0ICsyNyw1IEBAIGludCBtYWlu
IChpbnQsIGNoYXIgKiosIGNoYXIgKiopOwogc3RydWN0IF9yZWVudCAqX2lt
cHVyZV9wdHI7CiBpbnQgX2Ztb2RlOwordm9pZCBfcGVpMzg2X3J1bnRpbWVf
cmVsb2NhdG9yICgpOwogCiAvKiBTZXQgdXAgcG9pbnRlcnMgdG8gdmFyaW91
cyBwaWVjZXMgc28gdGhlIGRsbCBjYW4gdGhlbiB1c2UgdGhlbSwKQEAgLTk1
LDQgKzk2LDYgQEAgX2N5Z3dpbl9jcnQwX2NvbW1vbiAoTWFpbkZ1bmMgZiwg
cGVyX3BybwogICB1LT5ic3Nfc3RhcnQgPSAmX2Jzc19zdGFydF9fOwogICB1
LT5ic3NfZW5kID0gJl9ic3NfZW5kX187CisKKyAgX3BlaTM4Nl9ydW50aW1l
X3JlbG9jYXRvciAoKTsKICAgcmV0dXJuIDE7CiB9Cg==

------------A1A5D623365A1B
Content-Type: application/octet-stream; name="cygwin-runtime-pseudo-reloc-support-4.ChangeLog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cygwin-runtime-pseudo-reloc-support-4.ChangeLog"
Content-length: 269

MjAwMi0xMi0wMiAgRWdvciBEdWRhIDxkZW9AbG9nb3MtbS5ydT4KCgkqIGN5
Z3dpbi9saWIvcHNldWRvLXJlbG9jLmM6IE5ldyBmaWxlLgoJKiBjeWd3aW4v
bGliL19jeWd3aW5fY3J0MF9jb21tb24uY2M6IFBlcmZvcm0gcHNldWRvLXJl
bG9jcyBkdXJpbmcKCWluaXRpYWxpemF0aW9uIG9mIGN5Z3dpbiBiaW5hcnkg
KC5leGUgb3IgLmRsbCkuCg==

------------A1A5D623365A1B--
