From: egor duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Cc: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: [psusi@cfl.rr.com: Bug report in installer]
Date: Mon, 09 Jul 2001 00:03:00 -0000
Message-id: <68329971954.20010709110103@logos-m.ru>
References: <20010708165111.B16986@redhat.com> <177327937358.20010709102708@logos-m.ru>
X-SW-Source: 2001-q3/msg00003.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-89"

This is a multi-part message in MIME format...

------------=_1583532848-65438-89
Content-length: 1426

Hi!

Monday, 09 July, 2001 egor duda deo@logos-m.ru wrote:

ed> Hi!

ed> Monday, 09 July, 2001 Christopher Faylor cgf@redhat.com wrote:

CF>> Didn't we fix this some time ago?

ed> I've submitted a patch for this, but it apparently wasn't applied.
ed> i'll remake it against current sources and resubmit it.

Uhm, i should have looked before posting this. it was applied, but the
problem is with foreground. not background. here's the patch.

CF>> ----- Forwarded message from Phillip Susi <psusi@cfl.rr.com> -----
CF>> From: Phillip Susi <psusi@cfl.rr.com>
CF>> To: cygwin@cygwin.com
CF>> Subject: Bug report in installer
CF>> Date: Sun, 08 Jul 2001 14:05:28 -0400

CF>> Hi, I just installed the latest cygwin from the web site, and there is a 
CF>> bug in the installer UI:

CF>> When you select which components to install, it draws the names of the 
CF>> components in black text, assuming the user's background color is 
CF>> white.  My color scheme is white text on a black background, and so the 
CF>> installer used the black background, with the black text, so I couldn't see 
CF>> it.  When drawing text, you should use the windows color scheme foreground 
CF>> text color, not force it to be black.

CF>>    -->Phillip Susi
CF>>       psusi@cfl.rr.com
CF>> ----- End forwarded message -----

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
setup-foreground.ChangeLog
setup-foreground.diff


------------=_1583532848-65438-89
Content-Type: text/plain; charset=us-ascii; name="setup-foreground.ChangeLog"
Content-Disposition: inline; filename="setup-foreground.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 135

MjAwMS0wNy0wOSAgRWdvciBEdWRhIDxkZW9AbG9nb3MtbS5ydT4KCgkqIGNo
b29zZS5jYzogVXNlIHN5c3RlbSBmb3JlZ3JvdW5kIGNvbG9yIGZvciB0ZXh0
IG91dHB1dC4K

------------=_1583532848-65438-89
Content-Type: text/x-diff; charset=us-ascii; name="setup-foreground.diff"
Content-Disposition: inline; filename="setup-foreground.diff"
Content-Transfer-Encoding: base64
Content-Length: 619

SW5kZXg6IGNob29zZS5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBm
aWxlOiAvY3ZzL3ViZXJiYXVtL3dpbnN1cC9jaW5zdGFsbC9jaG9vc2UuY2Ms
dgpyZXRyaWV2aW5nIHJldmlzaW9uIDIuNDUKZGlmZiAtdSAtcCAtMiAtcjIu
NDUgY2hvb3NlLmNjCi0tLSBjaG9vc2UuY2MJMjAwMS8wNy8wNyAwNDo0Njoz
MQkyLjQ1CisrKyBjaG9vc2UuY2MJMjAwMS8wNy8wOSAwNjo1NDowMwpAQCAt
Mjg5LDQgKzI4OSw1IEBAIHBhaW50IChIV05EIGh3bmQpCiAgIFNlbGVjdE9i
amVjdCAoaGRjLCBzeXNmb250KTsKICAgU2V0QmtDb2xvciAoaGRjLCBHZXRT
eXNDb2xvciAoQ09MT1JfV0lORE9XKSk7CisgIFNldFRleHRDb2xvciAoaGRj
LCBHZXRTeXNDb2xvciAoQ09MT1JfV0lORE9XVEVYVCkpOwogCiAgIFJFQ1Qg
Y3I7Cg==

------------=_1583532848-65438-89--
