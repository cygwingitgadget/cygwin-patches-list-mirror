Return-Path: <cygwin-patches-return-3580-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30000 invoked by alias); 17 Feb 2003 19:23:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29991 invoked from network); 17 Feb 2003 19:23:15 -0000
Date: Mon, 17 Feb 2003 19:23:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
In-Reply-To: <20030217185225.GD7514@redhat.com>
Message-ID: <20030217201745.R97990-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=-0.5 required=5.0
	tests=CARRIAGE_RETURNS,IN_REP_TO,QUOTED_EMAIL_TEXT,
	      SPAM_PHRASE_00_01
	version=2.43
X-Spam-Level: 
X-SW-Source: 2003-q1/txt/msg00229.txt.bz2

> This is consistent with the way the rest of cygwin works, however.  The
> same argument could be applied to testing for ntsec.  If this was an issue
> then we should be changing the fs information to reflect reparse points.
>
> cgf

I am not sure what is the conclusion here. Should I make it check for
FILE_SUPPORTS_SPARSE_FILES even though it can be inaccurate?

Vaclav Haisman
