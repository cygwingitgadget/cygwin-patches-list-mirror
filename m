Return-Path: <cygwin-patches-return-3394-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20582 invoked by alias); 15 Jan 2003 13:19:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20566 invoked from network); 15 Jan 2003 13:19:53 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Wed, 15 Jan 2003 13:19:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] system-cancel part2
In-Reply-To: <1042635258.16748.21.camel@lifelesslap>
Message-ID: <Pine.WNT.4.44.0301151357510.249-300000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1307872-21188-1042636765=:249"
X-SW-Source: 2003-q1/txt/msg00043.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1307872-21188-1042636765=:249
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 821



On Wed, 15 Jan 2003, Robert Collins wrote:

> On Wed, 2003-01-15 at 22:23, Thomas Pfaff wrote:
> > This patch will make sure that the signal handlers that are saved in the
> > system call are restored even if the thread got cancelled. Since
> > spawn_guts uses waitpid when mode is _P_WAIT spawn_guts is a cancellation
> > point.
> >
> > Attached is the patch and a new test case.
>
> The new test case doesn't appear to check that the signal handlers where
> saved. Am I misreading that?
>

The test case was created to prove that system is a cancellation point
even if the child process is already created and the system call is
waiting on child termination.

Atached are two test cases that will test if the signal handlers are
restored when the call get cancelled and has waited successfully for the
child.

Thomas

--1307872-21188-1042636765=:249
Content-Type: TEXT/plain; name="cancel11.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0301151419250.249@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="cancel11.c"
Content-length: 1525

LyoKICogRmlsZTogY2FuY2VsMTEuYwogKgogKiBUZXN0IFN5bm9wc2lzOiBU
ZXN0IGlmIHN5c3RlbSBpcyBhIGNhbmNlbGxhdGlvbiBwb2ludC4KICoKICog
VGVzdCBNZXRob2QgKFZhbGlkYXRpb24gb3IgRmFsc2lmaWNhdGlvbik6CiAq
IC0gCiAqCiAqIFJlcXVpcmVtZW50cyBUZXN0ZWQ6CiAqIC0KICoKICogRmVh
dHVyZXMgVGVzdGVkOgogKiAtIAogKgogKiBDYXNlcyBUZXN0ZWQ6CiAqIC0g
CiAqCiAqIERlc2NyaXB0aW9uOgogKiAtIAogKgogKiBFbnZpcm9ubWVudDoK
ICogLSAKICoKICogSW5wdXQ6CiAqIC0gTm9uZS4KICoKICogT3V0cHV0Ogog
KiAtIEZpbGUgbmFtZSwgTGluZSBudW1iZXIsIGFuZCBmYWlsZWQgZXhwcmVz
c2lvbiBvbiBmYWlsdXJlLgogKiAtIE5vIG91dHB1dCBvbiBzdWNjZXNzLgog
KgogKiBBc3N1bXB0aW9uczoKICogLSBoYXZlIHdvcmtpbmcgcHRocmVhZF9j
cmVhdGUsIHB0aHJlYWRfY2FuY2VsLCBwdGhyZWFkX3NldGNhbmNlbHN0YXRl
CiAqICAgcHRocmVhZF9qb2luCiAqCiAqIFBhc3MgQ3JpdGVyaWE6CiAqIC0g
UHJvY2VzcyByZXR1cm5zIHplcm8gZXhpdCBzdGF0dXMuCiAqCiAqIEZhaWwg
Q3JpdGVyaWE6CiAqIC0gUHJvY2VzcyByZXR1cm5zIG5vbi16ZXJvIGV4aXQg
c3RhdHVzLgogKi8KCiNpbmNsdWRlICJ0ZXN0LmgiCgpzdGF0aWMgdm9pZCBz
aWdfaGFuZGxlcihpbnQgc2lnKQp7Cn0KCnN0YXRpYyB2b2lkICpUaHJlYWQo
dm9pZCAqcHVudXNlZCkKewogIHN5c3RlbSAoInNsZWVwIDEwIik7CgogIHJl
dHVybiBOVUxMOwp9CgppbnQgbWFpbiAodm9pZCkKewogIHZvaWQgKiByZXN1
bHQ7CiAgcHRocmVhZF90IHQ7CgogIHNpZ25hbCAoU0lHSU5ULCBzaWdfaGFu
ZGxlcik7CgogIGFzc2VydCAocHRocmVhZF9jcmVhdGUgKCZ0LCBOVUxMLCBU
aHJlYWQsIE5VTEwpID09IDApOwogIHNsZWVwICg1KTsKICBhc3NlcnQgKHB0
aHJlYWRfY2FuY2VsICh0KSA9PSAwKTsKICBhc3NlcnQgKHB0aHJlYWRfam9p
biAodCwgJnJlc3VsdCkgPT0gMCk7CiAgYXNzZXJ0IChyZXN1bHQgPT0gUFRI
UkVBRF9DQU5DRUxFRCk7CgogIGFzc2VydCAoKHZvaWQgKilzaWduYWwgKFNJ
R0lOVCwgTlVMTCkgPT0gc2lnX2hhbmRsZXIpOwoKICByZXR1cm4gMDsKfQo=

--1307872-21188-1042636765=:249
Content-Type: TEXT/plain; name="cancel12.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0301151419251.249@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="cancel12.c"
Content-length: 1464

LyoKICogRmlsZTogY2FuY2VsMTIuYwogKgogKiBUZXN0IFN5bm9wc2lzOiBU
ZXN0IGlmIHN5c3RlbSBpcyBhIGNhbmNlbGxhdGlvbiBwb2ludC4KICoKICog
VGVzdCBNZXRob2QgKFZhbGlkYXRpb24gb3IgRmFsc2lmaWNhdGlvbik6CiAq
IC0gCiAqCiAqIFJlcXVpcmVtZW50cyBUZXN0ZWQ6CiAqIC0KICoKICogRmVh
dHVyZXMgVGVzdGVkOgogKiAtIAogKgogKiBDYXNlcyBUZXN0ZWQ6CiAqIC0g
CiAqCiAqIERlc2NyaXB0aW9uOgogKiAtIAogKgogKiBFbnZpcm9ubWVudDoK
ICogLSAKICoKICogSW5wdXQ6CiAqIC0gTm9uZS4KICoKICogT3V0cHV0Ogog
KiAtIEZpbGUgbmFtZSwgTGluZSBudW1iZXIsIGFuZCBmYWlsZWQgZXhwcmVz
c2lvbiBvbiBmYWlsdXJlLgogKiAtIE5vIG91dHB1dCBvbiBzdWNjZXNzLgog
KgogKiBBc3N1bXB0aW9uczoKICogLSBoYXZlIHdvcmtpbmcgcHRocmVhZF9j
cmVhdGUsIHB0aHJlYWRfY2FuY2VsLCBwdGhyZWFkX3NldGNhbmNlbHN0YXRl
CiAqICAgcHRocmVhZF9qb2luCiAqCiAqIFBhc3MgQ3JpdGVyaWE6CiAqIC0g
UHJvY2VzcyByZXR1cm5zIHplcm8gZXhpdCBzdGF0dXMuCiAqCiAqIEZhaWwg
Q3JpdGVyaWE6CiAqIC0gUHJvY2VzcyByZXR1cm5zIG5vbi16ZXJvIGV4aXQg
c3RhdHVzLgogKi8KCiNpbmNsdWRlICJ0ZXN0LmgiCgpzdGF0aWMgdm9pZCBz
aWdfaGFuZGxlcihpbnQgc2lnKQp7Cn0KCnN0YXRpYyB2b2lkICpUaHJlYWQo
dm9pZCAqcHVudXNlZCkKewogIHNpZ25hbCAoU0lHSU5ULCBzaWdfaGFuZGxl
cik7CgogIHN5c3RlbSAoInNsZWVwIDUiKTsKCiAgYXNzZXJ0ICgodm9pZCAq
KXNpZ25hbCAoU0lHSU5ULCBOVUxMKSA9PSBzaWdfaGFuZGxlcik7CgogIHJl
dHVybiBOVUxMOwp9CgppbnQgbWFpbiAodm9pZCkKewogIHZvaWQgKm9sZF9z
aWdoOwogIHZvaWQgKiByZXN1bHQ7CiAgcHRocmVhZF90IHQ7CgogIGFzc2Vy
dCAocHRocmVhZF9jcmVhdGUgKCZ0LCBOVUxMLCBUaHJlYWQsIE5VTEwpID09
IDApOwogIGFzc2VydCAocHRocmVhZF9qb2luICh0LCAmcmVzdWx0KSA9PSAw
KTsKICBhc3NlcnQgKHJlc3VsdCA9PSBOVUxMKTsKCiAgcmV0dXJuIDA7Cn0K

--1307872-21188-1042636765=:249--
