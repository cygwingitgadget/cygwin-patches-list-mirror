Return-Path: <cygwin-patches-return-4031-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25325 invoked by alias); 1 Aug 2003 00:57:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25312 invoked from network); 1 Aug 2003 00:57:06 -0000
Date: Fri, 01 Aug 2003 00:57:00 -0000
From: Pavel Tsekov <ptsekov@gmx.net>
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary101171059699425"
Subject: [PATCH] Add support for ioctl TIOCLINUX, function 6 (get key modifiers) on a TTY
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0014308112@gmx.net
X-Authenticated-IP: [217.110.54.90]
Message-ID: <10117.1059699425@www61.gmx.net>
X-Flags: 0001
X-SW-Source: 2003-q3/txt/msg00047.txt.bz2

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary101171059699425
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-length: 1545

Hello,

I'm suggesting the following patch wich allows keyboard modifiers (CTRL,
SHIFT, ALT) to be retrieved by applications that might need them using an ioctl
command - MC is one of them. I don't really care if the name used will be
TIOCLINUX, I am open to suggestions what the proper name might for the ioctl
control code should be. In fact I have coded an alternative patch that uses
cygwin_internal () to retrieve the data but I dont feel too comfortable with it
since it seems too Cygwin specific - in any case I prefer the ioctl way of
doing things but as I said I have an alternative just in case. The attached
patch is pretty much non-intrusive, while the one employing cygwin_internal ()
adds a new member to the tty_min structure thus changing the shared memory
footprint and I consider it too intrusive.

Please, review and share your thoughts :)

2003-08-01  Pavel Tsekov  <ptsekov@gmx.net>

	* fhandler_console.c (fhandler_console::read): Record the state of the
SHIFT, CTRL and
	ALT keys at the time of the last keyboard input event.
	(fhandler_console::ioctl): Handle requests to retrieve the keyboard
modifiers via the
	TIOCLINUX command.
	* fhandler_tty.c (fhandler_tty_slave::read): Ditto.
	* include/sys/termios.h (TIOCLINUX): New macro definition.

-- 
COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post
--========GMXBoundary101171059699425
Content-Type: text/plain; name="tioclinux.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="tioclinux.patch"
Content-length: 4921

SW5kZXg6IGZoYW5kbGVyX2NvbnNvbGUuY2MKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vZmhh
bmRsZXJfY29uc29sZS5jYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xMTEK
ZGlmZiAtdSAtcCAtcjEuMTExIGZoYW5kbGVyX2NvbnNvbGUuY2MKLS0tIGZo
YW5kbGVyX2NvbnNvbGUuY2MJMTYgSnVuIDIwMDMgMDM6MjQ6MTAgLTAwMDAJ
MS4xMTEKKysrIGZoYW5kbGVyX2NvbnNvbGUuY2MJMSBBdWcgMjAwMyAwMDoz
MDo1NCAtMDAwMApAQCAtMjk0LDYgKzI5NCw4IEBAIGZoYW5kbGVyX2NvbnNv
bGU6OnJlYWQgKHZvaWQgKnB2LCBzaXplX3QKICNkZWZpbmUgdmlydHVhbF9r
ZXlfY29kZSAoaW5wdXRfcmVjLkV2ZW50LktleUV2ZW50LndWaXJ0dWFsS2V5
Q29kZSkKICNkZWZpbmUgY29udHJvbF9rZXlfc3RhdGUgKGlucHV0X3JlYy5F
dmVudC5LZXlFdmVudC5kd0NvbnRyb2xLZXlTdGF0ZSkKIAorCSAgZGV2X3N0
YXRlLT5uTW9kaWZpZXJzID0gMDsKKwogI2lmZGVmIERFQlVHR0lORwogCSAg
LyogYWxsb3cgbWFudWFsIHN3aXRjaGluZyB0by9mcm9tIHJhdyBtb2RlIHZp
YSBjdHJsLWFsdC1zY3JvbGxsb2NrICovCiAJICBpZiAoaW5wdXRfcmVjLkV2
ZW50LktleUV2ZW50LmJLZXlEb3duICYmCkBAIC0zNDAsMTMgKzM0MiwyNSBA
QCBmaGFuZGxlcl9jb25zb2xlOjpyZWFkICh2b2lkICpwdiwgc2l6ZV90CiAJ
CSYmIGlucHV0X3JlYy5FdmVudC5LZXlFdmVudC53VmlydHVhbFNjYW5Db2Rl
ID09IDB4MzgpKQogCSAgICBjb250aW51ZTsKIAorCSAgaWYgKGNvbnRyb2xf
a2V5X3N0YXRlICYgU0hJRlRfUFJFU1NFRCkKKwkgICAgZGV2X3N0YXRlLT5u
TW9kaWZpZXJzIHw9IDE7CisJICBpZiAoY29udHJvbF9rZXlfc3RhdGUgJiBS
SUdIVF9BTFRfUFJFU1NFRCkKKwkgICAgZGV2X3N0YXRlLT5uTW9kaWZpZXJz
IHw9IDI7CisJICBpZiAoY29udHJvbF9rZXlfc3RhdGUgJiBDVFJMX1BSRVNT
RUQpCisJICAgIGRldl9zdGF0ZS0+bk1vZGlmaWVycyB8PSA0OworCSAgaWYg
KGNvbnRyb2xfa2V5X3N0YXRlICYgTEVGVF9BTFRfUFJFU1NFRCkKKwkgICAg
ZGV2X3N0YXRlLT5uTW9kaWZpZXJzIHw9IDg7CisKIAkgIGlmICh3Y2ggPT0g
MCB8fAogCSAgICAgIC8qIGFycm93L2Z1bmN0aW9uIGtleXMgKi8KIAkgICAg
ICAoaW5wdXRfcmVjLkV2ZW50LktleUV2ZW50LmR3Q29udHJvbEtleVN0YXRl
ICYgRU5IQU5DRURfS0VZKSkKIAkgICAgewogCSAgICAgIHRvYWRkID0gZ2V0
X25vbmFzY2lpX2tleSAoaW5wdXRfcmVjLCB0bXApOwogCSAgICAgIGlmICgh
dG9hZGQpCi0JCWNvbnRpbnVlOworCQl7CisJCSAgZGV2X3N0YXRlLT5uTW9k
aWZpZXJzID0gMDsKKwkJICBjb250aW51ZTsKKwkJfQogCSAgICAgIG5yZWFk
ID0gc3RybGVuICh0b2FkZCk7CiAJICAgIH0KIAkgIGVsc2UKQEAgLTM3OSw2
ICszOTMsNyBAQCBmaGFuZGxlcl9jb25zb2xlOjpyZWFkICh2b2lkICpwdiwg
c2l6ZV90CiAJCSAgdG1wWzFdID0gY3lnX3RvbG93ZXIgKHRtcFsxXSk7CiAJ
CSAgdG9hZGQgPSB0bXA7CiAJCSAgbnJlYWQrKzsKKwkJICBkZXZfc3RhdGUt
Pm5Nb2RpZmllcnMgJj0gfjQ7CiAJCX0KIAkgICAgfQogI3VuZGVmIGljaApA
QCAtNzE1LDYgKzczMCwxNyBAQCBmaGFuZGxlcl9jb25zb2xlOjppb2N0bCAo
dW5zaWduZWQgaW50IGNtCiAgICAgICBjYXNlIFRJT0NTV0lOU1o6CiAJKHZv
aWQpIGJnX2NoZWNrIChTSUdUVE9VKTsKIAlyZXR1cm4gMDsKKyAgICAgIGNh
c2UgVElPQ0xJTlVYOgorCWlmICgqIChpbnQgKikgYnVmID09IDYpCisJICB7
CisJICAgICogKGludCAqKSBidWYgPSBkZXZfc3RhdGUtPm5Nb2RpZmllcnM7
CisJICAgIHJldHVybiAwOworCSAgfQorCWVsc2UKKwkgIHsKKwkgICAgc2V0
X2Vycm5vIChFSU5WQUwpOworCSAgICByZXR1cm4gLTE7CisJICB9CiAgICAg
fQogCiAgIHJldHVybiBmaGFuZGxlcl9iYXNlOjppb2N0bCAoY21kLCBidWYp
OwpJbmRleDogZmhhbmRsZXJfdHR5LmNjCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2ZoYW5k
bGVyX3R0eS5jYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xMDEKZGlmZiAt
dSAtcCAtcjEuMTAxIGZoYW5kbGVyX3R0eS5jYwotLS0gZmhhbmRsZXJfdHR5
LmNjCTI2IEp1bCAyMDAzIDA0OjUzOjU5IC0wMDAwCTEuMTAxCisrKyBmaGFu
ZGxlcl90dHkuY2MJMSBBdWcgMjAwMyAwMDozMDo1OCAtMDAwMApAQCAtOTkx
LDYgKzk5MSw3IEBAIGZoYW5kbGVyX3R0eV9zbGF2ZTo6aW9jdGwgKHVuc2ln
bmVkIGludCAKICAgICB7CiAgICAgY2FzZSBUSU9DR1dJTlNaOgogICAgIGNh
c2UgVElPQ1NXSU5TWjoKKyAgICBjYXNlIFRJT0NMSU5VWDoKICAgICAgIGJy
ZWFrOwogICAgIGNhc2UgRklPTkJJTzoKICAgICAgIHNldF9ub25ibG9ja2lu
ZyAoKihpbnQgKikgYXJnKTsKQEAgLTEwMzIsNiArMTAzMywyMSBAQCBmaGFu
ZGxlcl90dHlfc2xhdmU6OmlvY3RsICh1bnNpZ25lZCBpbnQgCiAJICAgIH0K
IAkgIGlmIChpb2N0bF9kb25lX2V2ZW50KQogCSAgICBXYWl0Rm9yU2luZ2xl
T2JqZWN0IChpb2N0bF9kb25lX2V2ZW50LCBJTkZJTklURSk7CisJfQorICAg
ICAgYnJlYWs7CisgICAgY2FzZSBUSU9DTElOVVg6CisgICAgICBpbnQgdmFs
ID0gKiAodW5zaWduZWQgY2hhciAqKSBhcmc7CisgICAgICBpZiAodmFsID09
IDYgJiYgaW9jdGxfcmVxdWVzdF9ldmVudCAmJiBpb2N0bF9kb25lX2V2ZW50
KQorCXsKKwkgIGdldF90dHlwICgpLT5hcmcudmFsdWUgPSB2YWw7IAorCSAg
U2V0RXZlbnQgKGlvY3RsX3JlcXVlc3RfZXZlbnQpOworCSAgV2FpdEZvclNp
bmdsZU9iamVjdCAoaW9jdGxfZG9uZV9ldmVudCwgSU5GSU5JVEUpOworCSAg
KiAodW5zaWduZWQgY2hhciAqKSBhcmcgPSBnZXRfdHR5cCAoKS0+YXJnLnZh
bHVlICYgMHhGRjsKKwl9CisgICAgICBlbHNlCisJeworCSAgZ2V0X3R0eXAg
KCktPmlvY3RsX3JldHZhbCA9IC0xOworCSAgc2V0X2Vycm5vIChFSU5WQUwp
OwogCX0KICAgICAgIGJyZWFrOwogICAgIH0KSW5kZXg6IGluY2x1ZGUvc3lz
L3Rlcm1pb3MuaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAv
Y3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL3N5cy90ZXJtaW9z
LmgsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNwpkaWZmIC11IC1wIC1yMS43
IHRlcm1pb3MuaAotLS0gaW5jbHVkZS9zeXMvdGVybWlvcy5oCTEwIEphbiAy
MDAzIDEyOjMyOjQ5IC0wMDAwCTEuNworKysgaW5jbHVkZS9zeXMvdGVybWlv
cy5oCTEgQXVnIDIwMDMgMDA6MzE6MDIgLTAwMDAKQEAgLTMzMCw1ICszMzAs
NiBAQCBzdHJ1Y3Qgd2luc2l6ZQogCiAjZGVmaW5lIFRJT0NHV0lOU1ogKCgn
VCcgPDwgOCkgfCAxKQogI2RlZmluZSBUSU9DU1dJTlNaICgoJ1QnIDw8IDgp
IHwgMikKKyNkZWZpbmUgVElPQ0xJTlVYICAoKCdUJyA8PCA4KSB8IDMpCiAK
ICNlbmRpZgkvKiBfU1lTX1RFUk1JT1NfSCAqLwo=

--========GMXBoundary101171059699425--
