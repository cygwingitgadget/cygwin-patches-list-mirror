Return-Path: <cygwin-patches-return-2392-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27604 invoked by alias); 12 Jun 2002 01:19:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27554 invoked from network); 12 Jun 2002 01:19:34 -0000
Date: Tue, 11 Jun 2002 18:19:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
X-X-Sender: joshua@iocc.com
To: cygwin-patches@cygwin.com
Subject: passwd edited /etc/passwd patch
Message-ID: <Pine.CYG.4.44.0206112017330.772-200000@iocc.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-726625162-1023844695=:772"
X-SW-Source: 2002-q2/txt/msg00375.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-726625162-1023844695=:772
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 472

Here is that patch for passwd.c to deal with user-edited /etc/passwd
files. I poked around about adding the CW_EXTRACT_DOMAIN_AND_USER
then did a CVS update and Corinna already had done it. Sorry for the
delay, I apparently haven't been paying attention for more than a week...

ChangeLog:

2002-06-11  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

	* passwd.c (GetPW): Handle case of user-edited /etc/passwd
	with cygwin_internal (CW_EXTRACT_DOMAIN_AND_USER, ...)


---559023410-726625162-1023844695=:772
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="passwd.c-patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.44.0206112018150.772@iocc.com>
Content-Description: 
Content-Disposition: attachment; filename="passwd.c-patch"
Content-length: 1416

LS0tIHBhc3N3ZC5jLW9yaWcJVHVlIEp1biAxMSAyMDoxMzo1MSAyMDAyDQor
KysgcGFzc3dkLmMJVHVlIEp1biAxMSAxOTo1OToxNyAyMDAyDQpAQCAtMTYs
NiArMTYsNyBAQCBkZXRhaWxzLiAqLw0KICNpbmNsdWRlIDx1bmlzdGQuaD4N
CiAjaW5jbHVkZSA8Z2V0b3B0Lmg+DQogI2luY2x1ZGUgPHB3ZC5oPg0KKyNp
bmNsdWRlIDxzeXMvY3lnd2luLmg+DQogI2luY2x1ZGUgPHN5cy90eXBlcy5o
Pg0KICNpbmNsdWRlIDx0aW1lLmg+DQogDQpAQCAtMTA3LDkgKzEwOCwyMSBA
QCBHZXRQVyAoY29uc3QgY2hhciAqdXNlcikNCiAgIFdDSEFSIG5hbWVbNTEy
XTsNCiAgIERXT1JEIHJldDsNCiAgIFBVU0VSX0lORk9fMyB1aTsNCi0NCisg
IHN0cnVjdCBwYXNzd2QgKnB3Ow0KKyAgY2hhciAqZG9tYWluID0gKGNoYXIg
KikgbWFsbG9jIChNQVhfUEFUSCArIDEpOw0KKyAgICAgDQogICBNdWx0aUJ5
dGVUb1dpZGVDaGFyIChDUF9BQ1AsIDAsIHVzZXIsIC0xLCBuYW1lLCA1MTIp
Ow0KICAgcmV0ID0gTmV0VXNlckdldEluZm8gKE5VTEwsIG5hbWUsIDMsIChM
UEJZVEUgKikgJnVpKTsNCisgIC8qIFRyeSBnZXR0aW5nIGEgV2luMzIgdXNl
cm5hbWUgaW4gY2FzZSB0aGUgdXNlciBlZGl0ZWQgL2V0Yy9wYXNzd2QgKi8N
CisgIGlmIChyZXQgPT0gTkVSUl9Vc2VyTm90Rm91bmQpDQorICB7DQorICAg
IGlmICgocHcgPSBnZXRwd25hbSAodXNlcikpKQ0KKyAgICAgIGN5Z3dpbl9p
bnRlcm5hbCAoQ1dfRVhUUkFDVF9ET01BSU5fQU5EX1VTRVIsIHB3LCBkb21h
aW4sIChjaGFyICopIHVzZXIpOw0KKyAgICBNdWx0aUJ5dGVUb1dpZGVDaGFy
IChDUF9BQ1AsIDAsIHVzZXIsIC0xLCBuYW1lLCA1MTIpOw0KKyAgICByZXQg
PSBOZXRVc2VyR2V0SW5mbyAoTlVMTCwgbmFtZSwgMywgKExQQllURSAqKSAm
dWkpOw0KKyAgICBpZiAocmV0ID09IChpbnQpIE5VTEwpDQorICAgICAgcHJp
bnRmICgiV2luZG93cyB1c2VybmFtZSA6ICVzXG4iLCB1c2VyKTsNCisgIH0N
CiAgIHJldHVybiBFdmFsUmV0IChyZXQsIHVzZXIpID8gTlVMTCA6IHVpOw0K
IH0NCiANCg==

---559023410-726625162-1023844695=:772--
