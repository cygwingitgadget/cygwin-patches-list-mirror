Return-Path: <cygwin-patches-return-5712-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27336 invoked by alias); 13 Jan 2006 05:01:54 -0000
Received: (qmail 27322 invoked by uid 22791); 13 Jan 2006 05:01:53 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 13 Jan 2006 05:01:50 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k0D51lA7027356 	for <cygwin-patches@cygwin.com>; Fri, 13 Jan 2006 00:01:48 -0500 (EST)
Date: Fri, 13 Jan 2006 05:01:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Proposed clarification of the snapshot installation FAQ
In-Reply-To: <Pine.GSO.4.63.0601122333160.27020@access1.cims.nyu.edu>
Message-ID: <Pine.GSO.4.63.0601122359430.27020@access1.cims.nyu.edu>
References: <dpu1ks$i0a$1@sea.gmane.org> <43C32DA9.2070900@cygwin.com>   <dpvba1$i83$1@sea.gmane.org> <43C3F412.1010008@cygwin.com> <dq3d00$4o7$1@sea.gmane.org>   <Pine.GSO.4.63.0601111200110.9317@access1.cims.nyu.edu> <dq3h09$k5o$1@sea.gmane.org>   <Pine.GSO.4.63.0601112136461.9317@access1.cims.nyu.edu>   <cb51e2e0601121957p711594fexdf2a87e4395e3059@mail.gmail.com>   <20060113041529.GB11985@trixie.casa.cgf.cx> <Pine.GSO.4.63.0601122333160.27020@access1.cims.nyu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-959030623-1137128507=:27020"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00021.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-959030623-1137128507=:27020
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1235

On Thu, 12 Jan 2006, Igor Peshansky wrote:

> On Thu, 12 Jan 2006, Christopher Faylor wrote:
>
> > Nevertheless, the advice about using "mv" to rename cygwin1.dll won't
> > work on every version of Windows and needs to be changed.
>
> Hmm, it's worked for me on Win98, Win2k, and WinXP (though I suppose
> there could be differences on, say, WinNT4 or something)...  I basically
> wanted to avoid giving too many things to do in Windows Explorer.  But
> no matter -- I'll submit a patch with this change shortly.

And here it is.
	Igor
==============================================================================
2006-01-12  Igor Peshansky  <pechtcha@cs.nyu.edu>

	* faq-setup.xml (faq.setup.snapshots): Rename DLL using Windows tools.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
---559023410-959030623-1137128507=:27020
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=faq-install-snapshots-nomv.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.63.0601130001470.27020@access1.cims.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename=faq-install-snapshots-nomv.patch
Content-length: 1684

SW5kZXg6IGZhcS1zZXR1cC54bWwNCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2RvYy9mYXEtc2V0dXAu
eG1sLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4zDQpkaWZmIC11IC1wIC1y
MS4zIGZhcS1zZXR1cC54bWwNCi0tLSBmYXEtc2V0dXAueG1sCTEzIEphbiAy
MDA2IDAzOjU1OjIzIC0wMDAwCTEuMw0KKysrIGZhcS1zZXR1cC54bWwJMTMg
SmFuIDIwMDYgMDQ6NTc6MzEgLTAwMDANCkBAIC00MTksMTIgKzQxOSwxMiBA
QCB0aGUgZm9sbG93aW5nIGNvbW1hbmRzOg0KIDxzY3JlZW4+DQogCS9iaW4v
dGFyIC1DLyAtanh2ZiAvcG9zaXgvcGF0aC90by9jeWd3aW4taW5zdC1ZWVlZ
TU1ERC50YXIuYnoyIC0tZXhjbHVkZT11c3IvYmluL2N5Z3dpbjEuZGxsDQog
CS9iaW4vdGFyIC1DL3RtcCAtanh2ZiAvcG9zaXgvcGF0aC90by9jeWd3aW4t
aW5zdC1ZWVlZTU1ERC50YXIuYnoyIHVzci9iaW4vY3lnd2luMS5kbGwNCi0J
L2Jpbi9tdiAvYmluL2N5Z3dpbjEuZGxsIC9iaW4vY3lnd2luMS1wcmV2LmRs
bA0KIDwvc2NyZWVuPg0KIDwvcGFyYT4NCi08cGFyYT5Ob3RlIHRoYXQgYWZ0
ZXIgdGhlICI8bGl0ZXJhbD5tdjwvbGl0ZXJhbD4iIGNvbW1hbmQgeW91IHdp
bGwgbm90IGJlIGFibGUgdG8gcnVuIGFueQ0KLUN5Z3dpbiBwcm9ncmFtcy4g
IEV4aXQgdGhlIGJhc2ggc2hlbGwsIGFuZCB1c2UgRXhwbG9yZXIgb3IgdGhl
DQotV2luZG93cyBjb21tYW5kIHNoZWxsIHRvIG1vdmUgPGxpdGVyYWw+Qzpc
Y3lnd2luXHRtcFx1c3JcYmluXGN5Z3dpbjEuZGxsPC9saXRlcmFsPg0KKzxw
YXJhPkV4aXQgdGhlIGJhc2ggc2hlbGwsIGFuZCB1c2UgRXhwbG9yZXIgb3Ig
dGhlIFdpbmRvd3MgY29tbWFuZCBzaGVsbCB0bw0KK2ZpcnN0IHJlbmFtZSA8
bGl0ZXJhbD5DOlxjeWd3aW5cYmluXGN5Z3dpbjEuZGxsPC9saXRlcmFsPiB0
bw0KKzxsaXRlcmFsPkM6XGN5Z3dpblxiaW5cY3lnd2luMS1wcmV2LmRsbDwv
bGl0ZXJhbD4gYW5kIHRoZW4gbW92ZQ0KKzxsaXRlcmFsPkM6XGN5Z3dpblx0
bXBcdXNyXGJpblxjeWd3aW4xLmRsbDwvbGl0ZXJhbD4NCiB0byA8bGl0ZXJh
bD5DOlxjeWd3aW5cYmluXGN5Z3dpbjEuZGxsPC9saXRlcmFsPiAoYXNzdW1p
bmcgeW91IGluc3RhbGxlZCBDeWd3aW4gaW4NCiA8bGl0ZXJhbD5DOlxjeWd3
aW48L2xpdGVyYWw+KS4NCiA8L3BhcmE+DQo=

---559023410-959030623-1137128507=:27020--
