Return-Path: <cygwin-patches-return-3574-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30938 invoked by alias); 17 Feb 2003 17:57:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30926 invoked from network); 17 Feb 2003 17:57:52 -0000
Date: Mon, 17 Feb 2003 17:57:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: Max Bowsher <maxb@ukf.net>
Cc: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
In-Reply-To: <005901c2d6ad$0446cbb0$78d96f83@pomello>
Message-ID: <20030217185236.X96740-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=-0.5 required=5.0
	tests=CARRIAGE_RETURNS,IN_REP_TO,QUOTED_EMAIL_TEXT,
	      SPAM_PHRASE_00_01
	version=2.43
X-Spam-Level: 
X-SW-Source: 2003-q1/txt/msg00223.txt.bz2


> Is it wise to set *all* new files to sparse? Surely if this was actually
> advantageous, Windows would do it anyway? From MSDN: "Note  It is up to the
> application to maintain sparseness by writing zeros with
> FSCTL_SET_ZERO_DATA." I.e., this will gain nothing unless the application
> knows about sparse-ness, in which case, it should explicitly specify that
> the file should be sparse. So, all this patch will do is to force Windows to
> examine more metadata for every file read. This seems *extremely
> undesirable*.
>
> Max.

As I have written in my previous emails in FreeBSD and SunOS all files are
sparse if underlying file system supports it. I doubt Windows is significantly
slower/faster in inspecting file system metadata than either of these OSes,

Vaclav Haisman
