Return-Path: <cygwin-patches-return-3254-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15712 invoked by alias); 2 Dec 2002 10:31:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15654 invoked from network); 2 Dec 2002 10:31:30 -0000
Date: Mon, 02 Dec 2002 02:31:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <1451205547776.20021202133024@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: --enable-runtime-pseudo-reloc support in cygwin, take 3.
In-Reply-To: <3577371564.20021119120659@logos-m.ru>
References: <20021119072016.23A231BF36@redhat.com>
 <3577371564.20021119120659@logos-m.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------56B9A339EE3149"
X-SW-Source: 2002-q4/txt/msg00205.txt.bz2

------------56B9A339EE3149
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 2571

Hi!

Tuesday, 19 November, 2002 egor duda deo@logos-m.ru wrote:

ed> Tuesday, 19 November, 2002 Christopher Faylor cygwin@cygwin.com wrote:

CF>> I've made a new version of binutils available for download.  This is
CF>> just a refresh from sources.redhat.com.  A notable change is the
CF>> addition of Egor Duda's --enable-runtime-pseudo-reloc option which
CF>> allows almost transparent linking of dll's without the need of a def
CF>> file.  However, this option requires functionality in the cygwin DLL
CF>> which is not yet present.  Stay tuned.

ed> Ok, it's time to revive a discussion about implementation of
ed> pseudo-relocations in runtime. So far, there were 3 propositions:

ed> 1. Implement everything in application (in crt0.o)
ed> Benefits: Will work with any version of cygwin1.dll. All problems with
ed> lack of support from runtime are detected during application linking.
ed> (Possibly) common code with mingw.
ed> Drawbacks: Will require rebuilding application in case we'll want
ed> change something.

ed> 2. Implement everything in cygwin1.dll. In this case application is
ed> about to have an external reference to _pei386_runtime_relocator.
ed> Benefits: Easy to change relocation semantics without relinking
ed> application.
ed> Drawbacks: GUI window popping up when "new" application is loaded with
ed> "old" runtime. Lack of support is detected only at application
ed> startup.

ed> 3. Implement actual relocation in dll, and call it from crt0 via
ed> cygwin_internal(). Check dll api version and print error message if
ed> runtime is too old.
ed> Benefits: Easy to change relocation semantics without relinking
ed> application.
ed> Drawbacks: Lack of support is detected only at application
ed> startup.
ed> Question: How can one distinguish console application from GUI one?
ed> What is the best wording for the error message?

ed> My own preference list (from most preferable to least preferable) is:
ed> 1st, then 3rd, then 2nd.

Ok, here's the patch to implement #1 (i.e. link all pseudo-reloc-
related code statically to the binary).

2002-12-02  Egor Duda <deo@logos-m.ru>

        * cygwin/lib/pseudo-reloc.c: New file.
        * cygwin/cygwin.sc: Add symbols to handle runtime pseudo-relocs.
        * cygwin/lib/_cygwin_crt0_common.cc: Perform pseudo-relocs during
        initialization of cygwin binary (.exe or .dll).

Also attached are the tests to check if everything works for application
importing data from dll and for dll importing data from other dll.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
------------56B9A339EE3149
Content-Type: application/octet-stream; name="pseudo-reloc.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pseudo-reloc.c"
Content-length: 1269

LyogcHNldWRvLXJlbG9jLmMKCiAgIENvcHlyaWdodCAyMDAyIFJlZCBIYXQs
IEluYy4KICAgV3JpdHRlbiBieSBFZ29yIER1ZGEgPGRlb0Bsb2dvcy1tLnJ1
PgoKVGhpcyBmaWxlIGlzIHBhcnQgb2YgQ3lnd2luLgoKVGhpcyBzb2Z0d2Fy
ZSBpcyBhIGNvcHlyaWdodGVkIHdvcmsgbGljZW5zZWQgdW5kZXIgdGhlIHRl
cm1zIG9mIHRoZQpDeWd3aW4gbGljZW5zZS4gIFBsZWFzZSBjb25zdWx0IHRo
ZSBmaWxlICJDWUdXSU5fTElDRU5TRSIgZm9yCmRldGFpbHMuICovCgojaW5j
bHVkZSA8d2luZG93cy5oPgoKZXh0ZXJuIGNoYXIgX19SVU5USU1FX1BTRVVE
T19SRUxPQ19MSVNUX187CmV4dGVybiBjaGFyIF9fUlVOVElNRV9QU0VVRE9f
UkVMT0NfTElTVF9FTkRfXzsKZXh0ZXJuIGNoYXIgX2ltYWdlX2Jhc2VfXzsK
CnR5cGVkZWYgc3RydWN0CiAgewogICAgRFdPUkQgYWRkZW5kOwogICAgRFdP
UkQgdGFyZ2V0OwogIH0KcnVudGltZV9wc2V1ZG9fcmVsb2M7Cgp2b2lkCmRv
X3BzZXVkb19yZWxvYyAodm9pZCogc3RhcnQsIHZvaWQqIGVuZCwgdm9pZCog
YmFzZSkKewogIERXT1JEIHJlbG9jX3RhcmdldDsKICBydW50aW1lX3BzZXVk
b19yZWxvYyogcjsKICBmb3IgKHIgPSAocnVudGltZV9wc2V1ZG9fcmVsb2Mq
KSBzdGFydDsgciA8IChydW50aW1lX3BzZXVkb19yZWxvYyopIGVuZDsgcisr
KQogICAgewogICAgICByZWxvY190YXJnZXQgPSAoRFdPUkQpIGJhc2UgKyBy
LT50YXJnZXQ7CiAgICAgICooKERXT1JEKikgcmVsb2NfdGFyZ2V0KSArPSBy
LT5hZGRlbmQ7CiAgICB9Cn0KCnZvaWQKX3BlaTM4Nl9ydW50aW1lX3JlbG9j
YXRvciAoKQp7CiAgZG9fcHNldWRvX3JlbG9jICgmX19SVU5USU1FX1BTRVVE
T19SRUxPQ19MSVNUX18sCgkJICAgJl9fUlVOVElNRV9QU0VVRE9fUkVMT0Nf
TElTVF9FTkRfXywKCQkgICAmX2ltYWdlX2Jhc2VfXyk7Cn0K

------------56B9A339EE3149
Content-Type: application/octet-stream; name="cygwin-runtime-pseudo-reloc-support-3.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cygwin-runtime-pseudo-reloc-support-3.diff"
Content-length: 1855

SW5kZXg6IGN5Z3dpbi9jeWd3aW4uc2MKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQpSQ1MgZmlsZTogL2N2cy91YmVyYmF1bS93aW5zdXAvY3lnd2luL2N5Z3dp
bi5zYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS43CmRpZmYgLXUgLXAgLTIg
LXIxLjcgY3lnd2luLnNjCi0tLSBjeWd3aW4vY3lnd2luLnNjCTIzIEp1biAy
MDAyIDE4OjU1OjIzIC0wMDAwCTEuNworKysgY3lnd2luL2N5Z3dpbi5zYwky
IERlYyAyMDAyIDEwOjA1OjI5IC0wMDAwCkBAIC00MCw0ICs0MCw5IEBAIFNF
Q1RJT05TCiAgICAgKihTT1JUKC5yZGF0YSQqKSkKICAgICAqKC5laF9mcmFt
ZSkKKyAgICBfX19SVU5USU1FX1BTRVVET19SRUxPQ19MSVNUX18gPSAuOwor
ICAgIF9fUlVOVElNRV9QU0VVRE9fUkVMT0NfTElTVF9fID0gLjsKKyAgICAq
KC5yZGF0YV9ydW50aW1lX3BzZXVkb19yZWxvYykKKyAgICBfX19SVU5USU1F
X1BTRVVET19SRUxPQ19MSVNUX0VORF9fID0gLjsKKyAgICBfX1JVTlRJTUVf
UFNFVURPX1JFTE9DX0xJU1RfRU5EX18gPSAuOwogICB9CiAgIC5wZGF0YSBC
TE9DSyhfX3NlY3Rpb25fYWxpZ25tZW50X18pIDoKSW5kZXg6IGN5Z3dpbi9s
aWIvX2N5Z3dpbl9jcnQwX2NvbW1vbi5jYwo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09ClJDUyBmaWxlOiAvY3ZzL3ViZXJiYXVtL3dpbnN1cC9jeWd3aW4vbGli
L19jeWd3aW5fY3J0MF9jb21tb24uY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9u
IDEuMTAKZGlmZiAtdSAtcCAtMiAtcjEuMTAgX2N5Z3dpbl9jcnQwX2NvbW1v
bi5jYwotLS0gY3lnd2luL2xpYi9fY3lnd2luX2NydDBfY29tbW9uLmNjCTEx
IFNlcCAyMDAxIDIwOjAxOjAyIC0wMDAwCTEuMTAKKysrIGN5Z3dpbi9saWIv
X2N5Z3dpbl9jcnQwX2NvbW1vbi5jYwkyIERlYyAyMDAyIDEwOjA1OjMwIC0w
MDAwCkBAIC0yNyw0ICsyNyw1IEBAIGludCBtYWluIChpbnQsIGNoYXIgKios
IGNoYXIgKiopOwogc3RydWN0IF9yZWVudCAqX2ltcHVyZV9wdHI7CiBpbnQg
X2Ztb2RlOwordm9pZCBfcGVpMzg2X3J1bnRpbWVfcmVsb2NhdG9yICgpOwog
CiAvKiBTZXQgdXAgcG9pbnRlcnMgdG8gdmFyaW91cyBwaWVjZXMgc28gdGhl
IGRsbCBjYW4gdGhlbiB1c2UgdGhlbSwKQEAgLTk1LDQgKzk2LDYgQEAgX2N5
Z3dpbl9jcnQwX2NvbW1vbiAoTWFpbkZ1bmMgZiwgcGVyX3BybwogICB1LT5i
c3Nfc3RhcnQgPSAmX2Jzc19zdGFydF9fOwogICB1LT5ic3NfZW5kID0gJl9i
c3NfZW5kX187CisKKyAgX3BlaTM4Nl9ydW50aW1lX3JlbG9jYXRvciAoKTsK
ICAgcmV0dXJuIDE7CiB9Cg==

------------56B9A339EE3149
Content-Type: application/octet-stream; name="cygwin-runtime-pseudo-reloc-support-3.ChangeLog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cygwin-runtime-pseudo-reloc-support-3.ChangeLog"
Content-length: 358

MjAwMi0xMi0wMiAgRWdvciBEdWRhIDxkZW9AbG9nb3MtbS5ydT4KCgkqIGN5
Z3dpbi9saWIvcHNldWRvLXJlbG9jLmM6IE5ldyBmaWxlLgoJKiBjeWd3aW4v
Y3lnd2luLnNjOiBBZGQgc3ltYm9scyB0byBoYW5kbGUgcnVudGltZSBwc2V1
ZG8tcmVsb2NzLgoJKiBjeWd3aW4vbGliL19jeWd3aW5fY3J0MF9jb21tb24u
Y2M6IFBlcmZvcm0gcHNldWRvLXJlbG9jcyBkdXJpbmcKCWluaXRpYWxpemF0
aW9uIG9mIGN5Z3dpbiBiaW5hcnkgKC5leGUgb3IgLmRsbCkuCg==

------------56B9A339EE3149
Content-Type: application/octet-stream; name="pseudo-reloc-tests.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pseudo-reloc-tests.tar.bz2"
Content-length: 2611

QlpoOTFBWSZTWWwRQvYADhJ/lPyyAGb////fP+///v/v//pggACAAAhgCX90
AAAASAAAAAAAHDEaaaDQBoAAAAaDINNA0AGjQBiGgOGI000GgDQAAAA0GQaa
BoANGgDENAMiaT1KAAAAAHlAAAAAAAAAAA4YjTTQaANAAAADQZBpoGgA0aAM
Q0BwxGmmg0AaAAAAGgyDTQNABo0AYhoAqSITTQQCYmjQTIamnqYaRmkyngh6
p5R6I8oaPaMppHinp9JP0+qf0U+t32FU9ST15TgufcSy1RUhWkkBIYTzTJCa
gM84BcAuAYokisrRVA6BXkFYwR2zSRKEqhRIokySbJH/X4z2r11Ycp2J9r22
XmOf/n1XjWwdp9r9rGlX3W1mauGU1uD8V1KSlMiiqVSblGKmCi7yJdiwWaL2
ZK1YsHpLFln929yHKZbn8FLSb1NmLap+82ua83Njzudg+1Uk4tqyjVZvUYXr
Fg2MT38m0at2uM16tvrPVqv1O0SiqQj+xKETJJJ7qoTZJyHOeXSTqV3+Xf/7
12roMnOduyhujiUlHaaL2ehdL3fI2NTxszz9xms2OR8icaZTR7nC9qehrPSq
a5q5WrPGaK/1T6nchvczlKovORgm1xbWD73cR3WpoThPCYPpbmXeKbXdt28M
L4XVhhhhGFX2GbqNHcZ9exOOOBhmxaZ44Ku2q2M2MZnqGjR/FsazoYuJrMHd
bzFg1NbhOQwa1mob1U5lYmprPCovI2HfWM5PAsUVSeEP0VIlFHwwwkTSHyfJ
8jMxnbf2d11OJiUo5XYWg51IfwQpotM1RdaFD+sdTtP2x5H7Fmprk+ozlU7j
rWLypW5iwfuWKPEzaMFN/rrz2XvZHK0o+ZwNZ3KcjwrPdbzh+gU+R8qlPeXU
5HAupmZMn7A9gNjaKJ6qpRSlDMd4sfrWXT6YWYTFKXYTFeReeFkwUwmuYrJ1
TlYJ2lG/QsrjqUqKqVSr2VVVVJ4Wx77JqYsqVS7lT8LZZaYYVSqquJ8TKRvb
VQ+bm+Py/Pe8k+e1iSnwCWJRP6vRyw+I/4p9bImoTXU0TQmBNmENsy3Hpdxm
TdKe67MmuGu7brYf6fRtiy7BUmHz2ZJ3mO9M8N03Njbjt7rYTAmLRlnwt1aN
MmsmDfnntvmbkylyXtll7MM8rmzst9753vWu1Xs/zTYWYM8WWuVsoAoAsQCs
aNhSFwyRaJCPFXEpMYwCkyIyuzq0UDgGJggccwMrEFJAWUGCJIQ6EyywYAww
tUS6fGzcrB7az0vVd/16qzxL+x4mp7i/stHyslOtS74Eman6lmSm3CTFmnBw
4LVMmL96dmJ5FHEwce5qeVJd5U8c+ZPWHkE8Z45PHGqSfBDgeRSxRZ2H/kJ5
0YzFoksybD7oSnuMlMTzp9ZLvijSE2pywmqbH3npj74TOOIqFJmfaJ4nFG7h
bXocaYJySfxhPSsTkMVlT0CbkmuORYm1wnRCZnTCeZdMDGEzdlk1QnU3o2nF
E1wnUfYvE2RN8JyNqLQlQUGpukw9EeklKJnCcBNUTlibYTtk44TOLsITCJzk
6TRuRzhrjN2W/2H5KT8lKWX83rvI9x5Xtqe2sWe8c8keBOGTvuWWUs4iXhO3
CZEovE/XOV2DWXUs8buPwOpRTKMBZQ6VMJc9H8/E1E1EpPhTyLydI7UTqJ6y
bhT+b3Vlz4U+5wqU86J/JwJ5HrTjXO8vGhPej1VkjjPfHGT47p9bNyv5ScV3
qRcdKck53UnG6IbXZU0KWRtUPwUOopPoTlXfW4nS7aOafAwGDoS0tdkXLr2l
qWUWY2mK/4nAwOwbzjlnCtI2lzRYsoxZk5xuU5xdGxrOBteen95KdQ2yOQ55
DaNEtsQxaE4X2PcpoUUmLnwi2PaOZZi61mCmTMYxgh20xNa01yMy6eZSSyYI
ORwJxsUpS8jB+TkJqbiWQjcGJdDjGk7M+6hZ1IZyOwuudBzKQwcJNVUqUo7L
ocrXD7E6hwhg99OF3nCsizjlOVwp0yTvF1FOmR0yPA8DZycbsRcS0cz1nKhR
rRTNJ1uiMp3SueQ3tbMuWHFI+UKJOPcdqPAnYNHhdibnaVKwkbZSRVV0IPG2
yzraI4W4eDl8tVbMncmIm9xrSblDXKJRKK/+ku3JgipIoM1OhUS6pDeJ3WNR
WuKtOI5XedtdmxMolyVJ0IPDDpntEu65I42hZSjqkZN80Xjxd9g5zvp+pzut
2XTNCnVKYx0nbZmqUpSUbGhNrv5k50ZNy6yfSp6qnMdbmTKbW0yNqw3LpZMV
ig45Dcfe4psJXQskwTJUop35Em81m5Q4nI3JoTszwsyaLthPnJwobZwOCSSU
TebXpLGEhSYzhN5347DvrramsxFi1MIwkaSoRvZMmSZKUuMRZvJYmKe2U2l0
0UdomqeCRUE+zx/0r5/z/Pbh+X//6aSccjgcdhOZZOlxOMOYqTrbmh4idCMk
PA0YiZncOh+hO7MnW3HaK/cs1PCunebGLW2ew9lZPMxYOIbb2gyWeBNczMGD
Kp7ClLQsj81LJdSxZbwPMUv5VlLSI/wLuSKcKEg2CKF7AA==

------------56B9A339EE3149--
