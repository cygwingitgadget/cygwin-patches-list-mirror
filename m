From: Egor Duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Re: CTRL-U in bash changes color to black on black?
Date: Thu, 22 Mar 2001 07:02:00 -0000
Message-id: <194675503.20010322180111@logos-m.ru>
References: <20010321221952.A12182@redhat.com>
X-SW-Source: 2001-q1/msg00234.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65438-31"

This is a multi-part message in MIME format...

------------=_1583532846-65438-31
Content-length: 595

Hi!

Thursday, 22 March, 2001 Christopher Faylor cgf@redhat.com wrote:

CF> I just noticed that a CTRL-U in bash on Windows 95 either causes the
CF> color in bash to change to black on black or somehow causes characters
CF> to be output as spaces.  The cursor still moves but no characters are
CF> displayed.

CF> Does anyone have time to look into this?

can anybody test this patch? i think it may help. i don't have w95
around to test it myself, so please give some feedback.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
console-init.diff
console-init.ChangeLog


------------=_1583532846-65438-31
Content-Type: text/plain; charset=us-ascii; name="console-init.ChangeLog"
Content-Disposition: inline; filename="console-init.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 204

MjAwMS0wMy0yMiAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBm
aGFuZGxlcl9jb25zb2xlLmNjIChmaGFuZGxlcl9jb25zb2xlOjpzZXRfZGVm
YXVsdF9hdHRyKTogVXBkYXRlCgljb25zb2xlIGNvbG9yIGF0dHJpYnV0ZXMg
b24gdHR5IHJlc2V0Lgo=

------------=_1583532846-65438-31
Content-Type: text/x-diff; charset=us-ascii; name="console-init.diff"
Content-Disposition: inline; filename="console-init.diff"
Content-Transfer-Encoding: base64
Content-Length: 789

SW5kZXg6IGZoYW5kbGVyX2NvbnNvbGUuY2MKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vZmhh
bmRsZXJfY29uc29sZS5jYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS40Mgpk
aWZmIC11IC1wIC0yIC1yMS40MiBmaGFuZGxlcl9jb25zb2xlLmNjCi0tLSBm
aGFuZGxlcl9jb25zb2xlLmNjCTIwMDEvMDMvMTIgMjA6Mzk6NDAJMS40Mgor
KysgZmhhbmRsZXJfY29uc29sZS5jYwkyMDAxLzAzLzIyIDE0OjU2OjA0CkBA
IC04MTgsNCArODE4LDYgQEAgZmhhbmRsZXJfY29uc29sZTo6c2V0X2RlZmF1
bHRfYXR0ciAoKQogICBmZyA9IGRlZmF1bHRfY29sb3IgJiBGT1JFR1JPVU5E
X0FUVFJfTUFTSzsKICAgYmcgPSBkZWZhdWx0X2NvbG9yICYgQkFDS0dST1VO
RF9BVFRSX01BU0s7CisgIGN1cnJlbnRfd2luMzJfYXR0ciA9IGdldF93aW4z
Ml9hdHRyICgpOworICBTZXRDb25zb2xlVGV4dEF0dHJpYnV0ZSAoZ2V0X291
dHB1dF9oYW5kbGUgKCksIGN1cnJlbnRfd2luMzJfYXR0cik7CiB9CiAK

------------=_1583532846-65438-31--
