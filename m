Return-Path: <cygwin-patches-return-2655-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24334 invoked by alias); 15 Jul 2002 11:39:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24320 invoked from network); 15 Jul 2002 11:39:31 -0000
Message-ID: <01dd01c22bf4$43b1de20$1800a8c0@LAPTOP>
From: "Robert Collins" <robert.collins@syncretize.net>
To: <bkeener@thesoftwaresource.com>,
	"cygwin-patches" <cygwin-patches@cygwin.com>
References: <000501c22951$a948b740$0200a8c0@lifelesswks> <VA.00000bf1.00258f45@thesoftwaresource.com>
Subject: Re: [Setup] [Patch] New Views for Skipped Packages and Installed Packages (keeps)
Date: Mon, 15 Jul 2002 04:39:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00103.txt.bz2

It can't be against head, as you are using db.packages.number() which
doesn't exist since I got rid of the custom container code...

if you look in CVS/Entries, the last field is the tag.
HEAD:
/choose.cc/2.106/Mon Jul 15 11:33:48 2002//

setup-200207:
/choose.cc/2.101.2.1/Fri Jul  5 02:01:10 2002//Tsetup-200207

To get a list of the available tags, you can look in val-tags in CVSROOT.
(You may need to check CVSROOT out first). Or you can go to the cvsweb site
referenced from http://sources.redhat.com/cygwin-apps/setup.html and click
on the dropdown list of tags.

Could you please update the patch to be against HEAD, and check it - then
I'll happily commit it.

Rob
----- Original Message -----
From: "Brian Keener" <bkeener@thesoftwaresource.com>
To: "cygwin-patches" <cygwin-patches@cygwin.com>
Sent: Saturday, July 13, 2002 1:20 AM
Subject: Re: [Setup] [Patch] New Views for Skipped Packages and Installed
Packages (keeps)


> Robert Collins wrote:
> > Sure. It doesn't apply for me - what branch is it against? If it's
> > against HEAD, can you please post it as an attachment?
>
> I thought these changes were listed in the README under wishlist, but at
any
> rate it is against HEAD (I thought).  I'll show my stupidity once again
since I
> don't guess I realized we currently had other branches working.
>
> Where would I go via the Web to check active branches or better yet can I
get
> CVS to tell me?
>
> Bk
>
>
