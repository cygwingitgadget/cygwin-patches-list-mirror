Return-Path: <cygwin-patches-return-2897-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2830 invoked by alias); 30 Aug 2002 18:12:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2816 invoked from network); 30 Aug 2002 18:12:39 -0000
Date: Fri, 30 Aug 2002 11:12:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <147200259187.20020830221236@logos-m.ru>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: [franck.leray@cheops.fr: tcsetattr timeout problem ?]
In-Reply-To: <5199249725.20020830215547@logos-m.ru>
References: <20020830145541.GB1402@redhat.com>
 <136198673817.20020830214611@logos-m.ru> <5199249725.20020830215547@logos-m.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------111B21FB267D9AB9"
X-SW-Source: 2002-q3/txt/msg00345.txt.bz2

------------111B21FB267D9AB9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 697

Hi!

Friday, 30 August, 2002 egor duda deo@logos-m.ru wrote:

ed> Hi!

ed> Friday, 30 August, 2002 egor duda deo@logos-m.ru wrote:

ed>> Hi!

ed>> Friday, 30 August, 2002 Christopher Faylor cgf@redhat.com wrote:

CF>>> So, did you put someone up to this, Egor?  :-)

ed>> Patch attached. Checking vtime in ready_for_read doesn't look like a
ed>> best way to do this, but it seems to work.

ed> Actually, the patch is wrong :(. I'm looking into it and post a
ed> correct one asap.

Forgot to include fhandler_tty.cc part.

Please check it if possible and feel free to apply it, as i will be
away from computer for some time.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
------------111B21FB267D9AB9
Content-Type: application/octet-stream; name="tty-vtime-fix.2.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="tty-vtime-fix.2.diff"
Content-length: 2213

SW5kZXg6IGZoYW5kbGVyX3R0eS5jYwo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
ClJDUyBmaWxlOiAvY3ZzL3ViZXJiYXVtL3dpbnN1cC9jeWd3aW4vZmhhbmRs
ZXJfdHR5LmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjY4CmRpZmYgLXUg
LXAgLTIgLXIxLjY4IGZoYW5kbGVyX3R0eS5jYwotLS0gZmhhbmRsZXJfdHR5
LmNjCTYgQXVnIDIwMDIgMDU6MDg6NTUgLTAwMDAJMS42OAorKysgZmhhbmRs
ZXJfdHR5LmNjCTMwIEF1ZyAyMDAyIDE4OjA2OjE5IC0wMDAwCkBAIC02NzAs
NSArNjcwLDUgQEAgZmhhbmRsZXJfdHR5X3NsYXZlOjpyZWFkICh2b2lkICpw
dHIsIHNpegogICAgICAgaWYgKHZ0aW1lIDwgMCkgdnRpbWUgPSAwOwogICAg
ICAgaWYgKHZtaW4gPT0gMCkKLQl0aW1lX3RvX3dhaXQgPSBJTkZJTklURTsK
Kwl0aW1lX3RvX3dhaXQgPSAwOwogICAgICAgZWxzZQogCXRpbWVfdG9fd2Fp
dCA9ICh2dGltZSA9PSAwID8gSU5GSU5JVEUgOiAxMDAgKiB2dGltZSk7Cklu
ZGV4OiBzZWxlY3QuY2MKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmls
ZTogL2N2cy91YmVyYmF1bS93aW5zdXAvY3lnd2luL3NlbGVjdC5jYyx2CnJl
dHJpZXZpbmcgcmV2aXNpb24gMS43NwpkaWZmIC11IC1wIC0yIC1yMS43NyBz
ZWxlY3QuY2MKLS0tIHNlbGVjdC5jYwkxOSBBdWcgMjAwMiAwNDo0Mzo1OCAt
MDAwMAkxLjc3CisrKyBzZWxlY3QuY2MJMzAgQXVnIDIwMDIgMTg6MDY6MTkg
LTAwMDAKQEAgLTc5Miw0ICs3OTIsNiBAQCBmaGFuZGxlcl90dHlfc2xhdmU6
OnJlYWR5X2Zvcl9yZWFkIChpbnQgCiB7CiAgIEhBTkRMRSB3NFsyXTsKKyAg
aW50IHZtaW4sIHZ0aW1lOworICBEV09SRCB0aW1lX3RvX3dhaXQgPSBJTkZJ
TklURTsKICAgaWYgKGN5Z2hlYXAtPmZkdGFiLm5vdF9vcGVuIChmZCkpCiAg
ICAgewpAQCAtODAyLDQgKzgwNCwxNSBAQCBmaGFuZGxlcl90dHlfc2xhdmU6
OnJlYWR5X2Zvcl9yZWFkIChpbnQgCiAgICAgICByZXR1cm4gMTsKICAgICB9
CisKKyAgaWYgKCEoZ2V0X3R0eXAgKCktPnRpLmNfbGZsYWcgJiBJQ0FOT04p
KQorICAgIHsKKyAgICAgIHZtaW4gPSBnZXRfdHR5cCAoKS0+dGkuY19jY1tW
TUlOXTsKKyAgICAgIHZ0aW1lID0gZ2V0X3R0eXAgKCktPnRpLmNfY2NbVlRJ
TUVdOworICAgICAgaWYgKHZtaW4gPT0gMCAmJiB2dGltZSA+IDApIAorCXRp
bWVfdG9fd2FpdCA9IDEwMCAqIHZ0aW1lOworICAgICAgaWYgKHRpbWVfdG9f
d2FpdCA8IGhvd2xvbmcpCisJaG93bG9uZyA9IHRpbWVfdG9fd2FpdDsKKyAg
ICB9CisKICAgdzRbMF0gPSBzaWduYWxfYXJyaXZlZDsKICAgdzRbMV0gPSBp
bnB1dF9hdmFpbGFibGVfZXZlbnQ7CkBAIC04MTYsNCArODI5LDYgQEAgZmhh
bmRsZXJfdHR5X3NsYXZlOjpyZWFkeV9mb3JfcmVhZCAoaW50IAogICAgICAg
cmV0dXJuIDA7CiAgICAgZGVmYXVsdDoKKyAgICAgIGlmICh0aW1lX3RvX3dh
aXQgIT0gSU5GSU5JVEUgJiYgaG93bG9uZyA9PSB0aW1lX3RvX3dhaXQpCisJ
cmV0dXJuIDE7CiAgICAgICBpZiAoIWhvd2xvbmcpCiAJc2V0X3NpZ19lcnJu
byAoRUFHQUlOKTsK

------------111B21FB267D9AB9
Content-Type: application/octet-stream; name="tty-vtime-fix.2.ChangeLog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="tty-vtime-fix.2.ChangeLog"
Content-length: 537

MjAwMi0wOC0zMCAgRWdvciBEdWRhIDxkZW9AbG9nb3MtbS5ydT4NCg0KCSog
c2VsZWN0LmNjIChmaGFuZGxlcl90dHlfc2xhdmU6OnJlYWR5X2Zvcl9yZWFk
KTogSWYgdHR5IGlzIHNldA0KCXRvIG5vbmNhbm9uaWNhbCBtb2RlIGFuZCB2
bWluPT0wIGFuZCB2dGltZSA+IDAsIHdhaXQgbm8gbG9uZ2VyIHRoYW4NCgkx
MDAqdnRpbWUgbWlsbGlzZWNvbmRzLg0KCSogZmhhbmRsZXJfdHR5LmNjIChm
aGFuZGxlcl90dHlfc2xhdmU6OnJlYWQpOiBJZiB0dHkgaXMgc2V0DQoJdG8g
bm9uY2Fub25pY2FsIG1vZGUgYW5kIHZtaW49PTAgYW5kIHZ0aW1lID4gMCwg
d2FpdCBubyBtb3JlLCBhcw0KCWFsbCB3YWl0aW5nIGlzIGRvbmUgaW4gZmhh
bmRsZXJfdHR5X3NsYXZlOjpyZWFkeV9mb3JfcmVhZCgpLg0K

------------111B21FB267D9AB9--
