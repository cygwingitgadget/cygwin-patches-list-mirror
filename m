Return-Path: <cygwin-patches-return-4057-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12825 invoked by alias); 9 Aug 2003 19:52:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12816 invoked from network); 9 Aug 2003 19:52:55 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Sat, 09 Aug 2003 19:52:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
In-Reply-To: <20030809181426.GA11170@redhat.com>
Message-ID: <Pine.GSO.4.44.0308091539340.7386-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-684387517-1060458775=:7386"
X-SW-Source: 2003-q3/txt/msg00073.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-684387517-1060458775=:7386
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 2315

On Sat, 9 Aug 2003, Christopher Faylor wrote:

> On Sat, Aug 09, 2003 at 12:29:39PM -0400, Christopher Faylor wrote:
> >On Sat, Aug 09, 2003 at 12:12:11PM -0400, Christopher Faylor wrote:
> >>On Thu, Aug 07, 2003 at 06:50:10PM -0400, Igor Pechtchanski wrote:
> >>>Hi,
> >>>
> >>>This patch adds most of the capability of the script from
> >>><http://cygwin.com/ml/cygwin-apps/2003-08/msg00106.html> to cygcheck.
> >>>It is triggered by the "-c" flag to cygcheck.  "Integrity" is a rather
> >>>strong word, actually, as all this checks for is the existence of files
> >>>and directories, but this could be further built upon (for example, tar
> >>>has a diff option that could be useful).  The patch is against cvs HEAD
> >>>with my previous micropatch
> >>>(<http://cygwin.com/ml/cygwin-patches/2003-q3/msg00058.html>) applied.
> >>>Comments and suggestions welcome.
> >>
> >>I'm getting some odd errors when I apply this patch:
> >>
> >>"4NT: Unknown command f:"
> >>
> >>(as you can see I use 4NT).
> >>
> >>I haven't had time to debug where these are coming from but I get one
> >>for every file displayed.
> >
> >The enclosed patch fixes that.
> >
> >I'll check this in but it would be nice if (WBNI) this used a mingw gzip
> >library rather than calling gzip directly.  That's a fair amount of
> >work but I could resurrect the zlib library in winsup if necessary.
> >
> >I wonder why setup is using gzip rather than bzip2 for the package files...
>
> On checking this patch a little further, I see that it gives a
> misleading "OK" when the package file is missing.  Could you detect
> that case?
>
> cgf

Yes.  The attached patch (against the initial one applied) does just that.
	Igor
==============================================================================
ChangeLog:
2003-08-09  Igor Pechtchanski  <pechtcha@cs.nyu.edu>

	* dump_setup.cc (dump_setup): Check for the existence
	of the package list file.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton


---559023410-684387517-1060458775=:7386
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cygcheck-verify-packages-adj.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0308091552550.7386@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="cygcheck-verify-packages-adj.patch"
Content-length: 1111

LS0tIGR1bXBfc2V0dXAuY2N+CTIwMDMtMDgtMDcgMTg6NDA6MjIuMDAwMDAw
MDAwIC0wNDAwDQorKysgZHVtcF9zZXR1cC5jYwkyMDAzLTA4LTA5IDE1OjQ4
OjE2LjAwMDAwMDAwMCAtMDQwMA0KQEAgLTIzOCwxMSArMjM4LDE3IEBAIHN0
YXRpYyBib29sDQogY2hlY2tfcGFja2FnZV9maWxlcyAoaW50IHZlcmJvc2Us
IGNoYXIgKnBhY2thZ2UpDQogew0KICAgYm9vbCByZXN1bHQgPSB0cnVlOw0K
LSAgY2hhciBmaWxlbGlzdFs0MDk2XSA9ICIgLWRjIC9ldGMvc2V0dXAvIjsN
CisgIGNoYXIgZmlsZWxpc3RbNDA5Nl0gPSAiZXRjL3NldHVwLyI7DQogICBz
dHJjYXQoc3RyY2F0KGZpbGVsaXN0LCBwYWNrYWdlKSwgIi5sc3QuZ3oiKTsN
CisgIGlmICghZmlsZV9leGlzdHMoZmFsc2UsIGZpbGVsaXN0LCBOVUxMLCBO
VUxMKSkNCisgICAgew0KKyAgICAgIGlmICh2ZXJib3NlKQ0KKwlwcmludGYg
KCJNaXNzaW5nIGZpbGUgbGlzdCAvJXMgZm9yIHBhY2thZ2UgJXNcbiIsIGZp
bGVsaXN0LCBwYWNrYWdlKTsNCisgICAgICByZXR1cm4gZmFsc2U7DQorICAg
IH0NCiAgIGNoYXIgKnpjYXQgPSBjeWdwYXRoKCIvYmluL2d6aXAuZXhlIiwg
TlVMTCk7DQogICBjaGFyIGNvbW1hbmRbNDA5Nl07DQotICBzdHJjYXQoc3Ry
Y3B5KGNvbW1hbmQsIHpjYXQpLCBmaWxlbGlzdCk7DQorICBzdHJjYXQoc3Ry
Y2F0KHN0cmNweShjb21tYW5kLCB6Y2F0KSwgIiAtZGMgLyIpLCBmaWxlbGlz
dCk7DQogICBGSUxFICpmcCA9IHBvcGVuIChjb21tYW5kLCAicnQiKTsNCiAg
IGNoYXIgYnVmWzQwOTZdOw0KICAgd2hpbGUgKGZnZXRzIChidWYsIDQwOTYs
IGZwKSkNCg==

---559023410-684387517-1060458775=:7386--
