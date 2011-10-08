Return-Path: <cygwin-patches-return-7519-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13423 invoked by alias); 8 Oct 2011 09:24:48 -0000
Received: (qmail 13413 invoked by uid 22791); 8 Oct 2011 09:24:47 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_40,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-gy0-f171.google.com (HELO mail-gy0-f171.google.com) (209.85.160.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 08 Oct 2011 09:24:33 +0000
Received: by gyh3 with SMTP id 3so5277304gyh.2        for <cygwin-patches@cygwin.com>; Sat, 08 Oct 2011 02:24:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.16.166 with SMTP id h6mr20188167pbd.103.1318065872247; Sat, 08 Oct 2011 02:24:32 -0700 (PDT)
Received: by 10.68.49.70 with HTTP; Sat, 8 Oct 2011 02:24:32 -0700 (PDT)
Date: Sat, 08 Oct 2011 09:24:00 -0000
Message-ID: <CAHWeT-ar0PNJ83P64iKOZq9f-AmjzsAqA9J=BHW_M24=URbKEg@mail.gmail.com>
Subject: Add locale.exe option for querying Windows UI languages
From: Andy Koppe <andy.koppe@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=bcaec51f8fc31b1ce904aec62090
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
X-SW-Source: 2011-q4/txt/msg00009.txt.bz2


--bcaec51f8fc31b1ce904aec62090
Content-Type: text/plain; charset=UTF-8
Content-length: 1783

The attached patch adds a --interface/-i option to locale.exe that
makes the --system/-s and --user/-u options print the respective
default UI language instead of the default locale.

	* locale.cc: Add --interface option for printing Windows default UI
	languages.

For background, here's what Windows' various default locales and languages do:

- LOCALE_USER_DEFAULT: This reflects the setting on the Formats tab of
the (Windows 7) Region&Language control panel, which affects the
format of times, dates, numbers, and currency.

- LOCALE_SYSTEM_DEFAULT: This reflects the "Language for non-Unicode
programs" on the Adminstrative tab of Region&Language control panel,
which also determines the ANSI and OEM codepages.

- GetUserDefaultUILanguage(): This is the current user's Windows UI
language, also called display language. On Windows installs with
multiple UI languages, a setting for this appears on the "Keyboards
and Languages" tab of the Region&Language control panel.

- GetSystemDefaultUILanguage(): The is the system-wide UI language
used for things that aren't user-specific, e.g. the login screen. As
far as I know it's determined at Windows install time and can''t be
changed.

(The latter two APIs are available from Windows 2000 onwards.)

Looking at those, and if we wanted to base the Cygwin locale settings
on the Windows ones, I think LC_NUMERIC, LC_TIME, and LC_MONETARY
should be determined by LOCALE_USER_DEFAULT, but LC_MESSAGES should be
determined by GetUserDefaultUILanguage(). Not sure about LC_CTYPE and
LC_COLLATE, but I suppose it would make sense for character
classification and sorting to match the UI language.

See also this blog post by MS's "Dr International" Michael Kaplan:
http://blogs.msdn.com/b/michkap/archive/2006/05/13/596971.aspx

Andy

--bcaec51f8fc31b1ce904aec62090
Content-Type: application/octet-stream; name="ui_lang.patch"
Content-Disposition: attachment; filename="ui_lang.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gtic6jfo0
Content-length: 2412

SW5kZXg6IHdpbnN1cC91dGlscy9sb2NhbGUuY2MKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC91dGlscy9s
b2NhbGUuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTEKZGlmZiAtdSAt
cjEuMTEgbG9jYWxlLmNjCi0tLSB3aW5zdXAvdXRpbHMvbG9jYWxlLmNjCTMg
TWF5IDIwMTEgMTA6MzQ6MjUgLTAwMDAJMS4xMQorKysgd2luc3VwL3V0aWxz
L2xvY2FsZS5jYwk4IE9jdCAyMDExIDA4OjExOjUyIC0wMDAwCkBAIC01OCw2
ICs1OCw3IEBACiAJICAgIiAgLW0sIC0tY2hhcm1hcHMgICAgICAgTGlzdCBh
bGwgYXZhaWxhYmxlIGNoYXJhY3RlciBtYXBzXG4iCiAJICAgIiAgLXMsIC0t
c3lzdGVtICAgICAgICAgUHJpbnQgc3lzdGVtIGRlZmF1bHQgbG9jYWxlXG4i
CiAJICAgIiAgLXUsIC0tdXNlciAgICAgICAgICAgUHJpbnQgdXNlcidzIGRl
ZmF1bHQgbG9jYWxlXG4iCisJICAgIiAgLWksIC0taW50ZXJmYWNlICAgICAg
UHJpbnQgZGVmYXVsdCBVSSBsYW5ndWFnZSBpbnN0ZWFkIG9mIGxvY2FsZVxu
IgogCSAgICIgIC1VLCAtLXV0ZiAgICAgICAgICAgIEF0dGFjaCBcIi5VVEYt
OFwiIHRvIHRoZSByZXN1bHRcbiIKIAkgICAiICAtdiwgLS12ZXJib3NlICAg
ICAgICBNb3JlIHZlcmJvc2Ugb3V0cHV0XG4iCiAJICAgIiAgLWgsIC0taGVs
cCAgICAgICAgICAgVGhpcyB0ZXh0XG4iLApAQCAtNzIsMTIgKzczLDEzIEBA
CiAgIHsiY2hhcm1hcHMiLCBub19hcmd1bWVudCwgTlVMTCwgJ20nfSwKICAg
eyJzeXN0ZW0iLCBub19hcmd1bWVudCwgTlVMTCwgJ3MnfSwKICAgeyJ1c2Vy
Iiwgbm9fYXJndW1lbnQsIE5VTEwsICd1J30sCisgIHsiaW50ZXJmYWNlIiwg
bm9fYXJndW1lbnQsIE5VTEwsICdpJ30sCiAgIHsidXRmIiwgbm9fYXJndW1l
bnQsIE5VTEwsICdVJ30sCiAgIHsidmVyYm9zZSIsIG5vX2FyZ3VtZW50LCBO
VUxMLCAndid9LAogICB7ImhlbHAiLCBub19hcmd1bWVudCwgTlVMTCwgJ2gn
fSwKICAgezAsIG5vX2FyZ3VtZW50LCBOVUxMLCAwfQogfTsKLWNvbnN0IGNo
YXIgKm9wdHMgPSAiYWNoa21zdVV2IjsKK2NvbnN0IGNoYXIgKm9wdHMgPSAi
YWNoa21zdWlVdiI7CiAKIGludAogZ2V0bG9jYWxlIChMQ0lEIGxjaWQsIGNo
YXIgKm5hbWUpCkBAIC03NDcsNiArNzQ5LDcgQEAKIHsKICAgaW50IG9wdDsK
ICAgTENJRCBsY2lkID0gMDsKKyAgaW50IHVpX2xhbmcgPSAwOwogICBpbnQg
YWxsID0gMDsKICAgaW50IGNhdCA9IDA7CiAgIGludCBrZXkgPSAwOwpAQCAt
Nzc3LDYgKzc4MCw5IEBACiAgICAgICBjYXNlICd1JzoKICAgICAgIAlsY2lk
ID0gTE9DQUxFX1VTRVJfREVGQVVMVDsKIAlicmVhazsKKyAgICAgIGNhc2Ug
J2knOgorCXVpX2xhbmcgPSAxOworCWJyZWFrOwogICAgICAgY2FzZSAnVSc6
CiAgICAgICAJdXRmID0gIi5VVEYtOCI7CiAJYnJlYWs7CkBAIC03OTYsNiAr
ODAyLDEzIEBACiAgICAgcHJpbnRfY2hhcm1hcHMgKCk7CiAgIGVsc2UgaWYg
KGxjaWQpCiAgICAgeworICAgICAgaWYgKHVpX2xhbmcpCisJeworCSAgaWYg
KGxjaWQgPT0gTE9DQUxFX1NZU1RFTV9ERUZBVUxUKQorCSAgICBsY2lkID0g
R2V0U3lzdGVtRGVmYXVsdFVJTGFuZ3VhZ2UoKTsKKwkgIGVsc2UKKwkgICAg
bGNpZCA9IEdldFVzZXJEZWZhdWx0VUlMYW5ndWFnZSgpOworCX0KICAgICAg
IGlmIChnZXRsb2NhbGUgKGxjaWQsIG5hbWUpKQogCXByaW50ZiAoIiVzJXNc
biIsIG5hbWUsIHV0Zik7CiAgICAgfQo=

--bcaec51f8fc31b1ce904aec62090--
