Return-Path: <cygwin-patches-return-3590-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19994 invoked by alias); 19 Feb 2003 00:21:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19984 invoked from network); 19 Feb 2003 00:21:09 -0000
Date: Wed, 19 Feb 2003 00:21:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: RE: Create new files as sparse on NT systems. (2nd try)
In-Reply-To: <001701c2d7a1$a101a020$2101a8c0@BRAEMARINC.COM>
Message-ID: <20030219010610.Y52168-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=-0.5 required=6.0
	tests=CARRIAGE_RETURNS,IN_REP_TO,QUOTED_EMAIL_TEXT,
	      SPAM_PHRASE_00_01
	version=2.44
X-Spam-Level: 
X-SW-Source: 2003-q1/txt/msg00239.txt.bz2


On Tue, 18 Feb 2003, Gary R Van Sickle wrote:

> "Note: It is up to the application to maintain sparseness by writing zeros
> with FSCTL_SET_ZERO_DATA", sez the Platform docs.

In this respect Windows are ahead of any recent Unix system. I wasn't able find
any Unix/Posix syscall that would allow this unlike Windows.

> Even if you do WriteFile()s with all zeros on a sparse file, you are
> actually hitting the disk.

Have you ever tryed the same thing in Unix environment? Writing buffer full of
zeros with write syscall won't gain you anything either. All the zeros will be
physicaly written onto the disk. This means it has the same behaviour as Unix
systems.

> The only thing this patch will do AFAICS is set a bit somewhere in the guts
> of NTFS that will be pretty much ignored.  I'm with Max, I don't see the
> benefit and can only imagine the consequences.

I don't see any negative consequences of this patch. The only one I can imagine
it can slow down file operations but I very very doubt it.

Vaclav Haisman
