From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: yet another "pedantic" patch
Date: Fri, 14 Sep 2001 13:11:00 -0000
Message-id: <84197556771.20010915000849@logos-m.ru>
References: <11495323718.20010913194455@logos-m.ru> <20010913133424.B13789@redhat.com> <150112180767.20010914002552@logos-m.ru> <20010913163632.D15490@redhat.com>
X-SW-Source: 2001-q3/msg00147.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-100"

This is a multi-part message in MIME format...

------------=_1583532848-65438-100
Content-length: 1778

Hi!

Friday, 14 September, 2001 Christopher Faylor cgf@redhat.com wrote:

>>CF> Can I suggest that you modify the check_null_empty_* to pass
>>CF> in an errno that should be used in the case of an empty string?
>>
>>CF> You are special casing checks to force an EINVAL.

>>neither SUSv2 nor posix draft say what symlink should do if first
>>argument is empty string. actually, posix say that symlink() shouldn't
>>care for its validity as filesystem object at all, and this can be
>>treated as if empty string is allowed as symlink value.
>>So, should we eliminate (topath[0] == '\0') check altogether?
>>Of course, after verifying that symlink resolution code won't break on
>>such symlinks.

CF> Yes.  I guess we should eliminate this then.  It will probably require
CF> another special case check for symlink.

it looks like current symlink code handles empty string in symlink
contents without any trouble, but i want to give it a bit more
testing.

>>CF> Hmm.  I wonder if EINVAL is always appropriate for an empty string.
>>CF> It could just be wrong in check_null_empty_str.

>>otherwise, i think that allowing the caller to specify desired errno
>>explicitly in call to check_null_empty_str_errno() is a good thing.

i've removed checks that were forcing EINVAL (leaving those that don't
relate to check_null_empty_*, however)

it turned out that current check_null_empty_* are ok, and there's no
actual need to add errno parameters to them. only place were empty
string in parameter is known to cause error is when it's file or
directory name. in that case ENOENT is pretty adequate, just as EFAULT
in case of NULL or invalid pointer.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
check-args-validity-2.ChangeLog
check-args-validity-2.diff


------------=_1583532848-65438-100
Content-Type: text/plain; charset=us-ascii;
 name="check-args-validity-2.ChangeLog"
Content-Disposition: inline; filename="check-args-validity-2.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 277

MjAwMS0wOS0xNCAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBw
YXRoLmNjIChzeW1saW5rKTogQ2hlY2sgYXJndW1lbnRzIGZvciB2YWxpZGl0
eS4KCShnZXRjd2QpOiBEaXR0by4KCSogc3lzY2FsbHMuY2MgKGZ0cnVuY2F0
ZSk6IERpdHRvLgoJKiB0aW1lcy5jYyAodGltZXMpOiBEaXR0by4KCSogdW5h
bWUuY2MgKHVuYW1lKTogRGl0dG8uCg==

------------=_1583532848-65438-100
Content-Type: text/x-diff; charset=us-ascii; name="check-args-validity-2.diff"
Content-Disposition: inline; filename="check-args-validity-2.diff"
Content-Transfer-Encoding: base64
Content-Length: 3738

SW5kZXg6IHBhdGguY2MKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmls
ZTogL2N2cy91YmVyYmF1bS93aW5zdXAvY3lnd2luL3BhdGguY2MsdgpyZXRy
aWV2aW5nIHJldmlzaW9uIDEuMTYyCmRpZmYgLXUgLXAgLTIgLXIxLjE2MiBw
YXRoLmNjCi0tLSBwYXRoLmNjCTIwMDEvMDkvMDcgMjE6MzI6MDQJMS4xNjIK
KysrIHBhdGguY2MJMjAwMS8wOS8xNCAxNTo1MDoyMgpAQCAtMjQwMCw0ICsy
NDAwLDEyIEBAIHN5bWxpbmsgKGNvbnN0IGNoYXIgKnRvcGF0aCwgY29uc3Qg
Y2hhciAKICAgU0VDVVJJVFlfQVRUUklCVVRFUyBzYSA9IHNlY19ub25lX25p
aDsKIAorICBpZiAoY2hlY2tfbnVsbF9lbXB0eV9zdHIgKHRvcGF0aCkgPT0g
RUZBVUxUKQorICAgIHsKKyAgICAgIHNldF9lcnJubyAoRUZBVUxUKTsKKyAg
ICAgIGdvdG8gZG9uZTsKKyAgICB9CisgIGlmIChjaGVja19udWxsX2VtcHR5
X3N0cl9lcnJubyAoZnJvbXBhdGgpKQorICAgIGdvdG8gZG9uZTsKKwogICB3
aW4zMl9wYXRoLmNoZWNrIChmcm9tcGF0aCwgUENfU1lNX05PRk9MTE9XKTsK
ICAgaWYgKGFsbG93X3dpbnN5bWxpbmtzICYmICF3aW4zMl9wYXRoLmVycm9y
KQpAQCAtMjQxNiw5ICsyNDI0LDQgQEAgc3ltbGluayAoY29uc3QgY2hhciAq
dG9wYXRoLCBjb25zdCBjaGFyIAogICBzeXNjYWxsX3ByaW50ZiAoInN5bWxp
bmsgKCVzLCAlcykiLCB0b3BhdGgsIHdpbjMyX3BhdGguZ2V0X3dpbjMyICgp
KTsKIAotICBpZiAodG9wYXRoWzBdID09IDApCi0gICAgewotICAgICAgc2V0
X2Vycm5vIChFSU5WQUwpOwotICAgICAgZ290byBkb25lOwotICAgIH0KICAg
aWYgKHN0cmxlbiAodG9wYXRoKSA+PSBNQVhfUEFUSCkKICAgICB7CkBAIC0y
OTg1LDUgKzI5ODgsMTAgQEAgY2hhciAqCiBnZXRjd2QgKGNoYXIgKmJ1Ziwg
c2l6ZV90IHVsZW4pCiB7Ci0gIHJldHVybiBjeWdoZWFwLT5jd2QuZ2V0IChi
dWYsIDEsIDEsIHVsZW4pOworICBjaGFyKiByZXMgPSBOVUxMOworICBpZiAo
dWxlbiA9PSAwKQorICAgIHNldF9lcnJubyAoRUlOVkFMKTsKKyAgZWxzZSBp
ZiAoIV9fY2hlY2tfbnVsbF9pbnZhbGlkX3N0cnVjdF9lcnJubyAoYnVmLCB1
bGVuKSkKKyAgICByZXMgPSBjeWdoZWFwLT5jd2QuZ2V0IChidWYsIDEsIDEs
IHVsZW4pOworICByZXR1cm4gcmVzOwogfQogCkluZGV4OiBzeXNjYWxscy5j
Ywo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3ZzL3ViZXJi
YXVtL3dpbnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MsdgpyZXRyaWV2aW5nIHJl
dmlzaW9uIDEuMTQ0CmRpZmYgLXUgLXAgLTIgLXIxLjE0NCBzeXNjYWxscy5j
YwotLS0gc3lzY2FsbHMuY2MJMjAwMS8wOS8xMiAxNzo0NjozNgkxLjE0NAor
Kysgc3lzY2FsbHMuY2MJMjAwMS8wOS8xNCAxNTo1MDoyMgpAQCAtMTc2OSw1
ICsxNzY5LDkgQEAgZnRydW5jYXRlIChpbnQgZmQsIG9mZl90IGxlbmd0aCkK
ICAgaW50IHJlcyA9IC0xOwogCi0gIGlmIChjeWdoZWFwLT5mZHRhYi5ub3Rf
b3BlbiAoZmQpKQorICBpZiAobGVuZ3RoIDwgMCkKKyAgICB7CisgICAgICBz
ZXRfZXJybm8gKEVJTlZBTCk7CisgICAgfQorICBlbHNlIGlmIChjeWdoZWFw
LT5mZHRhYi5ub3Rfb3BlbiAoZmQpKQogICAgIHsKICAgICAgIHNldF9lcnJu
byAoRUJBREYpOwpJbmRleDogdGltZXMuY2MKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQpSQ1MgZmlsZTogL2N2cy91YmVyYmF1bS93aW5zdXAvY3lnd2luL3Rp
bWVzLmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjIyCmRpZmYgLXUgLXAg
LTIgLXIxLjIyIHRpbWVzLmNjCi0tLSB0aW1lcy5jYwkyMDAxLzA5LzEyIDE3
OjQ2OjM2CTEuMjIKKysrIHRpbWVzLmNjCTIwMDEvMDkvMTQgMTU6NTA6MjIK
QEAgLTUzLDQgKzUzLDcgQEAgdGltZXMgKHN0cnVjdCB0bXMgKiBidWYpCiAg
IEZJTEVUSU1FIGNyZWF0aW9uX3RpbWUsIGV4aXRfdGltZSwga2VybmVsX3Rp
bWUsIHVzZXJfdGltZTsKIAorICBpZiAoY2hlY2tfbnVsbF9pbnZhbGlkX3N0
cnVjdF9lcnJubyAoYnVmKSkKKyAgICByZXR1cm4gKChjbG9ja190KSAtMSk7
CisKICAgRFdPUkQgdGlja3MgPSBHZXRUaWNrQ291bnQgKCk7CiAgIC8qIFRp
Y2tzIGlzIGluIG1pbGxpc2Vjb25kcywgY29udmVydCB0byBvdXIgdGlja3Mu
IFVzZSBsb25nIGxvbmcgdG8gcHJldmVudApJbmRleDogdW5hbWUuY2MKPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy91YmVyYmF1bS93
aW5zdXAvY3lnd2luL3VuYW1lLmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAx
LjE0CmRpZmYgLXUgLXAgLTIgLXIxLjE0IHVuYW1lLmNjCi0tLSB1bmFtZS5j
YwkyMDAxLzA5LzEyIDE3OjQ2OjM3CTEuMTQKKysrIHVuYW1lLmNjCTIwMDEv
MDkvMTQgMTU6NTA6MjIKQEAgLTIyLDQgKzIyLDggQEAgdW5hbWUgKHN0cnVj
dCB1dHNuYW1lICpuYW1lKQogICBEV09SRCBsZW47CiAgIFNZU1RFTV9JTkZP
IHN5c2luZm87CisKKyAgaWYgKGNoZWNrX251bGxfaW52YWxpZF9zdHJ1Y3Rf
ZXJybm8gKG5hbWUpKQorICAgIHJldHVybiAtMTsKKyAgICAKICAgY2hhciAq
c25wID0gc3Ryc3RyICAoY3lnd2luX3ZlcnNpb24uZGxsX2J1aWxkX2RhdGUs
ICJTTlAiKTsKIAo=

------------=_1583532848-65438-100--
