From: Egor Duda <deo@logos-m.ru>
To: Chris Faylor <cygwin-patches@sources.redhat.com>
Subject: Re: Just checked in a major change to cygwin
Date: Mon, 04 Sep 2000 00:51:00 -0000
Message-id: <128221669273.20000904115006@logos-m.ru>
References: <20000903003055.A14834@cygnus.com>
X-SW-Source: 2000-q3/msg00053.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65437-6"

This is a multi-part message in MIME format...

------------=_1583532846-65437-6
Content-length: 757

Hi!

Sunday, 03 September, 2000 Chris Faylor cgf@cygnus.com wrote:

CF> For the last several weeks, I've been working on giving cygwin it's own
CF> "heap".  I use this heap to allocate memory that should be common to a
CF> process's children.  This was one of the things that I desperately wanted
CF> copy-on-write for but I ended up implementing my own crude version instead.

stat("f:\\tmp\\bla-bla",...)   causes   exception   with  your  latest
changes.

in this line (path.cc:1025)

rc = normalize_win32_path (cwd_win32 (TMPCWD), src_path, dst);

alloca()  is  called  after  src_path  and dst are put on stack. patch
attached.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
win32-path-crash.ChangeLog
win32-path-crash.diff


------------=_1583532846-65437-6
Content-Type: text/plain; charset=us-ascii; name="win32-path-crash.ChangeLog"
Content-Disposition: inline; filename="win32-path-crash.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 188

MjAwMC0wOS0wNCAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBw
YXRoLmNjIChtb3VudF9pbmZvOjpjb252X3RvX3dpbjMyX3BhdGgpOiBGaXgg
Y3Jhc2ggd2hlbgoJZ2l2ZW4gcGF0aCBpcyBhbHJlYWR5IGluIHdpbjMyIG9u
ZS4K

------------=_1583532846-65437-6
Content-Type: text/x-diff; charset=us-ascii; name="win32-path-crash.diff"
Content-Disposition: inline; filename="win32-path-crash.diff"
Content-Transfer-Encoding: base64
Content-Length: 1578

SW5kZXg6IHdpbnN1cC9jeWd3aW4vcGF0aC5jYwo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09ClJDUyBmaWxlOiAvaG9tZS9kdWRhX2FkbWluL2N2cy1taXJyb3Iv
c3JjL3dpbnN1cC9jeWd3aW4vcGF0aC5jYyx2CnJldHJpZXZpbmcgcmV2aXNp
b24gMS40NgpkaWZmIC1jIC0yIC1yMS40NiBwYXRoLmNjCioqKiB3aW5zdXAv
Y3lnd2luL3BhdGguY2MJMjAwMC8wOS8wMyAwNDoxNjozNQkxLjQ2Ci0tLSB3
aW5zdXAvY3lnd2luL3BhdGguY2MJMjAwMC8wOS8wNCAwNjo0Mjo1MQoqKioq
KioqKioqKioqKioKKioqIDEwMDUsMTAwOCAqKioqCi0tLSAxMDA1LDEwMDkg
LS0tLQogICAgbW91bnRfaXRlbSAqbWkgPSBOVUxMOwkvKiBpbml0aWFsaXpl
ZCB0byBhdm9pZCBjb21waWxlciB3YXJuaW5nICovCiAgICBjaGFyIHBhdGhi
dWZbTUFYX1BBVEhdOworICAgY2hhciogY3dkX3dpbjMyX25vdyA9IE5VTEw7
CiAgCiAgICBjaGFyIGN3ZFtNQVhfUEFUSF07CioqKioqKioqKioqKioqKgoq
KiogMTAyMywxMDI3ICoqKioKICAgICAgewogICAgICAgIGRlYnVnX3ByaW50
ZiAoIiVzIGFscmVhZHkgd2luMzIiLCBzcmNfcGF0aCk7CiEgICAgICAgcmMg
PSBub3JtYWxpemVfd2luMzJfcGF0aCAoY3dkX3dpbjMyIChUTVBDV0QpLCBz
cmNfcGF0aCwgZHN0KTsKICAgICAgICBpZiAocmMpCiAgCXsKLS0tIDEwMjQs
MTAzMCAtLS0tCiAgICAgIHsKICAgICAgICBkZWJ1Z19wcmludGYgKCIlcyBh
bHJlYWR5IHdpbjMyIiwgc3JjX3BhdGgpOwohICAgICAgIAohICAgICAgIGN3
ZF93aW4zMl9ub3cgPSBjd2Rfd2luMzIgKFRNUENXRCk7CiEgICAgICAgcmMg
PSBub3JtYWxpemVfd2luMzJfcGF0aCAoY3dkX3dpbjMyX25vdywgc3JjX3Bh
dGgsIGRzdCk7CiAgICAgICAgaWYgKHJjKQogIAl7CioqKioqKioqKioqKioq
KgoqKiogMTE0MCwxMTQ0ICoqKioKICAgIHVuc2lnbmVkIGN3ZGxlbjsKICAg
IGN3ZGxlbiA9IDA7CS8qIGF2b2lkIGEgKGhvcGVmdWxseSkgYm9ndXMgY29t
cGlsZXIgd2FybmluZyAqLwotICAgY2hhciAqY3dkX3dpbjMyX25vdzsKICAg
IGN3ZF93aW4zMl9ub3cgPSBjd2Rfd2luMzIgKFRNUENXRCk7CiAgICBpZiAo
d2luMzJfcGF0aCA9PSBOVUxMKQotLS0gMTE0MywxMTQ2IC0tLS0K

------------=_1583532846-65437-6--
