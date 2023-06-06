Return-Path: <SRS0=KO2Y=B2=gmail.com=philcerf@sourceware.org>
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by sourceware.org (Postfix) with ESMTPS id 3C9773858416
	for <cygwin-patches@cygwin.com>; Tue,  6 Jun 2023 01:04:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3C9773858416
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-543ae674f37so1122009a12.1
        for <cygwin-patches@cygwin.com>; Mon, 05 Jun 2023 18:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686013497; x=1688605497;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LrOKhwA3WT9mk9YwOTmr1nxcOvOniEseYqeo8lwOkw=;
        b=C26jRs+72qbw/AGhMQE7+kjUtAt5n/Z6iOI5+/nxfkZ2XACTIDN7VjpzUCqhgsYKbR
         xa1KMyvuh5DLDlXXxPdDixWX/m+euUPV8qrsQQk6yamHQ6vwpDL/qUuR3b88S+MMBbc9
         wpxOdSiDzXc+xlOTWZIFfute9E8fFyOpeyAmZw1cyxQJI6aRc3AFxM5F98o32WUBIHss
         jdlzgdmc4IGMM+8gfmfQWHDmyroDmdy9mg5XP75bNV0kCymhNGYilcsjvFziXGRPPNYf
         8JKIYf83esU59ZY/nBSjAzxFzDT4uAdtIlyix3mdSZOxznO9wairBLko5bI/FXpOWNjD
         SJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686013497; x=1688605497;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LrOKhwA3WT9mk9YwOTmr1nxcOvOniEseYqeo8lwOkw=;
        b=e4e7W8K7AfBZZ+j/RK+lYBr8GEVVgrrpFvcK9FlAZT8zJaf/qLEvu9jmJNf0MGG18T
         lpUeZefYGQKcqdAymgsVXb9rIT5JZstDz2ZVaHPX+xOHTBm5OhfYAxEy0RdGHw+I0QDE
         9KY6EAuQ2T9V0KCqmj5xpMZ8GZlHvLUDJtu1JvW1IOLttC6zN0YXFxxOBYCS2y3woEEQ
         /CSD6NLti1ue7XUrNwpkizGpAqq35/iJQtVNO3JNho3IihlO6PNh1f+DmkKNDlW3dDvX
         DDf2tn3PJDEnSMNjylPtKWNQ8ErBUHc0/xhppWHZeDxSxu5kP378d3zGlzaiPpBvQILH
         Duzw==
X-Gm-Message-State: AC+VfDwTGDPkD4nt5aDyDXYTAKyDQdmxRjzp9Qtz7wtndzABtE8L5RRo
	FzvD9EsHcvsBd0ThYTym9muagJ6ob1FIbkcUzMZMZpQLAEQ=
X-Google-Smtp-Source: ACHHUZ78KcQBk1eTLjaJT2caoOmDNkDcNaev23FJ9kTqO+DFCtQ5crexYf31cKuZcxHNn80UFA5mrLx7iW/zp/S0wXs=
X-Received: by 2002:a17:902:b704:b0:1b0:34a1:9946 with SMTP id
 d4-20020a170902b70400b001b034a19946mr358505pls.46.1686013497048; Mon, 05 Jun
 2023 18:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAN+za=MhQdD2mzYxqVAm9ZwBUBKsyPiH+9T5xfGXtgxq1X1LAA@mail.gmail.com>
 <f4106af5-ed7a-0df5-a870-b87bb729f862@Shaw.ca> <ZH4yDkPXLU9cYsrn@calimero.vinschen.de>
In-Reply-To: <ZH4yDkPXLU9cYsrn@calimero.vinschen.de>
From: Philippe Cerfon <philcerf@gmail.com>
Date: Tue, 6 Jun 2023 03:04:45 +0200
Message-ID: <CAN+za=OS7t47S6jYkee2H8S697L7HapjXy1cQ2eh+VC+PPcx5A@mail.gmail.com>
Subject: Re: [PATCH] include/cygwin/limits.h: add XATTR_{NAME,SIZE,LIST}_MAX
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary="00000000000094745405fd6b9ba8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--00000000000094745405fd6b9ba8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Corinna, et al.

On Mon, Jun 5, 2023 at 9:05=E2=80=AFPM Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> - Whatever that's good for, we actually allow bigger values right
>   now.  For compat reasons we only allow attributes starting with
>   the "user." prefix, and the *trailing* part after "user." is
>   allowed to be 255 bytes long, because we don't store the "user."
>   prefix in the EA name on disk.  So in fact, XATTR_NAME_MAX should
>   be 255 + strlen("user.") =3D=3D 260.

I haven't given to much though into that right now (just about to go
for 2 weeks on vacation), but if "we" (Cygwin) allow now names up to
260 bytes, because we don't store the "user." .. doesn't that mean
users could set XATTRs, that in the end couldn't be read by e.g. Linux
(should there be, or ever be in the future, support for reading
FAT/NTFS' EAs as XATTRs.... e.g. from the Linux FAT/NTFS fs drivers)?


> - If we actually define these values in limits.h, it would also be a
>   good idea to use them in ntea.cc and to throw away the MAX_EA_*_LEN
>   macros.

Done so in a 2nd commit.
But that commit, right now, really just replaces the name!
MAX_EA_NAME_LEN was set 256, so presumably with the null terminator...
while now it would be set to 260, which seems wrong.

Please just adapt if necessary,... or at least I won't likely be able
to update the patch until in about 2 weeks or so.


Thanks,
Philippe

--00000000000094745405fd6b9ba8
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-Cygwin-use-new-XATTR_-NAME-SIZE-_MAX-instead-of-MAX_.patch"
Content-Disposition: attachment; 
	filename="0002-Cygwin-use-new-XATTR_-NAME-SIZE-_MAX-instead-of-MAX_.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lijkvqmn1>
X-Attachment-Id: f_lijkvqmn1

RnJvbSBhODYwMjEyNTMzYjJjNDM4ODMyZWE0MTlmYzIzNTM3ZDA1ZWEyMjEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXBwZSBDZXJmb24gPHBoaWxjZXJmQGdtYWlsLmNvbT4K
RGF0ZTogVHVlLCA2IEp1biAyMDIzIDAyOjUyOjQ5ICswMjAwClN1YmplY3Q6IFtQQVRDSCAyLzJd
IEN5Z3dpbjogdXNlIG5ldyBYQVRUUl97TkFNRSxTSVpFfV9NQVggaW5zdGVhZCBvZgogTUFYX0VB
X3tOQU1FLFZBTFVFfV9MRU4KClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIENlcmZvbiA8cGhpbGNl
cmZAZ21haWwuY29tPgotLS0KIHdpbnN1cC9jeWd3aW4vbnRlYS5jYyB8IDE4ICsrKysrKysrLS0t
LS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9udGVhLmNjIGIvd2luc3VwL2N5Z3dpbi9udGVh
LmNjCmluZGV4IGE0MDBmY2IyYi4uYWFmZWNkZTU5IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2lu
L250ZWEuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9udGVhLmNjCkBAIC0xNyw5ICsxNyw3IEBAIGRl
dGFpbHMuICovCiAjaW5jbHVkZSAidGxzX3BidWYuaCIKICNpbmNsdWRlIDxzdGRsaWIuaD4KICNp
bmNsdWRlIDxhdHRyL3hhdHRyLmg+Ci0KLSNkZWZpbmUgTUFYX0VBX05BTUVfTEVOICAgIDI1Ngot
I2RlZmluZSBNQVhfRUFfVkFMVUVfTEVOIDY1NTM2CisjaW5jbHVkZSA8Y3lnd2luL2xpbWl0cy5o
PgogCiAvKiBBdCBsZWFzdCBvbmUgbWF4aW11bSBzaXplZCBlbnRyeSBmaXRzLgogICAgQ1YgMjAx
NC0wNC0wNDogTnRRdWVyeUVhRmlsZSBmdW5jdGlvbiBjaG9rZXMgb24gYnVmZmVycyBiaWdnZXIg
dGhhbiA2NEsKQEAgLTI3LDEzICsyNSwxMyBAQCBkZXRhaWxzLiAqLwogCQkgIG9uIGEgcmVtb3Rl
IHNoYXJlLCBhdCBsZWFzdCBvbiBXaW5kb3dzIDcgYW5kIGxhdGVyLgogCQkgIEluIHRoZW9yeSB0
aGUgYnVmZmVyIHNob3VsZCBoYXZlIGEgc2l6ZSBvZgogCi0JCSAgICBzaXplb2YgKEZJTEVfRlVM
TF9FQV9JTkZPUk1BVElPTikgKyBNQVhfRUFfTkFNRV9MRU4KLQkJICAgICsgTUFYX0VBX1ZBTFVF
X0xFTgorCQkgICAgc2l6ZW9mIChGSUxFX0ZVTExfRUFfSU5GT1JNQVRJT04pICsgWEFUVFJfTkFN
RV9NQVgKKwkJICAgICsgWEFUVFJfU0laRV9NQVgKIAogCQkgICg2NTgwNCBieXRlcyksIGJ1dCB3
ZSdyZSBvcHRpbmcgZm9yIHNpbXBsaWNpdHkgaGVyZSwgYW5kCiAJCSAgYSA2NEsgYnVmZmVyIGhh
cyB0aGUgYWR2YW50YWdlIHRoYXQgd2UgY2FuIHVzZSBhIHRtcF9wYXRoYnVmCiAJCSAgYnVmZmVy
LCByYXRoZXIgdGhhbiBoYXZpbmcgdG8gYWxsb2NhIDY0SyBmcm9tIHN0YWNrLiAqLwotI2RlZmlu
ZSBFQV9CVUZTSVogTUFYX0VBX1ZBTFVFX0xFTgorI2RlZmluZSBFQV9CVUZTSVogWEFUVFJfU0la
RV9NQVgKIAogI2RlZmluZSBORVhUX0ZFQShwKSAoKFBGSUxFX0ZVTExfRUFfSU5GT1JNQVRJT04p
IChwLT5OZXh0RW50cnlPZmZzZXQgXAogCQkgICAgID8gKGNoYXIgKikgcCArIHAtPk5leHRFbnRy
eU9mZnNldCA6IE5VTEwpKQpAQCAtNTUsNyArNTMsNyBAQCByZWFkX2VhIChIQU5ETEUgaGRsLCBw
YXRoX2NvbnYgJnBjLCBjb25zdCBjaGFyICpuYW1lLCBjaGFyICp2YWx1ZSwgc2l6ZV90IHNpemUp
CiAgICAgIHJldHVybnMgdGhlIGxhc3QgRUEgZW50cnkgb2YgdGhlIGZpbGUgaW5maW5pdGVseS4g
IEV2ZW4gdXRpbGl6aW5nIHRoZQogICAgICBvcHRpb25hbCBFYUluZGV4IG9ubHkgaGVscHMgbWFy
Z2luYWxseS4gIElmIHlvdSB1c2UgdGhhdCwgdGhlIGxhc3QKICAgICAgRUEgaW4gdGhlIGZpbGUg
aXMgcmV0dXJuZWQgdHdpY2UuICovCi0gIGNoYXIgbGFzdG5hbWVbTUFYX0VBX05BTUVfTEVOXTsK
KyAgY2hhciBsYXN0bmFtZVtYQVRUUl9OQU1FX01BWF07CiAKICAgX190cnkKICAgICB7CkBAIC05
NSw3ICs5Myw3IEBAIHJlYWRfZWEgKEhBTkRMRSBoZGwsIHBhdGhfY29udiAmcGMsIGNvbnN0IGNo
YXIgKm5hbWUsIGNoYXIgKnZhbHVlLCBzaXplX3Qgc2l6ZSkKIAkgICAgICBfX2xlYXZlOwogCSAg
ICB9CiAKLQkgIGlmICgobmxlbiA9IHN0cmxlbiAobmFtZSkpID49IE1BWF9FQV9OQU1FX0xFTikK
KwkgIGlmICgobmxlbiA9IHN0cmxlbiAobmFtZSkpID49IFhBVFRSX05BTUVfTUFYKQogCSAgICB7
CiAJICAgICAgc2V0X2Vycm5vIChFSU5WQUwpOwogCSAgICAgIF9fbGVhdmU7CkBAIC0xOTcsNyAr
MTk1LDcgQEAgcmVhZF9lYSAoSEFORExFIGhkbCwgcGF0aF9jb252ICZwYywgY29uc3QgY2hhciAq
bmFtZSwgY2hhciAqdmFsdWUsIHNpemVfdCBzaXplKQogCQkgIC8qIEZvciBjb21wYXRpYmlsaXR5
IHdpdGggTGludXgsIHdlIGFsd2F5cyBwcmVwZW5kICJ1c2VyLiIgdG8KIAkJICAgICB0aGUgYXR0
cmlidXRlIG5hbWUsIHNvIGVmZmVjdGl2ZWx5IHdlIG9ubHkgc3VwcG9ydCB1c2VyCiAJCSAgICAg
YXR0cmlidXRlcyBmcm9tIGEgYXBwbGljYXRpb24gcG9pbnQgb2Ygdmlldy4gKi8KLQkJICBjaGFy
IHRtcGJ1ZltNQVhfRUFfTkFNRV9MRU4gKiAyXTsKKwkJICBjaGFyIHRtcGJ1ZltYQVRUUl9OQU1F
X01BWCAqIDJdOwogCQkgIGNoYXIgKnRwID0gc3RwY3B5ICh0bXBidWYsICJ1c2VyLiIpOwogCQkg
IHN0cGNweSAodHAsIGZlYS0+RWFOYW1lKTsKIAkJICAvKiBOVEZTIHN0b3JlcyBhbGwgRUEgbmFt
ZXMgaW4gdXBwZXJjYXNlIHVuZm9ydHVuYXRlbHkuICBUbwpAQCAtMjk3LDcgKzI5NSw3IEBAIHdy
aXRlX2VhIChIQU5ETEUgaGRsLCBwYXRoX2NvbnYgJnBjLCBjb25zdCBjaGFyICpuYW1lLCBjb25z
dCBjaGFyICp2YWx1ZSwKICAgICAgIC8qIFNraXAgInVzZXIuIiBwcmVmaXguICovCiAgICAgICBu
YW1lICs9IDU7CiAKLSAgICAgIGlmICgobmxlbiA9IHN0cmxlbiAobmFtZSkpID49IE1BWF9FQV9O
QU1FX0xFTikKKyAgICAgIGlmICgobmxlbiA9IHN0cmxlbiAobmFtZSkpID49IFhBVFRSX05BTUVf
TUFYKQogCXsKIAkgIHNldF9lcnJubyAoRUlOVkFMKTsKIAkgIF9fbGVhdmU7Ci0tIAoyLjQwLjEK
Cg==
--00000000000094745405fd6b9ba8
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Cygwin-export-XATTR_-NAME-SIZE-LIST-_MAX.patch"
Content-Disposition: attachment; 
	filename="0001-Cygwin-export-XATTR_-NAME-SIZE-LIST-_MAX.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lijkvqmc0>
X-Attachment-Id: f_lijkvqmc0

RnJvbSBiNjRiOWE0OGM3NzMyNmVkMjU0NGU1MTQyMmFkYmUxZjFjNjMxNTQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXBwZSBDZXJmb24gPHBoaWxjZXJmQGdtYWlsLmNvbT4K
RGF0ZTogVHVlLCAzMCBNYXkgMjAyMyAxMzoxNjoxOCArMDIwMApTdWJqZWN0OiBbUEFUQ0ggMS8y
XSBDeWd3aW46IGV4cG9ydCBYQVRUUl97TkFNRSxTSVpFLExJU1R9X01BWAoKVGhlc2UgYXJlIHVz
ZWQgZm9yIGV4YW1wbGUgYnkgQ1B5dGhvbi4KClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIENlcmZv
biA8cGhpbGNlcmZAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBDb3Jpbm5hIFZpbnNjaGVuIDxj
b3Jpbm5hQHZpbnNjaGVuLmRlPgotLS0KIHdpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vbGlt
aXRzLmggfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL2xpbWl0cy5oIGIvd2luc3VwL2N5
Z3dpbi9pbmNsdWRlL2N5Z3dpbi9saW1pdHMuaAppbmRleCBhZWZjN2M3YmQuLmVhM2UyODM2YSAx
MDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dpbi9saW1pdHMuaAorKysgYi93
aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL2xpbWl0cy5oCkBAIC01Niw0ICs1NiwxMSBAQCBk
ZXRhaWxzLiAqLwogI2RlZmluZSBfX1BBVEhfTUFYIDQwOTYKICNkZWZpbmUgX19QSVBFX0JVRiA0
MDk2CiAKKy8qIFhBVFRSX05BTUVfTUFYIGlzIHRoZSBtYXhpbXVtIFhBVFRSIG5hbWUgbGVuZ3Ro
IGV4Y2x1ZGluZyB0aGUgbnVsbAorICogdGVybWluYXRvci4gU2luY2Ugb25seSBYQVRUUnMgaW4g
dGhlIGB1c2VyJyBuYW1lc3BhY2UgYXJlIGFsbG93ZWQgYW5kIHRoZQorICogYHVzZXIuJyBwcmVm
aXggaXMgbm90IHN0b3JlZCwgdGhlIG1heGltdW0gaXMgaW5jcmVhc2VkIGJ5IDUuICovCisjZGVm
aW5lIFhBVFRSX05BTUVfTUFYIDI2MAorI2RlZmluZSBYQVRUUl9TSVpFX01BWCA2NTUzNgorI2Rl
ZmluZSBYQVRUUl9MSVNUX01BWCA2NTUzNgorCiAjZW5kaWYgLyogX0NZR1dJTl9MSU1JVFNfSF9f
ICovCi0tIAoyLjQwLjEKCg==
--00000000000094745405fd6b9ba8--
