Return-Path: <cygwin-patches-return-3578-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13155 invoked by alias); 17 Feb 2003 18:48:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13145 invoked from network); 17 Feb 2003 18:48:52 -0000
Date: Mon, 17 Feb 2003 18:48:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
In-Reply-To: <20030217183026.GA7514@redhat.com>
Message-ID: <20030217194118.P97990-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=-0.5 required=5.0
	tests=CARRIAGE_RETURNS,IN_REP_TO,QUOTED_EMAIL_TEXT,
	      SPAM_PHRASE_00_01
	version=2.43
X-Spam-Level: 
X-SW-Source: 2003-q1/txt/msg00227.txt.bz2

> Btw, now that I've said that it occurred to me to check
> GetVolumeInformation.  There is apparently a FILE_SUPPORTS_SPARSE_FILES
> flag available.  That's the ultimate way to deal with this rather than
> adding a wincap, I believe.  Check (pc->fs.flags &
> FILE_SUPPORTS_SPARSE_FILES) in fhandler_disk_file::open and do the
> appropriate thing there.
>
> Sorry I didn't think of this before.
>
> cgf

I know about this flag and I have considered it when I started writing this
patch. It has one flaw. The volume of root of the path to the file doesn't have
to be the same volume as the file is physicaly stored on in case of reparse
points presence. Besides I don't see it as a problem if this call fails to set
the sparseness becase the file system doesn't support it.

Vaclav Haisman
