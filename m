Return-Path: <cygwin-patches-return-7293-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27025 invoked by alias); 4 May 2011 06:04:28 -0000
Received: (qmail 27015 invoked by uid 22791); 4 May 2011 06:04:27 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f171.google.com (HELO mail-qy0-f171.google.com) (209.85.216.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 04 May 2011 06:04:10 +0000
Received: by qyj19 with SMTP id 19so2991710qyj.2        for <cygwin-patches@cygwin.com>; Tue, 03 May 2011 23:04:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.43.99 with SMTP id v35mr431840qce.8.1304489049201; Tue, 03 May 2011 23:04:09 -0700 (PDT)
Received: by 10.229.245.138 with HTTP; Tue, 3 May 2011 23:04:09 -0700 (PDT)
Date: Wed, 04 May 2011 06:04:00 -0000
Message-ID: <BANLkTi=XnXKSa4B1j3C=Zi_fu6fw7pKSBA@mail.gmail.com>
Subject: locale initialization issue
From: Andy Koppe <andy.koppe@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=0014853c90b0641c5904a26d0623
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00059.txt.bz2


--0014853c90b0641c5904a26d0623
Content-Type: text/plain; charset=UTF-8
Content-length: 2530

Hi,

I stumbled across an issues with locale initialization when the "C"
locale is specified in the environment.

$ cat test.c
#include <stdlib.h>
#include <stdio.h>
#include <locale.h>
#include <langinfo.h>

int main(void) {
  char cs[8];
  puts(nl_langinfo(CODESET));
  printf("%i\n", wctomb(cs, 0x80));
  return 0;
}

The program doesn't call setlocale, so it should be using the "C"
locale with its ASCII charset, which means the wctomb() call with a
codepoint outside the ASCII range should fail. And that's exactly what
happens as long as the locale set in the environment is something
other than "C", e.g.:

$ LC_ALL=C.UTF-8 ./test
ANSI_X3.4-1968
-1

$ LC_ALL=en_GB.ISO-8859-15 ./test
ANSI_X3.4-1968
-1

However, if the environment locale is "C", the charset is still
reported as ASCII (aka ANSI_X3.4-1968), but the wctomb call suddenly
succeeds:

$ LC_ALL=C ./a
ANSI_X3.4-1968
2

That's due to a combination of three things: Cygwin newlib starts with
the __wctomb and __mbtowc function pointers set to the UTF-8 variants
(for conversions during early Cygwin initialization), yet the LC_CTYPE
locale is set to "C", and setlocale() does nothing if the requested
locale is the same as the previous one.

Hence, with the locale set to "C" in the environment, both the
setlocale call from initial_setlocale(), which asks for the
environment locale for filename conversion, and the setlocale() just
before main() that sets the "C" locale, end up doing nothing. Thus the
conversion functions remain set to the UTF-8 variants instead of being
set to the ASCII ones as intended for the "C" locale.

The attached small patch addresses this by starting with the LC_CTYPE
locale set to "C.UTF-8"  and lc_ctype_charset set accordingly too.
This means that setting the "C" locale is recognised as a change and
that the conversion function pointers are updated accordingly. It also
has the happy side effect that the setlocale call from
initial_setlocale() will be short-circuited if the default "C.UTF-8"
locale has not been overridden in the environment.

Additionally, I think it's time to drop the "temporarily" #if 0'd code
for making UTF-8 the charset for the "C" locale.

It's a newlib patch, but it's entirely Cygwin-specific, so it seemed
more appropriate to send it here.

	* libc/locale/locale.c [__CYGWIN__]
	(current_categories, lc_ctype_charset): Start with the LC_CTYPE locale
	set to "C.UTF-8", to match initial __wctomb and __mbtowc settings.
	(lc_message_charset, loadlocale): Settle on ASCII as the "C" charset.

Andy

--0014853c90b0641c5904a26d0623
Content-Type: application/octet-stream; name="lc_ctype.patch"
Content-Disposition: attachment; filename="lc_ctype.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gn9v33ry0
Content-length: 2123

SW5kZXg6IG5ld2xpYi9saWJjL2xvY2FsZS9sb2NhbGUuYwo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvbmV3bGliL2xp
YmMvbG9jYWxlL2xvY2FsZS5jLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjQ4
CmRpZmYgLXUgLXIxLjQ4IGxvY2FsZS5jCi0tLSBuZXdsaWIvbGliYy9sb2Nh
bGUvbG9jYWxlLmMJMTkgTm92IDIwMTAgMTA6MDI6MzYgLTAwMDAJMS40OAor
KysgbmV3bGliL2xpYmMvbG9jYWxlL2xvY2FsZS5jCTQgTWF5IDIwMTEgMDU6
NTA6NDAgLTAwMDAKQEAgLTIzNSw3ICsyMzUsMTIgQEAKIHN0YXRpYyBjaGFy
IGN1cnJlbnRfY2F0ZWdvcmllc1tfTENfTEFTVF1bRU5DT0RJTkdfTEVOICsg
MV0gPSB7CiAgICAgIkMiLAogICAgICJDIiwKKyNpZmRlZiBfX0NZR1dJTl9f
CisvKiBDeWd3aW4gc3RhcnRzIHdpdGggTENfQ1RZUEUgc2V0IHRvICJDLlVU
Ri04Ii4gKi8KKyAgICAiQy5VVEYtOCIsCisjZWxzZQogICAgICJDIiwKKyNl
bmRpZgogICAgICJDIiwKICAgICAiQyIsCiAgICAgIkMiLApAQCAtMjU1LDEz
ICsyNjAsMTMgQEAKIAogI2VuZGlmIC8qIF9NQl9DQVBBQkxFICovCiAKLSNp
ZiAwIC8qZGVmIF9fQ1lHV0lOX18gIFRPRE86IHRlbXBvcmFyaWx5KD8pIGRp
c2FibGUgQyA9PSBVVEYtOCAqLworI2lmZGVmIF9fQ1lHV0lOX18KKy8qIEN5
Z3dpbiBzdGFydHMgd2l0aCBMQ19DVFlQRSBzZXQgdG8gIkMuVVRGLTgiLiAq
Lwogc3RhdGljIGNoYXIgbGNfY3R5cGVfY2hhcnNldFtFTkNPRElOR19MRU4g
KyAxXSA9ICJVVEYtOCI7Ci1zdGF0aWMgY2hhciBsY19tZXNzYWdlX2NoYXJz
ZXRbRU5DT0RJTkdfTEVOICsgMV0gPSAiVVRGLTgiOwogI2Vsc2UKIHN0YXRp
YyBjaGFyIGxjX2N0eXBlX2NoYXJzZXRbRU5DT0RJTkdfTEVOICsgMV0gPSAi
QVNDSUkiOwotc3RhdGljIGNoYXIgbGNfbWVzc2FnZV9jaGFyc2V0W0VOQ09E
SU5HX0xFTiArIDFdID0gIkFTQ0lJIjsKICNlbmRpZgorc3RhdGljIGNoYXIg
bGNfbWVzc2FnZV9jaGFyc2V0W0VOQ09ESU5HX0xFTiArIDFdID0gIkFTQ0lJ
IjsKIHN0YXRpYyBpbnQgbGNfY3R5cGVfY2prX2xhbmcgPSAwOwogCiBjaGFy
ICoKQEAgLTQ5NSwxMSArNTAwLDcgQEAKICAgaWYgKCFzdHJjbXAgKGxvY2Fs
ZSwgIlBPU0lYIikpCiAgICAgc3RyY3B5IChsb2NhbGUsICJDIik7CiAgIGlm
ICghc3RyY21wIChsb2NhbGUsICJDIikpCQkJCS8qIERlZmF1bHQgIkMiIGxv
Y2FsZSAqLwotI2lmIDAgLypkZWYgX19DWUdXSU5fXyAgVE9ETzogdGVtcG9y
YXJpbHkoPykgZGlzYWJsZSBDID09IFVURi04ICovCi0gICAgc3RyY3B5IChj
aGFyc2V0LCAiVVRGLTgiKTsKLSNlbHNlCiAgICAgc3RyY3B5IChjaGFyc2V0
LCAiQVNDSUkiKTsKLSNlbmRpZgogICBlbHNlIGlmIChsb2NhbGVbMF0gPT0g
J0MnCiAJICAgJiYgKGxvY2FsZVsxXSA9PSAnLScJCS8qIE9sZCBuZXdsaWIg
c3R5bGUgKi8KIAkgICAgICAgfHwgbG9jYWxlWzFdID09ICcuJykpCS8qIEV4
dGVuc2lvbiBmb3IgdGhlIEMgbG9jYWxlIHRvIGFsbG93Cg==

--0014853c90b0641c5904a26d0623--
