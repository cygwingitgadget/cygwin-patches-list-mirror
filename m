Return-Path: <cygwin-patches-return-3526-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18836 invoked by alias); 6 Feb 2003 16:37:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18826 invoked from network); 6 Feb 2003 16:37:17 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 06 Feb 2003 16:37:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: ntsec odds and ends
In-Reply-To: <20030206145328.GH5822@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.44.0302061135020.16397-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-758783491-1044549436=:16397"
X-SW-Source: 2003-q1/txt/msg00175.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-758783491-1044549436=:16397
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1075

On Thu, 6 Feb 2003, Corinna Vinschen wrote:

> On Thu, Feb 06, 2003 at 09:49:32AM -0500, Igor Pechtchanski wrote:
> > Umm, Corinna, suppose some misguided soul would actually create a user
> > named "mkpasswd" (or a group called "mkgroup")?  What then?  Perhaps a
> > note in the User Guide's ntsec section is in order?  Or an FAQ?
>
> Feel free to write one.
> Corinna

Sure.  How's this (attached)?  It'll need to be changed, of course, if you
decide to use something other than 'mkpasswd'/'mkgroup' for those names.
	Igor
========================================================================
ChangeLog:
2003-02-06  Igor Pechtchanski <pechtcha@cs.nyu.edu>

	* ntsec.sgml: Add note on special names for missing
	user/group.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Oh, boy, virtual memory! Now I'm gonna make myself a really *big* RAMdisk!
  -- /usr/games/fortune

---559023410-758783491-1044549436=:16397
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ntsec-special-names.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0302061137160.16397@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="ntsec-special-names.patch"
Content-length: 1920

SW5kZXg6IHdpbnN1cC9kb2MvbnRzZWMuc2dtbA0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvZG9jL250
c2VjLnNnbWwsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjkNCmRpZmYgLXUg
LXAgLXIxLjkgbnRzZWMuc2dtbA0KLS0tIHdpbnN1cC9kb2MvbnRzZWMuc2dt
bAkyMyBPY3QgMjAwMiAwNDoyOTo0NiAtMDAwMAkxLjkNCisrKyB3aW5zdXAv
ZG9jL250c2VjLnNnbWwJNiBGZWIgMjAwMyAxNjozMToxMiAtMDAwMA0KQEAg
LTczMSw0ICs3MzEsMjQgQEAgYWJsZSB0byBhY2Nlc3MgaXQgd2hlbiB0cnlp
bmcgdG8gbG9naW4gdQ0KIA0KIDwvc2VjdDI+DQogDQorPHNlY3QyIGlkPSJu
dHNlYy1yZWxlYXNlMS4zLjIwIj48dGl0bGU+TmV3IHNpbmNlIEN5Z3dpbiBy
ZWxlYXNlIDEuMy4yMDwvdGl0bGU+DQorDQorPHBhcmE+DQorSWYgYSB1c2Vy
IG9yIGdyb3VwIGlzIG5vdCBwcmVzZW50IGluIDxmaWxlbmFtZT4vZXRjL3Bh
c3N3ZDwvZmlsZW5hbWU+IChvcg0KK2lmIGEgZ3JvdXAgaXMgbm90IHByZXNl
bnQgaW4gPGZpbGVuYW1lPi9ldGMvZ3JvdXA8L2ZpbGVuYW1lPiksIGl0IHdp
bGwgaGF2ZQ0KK2Egc3BlY2lhbCB1c2VyL2dyb3VwIGlkIG9mIC0xICh3aGlj
aCB3b3VsZCBiZSBzaG93biBieSA8Y29tbWFuZD5sczwvY29tbWFuZD4NCith
cyA2NTUzNSkuICBJbiByZWxlYXNlcyBvZiBDeWd3aW4gYmVmb3JlIDEuMy4y
MCwgdGhlIHVzZXIvZ3JvdXAgbmFtZSBzaG93bg0KK3dhcyAnPz8/Pz8/Pz8n
LiAgU2luY2UgQ3lnd2luIHJlbGVhc2UgMS4zLjIwLCB0aGUgbmFtZSBvZiBh
IHVzZXIgd2l0aCBubw0KK2VudHJ5IGluIDxmaWxlbmFtZT4vZXRjL3Bhc3N3
ZDwvZmlsZW5hbWU+IHdpbGwgYmUgc2hvd24gYXMgYG1rcGFzc3dkJywgYW5k
DQordGhlIG5hbWUgb2YgYSBncm91cCBub3QgaW4gPGZpbGVuYW1lPi9ldGMv
Z3JvdXA8L2ZpbGVuYW1lPiB3aWxsIGJlIHNob3duIGFzDQorYG1rZ3JvdXAn
LCBpbmRpY2F0aW5nIHRoZSBjb21tYW5kcyB0aGF0IHNob3VsZCBiZSBydW4g
dG8gYWxsZXZpYXRlIHRoZQ0KK3NpdHVhdGlvbi4NCitTaW5jZSB0aGVzZSBu
YW1lcyBhcmUganVzdCBpbmRpY2F0b3JzLCBub3RoaW5nIHByZXZlbnRzIGFj
dHVhbGx5IGhhdmluZyBhDQordXNlciBuYW1lZCBgbWtwYXNzd2QnIGluIDxm
aWxlbmFtZT4vZXRjL3Bhc3N3ZDwvZmlsZW5hbWU+IChvciBhIGdyb3VwIG5h
bWVkDQorYG1rZ3JvdXAnIGluIDxmaWxlbmFtZT4vZXRjL2dyb3VwPC9maWxl
bmFtZT4pLiAgSWYgeW91IGRvIHRoYXQsIGhvd2V2ZXIsIGJlDQorYXdhcmUg
b2YgdGhlIHBvc3NpYmxlIGNvbmZ1c2lvbi4NCis8L3BhcmE+DQorDQorPC9z
ZWN0Mj4NCisNCiA8L3NlY3QxPg0K

---559023410-758783491-1044549436=:16397--
