Return-Path: <cygwin-patches-return-2658-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8204 invoked by alias); 16 Jul 2002 17:18:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8189 invoked from network); 16 Jul 2002 17:18:58 -0000
Date: Tue, 16 Jul 2002 10:18:00 -0000
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: [Setup] [Patch] New Views for Skipped Packages and Installed Packages (keeps)
Message-Id: <VA.00000bf9.00ef70a7@thesoftwaresource.com>
From: Brian Keener <bkeener@thesoftwaresource.com>
Reply-To: bkeener@thesoftwaresource.com
In-Reply-To: <01dd01c22bf4$43b1de20$1800a8c0@LAPTOP>
References: <000501c22951$a948b740$0200a8c0@lifelesswks> <VA.00000bf1.00258f45@thesoftwaresource.com> <01dd01c22bf4$43b1de20$1800a8c0@LAPTOP>
X-SW-Source: 2002-q3/txt/msg00106.txt.bz2

Robert Collins wrote:
> if you look in CVS/Entries, the last field is the tag.
> HEAD:
> /choose.cc/2.106/Mon Jul 15 11:33:48 2002//
> 
> setup-200207:
> /choose.cc/2.101.2.1/Fri Jul  5 02:01:10 2002//Tsetup-200207

I must have mucked up a merge when I updated from CVS while I was making these 
changes because all my tags showed // which would mean they were from HEAD - 
correct?  I updated again and specified -r HEAD and now they all show /THEAD so 
I must have it now.

> 
> To get a list of the available tags, you can look in val-tags in CVSROOT.
> (You may need to check CVSROOT out first). Or you can go to the cvsweb site
> referenced from http://sources.redhat.com/cygwin-apps/setup.html and click
> on the dropdown list of tags.

I obviously don't understand something here.  I found what I needed on the Web 
page (the list of tags) but as far as CVSROOT goes:  I looked at it on the web 
and even checked it out but never saw a file called val-tags or anything other 
file that listed the tags.  At any rate the drop down list works.
       
Thanks

bk

