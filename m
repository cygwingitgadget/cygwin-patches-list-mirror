Return-Path: <cygwin-patches-return-4089-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2444 invoked by alias); 15 Aug 2003 23:01:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2435 invoked from network); 15 Aug 2003 23:01:20 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Fri, 15 Aug 2003 23:01:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Package content search and listing functionality for
 cygcheck
In-Reply-To: <20030815202621.GG3101@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.44.0308151827280.1848-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1903590565-1060988479=:1848"
X-SW-Source: 2003-q3/txt/msg00105.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1903590565-1060988479=:1848
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 2727

On Fri, 15 Aug 2003, Corinna Vinschen wrote:

> On Fri, Aug 15, 2003 at 03:38:30PM -0400, Igor Pechtchanski wrote:
> > > On Cygwin:
> > >
> > >   $ cygcheck -f /usr/bin/tcsh.exe
> > >   /usr/bin/tcsh.exe: found in package tcsh-6.12.00-6
> > >
> > > On Linux:
> > >
> > >   $ rpm -qf /usr/bin/tcsh
> > >   tcsh-6.12.00-134
> > >
> > > Shouldn't we also just print the package name?  It doesn't really matter,
> > > just a question...
> >
> > Fixed.
>
> I'm happy!

On second thought, we're not using the verbose flag much.  We could
certainly use it for this.  If you don't mind, I'll revert the printout to
the more verbose form if -v is passed to cygcheck.  Also see below.

> Another difference to Linux is when using -l.  rpm -ql doesn't
> prepend the package version to each file list, it just prints a list of
> files of all packages on the command line:
>
>   $ rpm -ql bash tcsh
>   /bin/bash
>   [more bash files]
>   /usr/bin/tcsh
>   [more tcsh files]
>   $
>
> On Cygwin:
>
>   $ cygcheck -l bash tcsh
>   Package: bash-2.05b-12
>       /usr/bin/bash.exe
>       [more bash files]
>   Package: tcsh-6.12.00-7
>       /usr/bin/tcsh.exe
>       [more tcsh files]
>   $
>
> Should we do it also like rpm or do you like it better as it is?

Let's do it like rpm unless verbose output is requested.

> > Well, I agree with all the above points, so here's another iteration.
> > Same ChangeLog (except for the date -- reposting just in case).
>
> I've checked it in and added some formatting changes.  I removed most
> of the `puts("");' lines and the "Use -h to see..." is now only printed
> where it belongs to, to the end of a sysinfo dump.  Oh, and the other
> helptext ("Here is where the OS will...") would have been printed also
> on -f -h or -l -h, I've fixed the if clause appropriately.

Thanks.

> Thanks for the patch, it's really cool,
> Corinna

You're welcome.  Here's a minor adjustment based on the comments above.
Another thing to do is make cygcheck respect the order of arguments (right
now it lists the packages in alphabetical order).
	Igor
==============================================================================
ChangeLog:
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

---559023410-1903590565-1060988479=:1848
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cygcheck-list-verbose.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0308151901190.1848@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="cygcheck-list-verbose.patch"
Content-length: 2632

SW5kZXg6IGR1bXBfc2V0dXAuY2MNCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL3V0aWxzL2R1bXBfc2V0
dXAuY2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjEwDQpkaWZmIC11IC1w
IC1yMS4xMCBkdW1wX3NldHVwLmNjDQotLS0gZHVtcF9zZXR1cC5jYwkxNSBB
dWcgMjAwMyAyMDoyNjoxMSAtMDAwMAkxLjEwDQorKysgZHVtcF9zZXR1cC5j
YwkxNSBBdWcgMjAwMyAyMjo1NDoxMCAtMDAwMA0KQEAgLTQxMSwyMSArNDEx
LDIyIEBAIHBhY2thZ2VfbGlzdCAoaW50IHZlcmJvc2UsIGNoYXIgKiphcmd2
KQ0KICAgICB7DQogICAgICAgRklMRSAqZnAgPSBvcGVuX3BhY2thZ2VfbGlz
dCAocGFja2FnZXNbaV0ubmFtZSk7DQogICAgICAgaWYgKCFmcCkNCi0gICAg
ICB7DQotCWlmICh2ZXJib3NlKQ0KLQkgIHByaW50ZiAoIkNhbid0IG9wZW4g
ZmlsZSBsaXN0IC9ldGMvc2V0dXAvJXMubHN0Lmd6IGZvciBwYWNrYWdlICVz
XG4iLA0KLQkgICAgICBwYWNrYWdlc1tpXS5uYW1lLCBwYWNrYWdlc1tpXS5u
YW1lKTsNCi0JcmV0dXJuOw0KLSAgICAgIH0NCisJew0KKwkgIGlmICh2ZXJi
b3NlKQ0KKwkgICAgcHJpbnRmICgiQ2FuJ3Qgb3BlbiBmaWxlIGxpc3QgL2V0
Yy9zZXR1cC8lcy5sc3QuZ3ogZm9yIHBhY2thZ2UgJXNcbiIsDQorCQlwYWNr
YWdlc1tpXS5uYW1lLCBwYWNrYWdlc1tpXS5uYW1lKTsNCisJICByZXR1cm47
DQorCX0NCiANCi0gICAgICBwcmludGYgKCJQYWNrYWdlOiAlcy0lc1xuIiwg
cGFja2FnZXNbaV0ubmFtZSwgcGFja2FnZXNbaV0udmVyKTsNCisgICAgICBp
ZiAodmVyYm9zZSkNCisJcHJpbnRmICgiUGFja2FnZTogJXMtJXNcbiIsIHBh
Y2thZ2VzW2ldLm5hbWUsIHBhY2thZ2VzW2ldLnZlcik7DQogDQogICAgICAg
Y2hhciBidWZbTUFYX1BBVEggKyAxXTsNCiAgICAgICB3aGlsZSAoZmdldHMg
KGJ1ZiwgTUFYX1BBVEgsIGZwKSkNCiAJew0KIAkgIGNoYXIgKmxhc3RjaGFy
ID0gc3RyY2hyKGJ1ZiwgJ1xuJyk7DQogCSAgaWYgKGxhc3RjaGFyWy0xXSAh
PSAnLycpDQotCSAgICBwcmludGYgKCIgICAgLyVzIiwgYnVmKTsNCisJICAg
IHByaW50ZiAoIiVzLyVzIiwgKHZlcmJvc2U/IiAgICAiOiIiKSwgYnVmKTsN
CiAJfQ0KIA0KICAgICAgIGZjbG9zZSAoZnApOw0KQEAgLTQ1MCwxMiArNDUx
LDcgQEAgcGFja2FnZV9maW5kIChpbnQgdmVyYm9zZSwgY2hhciAqKmFyZ3Yp
DQogICAgIHsNCiAgICAgICBGSUxFICpmcCA9IG9wZW5fcGFja2FnZV9saXN0
IChwYWNrYWdlc1tpXS5uYW1lKTsNCiAgICAgICBpZiAoIWZwKQ0KLSAgICAg
IHsNCi0JaWYgKHZlcmJvc2UpDQotCSAgcHJpbnRmICgiQ2FuJ3Qgb3BlbiBm
aWxlIGxpc3QgL2V0Yy9zZXR1cC8lcy5sc3QuZ3ogZm9yIHBhY2thZ2UgJXNc
biIsDQotCSAgICAgIHBhY2thZ2VzW2ldLm5hbWUsIHBhY2thZ2VzW2ldLm5h
bWUpOw0KIAlyZXR1cm47DQotICAgICAgfQ0KIA0KICAgICAgIGNoYXIgYnVm
W01BWF9QQVRIICsgMl07DQogICAgICAgYnVmWzBdID0gJy8nOw0KQEAgLTQ3
OSw3ICs0NzUsMTEgQEAgcGFja2FnZV9maW5kIChpbnQgdmVyYm9zZSwgY2hh
ciAqKmFyZ3YpDQogCSAgICAgIGlmICghYSAmJiBpc19hbGlhcykNCiAJCWEg
PSBtYXRjaF9hcmd2IChhcmd2LCBmaWxlbmFtZSArIDQpOw0KIAkgICAgICBp
ZiAoYSA+IDApDQotCQlwcmludGYgKCIlcy0lc1xuIiwgcGFja2FnZXNbaV0u
bmFtZSwgcGFja2FnZXNbaV0udmVyKTsNCisJCXsNCisJCSAgaWYgKHZlcmJv
c2UpDQorCQkgICAgcHJpbnRmICgiJXM6IGZvdW5kIGluIHBhY2thZ2UgIiwg
ZmlsZW5hbWUpOw0KKwkJICBwcmludGYgKCIlcy0lc1xuIiwgcGFja2FnZXNb
aV0ubmFtZSwgcGFja2FnZXNbaV0udmVyKTsNCisJCX0NCiAJICAgIH0NCiAJ
fQ0KIA0K

---559023410-1903590565-1060988479=:1848--
