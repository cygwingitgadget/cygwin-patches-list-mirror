Return-Path: <cygwin-patches-return-3540-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3269 invoked by alias); 7 Feb 2003 15:24:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3254 invoked from network); 7 Feb 2003 15:24:53 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Fri, 07 Feb 2003 15:24:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: [doc PATCH] Re: ntsec odds and ends, take 2
In-Reply-To: <20030207100024.GE27349@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.44.0302071019490.12312-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-684387517-1044631310=:12312"
Content-ID: <Pine.GSO.4.44.0302071024090.12312@slinky.cs.nyu.edu>
X-SW-Source: 2003-q1/txt/msg00189.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-684387517-1044631310=:12312
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.44.0302071024091.12312@slinky.cs.nyu.edu>
Content-length: 1181

On Fri, 7 Feb 2003, Corinna Vinschen wrote:

> On Thu, Feb 06, 2003 at 02:49:59PM -0500, Igor Pechtchanski wrote:
> > Yes, it is.  What I meant was "files show up in the 'ls -l' listing with
> > '????????' in the user field".  Since the Administrators group is not the
> > current user, this field won't be set to whatever the default is, will it?
>
> It will be shown as "????????".  Just take my list in the previous mail
> serious ;-)
> Corinna

Corinna,

Ok, take 2 is attached.  I played it safe and actually included the list
you gave in your e-mail as a fallback.  Do read the rest of it, though,
please. ;-)
	Igor
=======================================================================
ChangeLog (needed?):
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

---559023410-684387517-1044631310=:12312
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ntsec-special-names.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0302071021500.12312@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ntsec-special-names.patch"
Content-length: 4181

SW5kZXg6IHdpbnN1cC9kb2MvbnRzZWMuc2dtbA0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvZG9jL250
c2VjLnNnbWwsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjkNCmRpZmYgLXUg
LXAgLXIxLjkgbnRzZWMuc2dtbA0KLS0tIHdpbnN1cC9kb2MvbnRzZWMuc2dt
bAkyMyBPY3QgMjAwMiAwNDoyOTo0NiAtMDAwMAkxLjkNCisrKyB3aW5zdXAv
ZG9jL250c2VjLnNnbWwJNyBGZWIgMjAwMyAxNToxNzo0NiAtMDAwMA0KQEAg
LTczMSw0ICs3MzEsNjcgQEAgYWJsZSB0byBhY2Nlc3MgaXQgd2hlbiB0cnlp
bmcgdG8gbG9naW4gdQ0KIA0KIDwvc2VjdDI+DQogDQorPHNlY3QyIGlkPSJu
dHNlYy1yZWxlYXNlMS4zLjIwIj48dGl0bGU+U3BlY2lhbCB2YWx1ZXMgb2Yg
dXNlciBhbmQgZ3JvdXANCitpZHM8L3RpdGxlPg0KKw0KKzxwYXJhPg0KK0lm
IHRoZSBjdXJyZW50IHVzZXIgaXMgbm90IHByZXNlbnQgaW4gPGZpbGVuYW1l
Pi9ldGMvcGFzc3dkPC9maWxlbmFtZT4sDQordGhhdCB1c2VyJ3MgdXNlciBp
ZCBpcyBzZXQgdG8gYSBzcGVjaWFsIHZhbHVlIG9mIDQwMC4gIFRoZSB1c2Vy
IG5hbWUgZm9yDQordGhlIGN1cnJlbnQgdXNlciB3aWxsIGFsd2F5cyBiZSBz
aG93biBjb3JyZWN0bHkuICBJZiBhbm90aGVyIHVzZXINCisob3IgYSBXaW5k
b3dzIGdyb3VwLCB0cmVhdGVkIGFzIGEgdXNlcikgaXMgbm90IHByZXNlbnQg
aW4NCis8ZmlsZW5hbWU+L2V0Yy9wYXNzd2Q8L2ZpbGVuYW1lPiwgdGhlIHVz
ZXIgaWQgb2YgdGhhdCB1c2VyIHdpbGwgaGF2ZSBhDQorc3BlY2lhbCB2YWx1
ZSBvZiAtMSAod2hpY2ggd291bGQgYmUgc2hvd24gYnkgPGNvbW1hbmQ+bHM8
L2NvbW1hbmQ+IGFzDQorNjU1MzUpLiAgVGhlIHVzZXIgbmFtZSBzaG93biBp
biB0aGlzIGNhc2Ugd2lsbCBiZSAnPz8/Pz8/Pz8nLg0KKzwvcGFyYT4NCisN
Cis8cGFyYT4NCitJZiB0aGUgY3VycmVudCB1c2VyIGlzIG5vdCBwcmVzZW50
IGluIDxmaWxlbmFtZT4vZXRjL3Bhc3N3ZDwvZmlsZW5hbWU+LA0KK3RoYXQg
dXNlcidzIGxvZ2luIGdyb3VwIGlkIGlzIHNldCB0byBhIHNwZWNpYWwgdmFs
dWUgb2YgNDAxLiAgSWYgYW5vdGhlcg0KK3VzZXIgaXMgbm90IHByZXNlbnQg
aW4gPGZpbGVuYW1lPi9ldGMvcGFzc3dkPC9maWxlbmFtZT4sIHRoYXQgdXNl
cidzIGxvZ2luDQorZ3JvdXAgaWQgaXMgc2V0IHRvIGEgc3BlY2lhbCB2YWx1
ZSBvZiAtMS4gIElmIHRoZSB1c2VyIGlzIHByZXNlbnQgaW4NCis8ZmlsZW5h
bWU+L2V0Yy9wYXNzd2Q8L2ZpbGVuYW1lPiwgYnV0IHRoYXQgdXNlcidzIGdy
b3VwIGlzIG5vdCBpbg0KKzxmaWxlbmFtZT4vZXRjL2dyb3VwPC9maWxlbmFt
ZT4gYW5kIGlzIG5vdCB0aGUgbG9naW4gZ3JvdXAgb2YgdGhhdCB1c2VyLA0K
K3RoZSBncm91cCBpZCBpcyBzZXQgdG8gYSBzcGVjaWFsIHZhbHVlIG9mIC0x
LiAgVGhlIG5hbWUgb2YgdGhpcyBncm91cA0KKyhpZCAtMSkgd2lsbCBiZSBz
aG93biBhcyAnPz8/Pz8/Pz8nLg0KK0luIHJlbGVhc2VzIG9mIEN5Z3dpbiBi
ZWZvcmUgMS4zLjIwLCB0aGUgZ3JvdXAgaWQgNDAxIGhhZCBhIGdyb3VwIG5h
bWUNCisnTm9uZScuICBTaW5jZSBDeWd3aW4gcmVsZWFzZSAxLjMuMjAsIHRo
ZSBncm91cCBpZCA0MDEgaXMgc2hvd24gYXMNCisnbWtwYXNzd2QnLCBpbmRp
Y2F0aW5nIHRoZSBjb21tYW5kIHRoYXQgc2hvdWxkIGJlIHJ1biB0byBhbGxl
dmlhdGUgdGhlDQorc2l0dWF0aW9uLg0KKzwvcGFyYT4NCisNCis8cGFyYT4N
CitBbHNvLCBzaW5jZSBDeWd3aW4gcmVsZWFzZSAxLjMuMjAsIGlmIHRoZSBj
dXJyZW50IHVzZXIgaXMgcHJlc2VudCBpbg0KKzxmaWxlbmFtZT4vZXRjL3Bh
c3N3ZDwvZmlsZW5hbWU+LCBidXQgdGhhdCB1c2VyJ3MgbG9naW4gZ3JvdXAg
aXMgbm90DQorcHJlc2VudCBpbiA8ZmlsZW5hbWU+L2V0Yy9ncm91cDwvZmls
ZW5hbWU+LCB0aGUgZ3JvdXAgbmFtZSB3aWxsIGJlIHNob3duDQorYXMgJ21r
Z3JvdXAnLCBhZ2FpbiBpbmRpY2F0aW5nIHRoZSBhcHByb3ByaWF0ZSBjb21t
YW5kLg0KKzwvcGFyYT4NCisNCis8cGFyYT5UbyBzdW1tYXJpemU6PC9wYXJh
Pg0KKzxpdGVtaXplZGxpc3Qgc3BhY2luZz0iY29tcGFjdCI+DQorDQorPGxp
c3RpdGVtPjxwYXJhPklmIHRoZSBjdXJyZW50IHVzZXIgZG9lc24ndCBzaG93
IHVwIGluDQorPGZpbGVuYW1lPi9ldGMvcGFzc3dkPC9maWxlbmFtZT4sIGl0
J3MgPGVtcGhhc2lzPmdyb3VwPC9lbXBoYXNpcz4gd2lsbA0KK2JlIG5hbWVk
ICdta3Bhc3N3ZCcuPC9wYXJhPjwvbGlzdGl0ZW0+DQorDQorPGxpc3RpdGVt
PjxwYXJhPk90aGVyd2lzZSwgaWYgdGhlIGxvZ2luIGdyb3VwIG9mIHRoZSBj
dXJyZW50IHVzZXIgaXNuJ3QNCitpbiA8ZmlsZW5hbWU+L2V0Yy9ncm91cDwv
ZmlsZW5hbWU+LCBpdCB3aWxsIGJlIG5hbWVkICdta2dyb3VwJy48L3BhcmE+
DQorPC9saXN0aXRlbT4NCisNCis8bGlzdGl0ZW0+PHBhcmE+T3RoZXJ3aXNl
IGEgZ3JvdXAgbm90IGluIDxmaWxlbmFtZT4vZXRjL2dyb3VwPC9maWxlbmFt
ZT4NCit3aWxsIGJlIHNob3duIGFzICc/Pz8/Pz8/PycgYW5kIGEgdXNlciBu
b3QgaW4NCis8ZmlsZW5hbWU+L2V0Yy9wYXNzd2Q8L2ZpbGVuYW1lPiB3aWxs
IGJlIHNob3duIGFzICI/Pz8/Pz8/PyIuPC9wYXJhPg0KKzwvbGlzdGl0ZW0+
DQorDQorPC9pdGVtaXplZGxpc3Q+DQorDQorPHBhcmE+DQorTm90ZSB0aGF0
LCBzaW5jZSB0aGUgc3BlY2lhbCB1c2VyIGFuZCBncm91cCBuYW1lcyBhcmUg
anVzdCBpbmRpY2F0b3JzLA0KK25vdGhpbmcgcHJldmVudHMgeW91IGZyb20g
YWN0dWFsbHkgaGF2aW5nIGEgdXNlciBuYW1lZCBgbWtwYXNzd2QnIGluDQor
PGZpbGVuYW1lPi9ldGMvcGFzc3dkPC9maWxlbmFtZT4gKG9yIGEgZ3JvdXAg
bmFtZWQgYG1rZ3JvdXAnIGluDQorPGZpbGVuYW1lPi9ldGMvZ3JvdXA8L2Zp
bGVuYW1lPikuICBJZiB5b3UgZG8gdGhhdCwgaG93ZXZlciwgYmUgYXdhcmUg
b2YNCit0aGUgcG9zc2libGUgY29uZnVzaW9uLg0KKzwvcGFyYT4NCisNCis8
L3NlY3QyPg0KKw0KIDwvc2VjdDE+DQo=

---559023410-684387517-1044631310=:12312--
