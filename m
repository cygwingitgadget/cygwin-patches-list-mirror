Return-Path: <cygwin-patches-return-3592-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27315 invoked by alias); 19 Feb 2003 00:44:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27295 invoked from network); 19 Feb 2003 00:44:54 -0000
Date: Wed, 19 Feb 2003 00:44:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
In-Reply-To: <00b701c2d7ad$a0cba590$78d96f83@pomello>
Message-ID: <20030219013337.V52168-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=-0.2 required=6.0
	tests=CARRIAGE_RETURNS,IN_REP_TO,QUOTED_EMAIL_TEXT,
	      SPAM_PHRASE_03_05
	version=2.44
X-Spam-Level: 
X-SW-Source: 2003-q1/txt/msg00241.txt.bz2


> Could you do some tests, so we have more than conjecture to go on?
>
> What programs actually *benefit* from sparseness?

My primary motivation to do this is that I use P2P sharing program called
BitTorrent. This program is written in Python and I run it in Cygwin. This
program first creates whole file that I want to download by writing very few
bytes with long distances between them and then fills it as it downloads chunks
of the file from various other peers. The creation of this file takes from tens
of seconds to few minutes without this patch, depending on size of the file.
But with this patch it takes about two seconds to create this almost empty
file. The files I usually download are movies. I don't experience any extra
slowness while playing such created files.

Vaclav Haisman
