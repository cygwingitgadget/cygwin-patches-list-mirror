Return-Path: <cygwin-patches-return-3560-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4287 invoked by alias); 13 Feb 2003 21:22:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4253 invoked from network); 13 Feb 2003 21:22:51 -0000
Date: Thu, 13 Feb 2003 21:22:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
In-Reply-To: <20030213203642.GG32279@redhat.com>
Message-ID: <20030213220730.Y52833-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=-0.5 required=5.0
	tests=CARRIAGE_RETURNS,IN_REP_TO,QUOTED_EMAIL_TEXT,
	      SPAM_PHRASE_00_01
	version=2.43
X-Spam-Level: 
X-SW-Source: 2003-q1/txt/msg00209.txt.bz2

On Thu, 13 Feb 2003, Christopher Faylor wrote:

> This is YA case where I don't think that a CYGWIN environment variable option is
> justified.
>
> UNIX has a method for producing sparse files.  If this is desired functionality,
> Cygwin should mimic that not invent a new way of doing things.
>
> cgf
>

I am not that much knowledgeable in matters of UNIX standars. What
libary/system call is it? My justificaion of this patch is that with this
option enable it mimics what this FreeBSD 4.7 box does. I don't need any other
syscall than open() and ftruncate() to create 100GB empty sparse file.

Vaclav Haisman
