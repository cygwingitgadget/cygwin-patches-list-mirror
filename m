From: Egor Duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Re: lseek() fails to seek on /dev/fd0 ('\\.\A:')
Date: Mon, 26 Feb 2001 11:11:00 -0000
Message-id: <1825816804.20010226221015@logos-m.ru>
References: <u67ae79bw6v.fsf@rachel.hq.vtech> <u671ysl8xda.fsf@rachel.hq.vtech> <613331659.20010226160225@logos-m.ru> <3A9A621F.7661F240@yahoo.com> <20010226161735.P27406@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00113.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65438-13"

This is a multi-part message in MIME format...

------------=_1583532846-65438-13
Content-length: 857

Hi!

Monday, 26 February, 2001 Corinna Vinschen cygwin@cygwin.com wrote:

CV> On Mon, Feb 26, 2001 at 09:03:11AM -0500, Earnie Boyd wrote:
>> Egor Duda wrote:
>> > 
>> > Anyway,  if  we  decide to be linux- and solaris- compatible here, the
>> > patch would be trivial.
>> > 
>> 
>> I thought the decision to be as Linux compatible as possible had already
>> been determined.  I suggest that someone submit the trivial patch.

CV> Indeed. I would be interested in the trivial patch as well.

well, almost trivial ;-)
It's not fully compatible with linux, as it doesn't allow seeking past
the  end  of  media (i think this is ok), and, alas, for NT only :( (i
don't  think  this  is ok, but i haven't found a way to get media size
under w9x)

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
floppy-lseek.diff
floppy-lseek.ChangeLog


------------=_1583532846-65438-13
Content-Type: text/plain; charset=us-ascii; name="floppy-lseek.ChangeLog"
Content-Disposition: inline; filename="floppy-lseek.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 350

MjAwMS0wMi0yNiAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBm
aGFuZGxlcl9mbG9wcHkuY2MgKGZoYW5kbGVyX2Rldl9mbG9wcHk6OmxzZWVr
KTogRGV0ZXJtaW5lCglkcml2ZSBnZW9tZXRyeSB0byBhbGxvdyBzZWVraW5n
IGZyb20gdGhlIGVuZCBvZiByYXcgZmxvcHB5CglkZXZpY2UuIERvbid0IGFs
bG93IHJlYWRpbmcgcGFzdCB0aGUgZW5kIG9mIG1lZGlhLiBBbHdheXMgcmV0
dXJuCgluZXcgZmlsZSBwb2ludGVyIHBvc2l0aW9uLgo=

------------=_1583532846-65438-13
Content-Type: text/x-diff; charset=us-ascii; name="floppy-lseek.diff"
Content-Disposition: inline; filename="floppy-lseek.diff"
Content-Transfer-Encoding: base64
Content-Length: 3266

SW5kZXg6IHdpbnN1cC9jeWd3aW4vZmhhbmRsZXJfZmxvcHB5LmNjCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5z
dXAvY3lnd2luL2ZoYW5kbGVyX2Zsb3BweS5jYyx2CnJldHJpZXZpbmcgcmV2
aXNpb24gMS42CmRpZmYgLXUgLXAgLTIgLXIxLjYgZmhhbmRsZXJfZmxvcHB5
LmNjCi0tLSBmaGFuZGxlcl9mbG9wcHkuY2MJMjAwMS8wMi8wNSAxNjoxMDow
NgkxLjYKKysrIGZoYW5kbGVyX2Zsb3BweS5jYwkyMDAxLzAyLzI2IDE5OjAy
OjMwCkBAIC0xNyw0ICsxNyw1IEBAIGRldGFpbHMuICovCiAjaW5jbHVkZSAi
ZmhhbmRsZXIuaCIKICNpbmNsdWRlICJjeWdlcnJuby5oIgorI2luY2x1ZGUg
PHdpbmlvY3RsLmg+CiAKIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwpA
QCAtODMsOCArODQsNDAgQEAgZmhhbmRsZXJfZGV2X2Zsb3BweTo6bHNlZWsg
KG9mZl90IG9mZnNldAogICBEV09SRCBvZmY7CiAgIGNoYXIgYnVmWzUxMl07
CisgIGxvbmcgZHJpdmVfc2l6ZSA9IDA7CiAKKyAgaWYgKG9zX2JlaW5nX3J1
biA9PSB3aW5OVCkKKyAgICB7CisgICAgICBESVNLX0dFT01FVFJZIGRpOwor
ICAgICAgRFdPUkQgYnl0ZXNfcmVhZDsKKworICAgICAgaWYgKCAhRGV2aWNl
SW9Db250cm9sICggZ2V0X2hhbmRsZSgpLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgSU9DVExfRElTS19HRVRfRFJJVkVfR0VPTUVUUlksCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCAwLAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmRpLCBzaXplb2YgKGRpKSwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZieXRlc19yZWFkLCBOVUxM
KSApCisgICAgICAgIHsKKyAgICAgICAgICBfX3NldGVycm5vICgpOworICAg
ICAgICAgIHJldHVybiAtMTsKKyAgICAgICAgfQorICAgICAgZGVidWdfcHJp
bnRmICggImRpc2sgZ2VvbWV0cnk6ICglbGQgY3lsKSooJWxkIHRyaykqKCVs
ZCBzZWMpKiglbGQgYnBzKSIsCisgICAgICAgICAgICAgICAgICAgICBkaS5D
eWxpbmRlcnMsCisgICAgICAgICAgICAgICAgICAgICBkaS5UcmFja3NQZXJD
eWxpbmRlciwKKyAgICAgICAgICAgICAgICAgICAgIGRpLlNlY3RvcnNQZXJU
cmFjaywKKyAgICAgICAgICAgICAgICAgICAgIGRpLkJ5dGVzUGVyU2VjdG9y
ICk7CisgICAgICBkcml2ZV9zaXplID0gZGkuQ3lsaW5kZXJzLkxvd1BhcnQg
KiBkaS5UcmFja3NQZXJDeWxpbmRlciAqCisgICAgICAgICAgICAgICAgICAg
ZGkuU2VjdG9yc1BlclRyYWNrICogZGkuQnl0ZXNQZXJTZWN0b3I7CisgICAg
ICBkZWJ1Z19wcmludGYgKCAiZHJpdmUgc2l6ZTogJWxkIiwgZHJpdmVfc2l6
ZSApOworICAgIH0KKworICBpZiAod2hlbmNlID09IFNFRUtfRU5EICYmIGRy
aXZlX3NpemUgPiAwKQorICAgIHsKKyAgICAgIG9mZnNldCArPSBkcml2ZV9z
aXplOworICAgICAgd2hlbmNlID0gU0VFS19TRVQ7IAorICAgIH0KKwogICBp
ZiAod2hlbmNlID09IFNFRUtfU0VUKQogICAgIHsKLSAgICAgIGlmIChvZmZz
ZXQgPCAwKQorICAgICAgaWYgKG9mZnNldCA8IDAgfHwKKyAgICAgICAgICBk
cml2ZV9zaXplID4gMCAmJiBvZmZzZXQgPiBkcml2ZV9zaXplKQogICAgICAg
ICB7CiAJICBzZXRfZXJybm8gKEVJTlZBTCk7CkBAIC0xMDYsNSArMTM5LDUg
QEAgZmhhbmRsZXJfZGV2X2Zsb3BweTo6bHNlZWsgKG9mZl90IG9mZnNldAog
CSAgcmV0dXJuIC0xOwogCX0KLSAgICAgIHJldHVybiByYXdfcmVhZCAoYnVm
LCBvZmZzZXQgLSBvZmYpOworICAgICAgcmV0dXJuIG9mZiArIHJhd19yZWFk
IChidWYsIG9mZnNldCAtIG9mZik7CiAgICAgfQogICBlbHNlIGlmICh3aGVu
Y2UgPT0gU0VFS19DVVIpCkBAIC0xMzIsNSArMTY1LDYgQEAgZmhhbmRsZXJf
ZGV2X2Zsb3BweTo6bHNlZWsgKG9mZl90IG9mZnNldAogCiAgICAgICBjdXIg
Kz0gb2Zmc2V0OwotICAgICAgaWYgKGN1ciA8IDApCisgICAgICBpZiAoY3Vy
IDwgMCB8fAorICAgICAgICAgIGRyaXZlX3NpemUgPiAwICYmIGN1ciA+IGRy
aXZlX3NpemUpCiAJewogCSAgc2V0X2Vycm5vIChFSU5WQUwpOwpAQCAtMTUw
LDcgKzE4NCw2IEBAIGZoYW5kbGVyX2Rldl9mbG9wcHk6OmxzZWVrIChvZmZf
dCBvZmZzZXQKIAkgIHJldHVybiAtMTsKIAl9Ci0gICAgICByZXR1cm4gcmF3
X3JlYWQgKGJ1Ziwgb2ZmKTsKKyAgICAgIHJldHVybiBvZmYgKyByYXdfcmVh
ZCAoYnVmLCBvZmYpOwogICAgIH0KLSAgLyogU0VFS19FTkQgaXMgbm90IHN1
cHBvcnRlZCBvbiByYXcgZGlzayBkZXZpY2VzLiAqLwogICBzZXRfZXJybm8g
KEVJTlZBTCk7CiAgIHJldHVybiAtMTsK

------------=_1583532846-65438-13--
