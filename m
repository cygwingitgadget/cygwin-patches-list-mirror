Return-Path: <cygwin-patches-return-3594-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6753 invoked by alias); 19 Feb 2003 01:19:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6744 invoked from network); 19 Feb 2003 01:19:41 -0000
Date: Wed, 19 Feb 2003 01:19:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
In-Reply-To: <000701c2d7b3$fbed0e90$78d96f83@pomello>
Message-ID: <20030219021346.P54058-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=0.3 required=6.0
	tests=CARRIAGE_RETURNS,IN_REP_TO,SPAM_PHRASE_00_01
	version=2.44
X-Spam-Level: 
X-SW-Source: 2003-q1/txt/msg00243.txt.bz2


On Wed, 19 Feb 2003, Max Bowsher wrote:

> Well, why not have BitTorrent set the file as sparse?

Because it runs as Cygwin app which is Unix-like environment. There is no way
to set files sparse in Unix because all files are sparse if the file systems
supports it.

Vaclav Haisman
