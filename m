Return-Path: <cygwin-patches-return-4660-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13213 invoked by alias); 10 Apr 2004 03:23:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13203 invoked from network); 10 Apr 2004 03:23:11 -0000
Message-Id: <3.0.5.32.20040409231957.00857bb0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 10 Apr 2004 03:23:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: path.cc
In-Reply-To: <20040410005113.GA4147@coe>
References: <3.0.5.32.20040404234622.00800100@incoming.verizon.net>
 <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net>
 <3.0.5.32.20040403214940.007f2650@incoming.verizon.net>
 <3.0.5.32.20040403214940.007f2650@incoming.verizon.net>
 <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net>
 <3.0.5.32.20040404234622.00800100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00012.txt.bz2

At 08:51 PM 4/9/2004 -0400, Christopher Faylor wrote:
>
>I've checked both of these in and am generating a snapshot now.
>
>Could you advertise its existence on cygwin at cygwin, Pierre?  I think
>we need feedback on these changes before we go live with a new release.

O.K. Chris, will do. However I have noticed two or three more things
(which I resisted including in the other patches).
- normalize_win32_path does not remove a trailing dot (xxxx\. )
  is that by design?
- and it does not handle names consisting only of ....
- and thus there is still a test for that in chdir, with an obsolete
  comment.
- Also, if we agree that the FIXME around line 757 is not needed,
  should we remove the comment?
- and around line 1490, in the else clause of "if (i < nmounts)",
  is it possible to have anything but a "C:" or UNC path (assuming
  that the root / is defined)? If so we could remove all tests and
  simply backslashify. That wouldn't really hurt when / isn't defined.   

Should I thus wait to advertise the snapshot until that's fixed?
(I won't touch any of that this evening).

Looking to the future, now that fs_info::update isn't really doing an
update (a better name would be fs_info::get), it turns out that the
  char name_storage[CYG_MAX_PATH];
  char root_dir_storage[CYG_MAX_PATH];
fields in fs_info can be removed (that requires a few other minor changes). 
Doing that would cut down the size of a fhandler from about 920 bytes
to 400, which looks like a good thing.

But coincidentally Corinna has also worked on related stuff today.
With her edit an even more efficient option would be to change
  fs_info fs; 
to
  fs_info * fs_ptr;
in path_conv. Corinna, are you heading that way?

I am somewhat concerned that the update of fsinfo isn't thread safe.
I don't know how the overhead of making it thread safe compares with
the overhead of the old method (not caching the fs_info).

Pierre
 
