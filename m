Return-Path: <cygwin-patches-return-2383-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24745 invoked by alias); 10 Jun 2002 15:26:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24704 invoked from network); 10 Jun 2002 15:26:20 -0000
Message-ID: <3D04C62B.E7804DC0@ieee.org>
Date: Mon, 10 Jun 2002 08:26:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
References: <3.0.5.32.20020609231253.008044d0@mail.attbi.com> <20020610035228.GC6201@redhat.com> <20020610111359.R30892@cygbert.vinschen.de> <20020610151016.GG6201@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00366.txt.bz2

Christopher Faylor wrote:
> 
> 
> Ok.  I'm in favor of getting rid of sexec in 1.3.11, then.
> 
> I'll do that sometime today.
> 
Then you can also junk the first argument (token) in _spawnve()
and spawn_guts() (FYI).

By the way, here is a diagram of what I proposed:

Currently:
PARENT
seteuid   internal_getlogin (1 & 2)  spawn_guts
CHILD
             uinfo_init   internal_getlogin (1 & 2)

Proposed:
PARENT
seteuid   spawn_guts   internal_getlogin (2)   
CHILD
             uinfo_init   internal_getlogin (1)

Another reason that 2) can't be pushed to the child 
is that it might be a non Cygwin process, expecting
a correct Windows environment.

Pierre
