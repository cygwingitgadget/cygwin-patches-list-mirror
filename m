Return-Path: <cygwin-patches-return-4191-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21879 invoked by alias); 9 Sep 2003 14:57:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21867 invoked from network); 9 Sep 2003 14:57:25 -0000
From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: Fixing a security hole in mount table.
Date: Tue, 09 Sep 2003 14:57:00 -0000
Message-ID: <002e01c376e3$12ca56d0$2101a8c0@BRAEMARINC.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <3F5D4A94.1060507@cwilson.fastmail.fm>
X-SW-Source: 2003-q3/txt/msg00207.txt.bz2

> Christopher Faylor wrote:
> 
> > I wonder if it is time to bite the bullet and get rid of user-mode
> > mounts entirely.  Or maybe disallow them in suid'ed sessions?  They
> > are always going to be a security hole AFAICT.
> 
> I think that would be a bad idea.  What if I want to install 
> a private 
> version of cygwin on a machine to which I don't have Admin access? 
> (ITFascists can shut up right now; I'm not listening..."You 
> vill use de 
> Microsoft Application Suite ve haf provided, and nuzzing else!")

I like to refer to them as "the MIStapo" ;-).

-- 
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337
