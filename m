From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-developers@cygwin.com>, <cygwin-patches@cygwin.com>
Subject: Re: hierarchy in setup (category stuff)
Date: Fri, 29 Jun 2001 19:20:00 -0000
Message-id: <039201c1010b$856f0c80$806410ac@local>
References: <3B3324A7.49FFC98A@yahoo.com> <054c01c0fbef$5f600e20$0200a8c0@lifelesswks> <06a001c0fc51$7a87e210$0200a8c0@lifelesswks> <20010629114004.A6990@redhat.com> <VA.00000842.01fd0b44@thesoftwaresource.com> <20010629172912.A8991@redhat.com> <032001c100fe$d62310c0$806410ac@local> <20010629205735.K9607@redhat.com> <034701c10106$34f6b6e0$806410ac@local> <036501c10108$b55383c0$806410ac@local> <20010629221309.A11334@redhat.com> <038301c1010a$bab7e840$806410ac@local>
X-SW-Source: 2001-q2/msg00377.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-84"

This is a multi-part message in MIME format...

------------=_1583532848-65438-84
Content-length: 1038

Applying this should fix my boo boo.

Rob
----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-developers@cygwin.com>; <cygwin-patches@cygwin.com>
Sent: Saturday, June 30, 2001 12:16 PM
Subject: Re: hierarchy in setup (category stuff)


>
> ----- Original Message -----
> From: "Christopher Faylor" <cgf@redhat.com>
> To: <cygwin-developers@cygwin.com>; <cygwin-patches@cygwin.com>
> Sent: Saturday, June 30, 2001 12:13 PM
> Subject: Re: hierarchy in setup (category stuff)
>
>
> > On Sat, Jun 30, 2001 at 12:02:24PM +1000, Robert Collins wrote:
> > >Michael,
> > >    I think I trashed some of your src related patches, CVS didn't
report
> > >any errors merging, but I just have this nasty suspicion.
> >
> > You did.  All of my changes are gone, too.
> >
> > I'd like to revert CVS to pre-your-change and try again.  Is that ok?
>
> It's possibly easier just to grab the diffs that you committed before and
> apply those again. (ie cvs rdiff -r 2.33 -r 2.35 choose.cc )
>
> >
> > cgf
> >
>
>

------------=_1583532848-65438-84
Content-Type: text/x-diff; charset=us-ascii; name="oops.patch"
Content-Disposition: inline; filename="oops.patch"
Content-Transfer-Encoding: base64
Content-Length: 1952

SW5kZXg6IGNob29zZS5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBm
aWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2NpbnN0YWxsL2Nob29zZS5jYyx2
CnJldHJpZXZpbmcgcmV2aXNpb24gMi4zNgpkaWZmIC11IC1wIC1yMi4zNiBj
aG9vc2UuY2MKLS0tIGNob29zZS5jYwkyMDAxLzA2LzMwIDAxOjM3OjU1CTIu
MzYKKysrIGNob29zZS5jYwkyMDAxLzA2LzMwIDAyOjE5OjIzCkBAIC0xMDAs
OSArMTAwLDExIEBAIGlzaW5zdGFsbGVkIChQYWNrYWdlICpwa2csIGludCB0
cnVzdCkKIHN0YXRpYyB2b2lkCiBzZXRfYWN0aW9uIChQYWNrYWdlICpwa2cs
IGJvb2wgcHJlaW5jKQogewotICBwa2ctPnNyY3BpY2tlZCA9IDA7CiAgIGlm
ICghcGtnLT5hY3Rpb24gfHwgcHJlaW5jKQotICAgICgoaW50KSBwa2ctPmFj
dGlvbikrKzsKKyAgICB7CisgICAgICAoKGludCkgcGtnLT5hY3Rpb24pKys7
CisgICAgICBwa2ctPnNyY3BpY2tlZCA9IDA7CisgICAgfQogCiAgIC8qIEV4
ZXJjaXNlIHRoZSBhY3Rpb24gc3RhdGUgbWFjaGluZS4gKi8KICAgZm9yICg7
OyAoKGludCkgcGtnLT5hY3Rpb24pKyspCkBAIC0xNDUsMjEgKzE0NywyOCBA
QCBzZXRfYWN0aW9uIChQYWNrYWdlICpwa2csIGJvb2wgcHJlaW5jKQogICAg
ICAgY2FzZSBBQ1RJT05fVU5JTlNUQUxMOgogCWlmIChwa2ctPmluc3RhbGxl
ZCkKIAkgIHJldHVybjsKKwlicmVhazsKICAgICAgIGNhc2UgQUNUSU9OX1JF
RE86Ci0JaWYgKHBrZy0+aW5zdGFsbGVkKQorCWlmIChwa2ctPmluc3RhbGxl
ZCAmJiBwa2ctPmluZm9bcGtnLT5pbnN0YWxsZWRfaXhdLmluc3RhbGxfZXhp
c3RzKQogCSAgewogCSAgICBwa2ctPnRydXN0ID0gcGtnLT5pbnN0YWxsZWRf
aXg7CiAJICAgIHJldHVybjsKIAkgIH0KKwlicmVhazsKICAgICAgIGNhc2Ug
QUNUSU9OX1NSQ19PTkxZOgotCWlmIChwa2ctPmluc3RhbGxlZCAmJiBwa2ct
Pmluc3RhbGxlZC0+c291cmNlX2V4aXN0cykKLQkgIHJldHVybjsKKwlpZiAo
cGtnLT5pbmZvW3BrZy0+dHJ1c3RdLnNvdXJjZV9leGlzdHMpCisJICB7CisJ
ICAgIHBrZy0+c3JjcGlja2VkID0gMTsKKwkgICAgcmV0dXJuOworCSAgfQog
CWJyZWFrOwogICAgICAgY2FzZSBBQ1RJT05fU0FNRV9MQVNUOgogCXBrZy0+
YWN0aW9uID0gQUNUSU9OX1NLSVA7CiAJLyogRmFsbCB0aHJvdWdoIGludGVu
dGlvbmFsbHkgKi8KICAgICAgIGNhc2UgQUNUSU9OX1NLSVA6Ci0JcmV0dXJu
OworICAgICAgICBpZiAoIXBrZy0+aW5zdGFsbGVkIHx8ICFwa2ctPmluZm9b
cGtnLT5pbnN0YWxsZWRfaXhdLmluc3RhbGxfZXhpc3RzKQorCSAgcmV0dXJu
OworCWJyZWFrOwogICAgICAgZGVmYXVsdDoKIAlsb2cgKDAsICJzaG91bGQg
bmV2ZXIgZ2V0IGhlcmUgJWRcbiIsIHBrZy0+YWN0aW9uKTsKICAgICAgIH0K

------------=_1583532848-65438-84--
