Return-Path: <cygwin-patches-return-4091-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13871 invoked by alias); 16 Aug 2003 02:29:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13852 invoked from network); 16 Aug 2003 02:29:58 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Sat, 16 Aug 2003 02:29:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Package content search and listing functionality for
 cygcheck
In-Reply-To: <16189.37381.740000.619089@gargle.gargle.HOWL>
Message-ID: <Pine.GSO.4.44.0308152213460.8431-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1061000998=:15497"
X-SW-Source: 2003-q3/txt/msg00107.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1061000998=:15497
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1808

On Fri, 15 Aug 2003, David Rothenberger wrote:

> Corinna Vinschen wrote:
> > Thanks for the patch, it's really cool,
>
> I agree, very cool, Igor.
>
> Any chance the return in package_find() could be changed to
> continue?  I went to try it out for /bin/ssh and found it didn't
> work because diffutils is missing the package list.  I didn't think
> to even try verbose until I read the code.
>
> Here's the ridiculously small patch if you agree.
>
> Dave
> ==============================
> 2003-08-15  David Rothenberger  <daveroth@acm.org>
>
> 	* dump_setup.cc (package_find): Don't stop searching on missing
> 	file list.

Dave,

Thanks for catching this -- this was a genuine bug.  Thanks also for the
patch, but I have another one in the pipeline that'll conflict with yours
(<http://cygwin.com/ml/cygwin-patches/2003-q3/msg00105.html>).  How about
I just resubmit that patch with your changes included?

Attached is a new patch, with an updated ChangeLog entry (well, two
entries).
	Igor
==============================================================================
ChangeLog:
2003-08-15  David Rothenberger  <daveroth@acm.org>

	* dump_setup.cc (package_find): Don't stop searching on missing
	file list.
	(package_list): Ditto.

2003-08-15  Igor Pechtchanski  <pechtcha@cs.nyu.edu>

	* dump_setup.cc: (package_list): Make output terse unless
	verbose requested.  Fix formatting.
	(package_find): Ditto.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton

---559023410-851401618-1061000998=:15497
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cygcheck-list-verbose.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0308152229580.15497@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="cygcheck-list-verbose.patch"
Content-length: 2652

SW5kZXg6IGR1bXBfc2V0dXAuY2MNCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL3V0aWxzL2R1bXBfc2V0
dXAuY2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjEwDQpkaWZmIC11IC1w
IC1yMS4xMCBkdW1wX3NldHVwLmNjDQotLS0gZHVtcF9zZXR1cC5jYwkxNSBB
dWcgMjAwMyAyMDoyNjoxMSAtMDAwMAkxLjEwDQorKysgZHVtcF9zZXR1cC5j
YwkxNiBBdWcgMjAwMyAwMjoyMjo1OCAtMDAwMA0KQEAgLTQxMSwyMSArNDEx
LDIyIEBAIHBhY2thZ2VfbGlzdCAoaW50IHZlcmJvc2UsIGNoYXIgKiphcmd2
KQ0KICAgICB7DQogICAgICAgRklMRSAqZnAgPSBvcGVuX3BhY2thZ2VfbGlz
dCAocGFja2FnZXNbaV0ubmFtZSk7DQogICAgICAgaWYgKCFmcCkNCi0gICAg
ICB7DQotCWlmICh2ZXJib3NlKQ0KLQkgIHByaW50ZiAoIkNhbid0IG9wZW4g
ZmlsZSBsaXN0IC9ldGMvc2V0dXAvJXMubHN0Lmd6IGZvciBwYWNrYWdlICVz
XG4iLA0KLQkgICAgICBwYWNrYWdlc1tpXS5uYW1lLCBwYWNrYWdlc1tpXS5u
YW1lKTsNCi0JcmV0dXJuOw0KLSAgICAgIH0NCisJew0KKwkgIGlmICh2ZXJi
b3NlKQ0KKwkgICAgcHJpbnRmICgiQ2FuJ3Qgb3BlbiBmaWxlIGxpc3QgL2V0
Yy9zZXR1cC8lcy5sc3QuZ3ogZm9yIHBhY2thZ2UgJXNcbiIsDQorCQlwYWNr
YWdlc1tpXS5uYW1lLCBwYWNrYWdlc1tpXS5uYW1lKTsNCisJICBjb250aW51
ZTsNCisJfQ0KIA0KLSAgICAgIHByaW50ZiAoIlBhY2thZ2U6ICVzLSVzXG4i
LCBwYWNrYWdlc1tpXS5uYW1lLCBwYWNrYWdlc1tpXS52ZXIpOw0KKyAgICAg
IGlmICh2ZXJib3NlKQ0KKwlwcmludGYgKCJQYWNrYWdlOiAlcy0lc1xuIiwg
cGFja2FnZXNbaV0ubmFtZSwgcGFja2FnZXNbaV0udmVyKTsNCiANCiAgICAg
ICBjaGFyIGJ1ZltNQVhfUEFUSCArIDFdOw0KICAgICAgIHdoaWxlIChmZ2V0
cyAoYnVmLCBNQVhfUEFUSCwgZnApKQ0KIAl7DQogCSAgY2hhciAqbGFzdGNo
YXIgPSBzdHJjaHIoYnVmLCAnXG4nKTsNCiAJICBpZiAobGFzdGNoYXJbLTFd
ICE9ICcvJykNCi0JICAgIHByaW50ZiAoIiAgICAvJXMiLCBidWYpOw0KKwkg
ICAgcHJpbnRmICgiJXMvJXMiLCAodmVyYm9zZT8iICAgICI6IiIpLCBidWYp
Ow0KIAl9DQogDQogICAgICAgZmNsb3NlIChmcCk7DQpAQCAtNDUwLDEyICs0
NTEsNyBAQCBwYWNrYWdlX2ZpbmQgKGludCB2ZXJib3NlLCBjaGFyICoqYXJn
dikNCiAgICAgew0KICAgICAgIEZJTEUgKmZwID0gb3Blbl9wYWNrYWdlX2xp
c3QgKHBhY2thZ2VzW2ldLm5hbWUpOw0KICAgICAgIGlmICghZnApDQotICAg
ICAgew0KLQlpZiAodmVyYm9zZSkNCi0JICBwcmludGYgKCJDYW4ndCBvcGVu
IGZpbGUgbGlzdCAvZXRjL3NldHVwLyVzLmxzdC5neiBmb3IgcGFja2FnZSAl
c1xuIiwNCi0JICAgICAgcGFja2FnZXNbaV0ubmFtZSwgcGFja2FnZXNbaV0u
bmFtZSk7DQotCXJldHVybjsNCi0gICAgICB9DQorCWNvbnRpbnVlOw0KIA0K
ICAgICAgIGNoYXIgYnVmW01BWF9QQVRIICsgMl07DQogICAgICAgYnVmWzBd
ID0gJy8nOw0KQEAgLTQ3OSw3ICs0NzUsMTEgQEAgcGFja2FnZV9maW5kIChp
bnQgdmVyYm9zZSwgY2hhciAqKmFyZ3YpDQogCSAgICAgIGlmICghYSAmJiBp
c19hbGlhcykNCiAJCWEgPSBtYXRjaF9hcmd2IChhcmd2LCBmaWxlbmFtZSAr
IDQpOw0KIAkgICAgICBpZiAoYSA+IDApDQotCQlwcmludGYgKCIlcy0lc1xu
IiwgcGFja2FnZXNbaV0ubmFtZSwgcGFja2FnZXNbaV0udmVyKTsNCisJCXsN
CisJCSAgaWYgKHZlcmJvc2UpDQorCQkgICAgcHJpbnRmICgiJXM6IGZvdW5k
IGluIHBhY2thZ2UgIiwgZmlsZW5hbWUpOw0KKwkJICBwcmludGYgKCIlcy0l
c1xuIiwgcGFja2FnZXNbaV0ubmFtZSwgcGFja2FnZXNbaV0udmVyKTsNCisJ
CX0NCiAJICAgIH0NCiAJfQ0KIA0K

---559023410-851401618-1061000998=:15497--
