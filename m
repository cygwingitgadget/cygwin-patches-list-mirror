Return-Path: <cygwin-patches-return-3541-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23967 invoked by alias); 7 Feb 2003 16:05:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23958 invoked from network); 7 Feb 2003 16:05:50 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Fri, 07 Feb 2003 16:05:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: [ls PATCH] Re: ntsec odds and ends
In-Reply-To: <Pine.GSO.4.44.0302060941150.15853-100000@slinky.cs.nyu.edu>
Message-ID: <Pine.GSO.4.44.0302071052030.12312-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1254324197-1044633950=:12312"
X-SW-Source: 2003-q1/txt/msg00190.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1254324197-1044633950=:12312
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 2276

On Thu, 6 Feb 2003, Igor Pechtchanski wrote:

> <WILD>
> I just had another really wild idea (feel free to ignore): since we want
> this visible in the "ls" output, suppose ls recognized these special names
> you are going to use (whatever they are), and used the existing
> "--color=auto" mechanism to output them in red to the terminal (and same
> with numeric values, I guess)?  I mean, ls *never* colors the user and
> group names, so it would be immediately visible...  Of course, the
> drawback is that we might need to allow the user to customize this (the
> color and all)...  Once the names for unknown user/group is decided, I
> might take a stab at making this patch to "ls".
> </WILD>

Well, I'm not at all sure this is the right list for it, but here's a
patch to ls that implements the above (except color control, but that can
be added).  The invalid user/group names will be colored bright white on
red if the output is to a tty (I tried to make it blink as well, but I
don't think you can do both bold and blink with ANSI color sequences).
This can be inhibited by the new '--inhibit-ntsec-warning' option (I
deliberately did not include a short option).

I'm sending it here, since it has to do with the recent ntsec changes that
are still in development.  Please let me know if this is too
inappropriate.  Otherwise, please evaluate it.  If it's useful, I can
re-send it to <cygwin at cygwin dot com> once 1.3.20 is released.
	Igor
P.S. This patch is against the fileutils-4.1-1 source.
========================================================================
2003-02-07  Igor Pechtchanski <pechtcha@cs.nyu.edu>

	* ls.c (print_long_format): Output color indicators for
	invalid users/groups (unless inhibit_ntsec_warning is in
	effect).
	(inhibit_ntsec_warning): New option.
	(main): Add "inhibit-ntsec-warning" option.
	(UNKNOWN_UID,UNKNOWN_GID,UNKNOWN_GROUP): New #defines.
	(copy_indicator): New function.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Oh, boy, virtual memory! Now I'm gonna make myself a really *big* RAMdisk!
  -- /usr/games/fortune

---559023410-1254324197-1044633950=:12312
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ls-ntsec-warn.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0302071105500.12312@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="ls-ntsec-warn.patch"
Content-length: 6588

LS0tIHNyYy9scy5jLW9yaWcJMjAwMi0wOC0wOSAxMToyMjozNi4wMDAwMDAw
MDAgLTA0MDANCisrKyBzcmMvbHMuYwkyMDAzLTAyLTA3IDEwOjQ0OjUzLjAw
MDAwMDAwMCAtMDUwMA0KQEAgLTMwNCw2ICszMDQsNyBAQCBzdGF0aWMgdWlu
dG1heF90IGdvYmJsZV9maWxlIFBBUkFNUyAoKGNvDQogc3RhdGljIHZvaWQg
cHJpbnRfY29sb3JfaW5kaWNhdG9yIFBBUkFNUyAoKGNvbnN0IGNoYXIgKm5h
bWUsIHVuc2lnbmVkIGludCBtb2RlLA0KIAkJCQkJICAgaW50IGxpbmtvaykp
Ow0KIHN0YXRpYyB2b2lkIHB1dF9pbmRpY2F0b3IgUEFSQU1TICgoY29uc3Qg
c3RydWN0IGJpbl9zdHIgKmluZCkpOw0KK3N0YXRpYyBpbnQgY29weV9pbmRp
Y2F0b3IgUEFSQU1TICgoY2hhciAqZGVzdCwgY29uc3Qgc3RydWN0IGJpbl9z
dHIgKmluZCkpOw0KIHN0YXRpYyBpbnQgbGVuZ3RoX29mX2ZpbGVfbmFtZV9h
bmRfZnJpbGxzIFBBUkFNUyAoKGNvbnN0IHN0cnVjdCBmaWxlaW5mbyAqZikp
Ow0KIHN0YXRpYyB2b2lkIGFkZF9pZ25vcmVfcGF0dGVybiBQQVJBTVMgKChj
b25zdCBjaGFyICpwYXR0ZXJuKSk7DQogc3RhdGljIHZvaWQgYXR0YWNoIFBB
UkFNUyAoKGNoYXIgKmRlc3QsIGNvbnN0IGNoYXIgKmRpcm5hbWUsIGNvbnN0
IGNoYXIgKm5hbWUpKTsNCkBAIC01NTEsNiArNTUyLDE4IEBAIHN0YXRpYyBz
dHJ1Y3QgY29sb3JfZXh0X3R5cGUgKmNvbG9yX2V4dF8NCiAvKiBCdWZmZXIg
Zm9yIGNvbG9yIHNlcXVlbmNlcyAqLw0KIHN0YXRpYyBjaGFyICpjb2xvcl9i
dWY7DQogDQorLyogTm9uemVybyBtZWFucyB0byBub3QgaGlnaGxpZ2h0IGlu
dmFsaWQgdXNlci9ncm91cCB3aXRoIGNvbG9ycy4gICovDQorDQorc3RhdGlj
IGludCBpbmhpYml0X250c2VjX3dhcm5pbmc7DQorDQorc3RhdGljIHN0cnVj
dCBiaW5fc3RyIG50c2VjX3dhcm5fY29sb3IgPQ0KKyAgeyBMRU5fU1RSX1BB
SVIgKCI0MTswMTswNTszNyIpIH07IC8qIG53OiBudHNlYyB3YXJuOiBibGlu
a2luZyB3aGl0ZSBvbiByZWQgKi8NCisNCisvKiBLZWVwIHRoZXNlIGluIHN5
bmMgd2l0aCBjeWd3aW4ncyBzZWN1cml0eS5oL2dycC5jYyAqLw0KKyNkZWZp
bmUgVU5LTk9XTl9VSUQgNjU1MzUNCisjZGVmaW5lIFVOS05PV05fR0lEIDQw
MQ0KKyNkZWZpbmUgVU5LTk9XTl9HUk9VUCAibWtncm91cCINCisNCiAvKiBO
b256ZXJvIG1lYW5zIHRvIGNoZWNrIGZvciBvcnBoYW5lZCBzeW1ib2xpYyBs
aW5rLCBmb3IgZGlzcGxheWluZw0KICAgIGNvbG9ycy4gICovDQogDQpAQCAt
NjYzLDcgKzY3Niw4IEBAIGVudW0NCiAgIFNIT1dfQ09OVFJPTF9DSEFSU19P
UFRJT04sDQogICBTSV9PUFRJT04sDQogICBTT1JUX09QVElPTiwNCi0gIFRJ
TUVfT1BUSU9ODQorICBUSU1FX09QVElPTiwNCisgIElOSElCSVRfTlRTRUNf
V0FSTklOR19PUFRJT04NCiB9Ow0KIA0KIHN0YXRpYyBzdHJ1Y3Qgb3B0aW9u
IGNvbnN0IGxvbmdfb3B0aW9uc1tdID0NCkBAIC03MDEsNiArNzE1LDcgQEAg
c3RhdGljIHN0cnVjdCBvcHRpb24gY29uc3QgbG9uZ19vcHRpb25zWw0KICAg
eyJ0aW1lIiwgcmVxdWlyZWRfYXJndW1lbnQsIDAsIFRJTUVfT1BUSU9OfSwN
CiAgIHsiY29sb3IiLCBvcHRpb25hbF9hcmd1bWVudCwgMCwgQ09MT1JfT1BU
SU9OfSwNCiAgIHsiYmxvY2stc2l6ZSIsIHJlcXVpcmVkX2FyZ3VtZW50LCAw
LCBCTE9DS19TSVpFX09QVElPTn0sDQorICB7ImluaGliaXQtbnRzZWMtd2Fy
bmluZyIsIG5vX2FyZ3VtZW50LCAwLCBJTkhJQklUX05UU0VDX1dBUk5JTkdf
T1BUSU9OfSwNCiAgIHtHRVRPUFRfSEVMUF9PUFRJT05fREVDTH0sDQogICB7
R0VUT1BUX1ZFUlNJT05fT1BUSU9OX0RFQ0x9LA0KICAge05VTEwsIDAsIE5V
TEwsIDB9DQpAQCAtMTMzNCw2ICsxMzQ5LDEwIEBAIFVzZSBgLS1zaScgZm9y
IHRoZSBvbGQgbWVhbmluZy4iKSk7DQogCSAgaHVtYW5fYmxvY2tfc2l6ZSAo
b3B0YXJnLCAxLCAmb3V0cHV0X2Jsb2NrX3NpemUpOw0KIAkgIGJyZWFrOw0K
IA0KKwljYXNlIElOSElCSVRfTlRTRUNfV0FSTklOR19PUFRJT046DQorCSAg
aW5oaWJpdF9udHNlY193YXJuaW5nID0gMTsNCisJICBicmVhazsNCisNCiAJ
Y2FzZV9HRVRPUFRfSEVMUF9DSEFSOw0KIA0KIAljYXNlX0dFVE9QVF9WRVJT
SU9OX0NIQVIgKFBST0dSQU1fTkFNRSwgQVVUSE9SUyk7DQpAQCAtMjUwNiw2
ICsyNTI1LDE0IEBAIHByaW50X2xvbmdfZm9ybWF0IChjb25zdCBzdHJ1Y3Qg
ZmlsZWluZm8NCiAgIHNwcmludGYgKHAsICIlcyAlM3UgIiwgbW9kZWJ1Ziwg
KHVuc2lnbmVkIGludCkgZi0+c3RhdC5zdF9ubGluayk7DQogICBwICs9IHN0
cmxlbiAocCk7DQogDQorICBpZiAoIWluaGliaXRfbnRzZWNfd2FybmluZyAm
JiBmLT5zdGF0LnN0X3VpZCA9PSBVTktOT1dOX1VJRCAmJg0KKyAgICAgIGlz
YXR0eSAoU1RET1VUX0ZJTEVOTykpDQorICAgIHsNCisgICAgICBwICs9IGNv
cHlfaW5kaWNhdG9yIChwLCAmY29sb3JfaW5kaWNhdG9yW0NfTEVGVF0pOw0K
KyAgICAgIHAgKz0gY29weV9pbmRpY2F0b3IgKHAsICZudHNlY193YXJuX2Nv
bG9yKTsNCisgICAgICBwICs9IGNvcHlfaW5kaWNhdG9yIChwLCAmY29sb3Jf
aW5kaWNhdG9yW0NfUklHSFRdKTsNCisgICAgfQ0KKw0KICAgdXNlcl9uYW1l
ID0gKG51bWVyaWNfaWRzID8gTlVMTCA6IGdldHVzZXIgKGYtPnN0YXQuc3Rf
dWlkKSk7DQogICBpZiAodXNlcl9uYW1lKQ0KICAgICBzcHJpbnRmIChwLCAi
JS04LjhzICIsIHVzZXJfbmFtZSk7DQpAQCAtMjUxMywxNCArMjU0MCw0MiBA
QCBwcmludF9sb25nX2Zvcm1hdCAoY29uc3Qgc3RydWN0IGZpbGVpbmZvDQog
ICAgIHNwcmludGYgKHAsICIlLTh1ICIsICh1bnNpZ25lZCBpbnQpIGYtPnN0
YXQuc3RfdWlkKTsNCiAgIHAgKz0gc3RybGVuIChwKTsNCiANCisgIGlmICgh
aW5oaWJpdF9udHNlY193YXJuaW5nICYmIGYtPnN0YXQuc3RfdWlkID09IFVO
S05PV05fVUlEICYmDQorICAgICAgaXNhdHR5IChTVERPVVRfRklMRU5PKSkN
CisgICAgew0KKyAgICAgIHAgKz0gY29weV9pbmRpY2F0b3IgKHAsICZjb2xv
cl9pbmRpY2F0b3JbQ19MRUZUXSk7DQorICAgICAgcCArPSBjb3B5X2luZGlj
YXRvciAocCwgJmNvbG9yX2luZGljYXRvcltDX05PUk1dKTsNCisgICAgICBw
ICs9IGNvcHlfaW5kaWNhdG9yIChwLCAmY29sb3JfaW5kaWNhdG9yW0NfUklH
SFRdKTsNCisgICAgfQ0KKw0KICAgaWYgKCFpbmhpYml0X2dyb3VwKQ0KICAg
ICB7DQogICAgICAgY2hhciAqZ3JvdXBfbmFtZSA9IChudW1lcmljX2lkcyA/
IE5VTEwgOiBnZXRncm91cCAoZi0+c3RhdC5zdF9naWQpKTsNCisgICAgICBp
bnQgdW5rbm93bl9ncm91cCA9ICghaW5oaWJpdF9udHNlY193YXJuaW5nICYm
IGdyb3VwX25hbWUgJiYgIXN0cmNtcChncm91cF9uYW1lLCBVTktOT1dOX0dS
T1VQKSk7DQorDQorICAgICAgaWYgKCFpbmhpYml0X250c2VjX3dhcm5pbmcg
JiYNCisJICAoZi0+c3RhdC5zdF9naWQgPT0gVU5LTk9XTl9HSUQgfHwgdW5r
bm93bl9ncm91cCkgJiYNCisJICBpc2F0dHkgKFNURE9VVF9GSUxFTk8pKQ0K
Kwl7DQorCSAgcCArPSBjb3B5X2luZGljYXRvciAocCwgJmNvbG9yX2luZGlj
YXRvcltDX0xFRlRdKTsNCisJICBwICs9IGNvcHlfaW5kaWNhdG9yIChwLCAm
bnRzZWNfd2Fybl9jb2xvcik7DQorCSAgcCArPSBjb3B5X2luZGljYXRvciAo
cCwgJmNvbG9yX2luZGljYXRvcltDX1JJR0hUXSk7DQorCX0NCisNCiAgICAg
ICBpZiAoZ3JvdXBfbmFtZSkNCiAJc3ByaW50ZiAocCwgIiUtOC44cyAiLCBn
cm91cF9uYW1lKTsNCiAgICAgICBlbHNlDQogCXNwcmludGYgKHAsICIlLTh1
ICIsICh1bnNpZ25lZCBpbnQpIGYtPnN0YXQuc3RfZ2lkKTsNCiAgICAgICBw
ICs9IHN0cmxlbiAocCk7DQorDQorICAgICAgaWYgKCFpbmhpYml0X250c2Vj
X3dhcm5pbmcgJiYNCisJICAoZi0+c3RhdC5zdF9naWQgPT0gVU5LTk9XTl9H
SUQgfHwgdW5rbm93bl9ncm91cCkgJiYNCisJICBpc2F0dHkgKFNURE9VVF9G
SUxFTk8pKQ0KKwl7DQorCSAgcCArPSBjb3B5X2luZGljYXRvciAocCwgJmNv
bG9yX2luZGljYXRvcltDX0xFRlRdKTsNCisJICBwICs9IGNvcHlfaW5kaWNh
dG9yIChwLCAmY29sb3JfaW5kaWNhdG9yW0NfTk9STV0pOw0KKwkgIHAgKz0g
Y29weV9pbmRpY2F0b3IgKHAsICZjb2xvcl9pbmRpY2F0b3JbQ19SSUdIVF0p
Ow0KKwl9DQogICAgIH0NCiANCiAgIGlmIChTX0lTQ0hSIChmLT5zdGF0LnN0
X21vZGUpIHx8IFNfSVNCTEsgKGYtPnN0YXQuc3RfbW9kZSkpDQpAQCAtMjky
NCw2ICsyOTc5LDIyIEBAIHByaW50X2NvbG9yX2luZGljYXRvciAoY29uc3Qg
Y2hhciAqbmFtZSwNCiAgIHB1dF9pbmRpY2F0b3IgKCZjb2xvcl9pbmRpY2F0
b3JbQ19SSUdIVF0pOw0KIH0NCiANCisvKiBDb3B5IGEgY29sb3IgaW5kaWNh
dG9yICh3aGljaCBzaG91bGQgbm90IGNvbnRhaW4gbnVsbHMpIHRvIGEgc3Ry
aW5nLiAgKi8NCisvKiBSZXR1cm4gdGhlIG51bWJlciBvZiBjaGFyYWN0ZXJz
IGNvcGllZC4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCitz
dGF0aWMgaW50DQorY29weV9pbmRpY2F0b3IgKGNoYXIgKmRlc3QsIGNvbnN0
IHN0cnVjdCBiaW5fc3RyICppbmQpDQorew0KKyAgcmVnaXN0ZXIgaW50IGk7
DQorICByZWdpc3RlciBjb25zdCBjaGFyICpwOw0KKw0KKyAgcCA9IGluZC0+
c3RyaW5nOw0KKw0KKyAgZm9yIChpID0gaW5kLT5sZW47IGkgPiAwOyAtLWkp
DQorICAgICooZGVzdCsrKSA9ICoocCsrKTsNCisNCisgIHJldHVybiBpbmQt
PmxlbjsNCit9DQorDQogLyogT3V0cHV0IGEgY29sb3IgaW5kaWNhdG9yICh3
aGljaCBtYXkgY29udGFpbiBudWxscykuICAqLw0KIHN0YXRpYyB2b2lkDQog
cHV0X2luZGljYXRvciAoY29uc3Qgc3RydWN0IGJpbl9zdHIgKmluZCkNCg==

---559023410-1254324197-1044633950=:12312--
