From: David Sainty <David.Sainty@optimation.co.nz>
To: "'cygwin-patches@sources.redhat.com'" <cygwin-patches@sources.redhat.com>
Cc: "Dave Sainty (E-mail)" <dave@dtsp.co.nz>
Subject: Patch to make setrlimit() more forgiving
Date: Thu, 04 Jan 2001 18:39:00 -0000
Message-id: <30E7BC40E838D211B3DB00104B09EFB77953DE@delorean.optimation.co.nz>
X-SW-Source: 2001-q1/msg00004.html
Content-type: multipart/mixed; boundary="----------=_1583532845-65438-0"

This is a multi-part message in MIME format...

------------=_1583532845-65438-0
Content-length: 687

Attached is a simple patch that prevents setrlimit() failing with an error
when the operation would not have changed anything.  This allows all
resource types to be set, so long as the setting is identical to the current
pseudo-settings.

One "problem" with the patch is that it calls getrlimit(), which calls
VirtualQuery() on an internal address that we are sure is ok.  This isn't
incorrect, it's just overkill.  The fix would be to use getrlimit() as a
wrapper to an internal function that avoids the memory test.  But... I'm not
sure why these tests are here at all, they don't seem to occur on other API
functions...  A crash is just as legitimate as an EFAULT? :)

Cheers,

Dave


------------=_1583532845-65438-0
Content-Type: text/x-diff; charset=us-ascii; name="setrlimit-patch"
Content-Disposition: inline; filename="setrlimit-patch"
Content-Transfer-Encoding: base64
Content-Length: 915

LS0tIHJlc291cmNlLmNjLm9yaWcJRnJpIEphbiAgNSAxNToxMTo0MCAyMDAx
CisrKyByZXNvdXJjZS5jYwlGcmkgSmFuICA1IDE1OjE1OjE0IDIwMDEKQEAg
LTE0MSw2ICsxNDEsMTkgQEAKICAgaWYgKCFybHAgfHwgIVZpcnR1YWxRdWVy
eSAocmxwLCAmbSwgc2l6ZW9mIChtKSkgfHwgKG0uU3RhdGUgIT0gTUVNX0NP
TU1JVCkpCiAgICAgcmV0dXJuIEVGQVVMVDsKIAorICBzdHJ1Y3QgcmxpbWl0
IG9sZGxpbWl0czsKKworICAvLyBDaGVjayBpZiB0aGUgcmVxdWVzdCBpcyB0
byBhY3R1YWxseSBjaGFuZ2UgdGhlIHJlc291cmNlIHNldHRpbmdzLgorICAv
LyBJZiBpdCBkb2VzIG5vdCByZXN1bHQgaW4gYSBjaGFuZ2UsIHRha2Ugbm8g
YWN0aW9uIGFuZCBkbyBub3QKKyAgLy8gZmFpbC4KKyAgaWYgKGdldHJsaW1p
dChyZXNvdXJjZSwgJm9sZGxpbWl0cykgPCAwKQorICAgIHJldHVybiAtMTsK
KworICBpZiAob2xkbGltaXRzLnJsaW1fY3VyID09IHJscC0+cmxpbV9jdXIg
JiYKKyAgICAgIG9sZGxpbWl0cy5ybGltX21heCA9PSBybHAtPnJsaW1fbWF4
KQorICAgIC8vIE5vIGNoYW5nZSBpbiByZXNvdXJjZSByZXF1aXJlbWVudHMs
IHN1Y2NlZWQgaW1tZWRpYXRlbHkKKyAgICByZXR1cm4gMDsKKwogICBzd2l0
Y2ggKHJlc291cmNlKQogICAgIHsKICAgICBjYXNlIFJMSU1JVF9DT1JFOgo=

------------=_1583532845-65438-0--
