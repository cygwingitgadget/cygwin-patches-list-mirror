From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin@cygwin.com>, <cygwin-patches@cygwin.com>
Subject: Re: pthreads works, sorta
Date: Wed, 27 Jun 2001 06:30:00 -0000
Message-id: <008201c0ff0d$8fe3c2a0$806410ac@local>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F09E@itdomain002.itdomain.net.au> <20010627012932.I19058@redhat.com> <20010627013502.K19058@redhat.com>
X-SW-Source: 2001-q2/msg00350.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-80"

This is a multi-part message in MIME format...

------------=_1583532848-65438-80
Content-length: 1937

changelog:

Wed Jun 27 23:30:00 2001  Robert Collins <rbtcollins@hotmail.com>

    * path.cc (check_null_empty_path): Change from VirtualQuery to
IsBadWritePtr.
    * resource.cc (getrlimit): Ditto.
    (setrlimit): Ditto.
    * thread.cc (check_valid_pointer): Ditto.


What about the other instances of virtualQuery? Or are the appropriate..

Rob (Your humble delegate).



----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin@cygwin.com>
Sent: Wednesday, June 27, 2001 3:35 PM
Subject: Re: pthreads works, sorta


> On Wed, Jun 27, 2001 at 01:29:32AM -0400, Christopher Faylor wrote:
> >On Wed, Jun 27, 2001 at 01:10:35PM +1000, Robert Collins wrote:
> >>> -----Original Message-----
> >>> From: Greg Smith [ mailto:gsmith@nc.rr.com ]
> >>
> >>>
> >>> More experimenting with my home computer, dual pIII 850:
> >>>
> >>> 1. 117  157 328
> >>> 2. 822 1527 ---
> >>> 3. 194  240 453
> >>> 4. 169  181 516
> >>>
> >>As usual, I write a missive, then solve the puzzle.
> >>
> >>try this:
> >>
> >>
> >>int __stdcall
> >>check_valid_pointer (void *pointer)
> >>{
> >>  if (!pointer || IsBadWritePtr(pointer, sizeof (verifyable_object)))
> >>    return EFAULT;
> >>  return 0;
> >>}
> >
> >This is not quite the same thing as VirtualQuery.  This verifies that the
> >process can write to memory.  It doesn't verify that it is accessible.
> >
> >Maybe that is not important but I would have to think about this.
> >
> >Nice find, though, Rob.
>
> I've thought about it.  IsBadWritePtr should be fine in both
check_null_empty_path
> and check_valid_pointer.
>
> Could you submit a patch, Rob?  If you are motivated, I'd appreciate a
cleanup
> patch for resource.cc, too.
>
> cgf
>
> --
> Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
> Bug reporting:         http://cygwin.com/bugs.html
> Documentation:         http://cygwin.com/docs.html
> FAQ:                   http://cygwin.com/faq/
>
>

------------=_1583532848-65438-80
Content-Type: text/x-diff; charset=us-ascii; name="virtualquery.patch"
Content-Disposition: inline; filename="virtualquery.patch"
Content-Transfer-Encoding: base64
Content-Length: 2880

PyB2aXJ0dWFscXVlcnkucGF0Y2gKSW5kZXg6IHBhdGguY2MKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9j
eWd3aW4vcGF0aC5jYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xNTQKZGlm
ZiAtdSAtcCAtcjEuMTU0IHBhdGguY2MKLS0tIHBhdGguY2MJMjAwMS8wNi8y
NCAyMjoyNjo1MgkxLjE1NAorKysgcGF0aC5jYwkyMDAxLzA2LzI3IDEzOjI2
OjMzCkBAIC0zMzU3LDggKzMzNTcsNyBAQCBjeWd3aW5fc3BsaXRfcGF0aCAo
Y29uc3QgY2hhciAqcGF0aCwgY2hhCiBpbnQgX19zdGRjYWxsCiBjaGVja19u
dWxsX2VtcHR5X3BhdGggKGNvbnN0IGNoYXIgKm5hbWUpCiB7Ci0gIE1FTU9S
WV9CQVNJQ19JTkZPUk1BVElPTiBtOwotICBpZiAoIW5hbWUgfHwgIVZpcnR1
YWxRdWVyeSAobmFtZSwgJm0sIHNpemVvZiAobSkpIHx8IChtLlN0YXRlICE9
IE1FTV9DT01NSVQpKQorICBpZiAoIW5hbWUgfHwgSXNCYWRXcml0ZVB0ciAo
KHZvaWQgKikgbmFtZSwgc2l6ZW9mIChzdHJ1Y3QgcmxpbWl0KSkpCiAgICAg
cmV0dXJuIEVGQVVMVDsKIAogICBpZiAoISpuYW1lKQpJbmRleDogcmVzb3Vy
Y2UuY2MKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9z
cmMvc3JjL3dpbnN1cC9jeWd3aW4vcmVzb3VyY2UuY2MsdgpyZXRyaWV2aW5n
IHJldmlzaW9uIDEuMTAKZGlmZiAtdSAtcCAtcjEuMTAgcmVzb3VyY2UuY2MK
LS0tIHJlc291cmNlLmNjCTIwMDEvMDYvMjQgMjI6MjY6NTIJMS4xMAorKysg
cmVzb3VyY2UuY2MJMjAwMS8wNi8yNyAxMzoyNjozMwpAQCAtMTA1LDggKzEw
NSw3IEBAIGV4dGVybiAiQyIKIGludAogZ2V0cmxpbWl0IChpbnQgcmVzb3Vy
Y2UsIHN0cnVjdCBybGltaXQgKnJscCkKIHsKLSAgTUVNT1JZX0JBU0lDX0lO
Rk9STUFUSU9OIG07Ci0gIGlmICghcmxwIHx8ICFWaXJ0dWFsUXVlcnkgKHJs
cCwgJm0sIHNpemVvZiAobSkpIHx8IChtLlN0YXRlICE9IE1FTV9DT01NSVQp
KQorICBpZiAoIXJscCB8fCBJc0JhZFdyaXRlUHRyIChybHAsIHNpemVvZiAo
c3RydWN0IHJsaW1pdCkpKQogICAgIHsKICAgICAgIHNldF9lcnJubyAoRUZB
VUxUKTsKICAgICAgIHJldHVybiAtMTsKQEAgLTE0MSw4ICsxNDAsNyBAQCBl
eHRlcm4gIkMiCiBpbnQKIHNldHJsaW1pdCAoaW50IHJlc291cmNlLCBjb25z
dCBzdHJ1Y3QgcmxpbWl0ICpybHApCiB7Ci0gIE1FTU9SWV9CQVNJQ19JTkZP
Uk1BVElPTiBtOwotICBpZiAoIXJscCB8fCAhVmlydHVhbFF1ZXJ5IChybHAs
ICZtLCBzaXplb2YgKG0pKSB8fCAobS5TdGF0ZSAhPSBNRU1fQ09NTUlUKSkK
KyAgaWYgKCFybHAgfHwgSXNCYWRXcml0ZVB0ciAoKHZvaWQgKikgcmxwLCBz
aXplb2YgKHN0cnVjdCBybGltaXQpKSkKICAgICB7CiAgICAgICBzZXRfZXJy
bm8gKEVGQVVMVCk7CiAgICAgICByZXR1cm4gLTE7CkluZGV4OiB0aHJlYWQu
Y2MKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMv
c3JjL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjLHYKcmV0cmlldmluZyByZXZp
c2lvbiAxLjM4CmRpZmYgLXUgLXAgLXIxLjM4IHRocmVhZC5jYwotLS0gdGhy
ZWFkLmNjCTIwMDEvMDYvMjYgMTQ6NTc6MzMJMS4zOAorKysgdGhyZWFkLmNj
CTIwMDEvMDYvMjcgMTM6MjY6MzQKQEAgLTczOSw5ICs3MzksNyBAQCB2ZXJp
ZnlhYmxlX29iamVjdDo6fnZlcmlmeWFibGVfb2JqZWN0ICgpCiBpbnQgX19z
dGRjYWxsCiBjaGVja192YWxpZF9wb2ludGVyICh2b2lkICpwb2ludGVyKQog
ewotICBNRU1PUllfQkFTSUNfSU5GT1JNQVRJT04gbTsKLSAgaWYgKCFwb2lu
dGVyIHx8ICFWaXJ0dWFsUXVlcnkgKHBvaW50ZXIsICZtLCBzaXplb2YgKG0p
KQotICAgICAgfHwgKG0uU3RhdGUgIT0gTUVNX0NPTU1JVCkpCisgIGlmICgh
cG9pbnRlciB8fCBJc0JhZFdyaXRlUHRyKHBvaW50ZXIsIHNpemVvZiAodmVy
aWZ5YWJsZV9vYmplY3QpKSkKICAgICByZXR1cm4gRUZBVUxUOwogICByZXR1
cm4gMDsKIH0K

------------=_1583532848-65438-80--
