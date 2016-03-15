Return-Path: <cygwin-patches-return-8411-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48969 invoked by alias); 15 Mar 2016 21:40:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48784 invoked by uid 89); 15 Mar 2016 21:40:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=4.2 required=5.0 tests=AWL,BAYES_50,GARBLED_SUBJECT,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=separated, 033, sk:fhandle, HX-HELO:sk:mout.ku
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 15 Mar 2016 21:40:11 +0000
Received: from [192.168.178.44] ([95.91.214.87]) by mrelayeu.kundenserver.de (mreue005) with ESMTPSA (Nemesis) id 0LsuhK-1Zeg1c16K2-012cD0 for <cygwin-patches@cygwin.com>; Tue, 15 Mar 2016 22:40:06 +0100
Subject: =?UTF-8?Q?Re:_Console_requested_reports_=e2=80=93_Re:_[ANNOUNCEMENT?= =?UTF-8?Q?]_TEST_RELEASE:_Cygwin_2.5.0-0.6?=
To: cygwin-patches@cygwin.com
References: <announce.20160312232737.GA25791@calimero.vinschen.de> <56E80B4B.5040106@towo.net> <20160315134655.GC4177@calimero.vinschen.de>
From: Thomas Wolff <towo@towo.net>
Message-ID: <56E88137.9020307@towo.net>
Date: Tue, 15 Mar 2016 21:40:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20160315134655.GC4177@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------040804050008030600070703"
X-UI-Out-Filterresults: notjunk:1;V01:K0:YHVGHjvp3OI=:MT9geChlp48ffdRaQIMZwF jb47My7g/B38duEAw4lBnV97UK+7QG2X69ZofHF79AqXBBvGTc5pt7JF5rlDCO596RaQmFOaS C5oTmH5J1Iuy2AYWhC+2TmD1hSVfONBNrchaSbatIan/djI00PsE6PTusIVbg16acq3gEAErK OAi0k0CP0Zg12+cf5mjydtt6jKzfIJxQv0Q3KjKJBS5cfvLqeB2fnhnbuGGtdAb8UTw+NiWIA 93evArgISJZ3Tii3u6z5inFfJ+f1qDyYW8TwpWmhRrVEHhqKOpYV8a5zPuXJlrCc34UBmR6Mr fH1hLysT2nFLVZ7imyN3UbpWUwxQUfEtJCWhBXuOc+i0/7PIRSRBx3r5QW8X4ythCDXXOZAfI 0HWebeejAvz2q/ttARWxD3i7hkGd5XbTp/g3unP/FObwmIir2mCM5GfXswg1FSj4MhRE1Je8I MQZSNsiNeFO83KhbM5D8E93scdTGvkJkps9sJptnaq2tMldz02kbBrlX7ZfWRo0s3uCH5yBod dnYLGfzvYCDSO8CZr4wvWvTWr+xUd9u1QkoY8HmzHLIgYk0SLMoIFxhnWHsPci31aTZdgmKvj oLp+m0/gIuznff9jg8bUiv13ZhtlfhXiL2tGXDPBJjs1wGyN4tkuOgKvsGUKtEGmKMvy66atc wmyLaWZI0YC1Q6fuWzAtKsMZxnm26aPNPsl10ogeMHSTTbPMiagYNRdIbR87I6ZXCyCk=
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00117.txt.bz2

This is a multi-part message in MIME format.
--------------040804050008030600070703
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1187

Hi Corinna,
here is my updated patch.
> Changelog (old format):
> Just drop this line from the comment, please.  If you send the mail
> via git format-patch/git send-email I can simply apply it with git am
> including the entire text in the git log.
I hope the comment format is OK now, I cannot currently use git 
format-patch due to missing setup.

Make requested console reports work, cf https://cygwin.com/ml/cygwin-patches/2012-q3/msg00019.html

This enables the following ESC sequences:
ESC[c sends primary device attributes
ESC[>c sends secondary device attributes
ESC[6n sends cursor position report

     * fhandler.h (class dev_console): Add console read-ahead buffer.
     (class fhandler_console): Add peek function for it (for select).
     * fhandler_console.cc (fhandler_console::setup): Init buffer.
     (fhandler_console::read): Check console read-aheader buffer.
     (fhandler_console::char_command): Put responses to terminal
     requests (device status and cursor position reports) into
     common console buffer (shared between CONOUT/CONIN)
     instead of fhandler buffer (separated).
     * select.cc (peek_console): Check console read-ahead buffer.

Thomas


--------------040804050008030600070703
Content-Type: text/plain; charset=UTF-8;
 name="terminal-requests.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="terminal-requests.patch"
Content-length: 4388

ZGlmZiAtcnVwIHdpbnN1cC9jeWd3aW4vb3JpZy9maGFuZGxlci5oIHdpbnN1
cC9jeWd3aW4vZmhhbmRsZXIuaAotLS0gd2luc3VwL2N5Z3dpbi9vcmlnL2Zo
YW5kbGVyLmgJMjAxNi0wMy0xMCAxNzozMDo0MC4wMDAwMDAwMDAgKzAwMDAK
KysrIHdpbnN1cC9jeWd3aW4vZmhhbmRsZXIuaAkyMDE2LTAzLTE1IDE2OjEw
OjM3LjM0MDM0OTYwMCArMDAwMApAQCAtMTM1Miw2ICsxMzUyLDggQEAgY2xh
c3MgZGV2X2NvbnNvbGUKICAgYm9vbCBleHRfbW91c2VfbW9kZTE1OwogICBi
b29sIHVzZV9mb2N1czsKICAgYm9vbCByYXdfd2luMzJfa2V5Ym9hcmRfbW9k
ZTsKKyAgY2hhciBjb25zX3JhYnVmWzQwXTsgIC8vIGNhbm5vdCBnZXQgbG9u
Z2VyIHRoYW4gY2hhciBidWZbNDBdIGluIGNoYXJfY29tbWFuZAorICBjaGFy
ICpjb25zX3JhcG9pOwogCiAgIGlubGluZSBVSU5UIGdldF9jb25zb2xlX2Nw
ICgpOwogICBEV09SRCBjb25fdG9fc3RyIChjaGFyICpkLCBpbnQgZGxlbiwg
V0NIQVIgdyk7CkBAIC0xNDQ5LDYgKzE0NTEsMTAgQEAgcHJpdmF0ZToKICAg
aW50IGluaXQgKEhBTkRMRSwgRFdPUkQsIG1vZGVfdCk7CiAgIGJvb2wgbW91
c2VfYXdhcmUgKE1PVVNFX0VWRU5UX1JFQ09SRCYgbW91c2VfZXZlbnQpOwog
ICBib29sIGZvY3VzX2F3YXJlICgpIHtyZXR1cm4gc2hhcmVkX2NvbnNvbGVf
aW5mby0+Y29uLnVzZV9mb2N1czt9CisgIGJvb2wgZ2V0X2NvbnNfcmVhZGFo
ZWFkX3ZhbGlkICgpCisgIHsKKyAgICByZXR1cm4gc2hhcmVkX2NvbnNvbGVf
aW5mby0+Y29uLmNvbnNfcmFwb2kgIT0gTlVMTDsKKyAgfQogCiAgIHNlbGVj
dF9yZWNvcmQgKnNlbGVjdF9yZWFkIChzZWxlY3Rfc3R1ZmYgKik7CiAgIHNl
bGVjdF9yZWNvcmQgKnNlbGVjdF93cml0ZSAoc2VsZWN0X3N0dWZmICopOwpk
aWZmIC1ydXAgd2luc3VwL2N5Z3dpbi9vcmlnL2ZoYW5kbGVyX2NvbnNvbGUu
Y2Mgd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9jb25zb2xlLmNjCi0tLSB3aW5z
dXAvY3lnd2luL29yaWcvZmhhbmRsZXJfY29uc29sZS5jYwkyMDE2LTAxLTEy
IDE0OjM5OjUyLjAwMDAwMDAwMCArMDAwMAorKysgd2luc3VwL2N5Z3dpbi9m
aGFuZGxlcl9jb25zb2xlLmNjCTIwMTYtMDMtMTUgMTY6MDM6NDYuMzI5MjUy
NjAwICswMDAwCkBAIC0xOTYsNiArMTk2LDcgQEAgZmhhbmRsZXJfY29uc29s
ZTo6c2V0dXAgKCkKIAkgIGNvbi5tZXRhX21hc2sgfD0gUklHSFRfQUxUX1BS
RVNTRUQ7CiAJY29uLnNldF9kZWZhdWx0X2F0dHIgKCk7CiAJY29uLmJhY2tz
cGFjZV9rZXljb2RlID0gQ0VSQVNFOworCWNvbi5jb25zX3JhcG9pID0gTlVM
TDsKIAlzaGFyZWRfY29uc29sZV9pbmZvLT50dHlfbWluX3N0YXRlLmlzX2Nv
bnNvbGUgPSB0cnVlOwogICAgICAgfQogfQpAQCAtMzEwLDYgKzMxMSwxNCBA
QCBmaGFuZGxlcl9jb25zb2xlOjpyZWFkICh2b2lkICpwdiwgc2l6ZV90CiAg
IGludCBjaDsKICAgc2V0X2lucHV0X3N0YXRlICgpOwogCisgIC8qIENoZWNr
IGNvbnNvbGUgcmVhZC1haGVhZCBidWZmZXIgZmlsbGVkIGZyb20gdGVybWlu
YWwgcmVxdWVzdHMgKi8KKyAgaWYgKGNvbi5jb25zX3JhcG9pICYmICpjb24u
Y29uc19yYXBvaSkKKyAgICB7CisgICAgICAqYnVmID0gKmNvbi5jb25zX3Jh
cG9pICsrOworICAgICAgYnVmbGVuID0gMTsKKyAgICAgIHJldHVybjsKKyAg
ICB9CisKICAgaW50IGNvcGllZF9jaGFycyA9IGdldF9yZWFkYWhlYWRfaW50
b19idWZmZXIgKGJ1ZiwgYnVmbGVuKTsKIAogICBpZiAoY29waWVkX2NoYXJz
KQpAQCAtMTg5OSw4ICsxOTA4LDExIEBAIGZoYW5kbGVyX2NvbnNvbGU6OmNo
YXJfY29tbWFuZCAoY2hhciBjKQogCXN0cmNweSAoYnVmLCAiXDAzM1s/NmMi
KTsKICAgICAgIC8qIFRoZSBnZW5lcmF0ZWQgcmVwb3J0IG5lZWRzIHRvIGJl
IGluamVjdGVkIGZvciByZWFkLWFoZWFkIGludG8gdGhlCiAJIGZoYW5kbGVy
X2NvbnNvbGUgb2JqZWN0IGFzc29jaWF0ZWQgd2l0aCBzdGFuZGFyZCBpbnB1
dC4KLQkgVGhlIGN1cnJlbnQgY2FsbCBkb2VzIG5vdCB3b3JrLiAqLwotICAg
ICAgcHV0c19yZWFkYWhlYWQgKGJ1Zik7CisJIFNvIHB1dHNfcmVhZGFoZWFk
IGRvZXMgbm90IHdvcmsuCisJIFVzZSBhIGNvbW1vbiBjb25zb2xlIHJlYWQt
YWhlYWQgYnVmZmVyIGluc3RlYWQuICovCisgICAgICBjb24uY29uc19yYXBv
aSA9IE5VTEw7CisgICAgICBzdHJjcHkgKGNvbi5jb25zX3JhYnVmLCBidWYp
OworICAgICAgY29uLmNvbnNfcmFwb2kgPSBjb24uY29uc19yYWJ1ZjsKICAg
ICAgIGJyZWFrOwogICAgIGNhc2UgJ24nOgogICAgICAgc3dpdGNoIChjb24u
YXJnc1swXSkKQEAgLTE5MTAsOSArMTkyMiwxMSBAQCBmaGFuZGxlcl9jb25z
b2xlOjpjaGFyX2NvbW1hbmQgKGNoYXIgYykKIAkgIHkgLT0gY29uLmIuc3JX
aW5kb3cuVG9wOwogCSAgLyogeCAtPSBjb24uYi5zcldpbmRvdy5MZWZ0OwkJ
Ly8gbm90IGF2YWlsYWJsZSB5ZXQgKi8KIAkgIF9fc21hbGxfc3ByaW50ZiAo
YnVmLCAiXDAzM1slZDslZFIiLCB5ICsgMSwgeCArIDEpOwotCSAgcHV0c19y
ZWFkYWhlYWQgKGJ1Zik7CisJICBjb24uY29uc19yYXBvaSA9IE5VTEw7CisJ
ICBzdHJjcHkgKGNvbi5jb25zX3JhYnVmLCBidWYpOworCSAgY29uLmNvbnNf
cmFwb2kgPSBjb24uY29uc19yYWJ1ZjsKIAkgIGJyZWFrOwotICAgICAgZGVm
YXVsdDoKKwlkZWZhdWx0OgogCSAgZ290byBiYWRfZXNjYXBlOwogCX0KICAg
ICAgIGJyZWFrOwpkaWZmIC1ydXAgd2luc3VwL2N5Z3dpbi9vcmlnL3NlbGVj
dC5jYyB3aW5zdXAvY3lnd2luL3NlbGVjdC5jYwotLS0gd2luc3VwL2N5Z3dp
bi9vcmlnL3NlbGVjdC5jYwkyMDE2LTAyLTE4IDEzOjEwOjQ2LjAwMDAwMDAw
MCArMDAwMAorKysgd2luc3VwL2N5Z3dpbi9zZWxlY3QuY2MJMjAxNi0wMy0x
NCAxMzowOTowNy42NjEyNjk0MDAgKzAwMDAKQEAgLTg0NSw2ICs4NDUsMTIg
QEAgcGVla19jb25zb2xlIChzZWxlY3RfcmVjb3JkICptZSwgYm9vbCkKICAg
aWYgKCFtZS0+cmVhZF9zZWxlY3RlZCkKICAgICByZXR1cm4gbWUtPndyaXRl
X3JlYWR5OwogCisgIGlmIChmaC0+Z2V0X2NvbnNfcmVhZGFoZWFkX3ZhbGlk
ICgpKQorICAgIHsKKyAgICAgIHNlbGVjdF9wcmludGYgKCJjb25zX3JlYWRh
aGVhZCIpOworICAgICAgcmV0dXJuIG1lLT5yZWFkX3JlYWR5ID0gdHJ1ZTsK
KyAgICB9CisKICAgaWYgKGZoLT5nZXRfcmVhZGFoZWFkX3ZhbGlkICgpKQog
ICAgIHsKICAgICAgIHNlbGVjdF9wcmludGYgKCJyZWFkYWhlYWQiKTsK

--------------040804050008030600070703--
