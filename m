Return-Path: <cygwin-patches-return-3388-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10230 invoked by alias); 14 Jan 2003 12:24:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10220 invoked from network); 14 Jan 2003 12:24:05 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Tue, 14 Jan 2003 12:24:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Make system a pthread cancellation point
In-Reply-To: <1042541969.25787.10.camel@lifelesslap>
Message-ID: <Pine.WNT.4.44.0301141321461.342-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="227265-22978-1042547004=:342"
X-SW-Source: 2003-q1/txt/msg00037.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--227265-22978-1042547004=:342
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 414


On Tue, 14 Jan 2003, Robert Collins wrote:

> On Tue, 2003-01-14 at 21:50, Thomas Pfaff wrote:
> > Sorry, no testcase for that patch (it is really to simple).
>
> I think it really is worth adding test cases - even for simple things.
>
> It prevents regressions, which is the main reason for testing in the
> first place.
>
> So, please, if a test case can be written, lets do so.

Test case is attached.

Thomas

--227265-22978-1042547004=:342
Content-Type: TEXT/plain; name="cancel10.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0301141323240.342@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="cancel10.c"
Content-length: 1436

LyoKICogRmlsZTogY2FuY2VsMTAuYwogKgogKiBUZXN0IFN5bm9wc2lzOiBU
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
c3RhdHVzLgogKi8KCiNpbmNsdWRlICJ0ZXN0LmgiCgpzdGF0aWMgaW50IGNh
bmNlbGxlZCA9IDA7CgpzdGF0aWMgdm9pZCAqVGhyZWFkKHZvaWQgKnB1bnVz
ZWQpCnsKICB3aGlsZSAoIWNhbmNlbGxlZCkKICAgIFNsZWVwICgwKTsKCiAg
c3lzdGVtIChOVUxMKTsKCiAgcmV0dXJuIE5VTEw7Cn0KCmludCBtYWluICh2
b2lkKQp7CiAgdm9pZCAqIHJlc3VsdDsKICBwdGhyZWFkX3QgdDsKCiAgYXNz
ZXJ0IChwdGhyZWFkX2NyZWF0ZSAoJnQsIE5VTEwsIFRocmVhZCwgTlVMTCkg
PT0gMCk7CiAgYXNzZXJ0IChwdGhyZWFkX2NhbmNlbCAodCkgPT0gMCk7CiAg
Y2FuY2VsbGVkID0gMTsKICBhc3NlcnQgKHB0aHJlYWRfam9pbiAodCwgJnJl
c3VsdCkgPT0gMCk7CiAgYXNzZXJ0IChyZXN1bHQgPT0gUFRIUkVBRF9DQU5D
RUxFRCk7CgogIHJldHVybiAwOwp9Cg==

--227265-22978-1042547004=:342--
