Return-Path: <cygwin-patches-return-2659-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28425 invoked by alias); 17 Jul 2002 08:05:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28399 invoked from network); 17 Jul 2002 08:05:27 -0000
Message-ID: <027801c22d68$ba3a3220$d500a8c0@study2>
From: "Robert Collins" <robert.collins@syncretize.net>
To: <bkeener@thesoftwaresource.com>,
	"cygwin-patches" <cygwin-patches@cygwin.com>
References: <000501c22951$a948b740$0200a8c0@lifelesswks> <VA.00000bf1.00258f45@thesoftwaresource.com> <01dd01c22bf4$43b1de20$1800a8c0@LAPTOP> <VA.00000bf9.00ef70a7@thesoftwaresource.com>
Subject: Re: [Setup] [Patch] New Views for Skipped Packages and Installed Packages (keeps)
Date: Wed, 17 Jul 2002 01:05:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00107.txt.bz2


----- Original Message -----
From: "Brian Keener" <bkeener@thesoftwaresource.com>
To: "cygwin-patches" <cygwin-patches@cygwin.com>
Sent: Wednesday, July 17, 2002 3:18 AM
Subject: Re: [Setup] [Patch] New Views for Skipped Packages and Installed
Packages (keeps)


> Robert Collins wrote:
> > if you look in CVS/Entries, the last field is the tag.
> > HEAD:
> > /choose.cc/2.106/Mon Jul 15 11:33:48 2002//
> >
> > setup-200207:
> > /choose.cc/2.101.2.1/Fri Jul  5 02:01:10 2002//Tsetup-200207
>
> I must have mucked up a merge when I updated from CVS while I was making
these
> changes because all my tags showed // which would mean they were from
HEAD -
> correct?  I updated again and specified -r HEAD and now they all show
/THEAD so
> I must have it now.

Yes they should have been ok, I'd say a mucked up merge is correct. I use
cvs -z3 up -Akkv
when I need to reset to point to HEAD. grabbing the HEAD tag is a nuisance -
because it's not a branch, so the files get frozen and don't update. You
need MAIN if you want the trunk tag, but oftimes -rMAIN doesn't work.

> > To get a list of the available tags, you can look in val-tags in
CVSROOT.
> > (You may need to check CVSROOT out first). Or you can go to the cvsweb
site
> > referenced from http://sources.redhat.com/cygwin-apps/setup.html and
click
> > on the dropdown list of tags.
>
> I obviously don't understand something here.  I found what I needed on the
Web
> page (the list of tags) but as far as CVSROOT goes:  I looked at it on the
web
> and even checked it out but never saw a file called val-tags or anything
other
> file that listed the tags.  At any rate the drop down list works.

It's not visible on the web, but it does exist.

Rob
