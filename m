Return-Path: <cygwin-patches-return-8407-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 122225 invoked by alias); 15 Mar 2016 13:17:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 122206 invoked by uid 89); 15 Mar 2016 13:17:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=4.0 required=5.0 tests=AWL,BAYES_50,GARBLED_SUBJECT,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=separated, work, work!, Wolff
X-HELO: demumfd001.nsn-inter.net
Received: from demumfd001.nsn-inter.net (HELO demumfd001.nsn-inter.net) (93.183.12.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 15 Mar 2016 13:17:04 +0000
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])	by demumfd001.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id u2FDH0u9014208	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Tue, 15 Mar 2016 13:17:01 GMT
Received: from [10.149.163.250] ([10.149.163.250])	by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id u2FDGxdD019471	for <cygwin-patches@cygwin.com>; Tue, 15 Mar 2016 14:17:00 +0100
Subject: =?UTF-8?Q?Console_requested_reports_=e2=80=93_Re:_[ANNOUNCEMENT]_TE?= =?UTF-8?Q?ST_RELEASE:_Cygwin_2.5.0-0.6?=
To: cygwin-patches@cygwin.com
References: <announce.20160312232737.GA25791@calimero.vinschen.de>
From: Thomas Wolff <towo@towo.net>
Message-ID: <56E80B4B.5040106@towo.net>
Date: Tue, 15 Mar 2016 13:17:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <announce.20160312232737.GA25791@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------000900010405010403090701"
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 6004
X-purgate-ID: 151667::1458047821-00007057-82FFAE06/0/0
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00113.txt.bz2

This is a multi-part message in MIME format.
--------------000900010405010403090701
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-length: 1147

On 13.03.2016, Corinna Vinschen wrote:
> - Make buffered console characters visible to select().
>    Addresses: https://cygwin.com/ml/cygwin/2014-12/msg00118.html
Triggered by this change, I thought I'd revisit an old problem 
(https://cygwin.com/ml/cygwin-patches/2012-q3/msg00019.html),
and in fact â requested console reports now work!
This makes the following ESC sequences work:
ESC[c sends primary device attributes
ESC[>c sends secondary device attributes
ESC[6n sends cursor position report

Changelog (old format):
2016-03-15  Thomas Wolff  <towo@towo.net>

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

--------------000900010405010403090701
Content-Type: text/plain; charset=UTF-8;
 name="terminal-requests.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="terminal-requests.patch"
Content-length: 4340

ZGlmZiAtcnVwIHdpbnN1cC9jeWd3aW4vb3JpZy9maGFuZGxlci5oIHdpbnN1
cC9jeWd3aW4vZmhhbmRsZXIuaAotLS0gd2luc3VwL2N5Z3dpbi9vcmlnL2Zo
YW5kbGVyLmgJMjAxNi0wMy0xMCAxNzozMDo0MC4wMDAwMDAwMDAgKzAwMDAK
KysrIHdpbnN1cC9jeWd3aW4vZmhhbmRsZXIuaAkyMDE2LTAzLTE0IDEzOjA4
OjE0LjU0NTk1ODQwMCArMDAwMApAQCAtMTM1Miw2ICsxMzUyLDggQEAgY2xh
c3MgZGV2X2NvbnNvbGUKICAgYm9vbCBleHRfbW91c2VfbW9kZTE1OwogICBi
b29sIHVzZV9mb2N1czsKICAgYm9vbCByYXdfd2luMzJfa2V5Ym9hcmRfbW9k
ZTsKKyAgY2hhciBjb25zX3JhYnVmWzQwXTsKKyAgY2hhciAqIGNvbnNfcmFw
b2k7CiAKICAgaW5saW5lIFVJTlQgZ2V0X2NvbnNvbGVfY3AgKCk7CiAgIERX
T1JEIGNvbl90b19zdHIgKGNoYXIgKmQsIGludCBkbGVuLCBXQ0hBUiB3KTsK
QEAgLTE0NDksNiArMTQ1MSw3IEBAIHByaXZhdGU6CiAgIGludCBpbml0IChI
QU5ETEUsIERXT1JELCBtb2RlX3QpOwogICBib29sIG1vdXNlX2F3YXJlIChN
T1VTRV9FVkVOVF9SRUNPUkQmIG1vdXNlX2V2ZW50KTsKICAgYm9vbCBmb2N1
c19hd2FyZSAoKSB7cmV0dXJuIHNoYXJlZF9jb25zb2xlX2luZm8tPmNvbi51
c2VfZm9jdXM7fQorICBib29sIGdldF9jb25zX3JlYWRhaGVhZF92YWxpZCAo
KSB7IHJldHVybiBzaGFyZWRfY29uc29sZV9pbmZvLT5jb24uY29uc19yYXBv
aSAhPSAwOyB9CiAKICAgc2VsZWN0X3JlY29yZCAqc2VsZWN0X3JlYWQgKHNl
bGVjdF9zdHVmZiAqKTsKICAgc2VsZWN0X3JlY29yZCAqc2VsZWN0X3dyaXRl
IChzZWxlY3Rfc3R1ZmYgKik7CmRpZmYgLXJ1cCB3aW5zdXAvY3lnd2luL29y
aWcvZmhhbmRsZXJfY29uc29sZS5jYyB3aW5zdXAvY3lnd2luL2ZoYW5kbGVy
X2NvbnNvbGUuY2MKLS0tIHdpbnN1cC9jeWd3aW4vb3JpZy9maGFuZGxlcl9j
b25zb2xlLmNjCTIwMTYtMDEtMTIgMTQ6Mzk6NTIuMDAwMDAwMDAwICswMDAw
CisrKyB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2NvbnNvbGUuY2MJMjAxNi0w
My0xNSAxMzoxMjoyOS4yNzM2MTIyMDAgKzAwMDAKQEAgLTE5Niw2ICsxOTYs
NyBAQCBmaGFuZGxlcl9jb25zb2xlOjpzZXR1cCAoKQogCSAgY29uLm1ldGFf
bWFzayB8PSBSSUdIVF9BTFRfUFJFU1NFRDsKIAljb24uc2V0X2RlZmF1bHRf
YXR0ciAoKTsKIAljb24uYmFja3NwYWNlX2tleWNvZGUgPSBDRVJBU0U7CisJ
Y29uLmNvbnNfcmFwb2kgPSAwOwogCXNoYXJlZF9jb25zb2xlX2luZm8tPnR0
eV9taW5fc3RhdGUuaXNfY29uc29sZSA9IHRydWU7CiAgICAgICB9CiB9CkBA
IC0zMTAsNiArMzExLDE0IEBAIGZoYW5kbGVyX2NvbnNvbGU6OnJlYWQgKHZv
aWQgKnB2LCBzaXplX3QKICAgaW50IGNoOwogICBzZXRfaW5wdXRfc3RhdGUg
KCk7CiAKKyAgLyogQ2hlY2sgY29uc29sZSByZWFkLWFoZWFkIGJ1ZmZlciBm
aWxsZWQgZnJvbSB0ZXJtaW5hbCByZXF1ZXN0cyAqLworICBpZiAoY29uLmNv
bnNfcmFwb2kgJiYgKiBjb24uY29uc19yYXBvaSkKKyAgICB7CisgICAgICAq
IGJ1ZiA9ICogY29uLmNvbnNfcmFwb2kgKys7CisgICAgICBidWZsZW4gPSAx
OworICAgICAgcmV0dXJuOworICAgIH0KKwogICBpbnQgY29waWVkX2NoYXJz
ID0gZ2V0X3JlYWRhaGVhZF9pbnRvX2J1ZmZlciAoYnVmLCBidWZsZW4pOwog
CiAgIGlmIChjb3BpZWRfY2hhcnMpCkBAIC0xODk5LDggKzE5MDgsMTIgQEAg
ZmhhbmRsZXJfY29uc29sZTo6Y2hhcl9jb21tYW5kIChjaGFyIGMpCiAJc3Ry
Y3B5IChidWYsICJcMDMzWz82YyIpOwogICAgICAgLyogVGhlIGdlbmVyYXRl
ZCByZXBvcnQgbmVlZHMgdG8gYmUgaW5qZWN0ZWQgZm9yIHJlYWQtYWhlYWQg
aW50byB0aGUKIAkgZmhhbmRsZXJfY29uc29sZSBvYmplY3QgYXNzb2NpYXRl
ZCB3aXRoIHN0YW5kYXJkIGlucHV0LgotCSBUaGUgY3VycmVudCBjYWxsIGRv
ZXMgbm90IHdvcmsuICovCi0gICAgICBwdXRzX3JlYWRhaGVhZCAoYnVmKTsK
KwkgU28gcHV0c19yZWFkYWhlYWQgZG9lcyBub3Qgd29yay4gKi8KKyAgICAg
IC8vcHV0c19yZWFkYWhlYWQgKGJ1Zik7CisgICAgICAvKiBVc2UgYSBjb21t
b24gY29uc29sZSByZWFkLWFoZWFkIGJ1ZmZlciBpbnN0ZWFkLiAqLworICAg
ICAgY29uLmNvbnNfcmFwb2kgPSAwOworICAgICAgc3RyY3B5IChjb24uY29u
c19yYWJ1ZiwgYnVmKTsKKyAgICAgIGNvbi5jb25zX3JhcG9pID0gY29uLmNv
bnNfcmFidWY7CiAgICAgICBicmVhazsKICAgICBjYXNlICduJzoKICAgICAg
IHN3aXRjaCAoY29uLmFyZ3NbMF0pCkBAIC0xOTEwLDcgKzE5MjMsMTAgQEAg
ZmhhbmRsZXJfY29uc29sZTo6Y2hhcl9jb21tYW5kIChjaGFyIGMpCiAJICB5
IC09IGNvbi5iLnNyV2luZG93LlRvcDsKIAkgIC8qIHggLT0gY29uLmIuc3JX
aW5kb3cuTGVmdDsJCS8vIG5vdCBhdmFpbGFibGUgeWV0ICovCiAJICBfX3Nt
YWxsX3NwcmludGYgKGJ1ZiwgIlwwMzNbJWQ7JWRSIiwgeSArIDEsIHggKyAx
KTsKLQkgIHB1dHNfcmVhZGFoZWFkIChidWYpOworCSAgLy9wdXRzX3JlYWRh
aGVhZCAoYnVmKTsKKwkgIGNvbi5jb25zX3JhcG9pID0gMDsKKwkgIHN0cmNw
eSAoY29uLmNvbnNfcmFidWYsIGJ1Zik7CisJICBjb24uY29uc19yYXBvaSA9
IGNvbi5jb25zX3JhYnVmOwogCSAgYnJlYWs7CiAgICAgICBkZWZhdWx0Ogog
CSAgZ290byBiYWRfZXNjYXBlOwpkaWZmIC1ydXAgd2luc3VwL2N5Z3dpbi9v
cmlnL3NlbGVjdC5jYyB3aW5zdXAvY3lnd2luL3NlbGVjdC5jYwotLS0gd2lu
c3VwL2N5Z3dpbi9vcmlnL3NlbGVjdC5jYwkyMDE2LTAyLTE4IDEzOjEwOjQ2
LjAwMDAwMDAwMCArMDAwMAorKysgd2luc3VwL2N5Z3dpbi9zZWxlY3QuY2MJ
MjAxNi0wMy0xNCAxMzowOTowNy42NjEyNjk0MDAgKzAwMDAKQEAgLTg0NSw2
ICs4NDUsMTIgQEAgcGVla19jb25zb2xlIChzZWxlY3RfcmVjb3JkICptZSwg
Ym9vbCkKICAgaWYgKCFtZS0+cmVhZF9zZWxlY3RlZCkKICAgICByZXR1cm4g
bWUtPndyaXRlX3JlYWR5OwogCisgIGlmIChmaC0+Z2V0X2NvbnNfcmVhZGFo
ZWFkX3ZhbGlkICgpKQorICAgIHsKKyAgICAgIHNlbGVjdF9wcmludGYgKCJj
b25zX3JlYWRhaGVhZCIpOworICAgICAgcmV0dXJuIG1lLT5yZWFkX3JlYWR5
ID0gdHJ1ZTsKKyAgICB9CisKICAgaWYgKGZoLT5nZXRfcmVhZGFoZWFkX3Zh
bGlkICgpKQogICAgIHsKICAgICAgIHNlbGVjdF9wcmludGYgKCJyZWFkYWhl
YWQiKTsK

--------------000900010405010403090701--
