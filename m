Return-Path: <cygwin-patches-return-2277-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6862 invoked by alias); 31 May 2002 02:13:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6835 invoked from network); 31 May 2002 02:13:45 -0000
Date: Thu, 30 May 2002 19:13:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
X-X-Sender: joshua@iocc.com
To: cygwin-patches@cygwin.com
Subject: Re: passwd help/version patch
Message-ID: <Pine.CYG.4.44.0205302054340.1492-200000@iocc.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1410507888-1022810962=:1492"
X-SW-Source: 2002-q2/txt/msg00260.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1410507888-1022810962=:1492
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 2643

--- Corinna Vinschen <cygwin-patches@cygwin.com> wrote:
> > > Or perhaps change passwd to take the Cygwin name and
> > > convert it to the windows name???
> > >
> > > Corinna
> >
> > Maybe I'm missing something, but there doesn't seem to be any Win32
> > function to get a username from a uid other than NetUserEnum, but
> > I really don't think people running 'passwd bob' are wanting to enum
> > all users. The code to do it wouldn't be that hard, but it wouldn't
> > work for those people with domains (unless they specify a domain like
> > for mkpasswd).
> >
> > Maybe mkpasswd should cache the info somewhere other than just /etc/passwd
> > for this purpose? Or use the GECOS field?
>
> I'm sorry if my mail wasn't clear but I just asked for getting the
> Win32 name from the cygwin name.  The cygwin name is the one given
> on the command line or what is returned by getlogin().  The information
> about the Win32 name is then returned in the pw_gecos field by
> getpwnam().  Either a U-DOMAIN\NAME or a S-1-5-xxx sid.  If the
> U- field is given, it contains the name, otherwise a LookupAccountSid()
> gives the Win32 name from the SID.  If neither is given, the Cygwin
> username is equal to the Win32 name.
>
> There is already a function `extract_nt_dom_user()' in Cygwin, file
> security.cc which contains this functionality.  Unfortunately it
> isn't exported so it would have to be copied to passwd.c (and
> transformed to plain c).
>
> Or we export that function.  I think it is a useful functionality for
> Cygwin tools.  Perhaps with the "cygwin_" prefix.
>
> Corinna

Thanks very much for the pointers. However,
After working on it a while, I think that exporting a
cygwin_extract_nt_dom_user() would be best. The attached patch is a
halfway solution that just copies most of extract_nt_dom_user()
other than the SID code. It will get the correct username in the case of
a U-DOMAIN type of GECOS, but if only a ':S-1-5-xxx:' is in the GECOS
it fails with the old 'passwd: unknown user boalhg' message.
If a Win32 username is found, a line like: 'Windows username : bob'
is output.

I tried to build up the structures necessary for LookupAccountSid()
with the sec* stuff in winsup/cygwin as a guide, but it looks like
reinventing a C wheel from C++ spare parts. It'd be a lot better to
be able to just put cygwin_extract_nt_dom_user(pw, domain, (char *) user)
right in passwd.c IMHO.

Caveat: I don't have a real domain that I'm testing with.

2002-05-30  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

	* passwd.c (extract_nt_dom_user): New function.
	(GetPW): Try to look up Win32 username in case of NERR_UserNotFound.

---559023410-1410507888-1022810962=:1492
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="passwd.c-patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.44.0205302109220.1492@iocc.com>
Content-Description: 
Content-Disposition: attachment; filename="passwd.c-patch"
Content-length: 2778

LS0tIHBhc3N3ZC5jLW9yaWcJVGh1IE1heSAzMCAyMDowNTowNSAyMDAyDQor
KysgcGFzc3dkLmMJVGh1IE1heSAzMCAyMDo1NDoxMCAyMDAyDQpAQCAtMjgs
NiArMjgsNyBAQCBkZXRhaWxzLiAqLw0KICNkZWZpbmUgVVNFUl9QUklWX0FE
TUlOCQkgMg0KIA0KICNkZWZpbmUgVUZfTE9DS09VVCAgICAgICAgICAgIDB4
MDAwMTANCisjZGVmaW5lIElOVEVSTkVUX01BWF9IT1NUX05BTUVfTEVOR1RI
IDI1Ng0KIA0KIHN0YXRpYyBjb25zdCBjaGFyIHZlcnNpb25bXSA9ICIkUmV2
aXNpb246IDEuNCAkIjsNCiBzdGF0aWMgY2hhciAqcHJvZ19uYW1lOw0KQEAg
LTEwMSwxNSArMTAyLDY2IEBAIEV2YWxSZXQgKGludCByZXQsIGNvbnN0IGNo
YXIgKnVzZXIpDQogICByZXR1cm4gMTsNCiB9DQogDQordm9pZA0KK2V4dHJh
Y3RfbnRfZG9tX3VzZXIgKGNvbnN0IHN0cnVjdCBwYXNzd2QgKnB3LCBjaGFy
ICpkb21haW4sIGNoYXIgKnVzZXIpDQorew0KKyAgY2hhciBidWZbSU5URVJO
RVRfTUFYX0hPU1RfTkFNRV9MRU5HVEggKyBVTkxFTiArIDJdOw0KKyAgY2hh
ciAqYzsNCisNCisgIHN0cmNweSAoZG9tYWluLCAiIik7DQorICBzdHJjcHkg
KGJ1ZiwgcHctPnB3X25hbWUpOw0KKw0KKyAgaWYgKChwdyAmJiBwdy0+cHdf
Z2Vjb3MpICYmIChzdHJyY2hyIChwdy0+cHdfZ2Vjb3MsICcsJykgPT0gTlVM
TCkpDQorICB7DQorICAgIHJldHVybjsNCisgIH0NCisNCisgIGlmIChwdy0+
cHdfZ2Vjb3MpDQorICAgIHsNCisgICAgICBpZiAoKGMgPSBzdHJzdHIgKHB3
LT5wd19nZWNvcywgIlUtIikpICE9IE5VTEwgJiYNCisgICAgICAgICAgKGMg
PT0gcHctPnB3X2dlY29zIHx8IGNbLTFdID09ICcsJykpDQorICAgICAgICB7
DQorICAgICAgICAgIGJ1ZlswXSA9ICdcMCc7DQorICAgICAgICAgIHN0cm5j
YXQgKGJ1ZiwgYyArIDIsIElOVEVSTkVUX01BWF9IT1NUX05BTUVfTEVOR1RI
ICsgVU5MRU4gKyAxKTsNCisgICAgICAgICAgaWYgKChjID0gc3RyY2hyIChi
dWYsICcsJykpICE9IE5VTEwpDQorICAgICAgICAgICAgKmMgPSAnXDAnOw0K
KyAgICAgICAgfQ0KKyAgICB9DQorICBpZiAoKGMgPSBzdHJjaHIgKGJ1Ziwg
J1xcJykpICE9IE5VTEwpDQorICAgIHsNCisgICAgICAqYysrID0gJ1wwJzsN
CisgICAgICBzdHJjcHkgKGRvbWFpbiwgYnVmKTsNCisgICAgICBzdHJjcHkg
KHVzZXIsIGMpOw0KKyAgICB9DQorICBlbHNlDQorICAgIHsNCisgICAgICBz
dHJjcHkgKGRvbWFpbiwgIiIpOw0KKyAgICAgIHN0cmNweSAodXNlciwgYnVm
KTsNCisgICAgfQ0KK30NCisNCiBQVVNFUl9JTkZPXzMNCiBHZXRQVyAoY29u
c3QgY2hhciAqdXNlcikNCiB7DQogICBXQ0hBUiBuYW1lWzUxMl07DQogICBE
V09SRCByZXQ7DQogICBQVVNFUl9JTkZPXzMgdWk7DQotDQorICBzdHJ1Y3Qg
cGFzc3dkICpwdzsNCisgIGNoYXIgKmRvbWFpbiA9IChjaGFyICopIG1hbGxv
YyAoTUFYX1BBVEggKyAxKTsNCisgICAgDQogICBNdWx0aUJ5dGVUb1dpZGVD
aGFyIChDUF9BQ1AsIDAsIHVzZXIsIC0xLCBuYW1lLCA1MTIpOw0KICAgcmV0
ID0gTmV0VXNlckdldEluZm8gKE5VTEwsIG5hbWUsIDMsIChMUEJZVEUgKikg
JnVpKTsNCisgIC8qIFRyeSBnZXR0aW5nIGEgV2luMzIgdXNlcm5hbWUgaW4g
Y2FzZSB0aGUgdXNlciBlZGl0ZWQgL2V0Yy9wYXNzd2QgKi8NCisgIGlmIChy
ZXQgPT0gTkVSUl9Vc2VyTm90Rm91bmQpDQorICB7DQorICAgIGlmICgocHcg
PSBnZXRwd25hbSAodXNlcikpKQ0KKyAgICAgIGV4dHJhY3RfbnRfZG9tX3Vz
ZXIgKHB3LCBkb21haW4sIChjaGFyICopIHVzZXIpOw0KKyAgICBNdWx0aUJ5
dGVUb1dpZGVDaGFyIChDUF9BQ1AsIDAsIHVzZXIsIC0xLCBuYW1lLCA1MTIp
Ow0KKyAgICByZXQgPSBOZXRVc2VyR2V0SW5mbyAoTlVMTCwgbmFtZSwgMywg
KExQQllURSAqKSAmdWkpOw0KKyAgICBpZiAocmV0ID09IChpbnQpIE5VTEwp
DQorICAgICAgcHJpbnRmICgiV2luZG93cyB1c2VybmFtZSA6ICVzXG4iLCB1
c2VyKTsNCisgIH0NCisNCiAgIHJldHVybiBFdmFsUmV0IChyZXQsIHVzZXIp
ID8gTlVMTCA6IHVpOw0KIH0NCiANCg==

---559023410-1410507888-1022810962=:1492--
