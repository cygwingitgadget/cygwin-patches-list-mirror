Return-Path: <cygwin-patches-return-4521-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15111 invoked by alias); 21 Jan 2004 15:34:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15102 invoked from network); 21 Jan 2004 15:34:46 -0000
Date: Wed, 21 Jan 2004 15:34:00 -0000
From: nwourms@netscape.net
To: cygwin-patches@sources.redhat.com
Subject: [PATCH]: Fix typo in signal.cc
MIME-Version: 1.0
Message-ID: <07620143.63682571.00213C57@netscape.net>
X-AOL-IP: 130.127.121.186
Content-Type: multipart/mixed; boundary=-------7ad502b63b374597ad502b63b37459
Content-Transfer-Encoding: 8bit
X-SW-Source: 2004-q1/txt/msg00011.txt.bz2


---------7ad502b63b374597ad502b63b37459
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-length: 730

Hi All,

While resolving some conflicts with the local changes I made to signal.cc, I came across what I believe to be a typo.  There is an if-statement in the sigaction function which is empty.  FWICT, based on logic and indentation, the expression following the if-statement was intended to be the expression used when the if-statement returned true.  I'm not entirely sure what side-effects this had (if any), but hopefully it might fix something.

Cheers,
Nicholas

__________________________________________________________________
New! Unlimited Netscape Internet Service.
Only $9.95 a month -- Sign up today at http://isp.netscape.com/register
Act now to get a personalized email address!

Netscape. Just the Net You Need.

---------7ad502b63b374597ad502b63b37459
Content-Type: application/octet-stream; name="cygwin-signal_cc-typo.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cygwin-signal_cc-typo.patch"
Content-Description: cygwin-signal_cc-typo.patch
Content-length: 749

SW5kZXg6IHNpZ25hbC5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBm
aWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9zaWduYWwuY2Msdgpy
ZXRyaWV2aW5nIHJldmlzaW9uIDEuNTYKZGlmZiAtdSAtcCAtcjEuNTYgc2ln
bmFsLmNjCi0tLSBzaWduYWwuY2MJMTkgSmFuIDIwMDQgMDU6NDY6NTQgLTAw
MDAJMS41NgorKysgc2lnbmFsLmNjCTIxIEphbiAyMDA0IDE1OjE1OjI0IC0w
MDAwCkBAIC0zNzYsNyArMzc2LDcgQEAgc2lnYWN0aW9uIChpbnQgc2lnLCBj
b25zdCBzdHJ1Y3Qgc2lnYWN0aQogICAgICAgaWYgKHNpZyA9PSBTSUdDSExE
KQogCXsKIAkgIG15c2VsZi0+cHJvY2Vzc19zdGF0ZSAmPSB+UElEX05PQ0xE
U1RPUDsKLQkgIGlmIChuZXdhY3QtPnNhX2ZsYWdzICYgU0FfTk9DTERTVE9Q
KTsKKwkgIGlmIChuZXdhY3QtPnNhX2ZsYWdzICYgU0FfTk9DTERTVE9QKQog
CSAgICBteXNlbGYtPnByb2Nlc3Nfc3RhdGUgfD0gUElEX05PQ0xEU1RPUDsK
IAl9CiAgICAgfQo=

---------7ad502b63b374597ad502b63b37459
Content-Type: text/plain; name="ChangeLog.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="ChangeLog.txt"
Content-Description: ChangeLog.txt
Content-length: 105

2004-01-21  Nicholas Wourms  <nwourms@netscape.net>

    * signal.cc (sigaction): Fix if-statement typo.

---------7ad502b63b374597ad502b63b37459--
